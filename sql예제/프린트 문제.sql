

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


-- 66�� 


 ��    A                      ������  C

 ��ID    ����           ������ID      ��������
 -------------------          -------------------------------
   A01      ����            B01            �丮����
                                   B02            SQL����
                                   B03            JAVA����


  ��õ ������  B              ��ȣ ������  D

  ��ID    ������ID        ��ID     ������ID
------------------------     ------------------------
   A01        B01              A01          B01
   A01        B03


  
 -- ���� 1  :   A + B + C

  C.������ID     C.��������
-------------------------------
   B01            �丮����
   B03            JAVA����


 -- ���� 2  :   A + B + C + D (ROJ)

  B.��ID    B.������ID     C.��������      D.��ID   D.������ ID    D.��������
------------------------------- --------        ----------------------------------------
  A01          B01            �丮����            A01         B01            �丮����
  A01          B03            JAVA����


  C.������ID     C.��������
-------------------------------
   B01            �丮����




  -- ���� 3  :   (A + B + C) + D   - > LOJ

  B.��ID    B.������ID     C.��������      D.��ID   D.������ ID    D.��������
------------------------------- --------        ----------------------------------------
  A01          B01            �丮����            A01         B01            �丮����
  A01          B03            JAVA����           null          null            null


  C.������ID     C.��������
-------------------------------
   B03            JAVA����



-- ���� 4  

  B.��ID    B.������ID     C.��������      X.��ID   X.������ ID    X.��������
------------------------------- --------        ----------------------------------------
  A01          B01            �丮����            A01         B01            �丮����
  A01          B03            JAVA����



-- 73�� 

  TBL1 A           TBL2  B

   ID                 ID
  ------             -----

   A01              A02
   A02              A03
   A03              A04
   
                                                                                 

-- 80�� 

    ȸ��                      

    ȸ��ID   ȸ����
  --------------------
    A001      ��ö��
    A002      �ڿ���             
                                                   ���� �̿�
  ==================                        
   
    ����                                          ����ID    ȸ��ID       
                                                -------------------------
    ����ID   ���񽺸�                               B001        A001
  ------------------------                         B001        A002
    B001       ���̹�                               B002        A001
    B002       ����                        
    B003       ���� 
    
    












-- 93�� -----------------------------------------------------------
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





-- 97�� 

 ȸ��

 ȸ����ȣ   ȸ����
----------------------
  A01        ����
  A02        �ڻ߻�
  A03        �ֲ���


 ����׸�

 ����ڵ�   �����
----------------------
  B01         ���ϼ��ſ���
  B02         ���ڼ��ſ���
  B03         ����������ȣ���� 


 �����׸�

 ȸ����ȣ   ����ڵ�  ���ǿ���  
--------------------------------------
  A01          B01          Y
  A01          B02          N
  A01          B03          Y
  A02          B01          Y
  A02          B02          Y
  A02          B03          Y
  A03          B01          N
  A03          B02          N
  A03          B03          N


 <���� SQL>

  A.ȸ����ȣ   A.ȸ����   B.���ǿ���      COUNT()
---------------------------  --------------- -----------
    A01           ����         Y  - null    
    A01           ����         N  -  0
    A01           ����         Y  - null
    A02           �ڻ߻�         Y  - null
    A02           �ڻ߻�         Y  - null
    A02           �ڻ߻�         Y  - null
    A03           �ֲ���         N  -  0
    A03           �ֲ���         N  -  0
    A03           �ֲ���         N  -  0

 A.ȸ����ȣ   A.ȸ����       COUNT()
---------------------------   -----------
    A01           ����          1
    A02           �ڻ߻�          0
    A03           �ֲ���          3


 A.ȸ����ȣ   A.ȸ����       COUNT()
---------------------------   -----------
    A01           ����          1
    A03           �ֲ���          3
 
 
 -- 98�� 
 
 
ȸ��                        �̺�Ʈ

 ȸ��ID   ȸ����         �̺�ƮID   �̺�Ʈ��     ��������
--------------------      ----------------------------------
  A01      ����          B01       �����̺�Ʈ   2014.08.01
  A02      �ڲٲ�          B02       Ư���̺�Ʈ   2014.10.04
  A03      �ۻǻ�          B03       �����̺�Ʈ   2014.10.07


 ���Ϲ߼�

 �̺�ƮID     ȸ��ID    �߼��Ͻ�
 ---------------------------------------
  B01           A01       2014.08.01
  B01           A02       2014.08.01
  B01           A03       2014.08.01
  B02           A01       2014.10.04
  B02           A03       2014.10.04
  B03           A01       2014.10.07
  B03           A02       2014.10.07
  B03           A03       2014.10.07


=================================

 �������̺�

 A.ȸ��ID  A.ȸ����  B.�̺�Ʈ��   C.ȸ��ID     
--------------------------------------------------
  A01        ����    Ư���̺�Ʈ   A01
  A01        ����    �����̺�Ʈ   A01
  A02        �ڲٲ�    �����̺�Ʈ   A02
  A03        �ۻǻ�    Ư���̺�Ʈ   A03
  A03        �ۻǻ�    �����̺�Ʈ   A03

 



 
 CREATE TABLE ȸ��_98 ( 
 ȸ��ID VARCHAR2(10)
 ,ȸ���� VARCHAR2(10)
 , �����Ͻ� DATE
 , �̸��� VARCHAR2(20)
 );
 
ALTER TABLE ȸ��_98 ADD CONSTRAINT PK_ȸ��ID PRIMARY KEY (ȸ��ID);

CREATE TABLE ���Ϲ߼�_98 (
    �̺�ƮID VARCHAR2(10) 
    ,ȸ��ID  VARCHAR2(10)
    , �߼��Ͻ� DATE 
);

CREATE TABLE �̺�Ʈ_98 (
    �̺�ƮID VARCHAR2(10)
    ,�̺�Ʈ�� VARCHAR2(10)
    ,�������� DATE 
    ,�������� DATE 
    , ���� VARCHAR2(10)
)









;