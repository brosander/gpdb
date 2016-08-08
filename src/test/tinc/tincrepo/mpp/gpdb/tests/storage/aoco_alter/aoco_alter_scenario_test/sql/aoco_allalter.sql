-- 
-- @created 2014-04-14 12:00:00
-- @modified 2014-04-14 12:00:00
-- @tags storage
-- @description AOCO compressed table : alter add all types of columns

DROP TABLE if exists aoco_allalter;
DROP TABLE if exists aoco_allalter_uncompr; 
--CREATE TABLE aoco_allalter (id SERIAL, DEFAULT COLUMN ENCODING (compresstype=zlib,blocksize=8192,compresslevel=1)) WITH (appendonly=true, orientation=column) distributed randomly ;
CREATE TABLE aoco_allalter (id SERIAL, DEFAULT COLUMN ENCODING (compresstype=zlib,blocksize=8192,compresslevel=1),num int) WITH (appendonly=true, orientation=column) distributed randomly ;
insert into aoco_allalter select i from generate_series(1,100) i;
update aoco_allalter set num = num + 10 where id < 10;
vacuum aoco_allalter;
insert into aoco_allalter select i from generate_series(101,500) i;
-- Alter all kinds of columns
Alter table aoco_allalter ADD COLUMN a1 int default 10 ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a2 char(5) default 'asdf' ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a3 numeric default 3.14 ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a4 boolean DEFAULT false  ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a5 char DEFAULT 'd' ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a6 text default 'some default value' ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a7 timestamp default '2003-10-21 02:26:11' ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a8 character varying(705) default 'asdsdsfdsnfdsnafkndasfdsajfldsjafdsbfjdsbfkdsjf' ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a9 bigint default 2342 ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a10 date default '1989-11-12' ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a11 varchar(600) default 'ksdhfkdshfdshfkjhdskjfhdshflkdshfhdsfkjhds' ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a12 text default 'mnsbfsndlsjdflsjasdjhhsafhshfsljlsahfkshalsdkfks' ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a13 decimal default 4.123 ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a14 real default 23232 ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a15 bigint default 2342 ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a16 int4 default 2342 ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a17 bytea default '0011' ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a18 timestamp with time zone default '1995-07-16 01:51:15+1359' ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a19 timetz default '1991-12-13 01:51:15' ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a20 path default '((6,7),(4,5),(2,1))' ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a21 box default '((1,3)(4,6))' ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a22 macaddr default '09:00:3b:01:02:03' ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a23 interval default '5-7' ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a24 character varying(800) default 'jdgfkasdksahkjcskgcksgckdsfkdslfhksagfksajhdjag' ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a25 lseg default '((1,2)(2,3))' ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a26 point default '(3,4)' ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a27 double precision default 12.211 ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a28 circle default '((2,3),4)' ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a29 int4 default 37 ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a30 numeric(8) default 3774 ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a31 polygon default '(1,5,4,3)' ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a32 date default '1988-02-21' ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a33 real default 41114 ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a34 money default '$7,222.00' ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a35 cidr default '192.167.2' ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a36 inet default '126.2.3.4' ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a37 time default '10:31:45' ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a38 text default 'sdhjfsfksfkjskjfksjfkjsdfkjdshkjfhdsjkfkjsd' ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a39 bit default '0' ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a40 bit varying(5) default '1' ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a41 smallint default 12 ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

Alter table aoco_allalter ADD COLUMN a42 int default 2323 ENCODING (compresstype=quicklz,compresslevel=1,blocksize=8192);

--
  -- Insert data to the table
 --
 INSERT INTO aoco_allalter(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42) values(generate_series(1,20),'M',2011,'t','a','This is news of today: Deadlock between Republicans and Democrats over how best to reduce the U.S. deficit, and over what period, has blocked an agreement to allow the raising of the $14.3 trillion debt ceiling','2001-12-24 02:26:11','U.S. House of Representatives Speaker John Boehner, the top Republican in Congress who has put forward a deficit reduction plan to be voted on later on Thursday said he had no control over whether his bill would avert a credit downgrade.',generate_series(2490,2505),'2011-10-11','The Republican-controlled House is tentatively scheduled to vote on Boehner proposal this afternoon at around 6 p.m. EDT (2200 GMT). The main Republican vote counter in the House, Kevin McCarthy, would not say if there were enough votes to pass the bill.','WASHINGTON:House Speaker John Boehner says his plan mixing spending cuts in exchange for raising the nations $14.3 trillion debt limit is not perfect but is as large a step that a divided government can take that is doable and signable by President Barack Obama.The Ohio Republican says the measure is an honest and sincere attempt at compromise and was negotiated with Democrats last weekend and that passing it would end the ongoing debt crisis. The plan blends $900 billion-plus in spending cuts with a companion increase in the nations borrowing cap.','1234.56',323453,generate_series(3452,3462),7845,'0011','2005-07-16 01:51:15+1359','2001-12-13 01:51:15','((1,2),(0,3),(2,1))','((2,3)(4,5))','08:00:2b:01:02:03','1-2','Republicans had been working throughout the day Thursday to lock down support for their plan to raise the nations debt ceiling, even as Senate Democrats vowed to swiftly kill it if passed.','((2,3)(4,5))','(6,7)',11.222,'((4,5),7)',32,3214,'(1,0,2,3)','2010-02-21',43564,'$1,000.00','192.168.1','126.1.3.4','12:30:45','Johnson & Johnsons McNeil Consumer Healthcare announced the voluntary dosage reduction today. Labels will carry new dosing instructions this fall.The company says it will cut the maximum dosage of Regular Strength Tylenol and other acetaminophen-containing products in 2012.Acetaminophen is safe when used as directed, says Edwin Kuffner, MD, McNeil vice president of over-the-counter medical affairs. But, when too much is taken, it can cause liver damage.The action is intended to cut the risk of such accidental overdoses, the company says in a news release.','1','0',12,23); 



--
--Alter table set distributed by 
ALTER table aoco_allalter set with ( reorganize='true') distributed by (a1);
-- Create Uncompressed table of same schema definition
CREATE TABLE aoco_allalter_uncompr (id SERIAL,a1 int,a2 char(5),a3 numeric,a4 boolean DEFAULT false ,a5 char DEFAULT 'd',a6 text,a7 timestamp,a8 character varying(705),a9 bigint,a10 date,a11 varchar(600),a12 text,a13 decimal,a14 real,a15 bigint,a16 int4 ,a17 bytea,a18 timestamp with time zone,a19 timetz,a20 path,a21 box,a22 macaddr,a23 interval,a24 character varying(800),a25 lseg,a26 point,a27 double precision,a28 circle,a29 int4,a30 numeric(8),a31 polygon,a32 date,a33 real,a34 money,a35 cidr,a36 inet,a37 time,a38 text,a39 bit,a40 bit varying(5),a41 smallint,a42 int) WITH (appendonly=true, orientation=column) distributed randomly;

--
-- Insert to uncompressed table
 --
 INSERT INTO aoco_allalter_uncompr(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42) values(generate_series(1,20),'M',2011,'t','a','This is news of today: Deadlock between Republicans and Democrats over how best to reduce the U.S. deficit, and over what period, has blocked an agreement to allow the raising of the $14.3 trillion debt ceiling','2001-12-24 02:26:11','U.S. House of Representatives Speaker John Boehner, the top Republican in Congress who has put forward a deficit reduction plan to be voted on later on Thursday said he had no control over whether his bill would avert a credit downgrade.',generate_series(2490,2505),'2011-10-11','The Republican-controlled House is tentatively scheduled to vote on Boehner proposal this afternoon at around 6 p.m. EDT (2200 GMT). The main Republican vote counter in the House, Kevin McCarthy, would not say if there were enough votes to pass the bill.','WASHINGTON:House Speaker John Boehner says his plan mixing spending cuts in exchange for raising the nations $14.3 trillion debt limit is not perfect but is as large a step that a divided government can take that is doable and signable by President Barack Obama.The Ohio Republican says the measure is an honest and sincere attempt at compromise and was negotiated with Democrats last weekend and that passing it would end the ongoing debt crisis. The plan blends $900 billion-plus in spending cuts with a companion increase in the nations borrowing cap.','1234.56',323453,generate_series(3452,3462),7845,'0011','2005-07-16 01:51:15+1359','2001-12-13 01:51:15','((1,2),(0,3),(2,1))','((2,3)(4,5))','08:00:2b:01:02:03','1-2','Republicans had been working throughout the day Thursday to lock down support for their plan to raise the nations debt ceiling, even as Senate Democrats vowed to swiftly kill it if passed.','((2,3)(4,5))','(6,7)',11.222,'((4,5),7)',32,3214,'(1,0,2,3)','2010-02-21',43564,'$1,000.00','192.168.1','126.1.3.4','12:30:45','Johnson & Johnsons McNeil Consumer Healthcare announced the voluntary dosage reduction today. Labels will carry new dosing instructions this fall.The company says it will cut the maximum dosage of Regular Strength Tylenol and other acetaminophen-containing products in 2012.Acetaminophen is safe when used as directed, says Edwin Kuffner, MD, McNeil vice president of over-the-counter medical affairs. But, when too much is taken, it can cause liver damage.The action is intended to cut the risk of such accidental overdoses, the company says in a news release.','1','0',12,23); 


\d+ aoco_allalter


--Select from pg_attribute_encoding to see the table entry 
select attrelid::regclass as relname, attnum, attoptions from pg_class c, pg_attribute_encoding e  where c.relname = 'aoco_allalter' and c.oid=e.attrelid  order by relname, attnum limit 3; 
--
-- Compare data with uncompressed table
--
--
-- Select number of rows from the uncompressed table 
--
SELECT count(*) as count_uncompressed from  aoco_allalter_uncompr ;
--
-- Select number of rows from the compressed table 
--
SELECT count(*) as count_compressed from  aoco_allalter;
--
-- Select number of rows using a FULL outer join on all the columns of the two tables 
-- Count should match with above result if the all the rows uncompressed correctly: 
--
Select count(*) as count_join from aoco_allalter t1 full outer join aoco_allalter_uncompr t2 on t1.id=t2.id and t1.a1=t2.a1 and t1.a2=t2.a2 and t1.a3=t2.a3 and t1.a4=t2.a4 and t1.a5=t2.a5 and t1.a6=t2.a6 and t1.a7=t2.a7 and t1.a8=t2.a8 and t1.a9=t2.a9 and t1.a10=t2.a10 and t1.a11=t2.a11 and t1.a12=t2.a12 and t1.a13=t2.a13 and t1.a14=t2.a14 and t1.a15=t2.a15 and t1.a16=t2.a16 and t1.a17=t2.a17 and t1.a18=t2.a18 and t1.a19=t2.a19 and t1.a22=t2.a22 and t1.a23=t2.a23 and t1.a24=t2.a24 and t1.a27=t2.a27 and t1.a29=t2.a29 and t1.a30=t2.a30 and t1.a32=t2.a32 and t1.a33=t2.a33 and t1.a34=t2.a34 and t1.a35=t2.a35 and t1.a36=t2.a36 and t1.a37=t2.a37 and t1.a38=t2.a38 and t1.a39=t2.a39 and t1.a40=t2.a40 and t1.a41=t2.a41 and t1.a42=t2.a42 ;
--
-- Truncate the table 
--
TRUNCATE table aoco_allalter;
--
-- Insert data again 
--
insert into aoco_allalter select * from aoco_allalter_uncompr order by a1;

--
-- Select the data: Using the JOIN as mentioned above 
--
Select count(*) as count_join from aoco_allalter t1 full outer join aoco_allalter_uncompr t2 on t1.id=t2.id and t1.a1=t2.a1 and t1.a2=t2.a2 and t1.a3=t2.a3 and t1.a4=t2.a4 and t1.a5=t2.a5 and t1.a6=t2.a6 and t1.a7=t2.a7 and t1.a8=t2.a8 and t1.a9=t2.a9 and t1.a10=t2.a10 and t1.a11=t2.a11 and t1.a12=t2.a12 and t1.a13=t2.a13 and t1.a14=t2.a14 and t1.a15=t2.a15 and t1.a16=t2.a16 and t1.a17=t2.a17 and t1.a18=t2.a18 and t1.a19=t2.a19 and t1.a22=t2.a22 and t1.a23=t2.a23 and t1.a24=t2.a24 and t1.a27=t2.a27 and t1.a29=t2.a29 and t1.a30=t2.a30 and t1.a32=t2.a32 and t1.a33=t2.a33 and t1.a34=t2.a34 and t1.a35=t2.a35 and t1.a36=t2.a36 and t1.a37=t2.a37 and t1.a38=t2.a38 and t1.a39=t2.a39 and t1.a40=t2.a40 and t1.a41=t2.a41 and t1.a42=t2.a42 ;
--Alter table alter type of a column 
Alter table aoco_allalter Alter column a3 TYPE int4; 
--Insert data to the table, select count(*)
Insert into aoco_allalter(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42) select a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42 from aoco_allalter where id =10;
Select count(*) from aoco_allalter; 

--Alter table drop a column 
Alter table aoco_allalter Drop column a12; 
Insert into aoco_allalter(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42) select a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42 from aoco_allalter where id =10;
Select count(*) from aoco_allalter; 

--Alter table rename a column 
Alter table aoco_allalter Rename column a13 TO after_rename_a13; 
--Insert data to the table, select count(*)
Insert into aoco_allalter(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,after_rename_a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42) select a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,after_rename_a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42 from aoco_allalter where id =10;
Select count(*) from aoco_allalter; 
update aoco_allalter set  a9 = a9 + 10 where a1 = 10;
