 
--1.mession  
--01
select ename,sal,hiredate
  from emp;
   
--02
select deptno "부서번호", dname "부서명"
  from dept;
  
--03
select distinct job
  from emp;
  
--2.mession  
--01
select empno, ename, sal
  from emp
 where sal <= 300; 
  
--02
select empno, ename, sal
  from emp
 where ename = '오지호';
 
--03
select empno, ename, sal
  from emp
 where sal = 250 or sal = 300 or sal = 500;
 
select empno, ename, sal
  from emp
 where sal in (250,300,500);
 
--04
select empno, ename, sal
  from emp
 where sal != 250 and sal != 300 and sal != 500;
 
select empno, ename, sal
  from emp
 where sal <> 250 and sal <> 300 and sal <> 500; 
 
select empno, ename, sal
  from emp
 where not (sal = 250 or sal = 300 or sal = 500); 
 
select empno, ename, sal
  from emp
 where sal not in (250,300,500); 
 
  select *
    from emp
   where sal >= 300   
order by sal desc, ename asc;
 
--3.mission
--1
select empno, ename
  from emp
 where ename like '김%' or ename like '%기%';
 
--2
select * 
  from emp
 where mgr is null;
 
--3
select empno, ename, job, to_char(hiredate,'YYYYMMDD')
  from emp
order by hiredate desc;

--4
select empno, ename, job, to_char(hiredate,'YYYYMMDD')
  from emp
order by deptno, hiredate;
 
 
 
  
  
  
  
  
  
  