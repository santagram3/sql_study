

-- DML : ������ ���۾� 
-- ��ȸ (SELECT) , ����(INSERT M UPDATE , DELETE)



INSERT INTO board
    
(bno , title , content , writer ,reg_date)
    VALUES
    (1,'�����̾�' ,'�����' , '�Ѹ� ' ,   SYSDATE + 1);

INSERT INTO board
    
(bno ,  content , writer )
    VALUES
    (2,'�����' , '�Ѹ� ' );
-- NOT NULL �������� ���� 

INSERT INTO board  
(bno , title , content , writer )
    VALUES
    (1,'�����̾�' ,'�����' , '�Ѹ� ' );
-- PK �������� ���� 

INSERT INTO board
(bno , title , writer )
    VALUES
    (2,'�����̾�' , '±��' );
    -- ���� ,���׵���Ʈ�� ����Ʈ0�̱� ������ �⺻���� 0 �̴� 


INSERT INTO board
-- ��� �Ǵµ� , ������� ������ �°� ����� �Ѵ� 
    VALUES
    (3,'��������' ,'�轺�зο�' , '���ϳ��� ' ,   SYSDATE + 1);
    -- �÷��� ������� �ʾ��� ��� �ݵ�� ��� �÷��� ���� ������� ä������ 


-- ������ ���� 

UPDATE board
SET title = '������ �����̾�~'
WHERE bno = 3 ;

UPDATE board
SET writer = '������'
    , content = '������ �����Դϴ�. fix'
WHERE bno = 2 ;

-- WHERE �� ������ ���������� 
UPDATE board
SET writer = '���۳�';
-- ��ü �����͸� ���۳����� �����ع����� .

-- ������ ���� -�߰� ������ ������� ������� ��ü �� �ϳ��� ������ �Ѵ� 
DELETE FROM board
WHERE bno = 1 ;

-- ��ü ������ ���� 
-- 1. WHERE���� ������ DELETE��
-- (�ѹ� ���� , ����Ŀ�� ����, �α� ����� ����)
DELETE FROM board ; 

-- 2. TRUNCATE TABLE
--(�ѹ� �Ұ��� , �ڵ�Ŀ�� , �α׸� ���� �� ���� , ���̺� ���� �ʱ� ���·� ���� )

TRUNCATE TABLE board; 

-- 3.   DROP TABLE 
--(�ѹ� �Ұ��� , �ڵ�Ŀ�� , �α׸� ���� �� ���� , ���̺� ������ ���� ������ )

7DROP TABLE board; 









COMMIT;

ROLLBACK;

SELECT
    * FROM board;
