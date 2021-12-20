--테이블 복사
create table emp06
as select * from emp;

select * from emp06;

--8
select ename, sal, job
  from emp06
 where sal > (select min(sal)
                from emp
               where job = '과장')
   and job != '과장';         
   
select ename, sal, job
  from emp06
 where sal > any(select sal
                   from emp06
                  where job = '과장')
   and job <> '과장';      
   
--9
select ename, sal
  from emp06
 where deptno in (  select deptno
                     from dept
                    where loc = '인천' );

update emp06
   set sal = sal + 100
 where deptno in (  select deptno
                     from dept
                    where loc = '인천' );
commit;

--10
select ename 
  from emp06
 where deptno = ( select deptno
                    from dept
                   where dname = '경리부' ) ;

select ename
  from emp06 t1 inner join dept t2
                on t1.deptno = t2.deptno
 where t2.dname = '경리부';
 
delete from emp06
 where deptno = ( select deptno
                    from dept
                   where dname = '경리부' ) ;
rollback;

--11
select ename, deptno
  from emp06
 where deptno in ( select deptno
                     from emp06
                    where ename = '이문세' ) 
   and ename <> '이문세';

--12
select ename, job
  from emp06
 where job in ( select job
                     from emp06
                    where ename = '이문세' ) 
   and ename <> '이문세';

--13
select ename, sal
  from emp06
 where sal >= ( select sal
                  from emp06
                 where ename = '이문세' )
   and ename <> '이문세';              

--14
select ename, deptno
  from emp06
 where deptno in ( select deptno
                     from dept
                    where loc = '인천' );

--15
select ename, sal
  from emp06
 where mgr = ( select empno
                 from emp
                where ename = '감우성' );
   
--16. 상관쿼리
select empno, ename, sal, deptno
  from emp t1
 where sal = ( select max(sal)
                 from emp
                where deptno = t1.deptno ); 

--17.
select deptno, dname, loc
  from dept
 where deptno in ( select deptno
                     from emp06
                    where job = '과장' ); 

--18.
select ename, sal, job
  from emp
 where sal > ( select max(sal)
                 from emp
                where job = '과장' )
order by sal; 
 
select ename, sal, job
  from emp
 where sal > all( select sal
                    from emp
                   where job = '과장' ) 
order by sal; 



   
   
   
   
   
   
   
   
   
   
   
   