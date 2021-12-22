--2)테이블 제거 / 생성
DROP TABLE works;
DROP TABLE project;
DROP TABLE department;
DROP TABLE employee;

CREATE TABLE department(   
    deptno      number(2),
    deptname    varchar2(20),
    manager     number(4)
);

CREATE TABLE employee(
    empno       number(4),
    name        varchar2(20),
    phoneno     varchar2(20),
    address     varchar2(20),
    sex         char(3),
    position    varchar2(20),
    salary      number(3),
    deptno      number(2)
);

CREATE TABLE project(
    projno      number(3),
    projname    varchar2(20),
    deptno      number(2)
);

CREATE TABLE works (
    projno      number(3),
    empno       number(4),
    hoursworked number(3)
);

--2)기본키 생성
ALTER TABLE department  ADD CONSTRAINT department_deptno_pk  PRIMARY KEY ( deptno );
ALTER TABLE employee    ADD CONSTRAINT employee_empno_pk     PRIMARY KEY ( empno );
ALTER TABLE project     ADD CONSTRAINT project_projno_pk     PRIMARY KEY ( projno );
ALTER TABLE works       ADD CONSTRAINT works_projno_empno_pk PRIMARY KEY ( projno, empno );

--3)외래키 생성
ALTER TABLE department  ADD CONSTRAINT department_manager_fk    FOREIGN KEY(manager)    REFERENCES employee(empno);
--ALTER TABLE employee    ADD CONSTRAINT employee_deptno_fk       FOREIGN KEY(deptno)     REFERENCES department(deptno);
ALTER TABLE project     ADD CONSTRAINT project_deptno_fk        FOREIGN KEY(deptno)     REFERENCES department(deptno);
ALTER TABLE works       ADD CONSTRAINT project_projno_fk1       FOREIGN KEY(projno)     REFERENCES project(projno);
ALTER TABLE works       ADD CONSTRAINT project_empno_fk2        FOREIGN KEY(empno)      REFERENCES employee(empno);

--5)기타 제약조건
ALTER TABLE employee    MODIFY sex         CONSTRAINT employee_sex_ch       CHECK( sex IN ('남', '여'));
ALTER TABLE works       MODIFY hoursworked CONSTRAINT works_hoursworked_ch  CHECK( hoursworked > 0 );

ALTER TABLE employee    MODIFY name     CONSTRAINT employee_name_nn         NOT NULL;
ALTER TABLE department  MODIFY deptname CONSTRAINT department_deptname_nn   NOT NULL;
ALTER TABLE project     MODIFY projname CONSTRAINT project_projname_nn      NOT NULL;

--6)시퀀스 생성
DROP SEQUENCE department_deptno_seq;
DROP SEQUENCE employee_empno_seq;
DROP SEQUENCE project_projno_seq;

CREATE SEQUENCE department_deptno_sql START WITH 10 INCREMENT BY 10;
CREATE SEQUENCE employee_empno_sql START WITH 1001 INCREMENT BY 1;
CREATE SEQUENCE project_projno_sql START WITH 101 INCREMENT BY 1;

--7)샘플데이터
insert into employee values (employee_empno_sql.nextval,'홍길동' ,'010-1111-1001','부산1','남','팀장',500,10);
insert into employee values (employee_empno_sql.nextval,'홍길동2' ,'010-1111-1002','부산2','남','팀원1',200,10);
insert into employee values (employee_empno_sql.nextval,'홍길동3' ,'010-1111-1003','부산3','남','팀원2',300,10);
insert into employee values (employee_empno_sql.nextval,'홍길동4' ,'010-1111-1004','부산4','여','팀원3',400,10);
insert into employee values (employee_empno_sql.nextval,'홍길동5' ,'010-2222-1001','울산1','남','팀장',600,20);
insert into employee values (employee_empno_sql.nextval,'홍길동6' ,'010-2222-1002','울산2','남','팀원1',200,20);
insert into employee values (employee_empno_sql.nextval,'홍길동7' ,'010-2222-1003','울산3','남','팀원2',300,20);
insert into employee values (employee_empno_sql.nextval,'홍길동8' ,'010-2222-1004','울산4','남','팀원3',400,20);
insert into employee values (employee_empno_sql.nextval,'홍길동9' ,'010-3333-1001','서울1','남','팀장',700,30);
insert into employee values (employee_empno_sql.nextval,'홍길동10','010-3333-1002','서울2','남','팀원1',300,40);

insert into department values (department_deptno_sql.nextval, '회계팀',1001);
insert into department values (department_deptno_sql.nextval, '전산팀',1005);
insert into department values (department_deptno_sql.nextval, '영업팀',1009);

insert into project values (project_projno_sql.nextval, 'IFRS', 10);
insert into project values (project_projno_sql.nextval, '빅데이터구축', 20);
insert into project values (project_projno_sql.nextval, '마케팅', 30);

insert into works values (101, 1001, 10);
insert into works values (101, 1002, 15);
insert into works values (102, 1003, 10);
insert into works values (102, 1004, 20);
insert into works values (102, 1005, 30);
insert into works values (103, 1005, 50);
commit;