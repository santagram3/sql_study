

--- ������� ���, �̸�  ,�ּ� ,�μ��� 

SELECT 
  E.emp_no , E.emp_nm, E.addr ,D.dept_nm

FROM tb_emp  E
JOIN tb_dept  D
ON E.dept_cd = D.dept_cd
;
-- ���� ���� �׽�Ʈ ������
CREATE TABLE TEST_A (
    id NUMBER(10) PRIMARY KEY -- �Խ��� ��ȣ 
    , content VARCHAR2(200) -- ����
);
CREATE TABLE TEST_B (
    b_id NUMBER(10) PRIMARY KEY -- ��۹�ȣ 
    , reply VARCHAR2(100) -- ����
    , a_id NUMBER(10) -- ������ ��ȣ ����Ű 
);

INSERT INTO TEST_A  VALUES (1, 'aaa');
INSERT INTO TEST_A  VALUES (2, 'bbb');
INSERT INTO TEST_A  VALUES (3, 'ccc');

INSERT INTO TEST_B  VALUES (1, '������', 1);
INSERT INTO TEST_B  VALUES (2, '������', 1);
INSERT INTO TEST_B  VALUES (3, '������', 2);
INSERT INTO TEST_B  VALUES (4, '������', 3);
COMMIT;

SELECT * FROM  test_a;
SELECT * FROM  test_b;

--cartesian product ī�׽þ� ��
SELECT *

FROM test_a,test_b
;  -- ũ�ν� ���� ,cartesian product


-- INNER JOIN (EQUI JOIN�� �� ���� ) 
SELECT 
   *
FROM test_a,test_b 
where test_a.id = test_b.a_id --���� ���� 
;


SELECT 
    test_a.ID, test_a.CONTENT, test_b.REPLY
FROM test_a,test_b 
where test_a.id = test_b.a_id --���� ���� 
;

SELECT 
    A.ID, A.CONTENT, B.REPLY
FROM test_a A , test_b B 
where test_a.id = test_b.a_id --���� ���� 
;


-- �ڰ��� ���� ���̺� 

select * from tb_emp_certi; --emp_no , certi_sn ,certi_cd , 
select * from tb_certi;
select * from tb_dept;

-- ����� �����ȣ�� ����ڰ��� ���� ��ȸ�ϰ���� 

select 
    *
from tb_emp_certi , tb_certi
;



select 
    A.emp_no , B.issue_insti_nm
from tb_emp_certi A , tb_certi B
where A.certi_cd = b.certi_cd
order by emp_no
;


-- ����� �����ȣ�� ��� �̸� �� ��� �ڰ������� ��ȸ�ϰ� ����

select 
    C.emp_nm , A.emp_no , B.issue_insti_nm
from tb_emp_certi A , tb_certi B , tb_emp C
where A.certi_cd = b.certi_cd
   AND A.emp_no = C.emp_no
order by emp_no
;

-- ����� �����ȣ�� ����̸��� �μ��̸��� ��� �ڰ������� ��ȸ�ϰ� ����

select 
    C.emp_nm , A.emp_no , D.dept_nm ,B.issue_insti_nm
from tb_emp_certi A , tb_certi B , tb_emp C , tb_dept D
where A.certi_cd = b.certi_cd
   AND A.emp_no = C.emp_no
   AND c.dept_cd = d.dept_cd
order by emp_no
;


--�μ��� �� �ڰ��� ������ ��ȸ 
-- 1. ������ � �ڰ����� ������ �˾ƾ� �Ѵ� 
 --a.certi_cd

-- �μ��ڵ� , �μ��� , �μ��� �ڰ��� �� 
select 
   b.dept_cd �����ȣ ,c.dept_nm �μ���  ,count(a.certi_cd) "�μ��� �ڰ��� ��" 
from tb_emp_certi A , tb_emp B , tb_dept c  
where A.emp_no = B.emp_no
    and b.dept_cd = C.dept_cd 

group by b.dept_cd , C.dept_nm
order by b.dept_cd
;

-- # INNER JOIN 
-- 1. 2�� �̻��� ���̺��� ����� Į���� �� �� �������� ���յǴ� ���� ����Դϴ�.
-- 2. WHERE���� ���� Į������ �������(=)�� ���ε˴ϴ�.

-- ���νÿ� ��� ����� �����ȣ, ����� , �ּ� , �μ��ڵ� , �μ����� ��ȸ�ϰ�ʹ� .

SELECT 
    A.emp_no, A.emp_nm, A.addr, A.dept_cd, B.dept_nm
FROM tb_emp A, tb_dept B
WHERE A.addr LIKE '%����%'
    AND A.dept_cd = B.dept_cd
    AND A.emp_nm LIKE '��%'
ORDER BY A.emp_no
;



-- JOIN ON (ANSI ǥ�� ����)
-- 1. FROM�� �� , WHERE �� �� 
-- 2. JOIN Ű���� �ڿ��� ������ ���̺���� ��� 
-- 3. ON Ű���� �ڿ��� ���� ������ ��� 
-- 4. ���� ���� ������(ON��) �Ϲ� ���� ������ (WHERER��)�� �и��ؼ� �ۼ��ϴ� �پ�
-- 5. ON ���� �̿��ϸ� JOIN ������ �������̳� ���������� ���� �߰� ������ ���� 

SELECT 
    A.emp_no, A.emp_nm, A.addr, A.dept_cd, B.dept_nm
FROM tb_emp A
INNER JOIN tb_dept B
ON A.dept_cd = B.dept_cd
WHERE A.addr LIKE '%����%'
    AND A.emp_nm LIKE '��%'
ORDER BY A.emp_no
;


-- 1990���� ������� ��� , ����� //emp , �μ��� //dept, �ڰ�����certi , ������ڸ� ��ȸ emp certi 
        
select * from tb_emp_certi;
select * from tb_certi;
select * from tb_dept;
select * from tb_emp;

-- 1980���� ������� ���, �����, �μ���, �ڰ�����, ������ڸ� ��ȸ
SELECT
    E.emp_no, E.emp_nm, D.dept_nm, C.certi_nm, EC.acqu_de
FROM tb_emp E, tb_dept D, tb_emp_certi EC, tb_certi C
WHERE E.dept_cd = D.dept_cd
    AND EC.certi_cd = C.certi_cd
    AND E.emp_no = EC.emp_no
    AND E.birth_de BETWEEN '19800101' AND '19891231'
;



SELECT
    E.emp_no, E.emp_nm ,e.birth_de , D.dept_nm, C.certi_nm, EC.acqu_de
FROM tb_emp E, tb_dept D, tb_emp_certi EC, tb_certi C
WHERE E.dept_cd = D.dept_cd
    AND EC.certi_cd = C.certi_cd
    AND E.emp_no = EC.emp_no
    AND E.birth_de BETWEEN '19800101' AND '19891231'
;

SELECT
    E.emp_no, E.emp_nm, E.birth_de, D.dept_nm, C.certi_nm, EC.acqu_de
FROM tb_emp E 
JOIN tb_dept D 
ON E.dept_cd = D.dept_cd
JOIN tb_emp_certi EC 
ON E.emp_no = EC.emp_no
JOIN tb_certi C
ON EC.certi_cd = C.certi_cd
WHERE E.birth_de BETWEEN '19800101' AND '19891231'
;


-- SELECT [DISTINCT] { ���̸� .... } 
-- FROM  ���̺� �Ǵ� �� �̸�
-- JOIN  ���̺� �Ǵ� �� �̸�
-- ON    ���� ����
-- WHERE ��ȸ ����
-- GROUP BY  ���� �׷�ȭ
-- HAVING    �׷�ȭ ����
-- ORDER BY  ������ �� [ASC | DESC];



-- JOIN ON �������� ī�׽þ� �� ����� 

SELECT 
    * 
FROM test_a, test_b
;

SELECT 
    * 
FROM test_a
CROSS join test_b
;

-- NATURAL JOIN 
-- 1. NATURAL JOIN�� ������ �̸��� ���� �÷��鿡 ���� �ڵ����� ���������� �����ϴ� ����Դϴ�.
-- 2. �� �ڵ����� 2���̻��� ���̺� �ð����̸��� ���� �÷��� ã�� INNER ������ �����մϴ�.
-- 3. �� �� ���εǴ� ���� �̸��� �÷��� ������ Ÿ���� ���ƾ� �ϸ� , 
--    ALLAS�� ���̺���� �ڵ� ���� �÷� �տ� ǥ���ϸ� �ȵ˴ϴ�.
-- 4. SELECT * ������ ����ϸ� , ���� �÷��� �����ؼ� �ѹ��� ǥ��˴ϴ�.
-- 5. ���� �÷��� N�� �̻��̸� ���������� n���� ó���˴ϴ�.     

-- ��� ���̺�� �μ� ���̺��� ���� (��� ,����� ,�μ��ڵ� , �μ��� )

SELECT 
    a.emp_no ,a.emp_nm ,b.dept_cd , b.dept_nm
FROM tb_emp A
inner join tb_dept B
on A.dept_cd = b.dept_cd
;
------------------------ �ٲٸ� ~~~~~~~~~~~~~
SELECT 
--  a.emp_no ,a.emp_nm ,b.dept_cd , b.dept_nm
    a.emp_no ,a.emp_nm ,dept_cd , b.dept_nm
        -- 
FROM tb_emp A
NATURAL join tb_dept B
;

-- ���� ! ���߷� ���ΰ� �׳� ������ ���� ���� �ֳ��� ? 

-- # USING �� ���� 
-- 1. NATURAL ���ο����� �ڵ����� �̸��� Ÿ���� ��ġ�ϴ� ��� Ŀ���� ���� 
--    ������ �Ͼ���� USING�� ����ϸ� ����ϴ� �÷����� ���ؼ��� ������ ���������� 
--    �ο��� �� �ֽ��ϴ�.
-- 2. USING �������� ���� �÷��� ���� ALLAS�� ���̺���� ǥ���Ͻø� �ȵ˴ϴ�.

SELECT 
    a.emp_no ,a.emp_nm , dept_cd , b.dept_nm
FROM tb_emp A
inner join tb_dept B
USING (dept_cd)
;



SELECT 
   *
FROM tb_emp A
inner join tb_dept B
on A.dept_cd = b.dept_cd
;



SELECT 
*
FROM tb_emp A
NATURAL join tb_dept B
;

SELECT 
  *
FROM tb_emp A
inner join tb_dept B
USING (dept_cd)
;







