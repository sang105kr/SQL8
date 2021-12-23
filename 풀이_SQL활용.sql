--1. 여자 사원의 이름을 보이시오.
select name "이름" 
  from employee 
 where sex = '여';

--2. 팀장의 급여를 10%인상해 보이시오.
update employee
   set salary = salary * 1.1
 where position = '팀장'; 
 
--3. 팀장(manager)의 이름을 보이시오.
select name "이름"
  from employee 
 where position = '팀장';

select t2.name "이름"
 from department t1 inner join employee t2
                     on t1.manager = t2.empno;

--4. ‘전산팀’ 부서에서 일하는 사원의 이름,주소를 보이시오.
select t1.name "이름", t1.address "주소"
  from employee t1 inner join department t2
                   on t1.deptno = t2.deptno
 where t2.deptname = '전산팀';                   

select name "이름", address "주소"
  from employee
 where deptno = (select deptno 
                   from department
                  where deptname = '전산팀');
select name "이름", address "주소"
 from Employee t1, Department t2
where t1.deptno = t2.deptno
  and deptname = '전산팀'
  and position != '팀장';
--5. ‘홍길동’ 팀장(manager) 부서에서 일하는 사원의 수를 보이시오.
select count(*) "사원수"
  from employee
 where deptno in (select deptno
                   from employee
                  where name = '홍길동' 
                    and position = '팀장' )
   and name <> '홍길동';
   

                  
--6. 프로젝트에 참여하지 않은 사원의 이름을 보이시오.
select t1.name "사원명"
  from employee t1 left outer join works t2
                   on t1.empno = t2.empno
 where t2.projno is null;

select name "사원명"
  from employee
 where empno <> all (select empno from works);  

select t1.name "사원명"
  from employee t1
 where not exists ( select empno
                      from works
                     where empno = t1.empno );
                    
--7. 급여 상위 TOP 3 을 보이시오.
select rownum "순위", name "이름", salary "급여"
  from ( select *
           from employee
       order by salary desc ) t2
where rownum <= 3;  


--8. 사원들이 일한 시간 수를 부서별, 사원 이름별 오름차순으로 보이시오.
select * from works;
select t4.deptname "부서명", t2.name "사원명", sum(t1.hoursworked) "프로젝트 투입시간"
  from works t1 inner join employee t2
                on t1.empno = t2.empno
                inner join project t3
                on t1.projno = t3.projno
                inner join department t4
                on t2.deptno = t4.deptno
group by t4.deptno, t4.deptname, t2.name
order by t4.deptno, t2.name;

--9. 두 명 이상의 사원이 참여한 프로젝트의 번호, 프로젝트명, 사원의 수를 보이시오.
select t3.projno "프로젝트번호", t3.projname "프로젝트명", count(t2.empno) "사원수"
  from works t1 inner join employee t2
                on t1.empno = t2.empno
                inner join project t3
                on t1.projno = t3.projno
group by  t3.projno, t3.projname
having count(t2.empno) >=2 ;

--10. 세 명 이상의 사원이 있는 부서의 사원 이름을 보이시오.
select t2.deptname "부서명", t1.name "사원명"
  from employee t1 inner join department t2
                   on t1.deptno = t2.deptno
 where exists ( select t3.deptno, count(*) cnt
                  from employee t3
                 where t2.deptno = t3.deptno                   
              group by t3.deptno
                having count(*) >=3 );

select t2.deptname "부서명", t1.name "사원명"
  from employee t1 inner join department t2
                    on t1.deptno = t2.deptno
 where t2.deptno in( select deptno
                       from employee
                   group by deptno
                     having count(*)>=3);

--11 사원이 참여한 프로젝트에 대해 사원명, 프로젝트명, 참여시간을 보이는 뷰를 작성하시오.
create view prj_view ("사원명", "프로젝트명", "참여시간")
as
select t2.name, t3.projname, sum(t1.hoursworked)
  from works t1 inner join employee t2
                on t1.empno = t2.empno
                inner join project t3
                on t1.projno = t3.projno
group by t2.name, t3.projno, t3.projname
order by t2.name; 
select * from prj_view;

--데이터사전을 통해 정의된 뷰 확인하기
select *
  from user_views
 where view_name = 'PRJ_VIEW';
 
--12. employee.name 컬럼에 대해 인덱스를 생성하시오.
create index employee_name_idx on employee (name);
--데이터사전을 통해 인덱스 생성 유무 확인 
select *  from user_ind_columns
 where table_name =  'EMPLOYEE'; 