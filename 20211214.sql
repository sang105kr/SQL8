select '오라클', length('오라클'), lengthb('오라클')
  from dual;
  
select 'welcome to oracle', substr('welcome to oracle',4,3)
  from dual;
  
select instr( 'welcome to oracle', 'oracle')
  from dual;
  
select substr('welcome to oracle',instr( 'welcome to oracle', 'oracle'),length('oracle'))
  from dual;  
  
select last_day('20220201')
  from dual;

select to_char(hiredate, 'YYYY/MM/DD') "입사일",
       to_char(round(hiredate,'YYYY'), 'YYYY/MM/DD') "입사일"
  from emp;       
  
select to_char(hiredate, 'YYYY/MM/DD') "입사일",
       to_char(trunc(hiredate,'YYYY'), 'YYYY/MM/DD') "입사일"
  from emp;    


select round(sysdate,'MONTH')
  from dual;

select trunc(sysdate,'MONTH')
  from dual;
  
select last_day(sysdate)  
  from dual;
  
  
select * from emp;  
  
--SUBSTR(문자열,검색할 문자, 시작지점, 시작지점 부터 N개)
-- 시작지점 양수면 왼쪽부터, 음수면 오른쪽부터 검색
--INSTR(문자열, 검색할 문자)
--INSTR(문자열, 검색할 문자, 시작지점, n번째 검색단어)

SELECT *
  FROM EMP
 WHERE ENAME LIKE '%기';

SELECT *
  FROM EMP
 WHERE SUBSTR(ENAME,-1,1) = '기';
 
 
SELECT ENAME , SUBSTR(ENAME,1,1) "성", SUBSTR(ENAME,2,LENGTH(ENAME)) "이름"
    FROM EMP;
 
 SELECT ENAME , SUBSTR(ENAME,1,1) || ' ' ||SUBSTR(ENAME,2,LENGTH(ENAME)) "이름"
    FROM EMP; 

select empno, ename, job, sal,
       decode(job, '부장', sal * 1.05,
                   '과장', sal * 1.1,
                   '대리', sal * 1.15,
                   '사원', sal * 1.2, 
                   sal) "upsal"
  from emp;

select empno, ename, job, sal,
       case when job = '부장' then sal * 1.05
            when job = '과장' then sal * 1.1
            when job = '대리' then sal * 1.15
            when job = '사원' then sal * 1.2
            else sal 
       end  "upsal"
  from emp;  
  
select empno, sal, nvl(comm,0) 
  from emp;
  
select empno, ename, decode(mgr, null, '관리자 없음',
                                 mgr) "관리자"
 from emp;
 
select * from emp; 


select sum(sal)
  from emp;

select deptno, job, avg(sal)
  from emp
group by deptno, job
order by deptno asc;


select deptno, count(*) cnt --5. 출력 하고자 하는 컬럼
  from emp   --  1. 대상 테이블
 where job = '사원'  -- 2. 레코드 필터링 하는 조건
group by deptno --3. 지정된 컬럼별 그루핑
having deptno <> 10 --4. 그루핑 결과를 필터링 하는 조건
order by cnt desc; --6. 정렬


select * from emp;

select count(*)
  from emp;
  
select count(empno)
  from emp;

select count(comm)
  from emp; 
  
select sum(sal) ,  sum(sal) / count(*)
  from emp;
  
select sum(sal),  avg(sal)
  from emp;  

--3. 도전 Quiz
--1
 select *
   from emp
  where mod(empno,2) = 1;
  
--2
 select hiredate,
        to_char(hiredate,'YYYYMMDD'),
        substr(to_char(hiredate,'YYYYMMDD'),1,4) "년도",
        substr(to_char(hiredate,'YYYYMMDD'),5,2) "월",
        substr(to_char(hiredate,'YYYYMMDD'),-2,2) "일"
   from emp;
   
--3
  select empno, ename, sysdate, hiredate , round(sysdate - hiredate) "근무일수"
    from emp
order by "근무일수" desc   ;

--4
  select empno, ename, nvl(to_char(mgr,'9999'),'CEO') "직속상관"
    from emp
   where mgr is null;  

--6
  select sysdate + 115
    from dual;
    
--7
  select last_day(sysdate)
    from dual;
    
--8
  select nvl2(comm, sal+comm, sal)
    from emp;

--9
  select sal,
         case when not (sal + 100 >= 500) then '고임금' 
              else '저임금'
         end "임금수준"     
    from emp;

--10
 select sysdate from dual;



  
--4. mission
--1
select max(sal) "Maximum", 
       min(sal) "Minimum", 
       sum(sal) "SUM", 
       round(avg(sal)) "Average"
  from emp;

--2
  select job, 
         max(sal) "Maximum", 
         min(sal) "Minimum", 
         sum(sal) "SUM", 
         round(avg(sal)) "Average"
    from emp
group by job;

--3
  select job, count(*)
    from emp
group by job;    
    
--4
  select job, count(*)
    from emp
group by job
  having job = '과장'; 
  
--5
  select max(sal) - min(sal) "DIFFERENCE"
    from emp;
    
--6
  select job, min(sal)
    from emp
group by job
  having min(sal) >= 500
order by min(sal) desc;

  select job, min(sal)
    from emp
group by job
  having not (min(sal) < 500)
order by min(sal) desc;

--7
  select deptno "DEPTNO", 
         count(empno) "Number Of People", 
         round(avg(sal),2) "Sal"
    from emp
group by deptno
order by deptno asc;    

--8
  select case when deptno=30 then '영업부'
              when deptno=10 then '인사부'
              when deptno=20 then '경리부'
              --else '기타부서'
         end "DEPTNO",         
         case when deptno=30 then '용인'
              when deptno=10 then '인천'
              when deptno=20 then '서울'
              --else '기타부서'
         end "Location", 
         count(empno) "Number Of People", 
         round(avg(sal),2) "Sal"
    from emp
group by deptno;    

--4장 도전 Quiz
--7
select count(*)
  from emp
 where deptno = 30
   and comm is not null;
   
--8
select max(hiredate) "가장 최근 입사일", min(hiredate) "가장 오래된 입사일"
  from emp;

--9
    select job, sum(sal) 
      from emp
  group by job
    having sum(sal) > 300; 


    select job, sum(sal) 
      from emp
     where deptno = 30 
  group by job
    having sum(sal) > 300; 














  
  
  
  
  
  
  
  
  




























  
 
  