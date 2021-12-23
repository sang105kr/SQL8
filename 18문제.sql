--1권영경	평균 상위 3명의 학번과 이름, 평균을 구하시오.
select name "이름", avg "평균"
  from (   select t2.student_id, t2.name, avg(t1.jumsu) avg 
             from score t1, student t2
            where t1.student_id = t2.student_id 
         group by t2.student_id, t2.name
         order by avg desc) u1
 where rownum <= 3 ; 
--2김강현	국어 점수가 가장 낮은 사람의 평균을 구하시오
select n2.student_id "학번", n2.name "이름", avg(n1.jumsu) "평균"
  from score n1, student n2, subject n3
 where n1.student_id = n2.student_id 
   and n1.subject_id = n3.subject_id
   and n2.student_id = (
                        select o2.student_id
                          from score o1, student o2, subject o3
                         where o1.student_id = o2.student_id 
                           and o1.subject_id = o3.subject_id
                           and o3.name = '국어'
                           and o1.jumsu = ( select min(t1.jumsu)
                                              from score t1, subject t2
                                             where t1.subject_id = t2.subject_id
                                               and t2.name = '국어') )
group by n2.student_id,n2.name
order by avg(n1.jumsu) ;
                       
--3김무년	각 과목별로 최고점수를 받은 사람의 이름과 점수를 출력하시오.
select o3.name, o2.student_id "학번", o2.name "이름", o1.jumsu "점수"
  from score o1, student o2, subject o3
 where o1.student_id = o2.student_id
   and o1.subject_id = o3.subject_id
   and (o1.subject_id, o1.jumsu) in ( select t2.subject_id, max(t1.jumsu)
                                        from score t1, subject t2, student t3
                                       where t1.student_id = t3.student_id
                                         and t1.subject_id = t2.subject_id
                                    group by t2.subject_id )
order by o3.name;

--4김소라	영어점수가 80점 미만인 학생의 이름을 출력하시오
select t3.name "이름", t1.jumsu "영어점수"
  from score t1, subject t2, student t3
 where t1.student_id = t3.student_id
   and t1.subject_id = t2.subject_id
   and t2.name = '영어'
   and t1.jumsu < 80;
   
--5김영빈	국어 점수가 80점 이상인 학생의 학번과 이름을 출력하세요
select t3.name "이름", t2.name "과목", t1.jumsu "점수"
  from score t1, subject t2, student t3
 where t1.student_id = t3.student_id
   and t1.subject_id = t2.subject_id
   and t2.name = '국어'
   and t1.jumsu >= 80;

--6김재엽	평균이 가장 높은 과목을 수강하는 학생의 이름을 구하시오.
select o3.name
  from score o1, subject o2, student o3
 where o1.student_id = o3.student_id
   and o1.subject_id = o2.subject_id
   and o1.subject_id in (   select subject_id
                              from (select t2.subject_id, avg(t1.jumsu) avg
                                      from score t1, subject t2, student t3
                                     where t1.student_id = t3.student_id
                                       and t1.subject_id = t2.subject_id
                                  group by t2.subject_id
                                  order by avg(t1.jumsu) desc )
                             where rownum = 1 );
                             
--7박성모	각 과목별 최하점을 받은 사람의 학번, 이름, 점수를 출력하시오.
select o3.name, o2.student_id "학번", o2.name "이름", o1.jumsu "점수"
  from score o1, student o2, subject o3
 where o1.student_id = o2.student_id
   and o1.subject_id = o3.subject_id
   and (o1.subject_id, o1.jumsu) in ( select t2.subject_id, min(t1.jumsu)
                                        from score t1, subject t2, student t3
                                       where t1.student_id = t3.student_id
                                         and t1.subject_id = t2.subject_id
                                    group by t2.subject_id )
order by o3.name;
--8박현근	수학 점수가 가장 높은 사람 이름을 출력하시오.
select o2.student_id "학번", o2.name "이름", o1.jumsu "점수"
  from score o1, student o2 , subject o3
 where o1.student_id = o2.student_id
   and o1.subject_id = o3.subject_id
   and o3.name = '수학'
   and o1.jumsu = ( select max(i1.jumsu)
                       from score i1, subject i2
                      where i1.subject_id = i2.subject_id
                        and i2.name = '수학' );
--9배지희	점수가 없는 학생의 학번과 이름을 출력하시오.
select t1.student_id "학번", t1.name "이름"
  from student t1 left outer join score t2
                  on t1.student_id = t2.student_id
 where t2.student_id is null; 
 
--10유기상	과목별 석차를 구하시오.
   select t2.name "과목", t3.name "이름", t1.jumsu "석차",
          rank() over (partition by t2.subject_id order by t1.jumsu desc) "순위"        
     from score t1, subject t2, student t3
    where t1.student_id = t3.student_id
      and t1.subject_id = t2.subject_id;

--11이규민	국어 1등 점수와 영어 꼴등점수 차이 값을 구하시오.
select (
    select max(t1.jumsu)
      from score t1, subject t2
     where t1.subject_id = t2.subject_id
       and t2.name = '국어' )
    -
    (select min(t1.jumsu)
      from score t1, subject t2
     where t1.subject_id = t2.subject_id
       and t2.name = '영어') "차이"
from dual;
--12이준혁	과목별 평균보다 높은 점수를 받은 학생들의 이름을 출력하시오.
select o2.name "이름", o3.name "과목", o1.jumsu "점수"
  from score o1, student o2, subject o3
 where o1.student_id = o2.student_id
   and o1.subject_id = o3.subject_id
   and o1.jumsu > (
            select avg(t1.jumsu)
              from score t1, subject t2
             where t1.subject_id = t2.subject_id
               and t1.subject_id = o1.subject_id
          group by t2.subject_id,t2.name ); 

--13이한봄	국어 점수가 가장 높은 학생부터 낮은 학생 순으로 학생별 성적을 정렬하시오.
select t2.student_id "학번", t2.name "이름", t1.jumsu "점수"
  from score t1, student t2, subject t3
 where t1.student_id = t2.student_id
   and t1.subject_id = t3.subject_id
   and t3.name = '국어'
order by t1.jumsu desc;   

--14전은우	점수가 없는 학생의 학번과 이름을 출력하시오.
select t1.student_id "학번", t1.name "이름"
  from student t1 left outer join score t2
                  on t1.student_id = t2.student_id
 where t2.student_id is null;                  
 
--15조세령	평균 70점 이하인 학생의 학번, 이름을 출력하시오.
   select t2.student_id "학번", t2.name "이름", avg(t1.jumsu) "평균" 
     from score t1, student t2
    where t1.student_id = t2.student_id 
 group by t2.student_id, t2.name
   having avg(t1.jumsu) <= 70; 
   
--16최수빈	영어과목중에 가장 낮은 점수를 받은 사람의 학번과 이름을 출력하시오.
select o2.student_id "학번", o2.name "이름", o1.jumsu "점수"
  from score o1, student o2 , subject o3
 where o1.student_id = o2.student_id
   and o1.subject_id = o3.subject_id
   and o3.name = '영어'
   and o1.jumsu = ( select min(i1.jumsu)
                       from score i1, subject i2
                      where i1.subject_id = i2.subject_id
                        and i2.name = '영어' );
   
--17최재훈	국어의 평균값과 영어의 평균값을 산출하고 국어의 평균값보다 점수가 작은 사람들의 합과 영어의 평균값보다 점수가 작은 사람들의 합의 차이를 절대값으로 구하시오 (모든 값은 소수첫번째에서 올림이다) / 전 못 풉니다
select abs((select sum(jumsu)
          from score o1, student o2, subject o3
         where o1.student_id = o2.student_id
           and o1.subject_id = o3.subject_id
           and o3.name = '국어'
           and o1.jumsu < ( select avg(t1.jumsu)
                              from score t1, subject t2
                             where t1.subject_id = t2.subject_id
                               and t2.name = '국어' )
           )-  
           (select sum(jumsu)
              from score o1, student o2, subject o3
             where o1.student_id = o2.student_id
               and o1.subject_id = o3.subject_id
               and o3.name = '영어'   
               and o1.jumsu < ( select avg(t1.jumsu)
                                  from score t1, subject t2
                                 where t1.subject_id = t2.subject_id
                                   and t2.name = '영어' ))) "차이"
from dual;                               
   

--18하태우	평균점수 70점~90점 사이에 있는 학생의 이름과 성적을 성적순으로 출력하시오.
select o2.name "이름", avg(o1.jumsu) "점수"
  from score o1, student o2, subject o3
 where o1.student_id = o2.student_id
   and o1.subject_id = o3.subject_id
   and o2.student_id in (   select t2.student_id
                              from score t1, student t2, subject t3
                             where t1.student_id = t2.student_id
                               and t1.subject_id = t3.subject_id
                          group by t2.student_id   
                            having avg(jumsu) between 70 and 90 )
group by o2.student_id, o2.name
order by avg(o1.jumsu) desc;
