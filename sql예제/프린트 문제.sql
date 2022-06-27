

-- 9�� 
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

-- �Ҷ� 
DELETE FROM T ;

-- �� ���� ? 
SELECT *FROM R ;



-- 13��

CREATE TABLE  �л�(
�й� CHAR(8) PRIMARY KEY 
, ���б� INTEGER
);
INSERT INTO �л� VALUES ('1',1234);
INSERT INTO �л� VALUES ('2',1344);
INSERT INTO �л� VALUES ('3',1554);

SELECT * FROM �л�;

SELECT COUNT(*) FROM �л�;
SELECT COUNT(�й�) FROM �л� ;


--17 �� 

CREATE TABLE �μ� (
�μ���ȣ CHAR(10) 
,�μ��� CHAR(10)
);

ALTER TABLE �μ� ADD CONSTRAINT PK_�μ�_�μ���ȣ PRIMARY KEY (�μ���ȣ);
COMMIT;

CREATE TABLE ���� (
������ȣ CHAR(10) ,
�ҼӺμ� CHAR(10)
);

ALTER TABLE ���� ADD CONSTRAINT PK_����_������ȣ PRIMARY KEY (������ȣ);
ALTER TABLE ���� ADD CONSTRAINT FK_����_�ҼӺμ� FOREIGN KEY (�ҼӺμ�) REFERENCES �μ�(�μ���ȣ) ON DELETE CASCADE;

INSERT INTO �μ�  VALUES ('10' , '������');
INSERT INTO �μ�  VALUES ('20' , '��ȹ��');

INSERT INTO ����  VALUES ('1000' , '10');
INSERT INTO ����  VALUES ('2000' , '20');
INSERT INTO ����  VALUES ('3000' , '20');
COMMIT; 

SELECT * FROM �μ� ;
SELECT * FROM ���� ;


SELECT COUNT(������ȣ) FROM ���� ;
SELECT * FROM ���� ;

DELETE FROM �μ� WHERE �μ���ȣ = '20';
SELECT * FROM �μ� ;

SELECT COUNT(������ȣ) FROM ���� ;
SELECT * FROM ���� ;

COMMIT;


-- 22�� 
CREATE TABLE �� (
    ��ID VARCHAR2(20) NOT NULL 
    , ���� VARCHAR(20) NULL 
    , �����Ͻ� DATE NOT NULL 
);
ALTER TABLE �� ADD CONSTRAINT PK_��ID PRIMARY KEY (��ID);

CREATE TABLE �ֹ� (
�ֹ���ȣ VARCHAR(20) NOT NULL  
, ��ID VARCHAR(20) NOT NULL
, �ֹ��Ͻ� DATE NOT NULL 
);

ALTER TABLE �ֹ� ADD CONSTRAINT FK_��ID FOREIGN KEY (��ID) REFERENCES ��(��ID) ON DELETE SET NULL;

INSERT INTO �� VALUES('C001','ȫ�浿','2013-12-12');
INSERT INTO �� VALUES('C002','�̼���','2013-12-12');

COMMIT;

INSERT INTO �ֹ� VALUES('0001','C001','2013-12-24');
INSERT INTO �ֹ� VALUES('0002','C001','2013-12-25');
INSERT INTO �ֹ� VALUES('0003','C002','2013-12-26');
INSERT INTO �ֹ� VALUES('0004','C002','2013-12-27');

SELECT * FROM �� ; 
SELECT * FROM �ֹ� ; 
DROP TABLE �� ;
DROP TABLE �ֹ� ;
-- ���� ���� ���������� ����Ǵ� SQL �� ���ÿ� 
-- 1.��
INSERT INTO �� VALUES ('C003','������' , '2014-01-01'); -- ����
-- 2.��
INSERT INTO �ֹ� VALUES ('0005', 'C003' , '2013-12-28'); 
-- �������Ϳ� C003 �̶�� �����Ͱ� ��� �ֹ� ����� �ȵ�
-- 3�� 
DELETE FROM �ֹ� WHERE �ֹ���ȣ IN ('0001' ,'0002'); --����

-- 4�� 
DELETE FROM �� WHERE ��ID = 'C002';
-- �ֹ����̺� ��ID�� NOT NULL �� �ɷ��־ �浹��   

------------------------------------------------------------------
------------------------------------------------------------------

CREATE TABLE ���ں�����_93 (
    ���� DATE,
    ����� NUMBER(5)
);

INSERT INTO ���ں�����_93 VALUES ('2015-11-01', 1000);
INSERT INTO ���ں�����_93 VALUES ('2015-11-02', 1000);
INSERT INTO ���ں�����_93 VALUES ('2015-11-03', 1000);
INSERT INTO ���ں�����_93 VALUES ('2015-11-04', 1000);
INSERT INTO ���ں�����_93 VALUES ('2015-11-05', 1000);
INSERT INTO ���ں�����_93 VALUES ('2015-11-06', 1000);
INSERT INTO ���ں�����_93 VALUES ('2015-11-07', 1000);
INSERT INTO ���ں�����_93 VALUES ('2015-11-08', 1000);
INSERT INTO ���ں�����_93 VALUES ('2015-11-09', 1000);
INSERT INTO ���ں�����_93 VALUES ('2015-11-10', 1000);
COMMIT;

SELECT 
*
FROM ���ں�����_93;


-- ���� 1 
select A.���� , sum(A.�����) as ���������
from ���ں�����_93 A
GROUP by A.���� 
order by A.���� 
;


-- ���� 2

SELECT B.����, SUM(B.�����) AS ���������
FROM ���ں�����_93 A
JOIN ���ں�����_93 B 
ON (A.���� >= B.����)
GROUP BY B.����
ORDER BY B.����;

SELECT A.����, A.�����, B.����, B.�����
FROM ���ں�����_93 A
JOIN ���ں�����_93 B 
ON (A.���� >= B.����)
ORDER BY B.����;


-- 86��

CREATE TABLE ȸ���⺻����_86 (
    user_id VARCHAR2(200) PRIMARY KEY
);

CREATE TABLE ȸ��������_86 (
    user_id VARCHAR2(200)    
);
ALTER TABLE ȸ��������_86
ADD CONSTRAINT fk_user_id 
FOREIGN KEY (user_id)
references ȸ���⺻����_86 (user_id);

insert into ȸ���⺻����_86 values ('abc01');
insert into ȸ���⺻����_86 values ('abc02');
insert into ȸ���⺻����_86 values ('abc03');
commit
;

insert into ȸ��������_86 values ('abc01');
insert into ȸ��������_86 values ('abc02');
insert into ȸ��������_86 values ('abc03');
commit;

select * from ȸ���⺻����_86 ;
select * from ȸ��������_86 ;

-- ���� 1 
select * from ȸ���⺻����_86 
minus
select * from ȸ��������_86 ;

-- ���� 2
select * from ȸ���⺻����_86 
union all
select * from ȸ��������_86 ;



-- ���� 3
SELECT user_id FROM ȸ���⺻����_86
INTERSECT
SELECT user_id FROM ȸ��������_86
;

SELECT A.user_id 
FROM ȸ���⺻����_86 A 
JOIN ȸ��������_86 B 
ON A.user_id = B.user_id
;

-- ���� 4
SELECT user_id FROM ȸ���⺻����_86
INTERSECT
SELECT user_id FROM ȸ��������_86
;

SELECT user_id FROM ȸ���⺻����_86
UNION
SELECT user_id FROM ȸ��������_86
;