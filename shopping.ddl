-- 생성자 Oracle SQL Developer Data Modeler 21.4.0.345.2220
--   위치:        2021-12-16 12:27:33 KST
--   사이트:      Oracle Database 12c
--   유형:      Oracle Database 12c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE customer (
    id       VARCHAR2(20) NOT NULL,
    pwd      VARCHAR2(20) NOT NULL,
    name     VARCHAR2(20) NOT NULL,
    phone    VARCHAR2(11),
    register VARCHAR2(13),
    address  VARCHAR2(100)
);

ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY ( id );

CREATE TABLE orders (
    oseq     NUMBER(6) NOT NULL,
    quantity NUMBER(10),
    indate   DATE,
    id       VARCHAR2(20) NOT NULL,
    pcode    VARCHAR2(20) NOT NULL
);

ALTER TABLE orders ADD CONSTRAINT orders_pk PRIMARY KEY ( id,
                                                          pcode );

CREATE TABLE product (
    pcode VARCHAR2(20) NOT NULL,
    pname VARCHAR2(100),
    price VARCHAR2(10)
);

ALTER TABLE product ADD CONSTRAINT product_pk PRIMARY KEY ( pcode );

ALTER TABLE orders
    ADD CONSTRAINT customer_fk FOREIGN KEY ( id )
        REFERENCES customer ( id );

ALTER TABLE orders
    ADD CONSTRAINT product_fk FOREIGN KEY ( pcode )
        REFERENCES product ( pcode );



-- Oracle SQL Developer Data Modeler 요약 보고서: 
-- 
-- CREATE TABLE                             3
-- CREATE INDEX                             0
-- ALTER TABLE                              5
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
