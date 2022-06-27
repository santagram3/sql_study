-- ���� ������
-- ## UNION
-- 1. ������ ������ �ǹ��Դϴ�.
-- 2. ù��° ������ �ι�° ������ �ߺ������� �ѹ��� �����ݴϴ�.
-- 3. ù��° ������ ���� ������ Ÿ���� �ι�° ������ ������ Ÿ�԰� �����ؾ� ��.
-- 4. �ڵ����� ������ �Ͼ (ù��° �÷� �������� �⺻��)
-- 5. 


SELECT 
--EMP_NO
EMP_NM BN, BIRTH_DE BD
FROM TB_EMP
WHERE BIRTH_DE BETWEEN '19600101' AND '19691231'
------------
UNION
------------
SELECT 
--EMP_NO
EMP_NM BN2 , BIRTH_DE BD2
FROM TB_EMP
WHERE BIRTH_DE BETWEEN '19700101' AND '19791231'
ORDER BY BD DESC
;
-- EMP_NO �� �־����� 
-- ����� �ٸ� ����� �ٸ� ������� �νĵǱ� ������  
-- 1000000014	�̰���	19780213 
-- 1000000023	�̰���	19780213
-- EMP_NO �� �ְ� ���Ͽ��� �ϸ� 8���� �Ǵ°Ű� 
-- EMP_NO �� ���� ���Ͽ��� �ϸ� 7���� �ȴ� 


-- AS "" �� �����ִ°ɷ� ���� 
-- ������ �׻� ���Ͽ��� ������ �ڸ� 

-- ## UNION ALL
-- 1. UNION�� ���� �� ���̺�� �������� ���ļ� �����ݴϴ�.
-- 2. UNION���� �޸� �ߺ��� �����͵� �ѹ� �� �����ݴϴ�.
-- 3. �ڵ� ���� ����� �������� �ʾ� ���ɻ� �����մϴ�.

SELECT 
EMP_NO
,EMP_NM BN, BIRTH_DE BD
FROM TB_EMP
WHERE BIRTH_DE BETWEEN '19600101' AND '19691231'
------------
UNION ALL
------------
SELECT 
EMP_NO
,EMP_NM BN2 , BIRTH_DE BD2
FROM TB_EMP
WHERE BIRTH_DE BETWEEN '19700101' AND '19791231'
;

-- ���� ���� 
-- �ߺ����� ���� 
-- �׷��� �÷������� , Ÿ���� �¾ƾ� �� 
-- �׷��� 8���� ���� �̰��� 2 �� �� ���� 

-------------------------------------------------------------------------------

-- ## INTERSECT (�� �� ��) 
-- 1. ù��° ������ �ι�° �������� �ߺ��� �ุ�� ����մϴ�.
-- 2. �������� �ǹ��Դϴ�.

SELECT 
    A.emp_no, A.emp_nm, A.addr
    , B.certi_cd, C.certi_nm
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
JOIN tb_certi C 
ON B.certi_cd = C.certi_cd 
WHERE C.certi_nm = 'SQLD'
-- 'SQLD' �� �ֵ��� ������ ? 
INTERSECT
SELECT 
    A.emp_no, A.emp_nm, A.addr
    , B.certi_cd, C.certi_nm
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
JOIN tb_certi C 
ON B.certi_cd = C.certi_cd 
WHERE A.addr LIKE '%����%';
-- ���λ�¾��߿� �ڰ��� �ִ¾� ������ ?? 

SELECT 
    A.emp_no, A.emp_nm, A.addr
    , B.certi_cd, C.certi_nm
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
JOIN tb_certi C 
ON B.certi_cd = C.certi_cd 
WHERE A.addr LIKE '%����%'
    AND C.certi_nm = 'SQLD'
;

-- ## MINUS(EXCEPT) 
-- 1. �ι�° �������� ���� ù��° �������� �ִ� �����͸� �����ݴϴ�.
-- 2. �������� �����Դϴ�.

SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp
MINUS
SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp WHERE dept_cd = '100001'
MINUS
SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp WHERE dept_cd = '100004'
MINUS
SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp WHERE sex_cd = '1'
MINUS 
SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp
;

--------------------------------------------------------------
--------------------------------------------------------------

--������ ���� 
-- START WITH : ������ ù �ܰ踦 ��� ������ �������� ���� ���� 
-- CONNECT BY PRIOR �ڽ� = �θ�  -- > ������ Ž��
-- CONNECT BY �ڽ� = PRIOR �θ� -- > ������ Ž�� 
-- ORDER SIBILINGS BY : ���� ���������� ������ ���� .
    

SELECT 
    LEVEL AS LVL,
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "�����ο�",
    A.dept_cd,
    B.dept_nm,
    A.emp_no,
    A.direct_manager_emp_no,
    CONNECT_BY_ISLEAF
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
START WITH A.direct_manager_emp_no IS NULL 
CONNECT BY PRIOR A.emp_no = A.direct_manager_emp_no;

-- START WITH A.direct_manager_emp_no IS NULL 
--��簡 - NULL �� �ֵ���� �����ض� 

-- CONNECT BY PRIOR A.emp_no = A.direct_manager_emp_no;
-- CONNECT BY PRIOR �ڽ� = �θ�  -- > ������ Ž��


SELECT 
    LEVEL AS LVL,
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "�����ο�",
    A.dept_cd,
    B.dept_nm,
    A.emp_no,
    a.direct_manager_emp_no
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
START WITH A.emp_no = '1000000037'
CONNECT BY A.emp_no = PRIOR A.direct_manager_emp_no;

----------------------------------------------------

SELECT 
-- LEVEL AS LVL, 
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "�����ο�",
    A.dept_cd,
    B.dept_nm,
    A.emp_no,
    A.direct_manager_emp_no,
    CONNECT_BY_ISLEAF
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
START WITH A.direct_manager_emp_no IS NULL 
CONNECT BY PRIOR A.emp_no = A.direct_manager_emp_no
ORDER SIBLINGS BY A.EMP_NO DESC;
--   ORDER SIBLINGS BY A.EMP_NO DESC;
---- ORDER SIBILINGS BY : ���� ���������� ������ ���� .




-- SELF JOIN 
-- 1. �ϳ��� ���̺��� �ڱ� �ڽ��� ���̺��� �����ϴ� ����Դϴ�.
-- 2. �ڱ� �ڽ� ���̺��� PK�� FK�� ���� �����մϴ�.


SELECT 
a.EMP_NO , a.EMP_NM , a.direct_manager_emp_no , b.emp_nm
FROM  tb_emp A
INNER JOIN tb_emp B
on a.direct_manager_emp_no = b.emp_no
-- where dept_cd = '100002'
ORDER BY emp_no
;


SELECT 
  a.EMP_NO 
, a.EMP_NM "��� ��"
, a.addr "��� �ּ�"
, a.direct_manager_emp_no
, b.emp_nm "���ӻ���� �����"
, b.addr "���� ����� �ּ�"
FROM  tb_emp A
INNER JOIN tb_emp B
on a.direct_manager_emp_no = b.emp_no

ORDER BY emp_no
;
--
alter table tb_emp 
add constraint fk_direct_manager_emp_no --��������� �Ŵ°��� 
foreign key (direct_manager_emp_no) --������ ����Ű�� ���� ���ϰ� 
references tb_emp (emp_no); -- ���� pk �� �ɲ��� ? ���̺�� (���̺� pk �÷�)



SELECT 
  a.EMP_NO 
, a.EMP_NM "��� ��"
, a.addr "��� �ּ�"
, a.direct_manager_emp_no
, b.emp_nm "���ӻ���� �����"
, b.addr "���� ����� �ּ�"
FROM  tb_emp A
left JOIN tb_emp B
on a.direct_manager_emp_no = b.emp_no

ORDER BY emp_no
;



----------------------------------------------------
-----------91��-------------------------------------
----------------------------------------------------


# ���� 1

   �μ��ڵ�   �μ���     �����μ��ڵ�    LVL
  =============================
      120      �Ϻ�����       100              1
      100      �ƽþ�����    null              2

   �μ��ڵ�   �μ���     �����μ��ڵ�    LVL
  =============================
      120      �Ϻ�����       100              1
      121      ��������       120              2
      122     ����ī����     120              2



   �μ��ڵ�   �μ���     �����μ��ڵ�    LVL
  =============================
      100      �ƽþ�����    null              2
      120      �Ϻ�����       100              1
      121      ��������       120              2
      122     ����ī����     120              2


   �μ��ڵ�   �μ���     �����μ��ڵ�    LVL     b.�����   
  =====================================
      100      �ƽþ�����    null              2         null
      120      �Ϻ�����       100              1         null
      121      ��������       120              2        1500
      122     ����ī����     120              2        1000


# ����2 


   �μ��ڵ�   �μ���        �����μ��ڵ�    LVL     �����
  =============================
    100         �ƽþ�����       null             1        null
    110         �ѱ�����         100              2        null
    111         ��������         110              3        1000 
    112         �λ�����         110              3        2000
    120         �Ϻ�����         100              2        null
    121         ��������         120              3        1500
    122         ����ī����      120              3        1000
    130         �߱�����         100              2        null
    131         ����¡����      130              3        1500
    132         ����������      130              3        2000


# ����3 


   �μ��ڵ�   �μ���        �����μ��ڵ�    LVL     �����
  =============================
    100         �ƽþ�����      null             3        null 
    120         �Ϻ�����         100             2        null
    121         ��������         120             1        1500

 
# ����4 


   �μ��ڵ�   �μ���        �����μ��ڵ�    LVL     �����
  =============================
    100         �ƽþ�����       null             1        null
    110         �ѱ�����         100              2        null
    111         ��������         110              3        1000 
    112         �λ�����         110              3        2000
    120         �Ϻ�����         100              2        null
    121         ��������         120              3        1500
    122         ����ī����      120              3        1000
    130         �߱�����         100              2        null
    131         ����¡����      130              3        1500
    132         ����������      130              3        2000




---------------------------------------------------------------------
---------------------------------93��--------------------------------
---------------------------------------------------------------------                         


# ���� 2

 ���ں� ���� A         ||    ���ں� ���� B

 A.����   A.�����     ||    B.����     B.�����

  11.01    1000         ||    11.01    1000 
  11.02    1000         ||    11.02    1000 
  11.03    1000         ||    11.03    1000 
  11.04    1000         ||    11.04    1000         
  11.05    1000         ||    11.05    1000 
  11.06    1000         ||    11.06    1000 
  11.07    1000         ||    11.07    1000 
  11.08    1000         ||    11.08    1000 
  11.09    1000         ||    11.09    1000 
  11.10    1000         ||    11.10    1000 




  11.01    1000         ||    11.01    1000 
  11.02    1000         ||    11.01    1000 
  11.02    1000         ||    11.02    1000 
  11.03    1000         ||    11.01    1000 
  11.03    1000         ||    11.02    1000 
  11.03    1000         ||    11.03    1000 
  11.04    1000         ||    11.01    1000 
  11.04    1000         ||    11.02    1000 
  11.04    1000         ||    11.03    1000 
  11.04    1000         ||    11.04    1000 












