

-- 9번 
DROP TABLE T ;
CREATE TABLE T (
C INTEGER PRIMARY KEY, D INTEGER
);
INSERT INTO T VALUES (1 , 1);
INSERT INTO T VALUES (2 , 1);

CREATE TABLE S (
B INTEGER PRIMARY KEY, c INTEGER REFERENCES T(C) ON DELETE CASCADE 
);

INSERT INTO S VALUES (1 , 1);
INSERT INTO S VALUES (2 , 1);

CREATE TABLE R (
A INTEGER PRIMARY KEY, B INTEGER REFERENCES S(B) ON DELETE SET NULL
);

INSERT INTO R VALUES (1 , 1);
INSERT INTO R VALUES (2 , 2);

SELECT *FROM T ;
SELECT *FROM S ;
SELECT *FROM R ;

-- 할때 
DELETE FROM T ;

-- 의 값은 ? 
SELECT *FROM R ;



-- 13번

CREATE TABLE  학생(
학번 CHAR(8) PRIMARY KEY 
, 장학금 INTEGER
);
INSERT INTO 학생 VALUES ('1',1234);
INSERT INTO 학생 VALUES ('2',1344);
INSERT INTO 학생 VALUES ('3',1554);

SELECT * FROM 학생;

SELECT COUNT(*) FROM 학생;
SELECT COUNT(학번) FROM 학생 ;


--17 번 

CREATE TABLE 부서 (
부서번호 CHAR(10) 
,부서명 CHAR(10)
);

ALTER TABLE 부서 ADD CONSTRAINT PK_부서_부서번호 PRIMARY KEY (부서번호);
COMMIT;

CREATE TABLE 직원 (
직원번호 CHAR(10) ,
소속부서 CHAR(10)
);

ALTER TABLE 직원 ADD CONSTRAINT PK_직원_직원번호 PRIMARY KEY (직원번호);
ALTER TABLE 직원 ADD CONSTRAINT FK_직원_소속부서 FOREIGN KEY (소속부서) REFERENCES 부서(부서번호) ON DELETE CASCADE;

INSERT INTO 부서  VALUES ('10' , '영업과');
INSERT INTO 부서  VALUES ('20' , '기획과');

INSERT INTO 직원  VALUES ('1000' , '10');
INSERT INTO 직원  VALUES ('2000' , '20');
INSERT INTO 직원  VALUES ('3000' , '20');
COMMIT; 

SELECT * FROM 부서 ;
SELECT * FROM 직원 ;


SELECT COUNT(직원번호) FROM 직원 ;
SELECT * FROM 직원 ;

DELETE FROM 부서 WHERE 부서번호 = '20';
SELECT * FROM 부서 ;

SELECT COUNT(직원번호) FROM 직원 ;
SELECT * FROM 직원 ;

COMMIT;


-- 22번 
CREATE TABLE 고객 (
    고객ID VARCHAR2(20) NOT NULL 
    , 고객명 VARCHAR(20) NULL 
    , 가입일시 DATE NOT NULL 
);
ALTER TABLE 고객 ADD CONSTRAINT PK_고객ID PRIMARY KEY (고객ID);

CREATE TABLE 주문 (
주문번호 VARCHAR(20) NOT NULL  
, 고객ID VARCHAR(20) NOT NULL
, 주문일시 DATE NOT NULL 
);

ALTER TABLE 주문 ADD CONSTRAINT FK_고객ID FOREIGN KEY (고객ID) REFERENCES 고객(고객ID) ON DELETE SET NULL;

INSERT INTO 고객 VALUES('C001','홍길동','2013-12-12');
INSERT INTO 고객 VALUES('C002','이순신','2013-12-12');

COMMIT;

INSERT INTO 주문 VALUES('0001','C001','2013-12-24');
INSERT INTO 주문 VALUES('0002','C001','2013-12-25');
INSERT INTO 주문 VALUES('0003','C002','2013-12-26');
INSERT INTO 주문 VALUES('0004','C002','2013-12-27');

SELECT * FROM 고객 ; 
SELECT * FROM 주문 ; 
DROP TABLE 고객 ;
DROP TABLE 주문 ;
-- 오류 없이 정상적으로 수행되는 SQL 을 고르시오 
-- 1.번
INSERT INTO 고객 VALUES ('C003','강감찬' , '2014-01-01'); -- 가능
-- 2.번
INSERT INTO 주문 VALUES ('0005', 'C003' , '2013-12-28'); 
-- 고객데이터에 C003 이라는 데이터가 없어서 주문 등록이 안됨
-- 3번 
DELETE FROM 주문 WHERE 주문번호 IN ('0001' ,'0002'); --가능

-- 4번 
DELETE FROM 고객 WHERE 고객ID = 'C002';
-- 주문테이블에 고객ID에 NOT NULL 이 걸려있어서 충돌남   

------------------------------------------------------------------
------------------------------------------------------------------

CREATE TABLE 일자별매출_93 (
    일자 DATE,
    매출액 NUMBER(5)
);

INSERT INTO 일자별매출_93 VALUES ('2015-11-01', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-02', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-03', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-04', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-05', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-06', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-07', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-08', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-09', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-10', 1000);
COMMIT;

SELECT 
*
FROM 일자별매출_93;


-- 보기 1 
select A.일자 , sum(A.매출액) as 누적매출액
from 일자별매출_93 A
GROUP by A.일자 
order by A.일자 
;


-- 보기 2

SELECT B.일자, SUM(B.매출액) AS 누적매출액
FROM 일자별매출_93 A
JOIN 일자별매출_93 B 
ON (A.일자 >= B.일자)
GROUP BY B.일자
ORDER BY B.일자;

SELECT A.일자, A.매출액, B.일자, B.매출액
FROM 일자별매출_93 A
JOIN 일자별매출_93 B 
ON (A.일자 >= B.일자)
ORDER BY B.일자;


-- 86번

CREATE TABLE 회원기본정보_86 (
    user_id VARCHAR2(200) PRIMARY KEY
);

CREATE TABLE 회원상세정보_86 (
    user_id VARCHAR2(200)    
);
ALTER TABLE 회원상세정보_86
ADD CONSTRAINT fk_user_id 
FOREIGN KEY (user_id)
references 회원기본정보_86 (user_id);

insert into 회원기본정보_86 values ('abc01');
insert into 회원기본정보_86 values ('abc02');
insert into 회원기본정보_86 values ('abc03');
commit
;

insert into 회원상세정보_86 values ('abc01');
insert into 회원상세정보_86 values ('abc02');
insert into 회원상세정보_86 values ('abc03');
commit;

select * from 회원기본정보_86 ;
select * from 회원상세정보_86 ;

-- 보기 1 
select * from 회원기본정보_86 
minus
select * from 회원상세정보_86 ;

-- 보기 2
select * from 회원기본정보_86 
union all
select * from 회원상세정보_86 ;



-- 보기 3
SELECT user_id FROM 회원기본정보_86
INTERSECT
SELECT user_id FROM 회원상세정보_86
;

SELECT A.user_id 
FROM 회원기본정보_86 A 
JOIN 회원상세정보_86 B 
ON A.user_id = B.user_id
;

-- 보기 4
SELECT user_id FROM 회원기본정보_86
INTERSECT
SELECT user_id FROM 회원상세정보_86
;

SELECT user_id FROM 회원기본정보_86
UNION
SELECT user_id FROM 회원상세정보_86
;