

-- ���� �Լ� : (������ �Լ� )

-- : ���� ���� ��� �Լ��� ���� 

SELECT *
FROM tb_sal_his;

SELECT * FROM tb_sal_his
WHERE pay_de BETWEEN '20190101'AND '20191231'
ORDER BY emp_no, pay_de
;
------------------------------------------------------
SELECT
*
FROM tb_sal_his

--where emp_no = '1000000005';
;

select 
    substr(emp_nm,1,1) ����
    ,emp_nm
from tb_emp;

-- ������ �Լ� : �ϳ��ϳ� �� �����ϴ°� -- 41�� ���� 


-- GROUP BY �� �ұ׷�ȭ ���� ������ �����Լ��� ��ü ����� �������� �����Ѵ� .

SELECT

 sum(pay_amt) "���� �Ѿ�"
 ,avg(pay_amt) "��� ���޾� "
 , COUNT(pay_amt) "���� Ƚ��"
  -- ,emp_no // not a single-group group function" ������ ����ϴ°� ���� ���� �������� 
FROM tb_sal_his
;

SELECT

count(emp_no) "�� �����" 
,count(direct_manager_emp_no)  "��� ��" --Ư�� �Լ��� ,�÷� , ǥ������ ������ NULL �� ���� �ʴ´� 
-- ȸ���� ���� �����ϱ� ������
,count(*) "�� ���� "
-- tb_emp �� ���°Ŷ� null�� �����ؼ� ����  
,Min(birth_de) "�� ������ "
,max(birth_de) "�� ������ "

FROM tb_emp
;



SELECT

count(emp_no) "�� �����" 
,Min(birth_de) "�� ���� ��� �̸� " -- 
,emp_nm(Max(birth_de)) "�� ��� ��� �̸� "
FROM tb_emp
;
--�̰� �� �ȳ��� ????????????????????
-- �ǵ� ..�ֿ��� ����̸��� ���Ϸ��� ������ ���������� ���� �ʴ´� 
--ORA-00904: "EMP_NM": invalid identifier
--�߸��� �ĺ���

-- GROUP BY : ������ �÷����� �ұ׷�ȭ �� �� �����Լ� ���� 
-- �μ����� ���� ������ ������� ,�������� ������� �μ��� �� ��� ���� ��ȸ 

SELECT * FROM TB_EMP
ORDER BY dept_cd
;
SELECT 
    --emp_nm
    --dept_cd
    MAX(birth_de) �ֿ����� 
    ,min(birth_de) �ֿ�����  
    ,count(emp_no) ������ 
    -- ��迡�� 
FROM tb_emp

GROUP BY dept_cd
-- �׷캰�� ���
ORDER BY dept_cd
-- ������ ������ �ض�
-- �ٵ� �� �� ���� �������� �ϴ°ǰ��� ? 
;

-- ������� ���ݱ��� ȸ�� ���� ���� �Ѿ� 
SELECT
    emp_no �����ȣ
    ,sum(pay_amt) �����Ѿ�
    --,avg(sum(pay_amt)) �����Ѿ� // �̰͵� �ȳ��� ... 
FROM tb_sal_his
group BY emp_no --���� ���� , �������� ��   
ORDER BY emp_no
;
 --,avg(sum(pay_amt)) �����Ѿ� // �̰͵� �ȳ��� .. 


-- ������� �޿��� ���� ���� �޾����� , ���� ���� �޾����� , ��������� �� �޾Ҵ��� ��ȸ 

SELECT 
    emp_no �����ȣ
    ,sum(pay_amt) �����Ѿ�
    ,max(pay_amt) "�ִ� ���� �ݾ�"
    ,to_char(max(pay_amt),'L999,999,999') "�ִ� ���� �ݾ�" 
    --  ��5,890,000
    -- ������ �����
    ,to_char(max(pay_amt),'L999999,999') "�ִ� ���� �ݾ�" 
    --################## �� �̷��� �����°ǰ� ? 
    ,min(pay_amt) "���� ���ɾ�"  
    ,to_char(min(pay_amt),'L999,999,999') "���� ���� �ݾ�"
    
    ,to_char(avg(pay_amt),'L999,999,999') "���� ���� �ݾ�"
    ,avg(pay_amt) �������
    ,round(avg(pay_amt),2) ������� -- 2°�ڸ����� ���´� 
   
   --,round(pay_amt ,2) �̰� �ȵ� ;; 
   -- �̰� ������ �ʹ� ���Ƽ� �ȸ��� 
FROM tb_sal_his
group BY emp_no --���� ���� , �������� ��   
ORDER BY emp_no
;
-- ���谡 ���� ��� ���ڴ� ����ȭ �Լ��� �����ִ� 


-- -- ������� 2019�⿡ �޿��� ���� ���� �޾����� , ���� ���� �޾����� , ��������� �� �޾Ҵ��� ��ȸ 

SELECT
    emp_no �����ȣ
    ,sum(pay_amt) �����Ѿ�
    
    ,to_char(max(pay_amt),'L999,999,999') "�ִ� ���� �ݾ�" 
    --  ��5,890,000
    -- ������ ����� 
    
    ,to_char(min(pay_amt),'L999,999,999') "���� ���� �ݾ�"
    ,to_char(avg(pay_amt),'L999,999,999') "���� ��� �ݾ�"
    
    ,round(avg(pay_amt),2) ������� -- 2°�ڸ����� ���´� 
    
    ,to_char(sum(pay_amt),'L999,999,999') "����"
   
   --,round(pay_amt ,2) �̰� �ȵ� ;; 
   -- �̰� ������ �ʹ� ���Ƽ� �ȸ��� 
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101'AND '20191231'
group BY emp_no --���� ���� , �������� ��   
ORDER BY emp_no
;

---------------------------HAVING : �׷�ȭ�� ������� ������ �ɾ� �� ���� ���� 

-- �μ����� ���� ������ ������� ,�������� ������� , �μ��� �� ��� ���� ��ȸ 
-- �׷��� �μ��� ����� 1���� �μ��� ������ ��ȸ�ϰ� ���� ����.

SELECT 
   
    dept_cd
    ,MAX(birth_de) �ֿ����� 
    ,min(birth_de) �ֿ�����  
    ,count(emp_no) ������ 
   
FROM tb_emp
GROUP BY dept_cd
HAVING COUNT(emp_no)>1 
ORDER BY dept_cd
;




-- ������� �޿��� ���� ���� �޾����� , ���� ���� �޾����� , ��������� �� �޾Ҵ��� ��ȸ 

SELECT 
    emp_no �����ȣ
    ,to_char(max(pay_amt),'L999,999,999') "�ִ� ���� �ݾ�" 
    ,to_char(min(pay_amt),'L999,999,999') "���� ���� �ݾ�"
     ,to_char(round(avg(pay_amt),2),'L999,999,999') "��ռ��ɾ�"
  
  
   
   --,round(pay_amt ,2) �̰� �ȵ� ;; 
   -- �̰� ������ �ʹ� ���Ƽ� �ȸ��� 
FROM tb_sal_his
group BY emp_no --���� ���� , �������� ��
HAVING AVG(pay_amt) >= 4500000
ORDER BY emp_no
;

-- ������� 2019�� ��� ���ɾ��� 450���� �̻��� ����� ���� ��ȸ 

SELECT
    emp_no �����ȣ
    ,to_char(sum(pay_amt),'L999,999,999') "����"
   
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101'AND '20191231'
group BY emp_no --���� ���� , �������� ��   
HAVING AVG(pay_amt) >= 4500000
   
ORDER BY emp_no
;


--


SELECT
    emp_no
     ,sex_cd
     ,dept_cd
FROM tb_emp
order BY dept_cd , sex_cd
;

SELECT
    dept_cd 
    ,count(*)
FROM tb_emp
GROUP BY dept_cd , sex_cd
ORDER BY dept_cd
;


--*----order by = ���� 
-- ASC : ������ ���� (�⺻��), DESC : ������ ���� 
-- �׻� SELECT�� �� �������� ��ġ 


SELECT 
    emp_no
    , emp_nm
    , addr 

FROM tb_emp
ORDER BY emp_no DESC
;

SELECT 
    emp_no
    , emp_nm
    , addr 
FROM tb_emp
ORDER BY emp_nm DESC
;

-- �켱���� 
SELECT 
    emp_no
    , emp_nm
    ,dept_cd 
FROM tb_emp
ORDER BY dept_cd , emp_nm DESC  
;




SELECT 
    emp_no ���
    , emp_nm �̸� 
    , addr �ּ�
FROM tb_emp
ORDER BY �̸� DESC
;
-- ��Ī���ε� �����ϴ� !! 




SELECT 
    emp_no
    , emp_nm
    ,dept_cd 
FROM tb_emp
ORDER BY 3 , 2 DESC  
;
-- �ڸ���° ���ε� ������ �����ϴ� 


SELECT 
    emp_no ���
    , emp_nm �̸�
    ,dept_cd �μ��ڵ� 
FROM tb_emp
ORDER BY �μ��ڵ� , 2 DESC , emp_no  
;
-- ȥ�뵵 �����ϴ� 


-- ������� 2019�� ��� ���ɾ��� 450���� �̻��� ����� ���� ��ȸ 

SELECT
    emp_no �����ȣ
    ,to_char(sum(pay_amt),'L999,999,999') "����"
   
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101'AND '20191231'
group BY emp_no --���� ���� , �������� ��   
HAVING AVG(pay_amt) >= 4500000
   
ORDER BY emp_no , sum(pay_amt) DESC ,max(pay_amt)
;
-- order by �� group BY emp_no �ȿ��ִ� ��鸸 �����ϴ� 






















