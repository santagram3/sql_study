

-- # ������ ��������
--  ���������� ��ȸ ����� 1�� ������ ���

-- �μ��ڵ尡 100004���� �μ��� ������� ��ȸ 
SELECT 
    EMP_NO , EMP_NM , DEPT_CD    
FROM tb_emp
WHERE DEPT_CD = '100004';

-- ��� �̸��� �̳����� ����� �����ִ� �μ��� ������� ��ȸ 


SELECT DEPT_CD FROM TB_EMP WHERE EMP_NM = '�̳���';
-- ����� �ϳ��� �����°� ������ ����������� �Ѵ� 
-- 100004 

--- ����̸��� �̰����� ����� ���� �ִ� �μ��� ������� ��ȸ
-- ������ �񱳿�����(=, <>, >, >=, <, <=)�� ������ ���������θ� ���ؾ� ��.

SELECT 
    EMP_NO , EMP_NM , DEPT_CD    
FROM tb_emp
WHERE DEPT_CD = (SELECT DEPT_CD FROM TB_EMP WHERE EMP_NM = '�̰���')
-- '�̳���' �� �Ѹ��ε� '�̰���' ������������ 2���̱⶧���� ���������� Ȯ���ؾߵȴ� 
;
-- ������ �񱳿�����()�� ������ ���������θ� ���ؾ��� 

-- 20200525�� ���� �޿��� ȸ�� ��ü�� 20200525�� 
-- ��ü��� �޿����� ���� ������� ���� ��ȸ 
-- ��� , �̸� , �޿������� , ���� �޿��׼� 
SELECT
    A.EMP_NO , A.EMP_NM , B.PAY_DE ,B.PAY_AMT 
FROM TB_EMP A 
JOIN TB_SAL_HIS B
ON A.EMP_NO = B.EMP_NO

-- ������ �������  TB_EMP ���̺� �ƴϰ� TB_SAL_HIS ���̺� �ƴϴ� 
-- �׳� ���� ������� ���̺��̴� 
WHERE B.PAY_DE = '20200525'
AND B.PAY_AMT  >=  (

SELECT AVG(PAY_AMT) 
FROM TB_SAL_HIS
WHERE PAY_DE = '20200525'
                        )
ORDER BY a.emp_no 
;

-- ȸ�� ��ü 20200525 �޿���� 
SELECT AVG(PAY_AMT) 
FROM TB_SAL_HIS
WHERE PAY_DE = '20200525'
;

-- # ������ �������� 
-- ���������� ��ȸ �Ǽ��� 0�� �̻��ΰ� 
-- ## ������ ������ 
-- 1.IN (,) : ���������� �������� �������� ����߿� �ϳ��� ��ġ�ϸ� �� 
--    ex )  salary IN (200, 300, 400)
--            250 ->  200, 300, 400 �߿� �����Ƿ� false
-- 2.ANY , SOME : ���������� �������� ���������� �˻� ����� �ϳ� �̻� ��ġ�ϸ� �� 
--  EX )  : salary > any(200,300,400) = salary > 200
    --        250  > 200 ���� ũ�Ƿ� TRUE 
-- 3. ALL : ���������� �������� ���������� �������� ��� ��ġ�ϸ� �� 
-- EX )  : salary > ALL(200,300,400) == SALLY �� 250�϶� FALSE 
-- �ֳ��ϸ� 250�� 300���ٴ� �����ϱ� , salary > ALL(200,300,400) �� ���ǿ� �� �¾ƾ� �����̴� 

-- 4. EXISTS : ���������� �������� ���������� ��� �� �����ϴ� ���� �ϳ��� �����ϸ� ��   

-- �ѱ������ͺ��̽���������� �߱��� �ڰ����� ������ �ִ�
-- ����� �����ȣ�� ����̸��� �ش� ����� �ѱ������ͺ��̽���������� 
-- �߱��� �ڰ��� ������ ��ȸ

--1 �ܰ� 
SELECT
    a.emp_no , a.emp_nm , b.certi_cd   
FROM tb_emp A
join tb_emp_certi B
on a.emp_no = b.emp_no
order by a.emp_no
;
SELECT certi_cd 
FROM tb_certi 
WHERE issue_insti_nm = '�ѱ������ͺ��̽������'
;

SELECT 
    A.emp_no, A.emp_nm, COUNT(B.certi_cd) "�ڰ��� ����"
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
WHERE B.certi_cd IN (
                        SELECT certi_cd 
                        FROM tb_certi 
                        WHERE issue_insti_nm = '�ѱ������ͺ��̽������'
                    )
GROUP BY A.emp_no, A.emp_nm
ORDER BY A.emp_no
;

SELECT 
    A.emp_no, A.emp_nm, COUNT(B.certi_cd) "�ڰ��� ����"
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
WHERE B.certi_cd = any (
                        SELECT certi_cd 
                        FROM tb_certi 
                        WHERE issue_insti_nm = '�ѱ������ͺ��̽������'
                    )
GROUP BY A.emp_no, A.emp_nm
ORDER BY A.emp_no
;

-- EXISTS�� : ���������� �������� ���������� ��� �� �����ϴ� ���� �ϳ��� �����ϸ� �� 
-- �ּҰ� ������ �������� �ٹ��ϰ� �ִ� �μ������� ��ȸ (�μ��ڵ� , �μ���)

SELECT 
    A.EMP_NO , a.emp_nm , A.ADDR , a.dept_cd
FROM TB_EMP A 
WHERE ADDR LIKE '%����%';


SELECT 
 dept_cd , DEPT_NM
FROM tb_dept  
WHERE DEPT_CD IN ('100009' ,'100010');

SELECT 
 dept_cd , DEPT_NM
FROM tb_dept  
WHERE dept_CD IN (

SELECT 
     a.dept_cd
FROM TB_EMP A 
WHERE ADDR LIKE '%����%'
)
;

------------------------------ EXISTS
SELECT 
 a.dept_cd , a.DEPT_NM
FROM tb_dept a 
WHERE EXISTS (

                SELECT 
                     --b.dept_cd
                     1
                FROM TB_EMP b 
                WHERE ADDR LIKE '%����%'
                and a.dept_cd = b.dept_cd
                )
;


    -- ���� , ������ ����  �ֳ� ���� �� ���̴� 
 SELECT 
                     --b.dept_cd
                     1
                FROM TB_EMP b 
                WHERE ADDR LIKE '%����%';
                
 SELECT 
                     --b.dept_cd
                     1
                FROM TB_EMP b 
                WHERE ADDR LIKE '%����%';


-- # ���� �÷� �������� 
-- : ���������� ��ȸ �÷��� 2�� �̻��� �������� 


-- �μ����� 2�� �̻��� �μ��߿��� �� �μ��� 
--���� �������� ����� �������rhk �μ��ڵ带 ��ȸ 


-- 1�ܰ� 
SELECT 
    a.emp_no ,a.emp_nm , a.birth_de , a.dept_cd
FROM tb_emp A
where (a.dept_cd , A.birth_de) in 
(('100001','19690204')
,('100002','19790204')
,('100003','19890204')
,('100004','19490204'))
-- in ��ȣ �ȿ� ��ȣ�� and �����̴�  
order by emp_no
;


-- 2�ܰ� ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

SELECT 
    a.emp_no ,a.emp_nm , a.birth_de , a.dept_cd ,b.dept_nm
FROM tb_emp A
join tb_dept B
on a.dept_cd = b.dept_cd 
where (a.dept_cd , A.birth_de) in 
                                (
                                select dept_cd , min(birth_de)
                                from tb_emp
                                GROUP BY dept_cd
                                having count(*) >= 2
                                )
order by emp_no
;

-- �ζ��� �� �������� (from���� ���� �������� )

-- �� ����� ����� �̸��� ��� �޿� ������ ��ȸ�ϰ�ʹ� 

--1 �ܰ� ---------------------------------
SELECT 
    A.EMP_NO , A.EMP_NM , AVG(B.PAY_AMT)
FROM TB_EMP A 
JOIN TB_SAL_HIS B
ON A.EMP_NO = B.EMP_NO
GROUP BY a.emp_no ,a.emp_nm
ORDER BY A.EMP_NO 
;

-- 2 �ܰ� --------------------------------
SELECT 
    A.emp_no, A.emp_nm, B.pay_avg
FROM tb_emp A, (
                 SELECT 
                    emp_no, AVG(pay_amt) AS pay_avg
                 FROM tb_sal_his
                 GROUP BY emp_no
                    ) B
                    -- ��ȣ�ȿ� emp_no,�̰� �־�� 
                    -- where �ȿ� B.emp_no �̰� �����ִ� 
WHERE A.emp_no = B.emp_no
ORDER BY A.emp_no
;


-- ��Į�� �������� (select���� ���� ��������)
-- ����� ���, ����� , �μ��� , ������� �����ڰ������� ��ȸ 
select
    A.emp_no
    , A.emp_nm
    , (SELECT B.dept_nm FROM tb_dept B WHERE A.dept_cd = B.dept_cd) AS dept_nm
    , A.birth_de
    , A.sex_cd
FROM tb_emp A
;




