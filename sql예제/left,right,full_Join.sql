


-- OUTER JOIN 실습환경 세팅
INSERT INTO tb_dept VALUES ('100014', '4차산업혁명팀', '999999');
INSERT INTO tb_dept VALUES ('100015', '포스트코로나팀', '999999');
COMMIT;

SELECT * FROM tb_dept;

ALTER TABLE tb_emp DROP CONSTRAINT fk_tb_emp01;

INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
                    final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000041', '이순신', '19811201', '1', '경기도 용인시 수지구 죽전1동 435', '010-5656-7878',
        NULL, '006', '003', '114-554-223433', '000000', 'N');

INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
                    final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000042', '정약용', '19820402', '1', '경기도 고양시 덕양구 화정동 231', '010-4054-6547',
        NULL, '004', '001', '110-223-553453', '000000', 'Y');

INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
                    final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000043', '박지원', '19850611', '1', '경기도 수원시 팔달구 매탄동 553', '010-1254-1116',
        NULL, '004', '001', '100-233-664234', '000000', 'N');
        
INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
            final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000044', '장보고', '19870102', '1', '경기도 성남시 분당구 정자동 776', '010-1215-8784',
        NULL, '004', '002', '180-345-556634', '000000', 'Y');
        
INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
            final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000045', '김종서', '19880824', '1', '경기도 고양시 일산서구 백석동 474', '010-3687-1245',
        NULL, '004', '002', '325-344-45345', '000000', 'Y');
        
COMMIT;
    
 
SELECT * FROM tb_emp ORDER BY emp_no DESC;
SELECT emp_no, emp_nm, dept_cd FROM tb_emp ORDER BY emp_no DESC;

SELECT * FROM tb_dept;

-- # OUTER JOIN
-- 1. 조인 조건을 만족하지 않는 행들도 조회할 때 사용하는 조인기법입니다.
-- 2. OUTER조인 연산자 기호는 (+)기호입니다.
-- 3. INNER조인은 조인 조건을 만족하지 않으면 해당 행을 조회하지 않습니다
--   그러나 OUTER JOIN은 방향(LEFT, RIGHT, FULL)에 맞게 조건에 매칭되지 
--   않는 행들도 모두 NULL로 처리해서 조회합니다.

-- # LEFT OUTER JOIN
-- 조인되는 왼쪽 테이블은 모두 조회하고, 오른쪽 테이블은 조인조건에 매칭된 것만 조회합니다.

-- 나는 사원정보는 일단 다 보고 싶은데 혹시 부서테이블에서 부서코드가 매칭되면
-- 보너스로 부서이름도 찍어줘라
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
    
    -- DEPT_CD를 조인한거라서 a.dept_cd 는 left outer join 때문에 왼쪽만 보이므로 오른쪽은 안나옴 , b.dept_Cd  
    
from tb_emp a 
left outer join tb_dept b 
on A.dept_cd = b.dept_cd 
order by a.emp_no
;

---------------- ORACLE 조인 
select 
    a.emp_no ,a.emp_nm ,a.dept_cd ,b.dept_nm
    -- a.dept_cd , b.dept_Cd 차이점을 모르겠음 ;; 
from tb_emp a , tb_dept b

WHERE A.dept_cd = b.dept_cd (+) 
order by a.emp_no
;

 -- # RIGHT OUTER JOIN 
 --  조인되는 오른쪽 테이블은 모두 조회하고 , 왼쪽 테이블은 조건에 매칭된것만 조회 
 
 -- 나는 모든 부서정보를 조회하고싶은데 혹시 부서 코드가 일치하는 사원이 있으면 함계 조회해줘 
 

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
-- 왼쪽 조인테이블 , 오른쪽 테이블을 모두 보여주고 매칭되면 매칭데이터까지 합쳐서 보여줌 

select 
    a.emp_no ,a.emp_nm ,a.dept_cd ,b.dept_nm
    
from tb_emp a 
FULL outer join tb_dept b 
on A.dept_cd = b.dept_cd 
order by a.emp_no
;

-- 72번 

--  A.고객번호  A.고객명  B.단말기ID  B.단말기명 B.OSID C.OSID  C.OS명
-------------------------------------------------------------------------

-- 11000         홍길동      1000          A1000      100      100     Android
-- 12000         강감찬      null            null         null      null      null
-- 13000         이순신      null            null         null      null      null
-- 14000         안중근      null            null         null      null      null
-- 15000         고길동      null            null         null      null      null
-- 16000         이대로      null            null         null      null      null




