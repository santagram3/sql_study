


-- OUTER JOIN �ǽ�ȯ�� ����
INSERT INTO tb_dept VALUES ('100014', '4�����������', '999999');
INSERT INTO tb_dept VALUES ('100015', '����Ʈ�ڷγ���', '999999');
COMMIT;

SELECT * FROM tb_dept;

ALTER TABLE tb_emp DROP CONSTRAINT fk_tb_emp01;

INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
                    final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000041', '�̼���', '19811201', '1', '��⵵ ���ν� ������ ����1�� 435', '010-5656-7878',
        NULL, '006', '003', '114-554-223433', '000000', 'N');

INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
                    final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000042', '�����', '19820402', '1', '��⵵ ���� ���籸 ȭ���� 231', '010-4054-6547',
        NULL, '004', '001', '110-223-553453', '000000', 'Y');

INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
                    final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000043', '������', '19850611', '1', '��⵵ ������ �ȴޱ� ��ź�� 553', '010-1254-1116',
        NULL, '004', '001', '100-233-664234', '000000', 'N');
        
INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
            final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000044', '�庸��', '19870102', '1', '��⵵ ������ �д籸 ���ڵ� 776', '010-1215-8784',
        NULL, '004', '002', '180-345-556634', '000000', 'Y');
        
INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
            final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000045', '������', '19880824', '1', '��⵵ ���� �ϻ꼭�� �鼮�� 474', '010-3687-1245',
        NULL, '004', '002', '325-344-45345', '000000', 'Y');
        
COMMIT;
    
 
SELECT * FROM tb_emp ORDER BY emp_no DESC;
SELECT emp_no, emp_nm, dept_cd FROM tb_emp ORDER BY emp_no DESC;

SELECT * FROM tb_dept;

-- # OUTER JOIN
-- 1. ���� ������ �������� �ʴ� ��鵵 ��ȸ�� �� ����ϴ� ���α���Դϴ�.
-- 2. OUTER���� ������ ��ȣ�� (+)��ȣ�Դϴ�.
-- 3. INNER������ ���� ������ �������� ������ �ش� ���� ��ȸ���� �ʽ��ϴ�
--   �׷��� OUTER JOIN�� ����(LEFT, RIGHT, FULL)�� �°� ���ǿ� ��Ī���� 
--   �ʴ� ��鵵 ��� NULL�� ó���ؼ� ��ȸ�մϴ�.

-- # LEFT OUTER JOIN
-- ���εǴ� ���� ���̺��� ��� ��ȸ�ϰ�, ������ ���̺��� �������ǿ� ��Ī�� �͸� ��ȸ�մϴ�.

-- ���� ��������� �ϴ� �� ���� ������ Ȥ�� �μ����̺��� �μ��ڵ尡 ��Ī�Ǹ�
-- ���ʽ��� �μ��̸��� ������
select count(emp_nm) from tb_emp;



select 
    a.emp_no ,a.emp_nm ,a.dept_cd ,b.dept_nm
from tb_emp a 
inner join tb_dept b 
on A.dept_cd = b.dept_cd 
order by A.emp_no 
;


select 
    a.emp_no ,a.emp_nm ,a.dept_cd ,b.dept_nm
from tb_emp a 
left outer join tb_dept b 
on A.dept_cd = b.dept_cd 
order by a.emp_no
;

select 
  *
from tb_emp a 
left outer join tb_dept b 
on A.dept_cd = b.dept_cd 
order by a.emp_no
;



select 
    a.emp_no ,a.emp_nm ,a.dept_cd ,b.dept_nm
    
    -- DEPT_CD�� �����ѰŶ� a.dept_cd �� left outer join ������ ���ʸ� ���̹Ƿ� �������� �ȳ��� , b.dept_Cd  
    
from tb_emp a 
left outer join tb_dept b 
on A.dept_cd = b.dept_cd 
order by a.emp_no
;

---------------- ORACLE ���� 
select 
    a.emp_no ,a.emp_nm ,a.dept_cd ,b.dept_nm
    -- a.dept_cd , b.dept_Cd �������� �𸣰��� ;; 
from tb_emp a , tb_dept b

WHERE A.dept_cd = b.dept_cd (+) 
order by a.emp_no
;

 -- # RIGHT OUTER JOIN 
 --  ���εǴ� ������ ���̺��� ��� ��ȸ�ϰ� , ���� ���̺��� ���ǿ� ��Ī�Ȱ͸� ��ȸ 
 
 -- ���� ��� �μ������� ��ȸ�ϰ������ Ȥ�� �μ� �ڵ尡 ��ġ�ϴ� ����� ������ �԰� ��ȸ���� 
 

select 
    a.emp_no ,a.emp_nm ,B.dept_cd ,b.dept_nm
from tb_emp a 
RIGHT outer join tb_dept b 
on A.dept_cd = b.dept_cd 
order by a.emp_no
;


select 
    *
from tb_emp a 
RIGHT outer join tb_dept b 
on A.dept_cd = b.dept_cd 
order by a.emp_no
;

-- FULL OUTER JOIN 
-- ���� �������̺� , ������ ���̺��� ��� �����ְ� ��Ī�Ǹ� ��Ī�����ͱ��� ���ļ� ������ 

select 
    a.emp_no ,a.emp_nm ,a.dept_cd ,b.dept_nm
    
from tb_emp a 
FULL outer join tb_dept b 
on A.dept_cd = b.dept_cd 
order by a.emp_no
;

-- 72�� 

--  A.����ȣ  A.����  B.�ܸ���ID  B.�ܸ���� B.OSID C.OSID  C.OS��
-------------------------------------------------------------------------

-- 11000         ȫ�浿      1000          A1000      100      100     Android
-- 12000         ������      null            null         null      null      null
-- 13000         �̼���      null            null         null      null      null
-- 14000         ���߱�      null            null         null      null      null
-- 15000         ��浿      null            null         null      null      null
-- 16000         �̴��      null            null         null      null      null




