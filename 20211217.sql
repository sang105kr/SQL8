create table emp01 (
    empno number(4),
    ename varchar2(14),
    sal   number(7,3)
);

describe emp01;
desc emp01;

--컬럼추가
alter table emp01
add(birth date);

--컬럼변경
alter table emp01
modify (ename varchar2(30));

--컬럼제거
alter table emp01
drop column ename;

--컬럼 미사용상태 변환
alter table emp01
set unused (empno);

--컬럼 미사용상태 컬럼이 있는 테이블 조회
select * from user_unused_col_tabs;

--컬럼 미사용상태 컬럼 제거하기
alter table emp01 drop unused columns;

--테이블 이름 변경하기
rename emp01 to emp02;

desc emp02;

--테이블 제거 (구조,데이터 모두 삭제)
drop table emp02;

select * from user_tables;
select owner, table_name from all_tables;
select * from dba_tables;

--테이블 복사
create table emp02
as select * from emp;
desc emp02;
select * from emp02;
drop table emp02;

--delete : 구조는 그대로 두고 데이터만 삭제, rollback가능
delete from emp02;
commit;
rollback;

--truncate : 구조는 그대로 두고 데이터만 삭제, rollback불가;
truncate table emp02;





--7. Mession
--1
create table dept_mission (
    dno     number(2),
    dname   varchar2(14),
    loc     varchar2(13)
);
desc dept_mission;
drop table dept_mission;

--2
create table emp_mission(
    eno     number(4),
    ename   varchar2(10),    
    dno     number(2)
);
desc emp_mission;

--3
alter table emp_mission
modify ename varchar2(25);
desc emp_mission;

--4
drop table emp_mission;
desc emp_mission;

--5
alter table dept_mission
drop column dname;
desc dept_mission;

--6
alter table dept_mission
set unused (loc);
desc dept_mission;
select * from user_unused_col_tabs;

--7
alter table dept_mission
drop unused columns;
select * from user_unused_col_tabs;

--8
rename dept_mission to department;
desc dept_mission;
desc department;


create table dept01(
    deptno  number(2),
    dname   varchar2(14),
    loc     varchar2(13)
);

desc dept01;

select * from dept01;

--inset
insert into dept01 (deptno, dname, loc)
     values ( 10, '경리부', '서울');
insert into dept01 (deptno, dname, loc)
     values ( 20, '인사부', '인천');
insert into dept01 --컬럼리스트 : 테이블의 모든 컬럼에 값을 줄경우 생략가능
     values (90, '총무부', '울산');    
insert into dept01 (deptno, dname)
     values (91, '회계부');
commit;     
     
--update
update dept01
   set dname = '생산부'
 where deptno = 10;
commit;

--delete
delete from dept01
 where deptno = 10;
rollback;

--8. mission
--1
create table employee03(
    empno   number(4) not null,
    ename   varchar2(20),
    job     varchar2(20),
    sal     number(7,3)
);

desc employee03;
select * from employee03;

--2
insert into employee03
     values (1000, '한동운', '승려', 100);
insert into employee03
     values (1010, '허준', '의관', 150);
insert into employee03
     values (1020, '주시경', '국어학자', 250);     
insert into employee03 (empno, ename, sal)
     values (1030, '계백', 250);  
insert into employee03 (empno, ename, sal)
     values (1040, '선덕여왕', 200);  
commit;

--3
update employee03
   set sal = sal + 50
 where sal < 200; 
commit;

--1
delete from employee03
 where job is null;
select * from employee03;
commit;

--9.mission
drop table speciality;
drop table assign;
drop table project;
drop table employee;

--1
create table employee (
    emp_no      number(4),
    emp_name    varchar2(20),
    salary      number(6),
    birthday    date
);
desc employee;
--2
create table project (
    pro_no      number(4),
    pro_content varchar2(100),
    start_date  date,
    finish_date date
);
desc project;
--3
create table speciality (
    emp_no      number(4),
    specialty   varchar2(20)
);
desc speciality;
--4
create table assign (
    emp_no      number(4),
    pro_no      number(4)
);
desc assign;

--5
--primary key
alter table employee
add constraint employee_pk primary key(emp_no);

alter table project
add constraint project_pk primary key(pro_no);

alter table speciality
add constraint speciality_pk primary key(emp_no,specialty );

alter table assign
add constraint assign_pk primary key(emp_no,pro_no );

select constraint_name, constraint_type, table_name, r_constraint_name
  from user_constraints
 where table_name in ('EMPLOYEE','PROJECT','SPECIALITY','ASSIGN'); 

--foreign key
alter table speciality
add constraint speciality_fk 
foreign key(emp_no) references employee(emp_no);

alter table assign
add constraint assign_employee_fk 
foreign key(emp_no) references employee(emp_no);

alter table assign
add constraint assign_project_fk 
foreign key(pro_no) references project(pro_no);

select constraint_name, constraint_type, table_name, r_constraint_name
  from user_constraints
 where table_name in ('EMPLOYEE','PROJECT','SPECIALITY','ASSIGN'); 

--check
alter table employee
add constraint employee_sal_ck
check( salary between 500 and 5000 );

--add column
alter table employee
add (gender varchar2(1)); 
desc employee;
alter table employee
add constraint employee_gender_ck
check(gender in('M','F'));

--not null추가
alter table employee
modify emp_name constraint employee_emp_name_nn not null;



select * from emp where ename = '김사랑';
select * from dept where deptno = 20;

select emp.empno "부서번호", emp.ename "사원명", dept.dname "부서명", dept.loc "부서위치"
  from emp, dept
 where emp.deptno = dept.deptno
   and emp.ename = '김사랑'; 

select * from emp;   
select * from dept;   

--cross join
select *
  from emp, dept;
  
--equi join
select emp.deptno, dept.deptno
  from emp, dept
 where emp.deptno = dept.deptno
   and emp.ename = '이문세';  


select t1.deptno
  from emp t1, dept t2
 where t1.deptno = t2.deptno
   and t1.ename = '이문세';

select * from salgrade;

select *
  from emp t1, salgrade t2
 where t1.sal >= t2.losal  and t1.sal <= t2.hisal;


select t1.ename || ' 의 팀장은 ? ' || t2.ename
  from emp t1 , emp t2
 where t1.mgr = t2.empno
   and t1.ename = '김사랑';

select t1.ename || ' 의 팀장은 ? ' || t2.ename
  from emp t1 , emp t2
 where t1.mgr = t2.empno;



select t1.ename, t2.dname
  from emp t1, dept t2
 where t1.deptno = t2.deptno;

select t1.ename, t2.dname
  from emp t1 inner join dept t2 on t1.deptno = t2.deptno;


select t1.ename, t2.dname
  from emp t1, dept t2
 where t1.deptno = t2.deptno
   and t1.ename = '김사랑';

select t1.ename, t2.dname
  from emp t1 inner join dept t2 on t1.deptno = t2.deptno
 where t1.ename = '김사랑';

---------------------------------------
-- inner join
---------------------------------------
select t1.ename, t2.ename
  from emp t1 , emp t2
 where t1.mgr = t2.empno;
 
select t1.ename, t2.ename
  from emp t1 inner join emp t2 on t1.mgr = t2.empno;
---------------------------------------
-- left outer join
---------------------------------------
select t1.ename, t2.ename
  from emp t1 , emp t2
 where t1.mgr = t2.empno(+);
 
select t1.ename, t2.ename
  from emp t1 left outer join emp t2 on t1.mgr = t2.empno; 
 




