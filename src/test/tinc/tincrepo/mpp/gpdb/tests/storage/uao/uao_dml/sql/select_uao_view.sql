-- @description : Create view and execute select from view
-- 
DROP TABLE IF EXISTS sto_uao_emp_forview cascade;
CREATE TABLE sto_uao_emp_forview (
   empno    INT  ,
   ename    VARCHAR(10),
   job      VARCHAR(9),
   mgr      INT NULL,
   hiredate DATE,
   sal      NUMERIC(7,2),
   comm     NUMERIC(7,2) NULL,
   dept     INT) with (appendonly=true) distributed by (empno);

insert into sto_uao_emp_forview values 
 (1,'JOHNSON','ADMIN',6,'12-17-1990',18000,10,4)
,(2,'HARDING','MANAGER',9,'02-02-1998',52000,15,3)
,(3,'TAFT','SALES I',2,'01-02-1996',25000,20,3)
,(4,'HOOVER','SALES I',2,'04-02-1990',27000,15,3)
,(5,'LINCOLN','TECH',6,'06-23-1994',22500,15,4)
,(6,'GARFIELD','MANAGER',9,'05-01-1993',54000,20,4)
,(7,'POLK','TECH',6,'09-22-1997',25000,15,4)
,(8,'GRANT','ENGINEER',10,'03-30-1997',32000,20,2)
,(9,'JACKSON','CEO',NULL,'01-01-1990',75000,30,4)
,(10,'FILLMORE','MANAGER',9,'08-09-1994',56000,20,2)
,(11,'ADAMS','ENGINEER',10,'03-15-1996',34000,20,2)
,(12,'WASHINGTON','ADMIN',6,'04-16-1998',18000,15,4)
,(13,'MONROE','ENGINEER',10,'12-03-2000',30000,20,2)
,(14,'ROOSEVELT','CPA',9,'10-12-1995',35000,30,1)
,(15,'More','ENGINEER',9,'10-12-1994',25000,20,2)
,(16,'ROSE','SALES I',10,'10-12-1999',18000,15,3)
,(17,'CLINT','CPA',2,'10-12-2001',24000,30,1);
DROP TABLE IF EXISTS sto_uao_dept_forview cascade;
CREATE TABLE sto_uao_dept_forview (
   deptno INT NOT NULL,
   dname  VARCHAR(14),
   loc    VARCHAR(13)) with (appendonly=true) distributed by (deptno);

insert into sto_uao_dept_forview values 
 (1,'ACCOUNTING','ST LOUIS')
,(2,'RESEARCH','NEW YORK')
,(3,'SALES','ATLANTA')
,(4, 'OPERATIONS','SEATTLE');


-- Create view
create or replace view sto_uao_emp_view as
select empno,ename,job,mgr,hiredate,sal,comm,dname,loc from sto_uao_dept_forview, sto_uao_emp_forview where sto_uao_dept_forview.deptno = sto_uao_emp_forview.dept; 

select * from sto_uao_emp_view  where mgr is not NULL order by 1;

