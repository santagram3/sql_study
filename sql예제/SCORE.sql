CREATE TABLE score (
    stu_num NUMBER(10),
    stu_name VARCHAR2(20) NOT NULL,
    kor NUMBER(3) NOT NULL,
    eng NUMBER(3) NOT NULL,
    math NUMBER(3) NOT NULL,
    total NUMBER(3),
    average NUMBER(5,2),
    CONSTRAINT pk_score PRIMARY KEY (stu_num)
);
-- Repository layar 
-- �𵨰�ü  �����ΰ�ü ����Ƽ 

-- ���ӵ� ���� ����
CREATE SEQUENCE seq_score;
-- �ڵ����� 1 �����ϴ� ���� ���� ���� 
-- �ߺ����� 
SELECT * FROM score;
SELECT * FROM score WHERE stu_num = 3;

INSERT INTO score VALUES (seq_score.nextval,  'ȫ�浿', 90, 90, 90, 270, 90);
INSERT INTO score VALUES (seq_score.nextval,  '��ö��', 80, 80, 80, 240, 80);
INSERT INTO score VALUES (seq_score.nextval,  '�ڿ���', 100, 100, 100, 300, 100);
COMMIT;






