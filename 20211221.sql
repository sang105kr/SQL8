/* system계정에서 실행한다. 	*/
/* Oracle 12c 이상의 CDB 사용자 생성을 위해 c##을 붙인다 	*/
DROP USER c##tester3 CASCADE;
CREATE USER c##tester3 IDENTIFIED BY 1234 DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp PROFILE DEFAULT;
GRANT CONNECT, RESOURCE TO c##tester3;
GRANT CREATE VIEW, CREATE SYNONYM TO c##tester3;
GRANT UNLIMITED TABLESPACE TO c##tester3;
ALTER USER c##tester3 ACCOUNT UNLOCK;

CREATE TABLE Book (
bookid NUMBER(2) PRIMARY KEY,
bookname VARCHAR2(40),
publisher VARCHAR2(40),
price NUMBER(8)
);

CREATE TABLE Customer (
custid NUMBER(2) PRIMARY KEY,
name VARCHAR2(40),
address VARCHAR2(50),
phone VARCHAR2(20)
);

CREATE TABLE Orders (
orderid NUMBER(2) PRIMARY KEY,
custid NUMBER(2) REFERENCES Customer(custid),
bookid NUMBER(2) REFERENCES Book(bookid),
saleprice NUMBER(8),
orderdate DATE
);

/* Book, Customer, Orders 데이터 생성 */
INSERT INTO Book VALUES(1, '축구의 역사', '굿스포츠', 7000);
INSERT INTO Book VALUES(2, '축구아는 여자', '나무수', 13000);
INSERT INTO Book VALUES(3, '축구의 이해', '대한미디어', 22000);
INSERT INTO Book VALUES(4, '골프 바이블', '대한미디어', 35000);
INSERT INTO Book VALUES(5, '피겨 교본', '굿스포츠', 8000);
INSERT INTO Book VALUES(6, '역도 단계별기술', '굿스포츠', 6000);
INSERT INTO Book VALUES(7, '야구의 추억', '이상미디어', 20000);
INSERT INTO Book VALUES(8, '야구를 부탁해', '이상미디어', 13000);
INSERT INTO Book VALUES(9, '올림픽 이야기', '삼성당', 7500);
INSERT INTO Book VALUES(10, 'Olympic Champions', 'Pearson', 13000);

INSERT INTO Customer VALUES (1, '박지성', '영국 맨체스타', '000-5000-0001');
INSERT INTO Customer VALUES (2, '김연아', '대한민국 서울', '000-6000-0001');
INSERT INTO Customer VALUES (3, '장미란', '대한민국 강원도', '000-7000-0001');
INSERT INTO Customer VALUES (4, '추신수', '미국 클리블랜드', '000-8000-0001');
INSERT INTO Customer VALUES (5, '박세리', '대한민국 대전', NULL);

INSERT INTO Orders VALUES (1, 1, 1, 6000, TO_DATE('2020-07-01','yyyy-mm-dd'));
INSERT INTO Orders VALUES (2, 1, 3, 21000, TO_DATE('2020-07-03','yyyy-mm-dd'));
INSERT INTO Orders VALUES (3, 2, 5, 8000, TO_DATE('2020-07-03','yyyy-mm-dd'));
INSERT INTO Orders VALUES (4, 3, 6, 6000, TO_DATE('2020-07-04','yyyy-mm-dd'));
INSERT INTO Orders VALUES (5, 4, 7, 20000, TO_DATE('2020-07-05','yyyy-mm-dd'));
INSERT INTO Orders VALUES (6, 1, 2, 12000, TO_DATE('2020-07-07','yyyy-mm-dd'));
INSERT INTO Orders VALUES (7, 4, 8, 13000, TO_DATE('2020-07-07','yyyy-mm-dd'));
INSERT INTO Orders VALUES (8, 3, 10, 12000, TO_DATE('2020-07-08','yyyy-mm-dd'));
INSERT INTO Orders VALUES (9, 2, 10, 7000, TO_DATE('2020-07-09','yyyy-mm-dd'));
INSERT INTO Orders VALUES (10, 3, 8, 13000, TO_DATE('2020-07-10','yyyy-mm-dd'));

CREATE TABLE Imported_Book (
bookid NUMBER,
bookname VARCHAR(40),
publisher VARCHAR(40),
price NUMBER(8)
);

INSERT INTO Imported_Book VALUES(21, 'Zen Golf', 'Pearson', 12000);
INSERT INTO Imported_Book VALUES(22, 'Soccer Skills', 'Human Kinetics', 15000);

COMMIT;

select * from book;
select * from customer;
select * from orders;

--마당서점의 고객이 요구하는 다음 질문에 대해 SQL 문을 작성하시오.
--(1) 도서번호가 1인 도서의 이름
select bookname
  from book
 where bookid = 1; 
--(2) 가격이 20,000원 이상인 도서의 이름 <= 김강현
select bookname
  from book
 where price >= 20000;
--(3) 박지성의 총 구매액(박지성의 고객번호는 1번으로 놓고 작성) <= 김무년
select sum(saleprice)
  from customer t1, orders t2
 where t1.custid = t2.custid
   and t1.custid = 1;
select sum(saleprice)
  from customer t1, orders t2
 where t1.custid = t2.custid
   and t1.name = '박지성';   
--(4) 박지성이 구매한 도서의 수(박지성의 고객번호는 1번으로 놓고 작성) <= 김세영
select count(*) "박지성이 구매한 도서의 수"
  from orders
 where custid = 1; 
--(1) 마당서점 도서의 총 개수 <= 김소라
SELECT COUNT(*) BOOKCOUNT
  FROM BOOK;
--(2) 마당서점에 도서를 출고하는 출판사의 총 개수 <= 김영빈
select count(publisher)
  from (select publisher
          from book
      GROUP by publisher);
select count(distinct publisher) 
  from book;      
--(3) 모든 고객의 이름, 주소 <= 박현근
select name, address
  from customer; 
--(4) 2020년 7월 4일~7월 7일 사이에 주문 받은 도서의 주문번호 <= 이규민
select orderid, orderdate 
  from orders
 WHERE orderdate BETWEEN TO_DATE('20-07-04', 'YY-MM-DD') 
                     AND TO_DATE('20-07-07', 'YY-MM-DD');  
                     
select orderid, orderdate 
  from orders
 WHERE orderdate >= TO_DATE('20-07-04', 'YY-MM-DD') 
   and orderdate <= TO_DATE('20-07-07', 'YY-MM-DD');                     
--(5) 2020년 7월 4일~7월 7일 사이에 주문 받은 도서를 제외한 도서의 주문번호 <= 이준혁
select orderid, orderdate 
  from orders
 WHERE orderdate not BETWEEN TO_DATE('20-07-04', 'YY-MM-DD') 
                         AND TO_DATE('20-07-07', 'YY-MM-DD'); 
select orderid, orderdate 
  from orders
 WHERE orderdate < TO_DATE('20-07-04', 'YY-MM-DD') 
    or orderdate > TO_DATE('20-07-07', 'YY-MM-DD');                           
--(6) 성이 ‘김’ 씨인 고객의 이름과 주소 <= 정윤해
select name, address
  from customer
 where name like '김%';
--(7) 성이 ‘김’ 씨이고 이름이 ‘아’로 끝나는 고객의 이름과 주소 <= 조세령
select name, address
  from customer
 where name like '김%아';
 
--박지성이 주문한 도서이름과 주문일을 출력하시오.
select t3.bookname, t1.orderdate
  from orders t1 inner join customer t2
                 on t1.custid = t2.custid
                 inner join book t3
                 on t1.bookid = t3.bookid
 where t2.name = '박지성';

select t3.bookname, t1.orderdate
  from orders t1, customer t2, book t3
 where t1.custid = t2.custid   
   and t1.bookid = t3.bookid
   and t2.name = '박지성';                 
 
select *
  from customer t1, (select *
                       from book b,orders o
                      where b.bookid=o.bookid) t2
where t1.custid = t2.custid
  and t1.name   = '박지성'; 

select *
  from orders t1, customer t2, book t3
 where t1.custid = t2.custid   
   and t1.bookid = t3.bookid
   and t2.name = '박지성';  
 
--박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이

select t3.bookname, t3.price, t1.saleprice, round(t3.price-t1.saleprice)
  from orders t1, customer t2, book t3
 where t1.custid = t2.custid   
   and t1.bookid = t3.bookid
   and t2.name in('박지성','김연아');  

--박지성이 구매하지 않은 도서의 이름
select t3.bookname , t2.name
  from orders t1, customer t2, book t3
 where t1.custid = t2.custid   
   and t1.bookid = t3.bookid
   and t2.name not in ('박지성','김연아');

--주문하지 않은 고객의 이름
--outer join
select t1.name
  from customer t1 left outer join orders t2
                   on t1.custid = t2.custid
 where t2.orderid is null;

--서브쿼리(상관쿼리)
select t1.name
  from customer t1
 where not exists ( select *
                      from orders t2
                     where t2.custid = t1.custid ) ;

--고객의 이름과 고객별 구매액
select t1.name , sum(t2.saleprice)
  from customer t1 inner join orders t2
                   on t1.custid = t2.custid
group by t1.custid, t1.name;
                   
--고객의 이름과 고객별 구매액 (총구매액이 30000이상인)

select t1.name , sum(t2.saleprice) total
  from customer t1 inner join orders t2
                   on t1.custid = t2.custid
group by t1.custid, t1.name
having sum(t2.saleprice) >= 30000;

--'박씨' 고객의 이름과 고객별 구매액 오름차순 (총구매액이 30000이상인)
select t1.name , sum(t2.saleprice) total
  from customer t1 inner join orders t2
                   on t1.custid = t2.custid
 where t1.name like '박%'                   
group by t1.custid, t1.name
having sum(t2.saleprice) >= 30000
order by total;

--도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름

select t1.name, avg(t2.saleprice)
  from customer t1, orders t2
 where t1.custid = t2.custid
group by t1.custid, t1.name;

select avg(t1.saleprice)
  from orders t1;
                                
  select t1.name, avg(t2.saleprice)
    from customer t1, orders t2
   where t1.custid = t2.custid
group by t1.custid, t1.name
  having avg(t2.saleprice) > ( select avg(t1.saleprice)
                                 from orders t1);
  

 
 
 
 
 

