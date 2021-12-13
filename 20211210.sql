--tester1 사용자 생성하기
create user c##tester1 identified by 1234;

--tester1 사용자에게 접속권한과 자원사용권한 부여
grant connect, resource to c##tester1;