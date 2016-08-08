"""
Copyright (C) 2004-2015 Pivotal Software, Inc. All rights reserved.

This program and the accompanying materials are made available under
the terms of the under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Filerep test suite, to test Replication of the GPDB cluster.
Run workload with all DB operations on all the relation types,
from transition states of insync, to change tracking, to resync,
and until insync again, workload generated by each transition
stage will be tested by all following transition stages. Catalog
is checked within each phase, checkmirrorseg performed within insync
phases.

This test suite leverages scenario framework to run the workload(sqls)
in parallel, however, in order to avoid issues of deadlock and currently
alterring the same relation, vacuum-full sqls and some other sqls are
put into a vacuum folder of each workload to run in sequential.
"""

import os
import socket

import tinctest
import unittest2 as unittest
from tinctest.lib import local_path
from mpp.gpdb.tests.storage.lib import Database
from mpp.models import MPPTestCase
from tinctest.models.scenario import ScenarioTestCase
from mpp.gpdb.tests.storage.filerep_end_to_end import FilerepTestCase

class FilerepE2EScenarioTestCase(ScenarioTestCase, MPPTestCase):
    """
    @gucs gp_create_table_random_default_distribution=off
    """
    
    def __init__(self, methodName):
        self.filerep = FilerepTestCase('preprocess')
        self.path = local_path("data")
        super(FilerepE2EScenarioTestCase,self).__init__(methodName)


    def setUp(self):
        '''
        gpfdist port should be dynamically generated, this is a chance
        that it may fail to start gpfdist service as other processes are
        likely to be running on this specific port.   
        '''

        super(FilerepE2EScenarioTestCase, self).setUp()
        db = Database()
        db.setupDatabase('gptest')
        
        self.filerep.preprocess()
        self.filerep.setupGpfdist('8088', self.path)
        self.filerep.method_setup()
        
    def tearDown(self):
        self.filerep.cleanupGpfdist('8088', self.path)
        super(FilerepE2EScenarioTestCase, self).tearDown()
         
    @classmethod
    def setUpClass(cls):
        pass

    @classmethod
    def tearDownClass(cls):
        pass

    def test_incr_mirror(self):
        self.do_test('incr','mirror')

    def test_full_mirror(self): 
        self.do_test('full','mirror')

    def test_incr_primary(self):
        self.do_test('incr','primary')

    def test_full_primary(self):
        self.do_test('full', 'primary')
    
    def do_test(self,rec_mode,fail_type):
        '''
        @rec_mode: recovery mode, can be full or incremental
        @fail_type, failover type, can be mirror or primary
        '''

        self.do_sync1_tests(fail_type)
        self.do_ck_sync1_tests()
        self.do_ct_tests(fail_type)
        self.do_resync_tests(rec_mode, fail_type)
        self.do_sync2_tests(rec_mode, fail_type)
        self.do_clean_tests()

    def do_sync1_tests(self, fail_type):
        '''
        Run workload while insync transition state, creates workload to be tested by following
        transition phases.
        @fail_type: failover type, can be mirror or primary
        '''

        list_cl = []
        list_cl.append("mpp.gpdb.tests.storage.filerep_end_to_end.FilerepTestCase.clean_data")
        self.test_case_scenario.append(list_cl) 

        list_set_sync1 = []
        list_set_sync1.append("mpp.gpdb.tests.storage.filerep_end_to_end.set_sync1.test_set_sync1.SetSync1TestCase")
        self.test_case_scenario.append(list_set_sync1)
        
        list_sync1 = []
        list_sync1.append("mpp.gpdb.tests.storage.filerep_end_to_end.sync1.test_sync1.Sync1TestCase")
        self.test_case_scenario.append(list_sync1)
 
        list_serial = []
        list_serial.append("mpp.gpdb.tests.storage.filerep_end_to_end.sync1.vacuum.test_vacuum.VacuumTestCase")
        list_serial.append("mpp.gpdb.tests.storage.filerep_end_to_end.FilerepTestCase.check_mirror_seg")
        list_serial.append(("mpp.gpdb.tests.storage.filerep_end_to_end.FilerepTestCase.run_gpstate", [fail_type, 'sync1']))
        list_serial.append(("mpp.gpdb.tests.storage.filerep_end_to_end.FilerepTestCase.do_gpcheckcat", {'outputFile':'sync1_checkcat.out'}))
        self.test_case_scenario.append(list_serial, serial=True)

    def do_ck_sync1_tests(self):
        '''
        Run workload in insync but after pushing a checkpoint, in case heap data pages maybe in flight getting flushed to mirror 
        and not on primary.
        '''

        list_cl_and_ck = []
        list_cl_and_ck.append("mpp.gpdb.tests.storage.filerep_end_to_end.FilerepTestCase.clean_data")
        list_cl_and_ck.append("mpp.gpdb.tests.storage.filerep_end_to_end.runcheckpoint.runCheckPointSQL.runCheckPointTestCase")
        self.test_case_scenario.append(list_cl_and_ck, serial=True)

        list_set_checkpoint_sync1 = []
        list_set_checkpoint_sync1.append("mpp.gpdb.tests.storage.filerep_end_to_end.set_ck_sync1.test_set_ck_sync1.SetCkSync1TestCase")
        self.test_case_scenario.append(list_set_checkpoint_sync1)

        list_checkpoint_sync1 = []
        list_checkpoint_sync1.append("mpp.gpdb.tests.storage.filerep_end_to_end.ck_sync1.test_ck_sync1.CkSync1TestCase")
        self.test_case_scenario.append(list_checkpoint_sync1)

        list_serial = []
        list_serial.append("mpp.gpdb.tests.storage.filerep_end_to_end.ck_sync1.vacuum.test_vacuum.VacuumTestCase")
        list_serial.append(("mpp.gpdb.tests.storage.filerep_end_to_end.FilerepTestCase.do_gpcheckcat", {'outputFile':'ck_sync1_checkcat.out'}))
        self.test_case_scenario.append(list_serial, serial=True)        

    def do_ct_tests(self, fail_type):
        '''
        Run workload in change tracking
        @fail_type: failover type, can be mirror or primary
        '''

        list = []
        list.append("mpp.gpdb.tests.storage.filerep_end_to_end.FilerepTestCase.clean_data")
        list.append(("mpp.gpdb.tests.storage.filerep_end_to_end.FilerepTestCase.method_run_failover",[fail_type]))
        if (fail_type=='mirror'):
            list.append("mpp.gpdb.tests.storage.filerep_end_to_end.FilerepTestCase.trigger_transition")
        list.append("mpp.gpdb.tests.storage.filerep_end_to_end.FilerepTestCase.wait_till_change_tracking_transition")
        self.test_case_scenario.append(list,serial=True)
        
        list_set_ct = []
        list_set_ct.append("mpp.gpdb.tests.storage.filerep_end_to_end.set_ct.test_set_ct.SetCtTestCase")
        self.test_case_scenario.append(list_set_ct)

        list_ct = []
        list_ct.append("mpp.gpdb.tests.storage.filerep_end_to_end.ct.test_ct.CtTestCase")
        self.test_case_scenario.append(list_ct)

        list_serial = []
        list_serial.append("mpp.gpdb.tests.storage.filerep_end_to_end.ct.vacuum.test_vacuum.VacuumTestCase")
        list_serial.append(("mpp.gpdb.tests.storage.filerep_end_to_end.FilerepTestCase.do_gpcheckcat",{'outputFile':'ct_checkcat.out'}))
        list_serial.append(("mpp.gpdb.tests.storage.filerep_end_to_end.FilerepTestCase.run_gpstate",[fail_type, 'ct']))
        self.test_case_scenario.append(list_serial, serial=True)

    def do_resync_tests(self, rec_mode, fail_type):
        '''
        Suspend the transition to resync, trigger gprecoverseg, run workload.
        @rec_mode: recovery type, can be full or incremental.
        @fail_type: failover type, can be mirror or primary.
        '''

        list = []
        list.append("mpp.gpdb.tests.storage.filerep_end_to_end.FilerepTestCase.clean_data")
        list.append("mpp.gpdb.tests.storage.filerep_end_to_end.FilerepTestCase.run_method_suspendresync")
	if ((rec_mode == 'incr') and (fail_type == 'primary')):
            list.append("mpp.gpdb.tests.storage.filerep_end_to_end.FilerepTestCase.inject_fault_on_first_primary");
        list.append(("mpp.gpdb.tests.storage.filerep_end_to_end.FilerepTestCase.run_gprecoverseg",[rec_mode]))
        list.append(("mpp.gpdb.tests.storage.filerep_end_to_end.FilerepTestCase.run_gpstate",[fail_type,'resync_'+rec_mode]))
        self.test_case_scenario.append(list, serial=True) 

        list_set_resync = []
        list_set_resync.append("mpp.gpdb.tests.storage.filerep_end_to_end.set_resync.test_set_resync.SetResyncTestCase")
        self.test_case_scenario.append(list_set_resync)

        list_resync = []
        list_resync.append("mpp.gpdb.tests.storage.filerep_end_to_end.resync.test_resync.ResyncTestCase")
        self.test_case_scenario.append(list_resync)

        list_serial = []
        list_serial.append("mpp.gpdb.tests.storage.filerep_end_to_end.resync.vacuum.test_vacuum.VacuumTestCase")
        list_serial.append(("mpp.gpdb.tests.storage.filerep_end_to_end.FilerepTestCase.do_gpcheckcat",{'outputFile':'resync_checkcat.out'}))
        self.test_case_scenario.append(list_serial,serial=True) 

    def do_sync2_tests(self, rec_mode, fail_type):
        '''
        Resume and reset the fault, bring cluster into insync, run workload, perform checkmirrorseg and check catalog.
        '''

        list_resume_validate = []
        list_resume_validate.append("mpp.gpdb.tests.storage.filerep_end_to_end.FilerepTestCase.clean_data")
        list_resume_validate.append("mpp.gpdb.tests.storage.filerep_end_to_end.FilerepTestCase.method_resume_filerep_resync")
        list_resume_validate.append("mpp.gpdb.tests.storage.filerep_end_to_end.FilerepTestCase.method_reset_fault_injection")
	if ((rec_mode == 'incr') and (fail_type == 'primary')):
            list_resume_validate.append("mpp.gpdb.tests.storage.filerep_end_to_end.FilerepTestCase.inject_fault_on_first_mirror");
            list_resume_validate.append(("mpp.gpdb.tests.storage.filerep_end_to_end.FilerepTestCase.stop_start_validate", [False]))
        else:
            list_resume_validate.append("mpp.gpdb.tests.storage.filerep_end_to_end.FilerepTestCase.stop_start_validate")
        list_resume_validate.append("mpp.gpdb.tests.storage.filerep_end_to_end.FilerepTestCase.wait_till_insync_transition")
        self.test_case_scenario.append(list_resume_validate,serial=True)

        list_set_sync2 = []
        list_set_sync2.append("mpp.gpdb.tests.storage.filerep_end_to_end.set_sync2.test_set_sync2.SetSync2TestCase")
        self.test_case_scenario.append(list_set_sync2)

        list_sync2 = []
        list_sync2.append("mpp.gpdb.tests.storage.filerep_end_to_end.sync2.test_sync2.Sync2TestCase")
        self.test_case_scenario.append(list_sync2)

        list_serial = []
        list_serial.append("mpp.gpdb.tests.storage.filerep_end_to_end.sync2.vacuum.test_vacuum.VacuumTestCase")
        list_serial.append("mpp.gpdb.tests.storage.filerep_end_to_end.FilerepTestCase.check_mirror_seg")
        list_serial.append(("mpp.gpdb.tests.storage.filerep_end_to_end.FilerepTestCase.do_gpcheckcat",{'outputFile':'sync2_checkcat.out'}))
        self.test_case_scenario.append(list_serial,serial=True)

    def do_clean_tests(self):
        '''
        Drop databases, tablespaces, and filespaces.
        '''

        list_cleanup = []
        list_cleanup.append("mpp.gpdb.tests.storage.filerep_end_to_end.clean.test_clean.CleanTestCase")
        self.test_case_scenario.append(list_cleanup)

