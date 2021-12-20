--11
--ansi sql
select t1.ename "사원이름", t2.deptno "부서번호", t2.dname "부서명"
  from emp t1 inner join dept t2
    on t1.deptno = t2.deptno;
--t-sql
select t1.ename "사원이름", t2.deptno "부서번호", t2.dname "부서명"
  from emp t1 , dept t2
 where t1.deptno = t2.deptno;

--12
select e.ename "이름", e.hiredate "입사일"
  from emp e, dept d
 where e.deptno = d.deptno
   and d.dname = '경리부';

--13
select e.ename, d.dname
  from emp e, dept d
 where e.deptno = d.deptno
   and e.job = '과장';
     
--14
select work.ename, work.job 
  from emp work, emp manager
 where work.mgr = manager.empno
   and manager.ename = '감우성';
  
--15
select *
  from emp work, emp friend
 where work.deptno = friend.deptno
   and work.ename = '감우성'
   and friend.ename != '감우성';