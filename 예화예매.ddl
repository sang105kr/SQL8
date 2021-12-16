-- 생성자 Oracle SQL Developer Data Modeler 21.4.0.345.2220
--   위치:        2021-12-16 17:05:51 KST
--   사이트:      Oracle Database 12c
--   유형:      Oracle Database 12c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE member (
    member_no   NUMBER NOT NULL,
    member_name VARCHAR2(20),
    reg_no      VARCHAR2(8),
    tel_no      VARCHAR2(11),
    email       VARCHAR2(50),
    id          VARCHAR2(40),
    pw          VARCHAR2(50),
    point       NUMBER(4)
);

COMMENT ON COLUMN member.member_no IS
    '회원번호';

COMMENT ON COLUMN member.member_name IS
    '이름';

COMMENT ON COLUMN member.reg_no IS
    '주민번호';

COMMENT ON COLUMN member.tel_no IS
    '전화번호';

COMMENT ON COLUMN member.email IS
    '이메일';

COMMENT ON COLUMN member.id IS
    '회원아이디';

COMMENT ON COLUMN member.pw IS
    '비밀번호';

COMMENT ON COLUMN member.point IS
    '포인트';

ALTER TABLE member ADD CONSTRAINT member_pk PRIMARY KEY ( member_no );

CREATE TABLE movie (
    movie_no    NUMBER NOT NULL,
    movie_title VARCHAR2(100),
    director    VARCHAR2(20),
    actor       VARCHAR2(20)
);

COMMENT ON COLUMN movie.movie_no IS
    '영화번호';

COMMENT ON COLUMN movie.movie_title IS
    '영화제목';

COMMENT ON COLUMN movie.director IS
    '감독';

COMMENT ON COLUMN movie.actor IS
    '주연배우';

ALTER TABLE movie ADD CONSTRAINT movie_pk PRIMARY KEY ( movie_no );

CREATE TABLE refund (
    refund_no     NUMBER NOT NULL,
    refund_charge NUMBER(16),
    cancel_method VARCHAR2(20)
);

ALTER TABLE refund
    ADD CONSTRAINT refund_cancel_method_ck CHECK ( cancel_method IN ( '1', '2' ) );

COMMENT ON COLUMN refund.refund_no IS
    '환불번호';

COMMENT ON COLUMN refund.refund_charge IS
    '환불금액';

COMMENT ON COLUMN refund.cancel_method IS
    '취소방법';

ALTER TABLE refund ADD CONSTRAINT refund_pk PRIMARY KEY ( refund_no );

CREATE TABLE reserve (
    reserve_no       NUMBER NOT NULL,
    reserve_date     DATE,
    reserve_quantity NUMBER(10),
    reserve_charge   NUMBER(16),
    approval_method  VARCHAR2(20),
    ticket_no        NUMBER NOT NULL,
    refund_no        NUMBER NOT NULL,
    member_no        NUMBER NOT NULL
);

ALTER TABLE reserve
    ADD CONSTRAINT reserve_approval_method CHECK ( approval_method IN ( '1', '2', '3' ) );

COMMENT ON COLUMN reserve.reserve_no IS
    '예매번호';

COMMENT ON COLUMN reserve.reserve_date IS
    '예매일자';

COMMENT ON COLUMN reserve.reserve_quantity IS
    '예매수량';

COMMENT ON COLUMN reserve.reserve_charge IS
    '예매금액';

COMMENT ON COLUMN reserve.approval_method IS
    '결재방법';

COMMENT ON COLUMN reserve.ticket_no IS
    '영화표번호';

COMMENT ON COLUMN reserve.refund_no IS
    '환불번호';

COMMENT ON COLUMN reserve.member_no IS
    '회원번호';

ALTER TABLE reserve ADD CONSTRAINT reserve_pk PRIMARY KEY ( reserve_no );

CREATE TABLE schedule (
    schedule_no   NUMBER NOT NULL,
    schedule_date DATE,
    schedule_time DATE,
    category      VARCHAR2(20),
    charge        NUMBER(16),
    movie_no      NUMBER NOT NULL,
    screen_no     NUMBER NOT NULL,
    theater_no    NUMBER NOT NULL
);

COMMENT ON COLUMN schedule.schedule_no IS
    '상영일정번호';

COMMENT ON COLUMN schedule.schedule_date IS
    '상영일자';

COMMENT ON COLUMN schedule.schedule_time IS
    '상영시간';

COMMENT ON COLUMN schedule.category IS
    '분류';

COMMENT ON COLUMN schedule.charge IS
    '요금';

COMMENT ON COLUMN schedule.movie_no IS
    '영화번호';

COMMENT ON COLUMN schedule.screen_no IS
    '상영관번호';

COMMENT ON COLUMN schedule.theater_no IS
    '극장번호';

ALTER TABLE schedule ADD CONSTRAINT schedule_pk PRIMARY KEY ( schedule_no );

CREATE TABLE screen (
    screen_no   NUMBER NOT NULL,
    screen_name VARCHAR2(20),
    seat_amount NUMBER(10),
    theater_no  NUMBER NOT NULL
);

COMMENT ON COLUMN screen.screen_no IS
    '상영관번호';

COMMENT ON COLUMN screen.screen_name IS
    '상영관이름';

COMMENT ON COLUMN screen.seat_amount IS
    '좌석수';

COMMENT ON COLUMN screen.theater_no IS
    '극장번호';

ALTER TABLE screen ADD CONSTRAINT screen_pk PRIMARY KEY ( screen_no,
                                                          theater_no );

CREATE TABLE seat (
    seat_no    NUMBER NOT NULL,
    "row"      NUMBER(6),
    col        NUMBER(6),
    assign_yn  VARCHAR2(1),
    screen_no  NUMBER NOT NULL,
    theater_no NUMBER NOT NULL
);

ALTER TABLE seat
    ADD CONSTRAINT seat_assign_yn_ck CHECK ( assign_yn IN ( 'n', 'y' ) );

COMMENT ON COLUMN seat.seat_no IS
    '좌석번호';

COMMENT ON COLUMN seat."row" IS
    '행';

COMMENT ON COLUMN seat.col IS
    '열';

COMMENT ON COLUMN seat.assign_yn IS
    '좌석배정유무';

COMMENT ON COLUMN seat.screen_no IS
    '상영관번호';

COMMENT ON COLUMN seat.theater_no IS
    '극장번호';

ALTER TABLE seat
    ADD CONSTRAINT seat_pk PRIMARY KEY ( seat_no,
                                         screen_no,
                                         theater_no );

CREATE TABLE theater (
    theater          NUMBER NOT NULL,
    theater_branch   VARCHAR2(20),
    theater_position VARCHAR2(20)
);

COMMENT ON COLUMN theater.theater IS
    '극장번호';

COMMENT ON COLUMN theater.theater_branch IS
    '극장지점';

COMMENT ON COLUMN theater.theater_position IS
    '위치';

ALTER TABLE theater ADD CONSTRAINT theater_pk PRIMARY KEY ( theater );

CREATE TABLE ticket (
    ticket_no   NUMBER NOT NULL,
    seat_no     NUMBER NOT NULL,
    screen_no   NUMBER NOT NULL,
    theater_no  NUMBER NOT NULL,
    schedule_no NUMBER NOT NULL
);

COMMENT ON COLUMN ticket.ticket_no IS
    '영화표번호';

COMMENT ON COLUMN ticket.seat_no IS
    '좌석번호';

COMMENT ON COLUMN ticket.screen_no IS
    '상영관번호';

COMMENT ON COLUMN ticket.theater_no IS
    '극장번호';

COMMENT ON COLUMN ticket.schedule_no IS
    '상영일정번호';

ALTER TABLE ticket ADD CONSTRAINT ticket_pk PRIMARY KEY ( ticket_no );

ALTER TABLE reserve
    ADD CONSTRAINT reserve_member_fk FOREIGN KEY ( member_no )
        REFERENCES member ( member_no );

ALTER TABLE reserve
    ADD CONSTRAINT reserve_refund_fk FOREIGN KEY ( refund_no )
        REFERENCES refund ( refund_no );

ALTER TABLE reserve
    ADD CONSTRAINT reserve_ticket_fk FOREIGN KEY ( ticket_no )
        REFERENCES ticket ( ticket_no );

ALTER TABLE schedule
    ADD CONSTRAINT schedule_movie_fk FOREIGN KEY ( movie_no )
        REFERENCES movie ( movie_no );

ALTER TABLE schedule
    ADD CONSTRAINT schedule_screen_fk FOREIGN KEY ( screen_no,
                                                    theater_no )
        REFERENCES screen ( screen_no,
                            theater_no );

ALTER TABLE seat
    ADD CONSTRAINT screen_seat_fk FOREIGN KEY ( screen_no,
                                                theater_no )
        REFERENCES screen ( screen_no,
                            theater_no );

ALTER TABLE screen
    ADD CONSTRAINT theater_screen_fk FOREIGN KEY ( theater_no )
        REFERENCES theater ( theater );

ALTER TABLE ticket
    ADD CONSTRAINT ticket_schedule_fk FOREIGN KEY ( schedule_no )
        REFERENCES schedule ( schedule_no );

ALTER TABLE ticket
    ADD CONSTRAINT ticket_seat_fk FOREIGN KEY ( seat_no,
                                                screen_no,
                                                theater_no )
        REFERENCES seat ( seat_no,
                          screen_no,
                          theater_no );



-- Oracle SQL Developer Data Modeler 요약 보고서: 
-- 
-- CREATE TABLE                             9
-- CREATE INDEX                             0
-- ALTER TABLE                             21
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- TSDP POLICY                              0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
