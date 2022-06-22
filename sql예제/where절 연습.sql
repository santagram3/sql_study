

-- WHERE 조건절 : 조회 결과 행을 제한하는 조건절 

SELECT 
    emp_no, emp_nm , addr ,sex_cd
FROM tb_emp
WHERE sex_cd = 2;


-- PK로 WHERE절 동등조건을 만들면 반드시 단일행이 조회된다
SELECT 
    emp_no, emp_nm , addr ,sex_cd
FROM tb_emp
where emp_no = 10000300;

-- 비교 연산자 
SELECT 
    emp_no, emp_nm , birth_de ,tel_no
FROM tb_emp
WHERE  birth_de >= '19900101'
    and birth_de <= '19991231'
    ;
    -- BETWEEN 연산자 
    -- 빼기 연산 - 
SELECT 
    emp_no, emp_nm , birth_de ,tel_no
FROM tb_emp
WHERE birth_de BETWEEN '19900101' and '19991231'
    ;    
    
    -- OR 연산 
    -- 더하기 연산 +
SELECT 
    emp_no, emp_nm , dept_cd 
FROM tb_emp
WHERE dept_cd = '100004'
   OR dept_cd = '100006'
;
-- IN 연산자 
-- 또는 
SELECT 
    emp_no, emp_nm , dept_cd 
FROM tb_emp
WHERE dept_cd IN ('100004', '100006')
;
 
-- NOT IN 
-- 쟤내 빼고
SELECT 
    emp_no, emp_nm , dept_cd 
FROM tb_emp
WHERE dept_cd NOT IN ('100004', '100006')
;

-- LIKE 연산자 
-- 검색식 사용 
-- 와일드 카드 맵핑 (% : 0글자 이상 , _ : 단 한글자만 )

SELECT 
    emp_no, emp_nm 
FROM tb_emp
WHERE  emp_nm LIKE '이%'
;
-- 성이 이 이기만하면 다 검색 
SELECT 
    emp_no, emp_nm 
FROM tb_emp
WHERE  emp_nm LIKE '이_' 
;
-- 이 씨성을 가진 이름이 1글자인사람 

SELECT 
    emp_no, emp_nm 
FROM tb_emp
WHERE  emp_nm LIKE '%심'
;
-- 심으로 끝나는 애들 

SELECT 
    emp_no, emp_nm , addr 
FROM tb_emp
WHERE  addr LIKE '%용인%'
;
-- 용인에 사는애들 다 검색  




-- 성씨가 김씨이면서, 부서가 100003, 100004, 100006번 중에 하나이면서, 
-- 90년대생인 사원의 사번, 이름, 생일, 부서코드를 조회

SELECT 
    emp_no, emp_nm ,birth_de, dept_cd 
FROM tb_emp
WHERE 1=1
and emp_nm LIKE '김%' 
and dept_cd in ('100003', '100004', '100006') 
and birth_de BETWEEN '19900101' and '19991231'
;

-- 부정 일치 비교 연산자 
    
SELECT 
    emp_no, emp_nm , addr ,sex_cd
FROM tb_emp
WHERE sex_cd != 2
;
-- 부정 일치 !! 성별이 2가 아닌사람 
SELECT 
    emp_no, emp_nm , addr ,sex_cd
FROM tb_emp
WHERE sex_cd ^= 2
;
-- 부정 일치 !! 성별이 2가 아닌사람 
SELECT 
    emp_no, emp_nm , addr ,sex_cd
FROM tb_emp
WHERE sex_cd <> 2
;
-- 부정 일치 !! 성별이 2가 아닌사람 

SELECT 
    emp_no, emp_nm , addr ,sex_cd
FROM tb_emp
WHERE NOT sex_cd =2
;
-- 부정 일치 !! 성별이 2가 아닌사람 

-- 성별코드가 1이 아니면서 성씨가 이씨가 아닌 사람들의
-- 사번, 이름, 성별코드를 조회하세요.
SELECT 
    emp_no, emp_nm ,sex_cd
FROM tb_emp
WHERE 1=1
AND NOT sex_cd =1
AND emp_nm not like '이%'
;

-- null 값 조회 
SELECT 
    emp_no, emp_nm , direct_manager_emp_no
FROM tb_emp
WHERE 1=1
-- AND direct_manager_emp_no = NULL 이거 아니고  
AND direct_manager_emp_no IS NULL  -- 이거임 
; 

SELECT 
    emp_no, emp_nm , direct_manager_emp_no
FROM tb_emp
WHERE 1=1
-- AND direct_manager_emp_no != NULL 이거 아니고  
AND direct_manager_emp_no IS NOT NULL  -- 이거임 
;

-- 연산자 우선순위 : NOT > AND > OR 

-- 사원정보 중에 김씨이면서 수원 또는 일산에 사는 사원들의 정보 

SELECT 
    emp_no, emp_nm , addr ,sex_cd
FROM tb_emp
WHERE 1=1
AND emp_nm LIKE '김%'
AND ADDR LIKE '%수원%' 
OR ADDR LIKE '%일산%'
;
SELECT 
    emp_no, emp_nm , addr ,sex_cd
FROM tb_emp
WHERE 1=1
AND emp_nm LIKE '김%'
AND (ADDR LIKE '%수원%' 
OR ADDR LIKE '%일산%')
;









    
    
    
    
    
    





















