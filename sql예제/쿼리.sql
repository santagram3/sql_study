

-- # 단일행 서브쿼리
--  서브쿼리의 조회 결과가 1건 이하인 경우

-- 부서코드가 100004번인 부서의 사원정보 조회 
SELECT 
    EMP_NO , EMP_NM , DEPT_CD    
FROM tb_emp
WHERE DEPT_CD = '100004';

-- 사원 이름이 이나라인 사람이 속해있는 부서의 사원정보 조회 


SELECT DEPT_CD FROM TB_EMP WHERE EMP_NM = '이나라';
-- 결과가 하나만 나오는걸 단일행 서브쿼리라고 한다 
-- 100004 

--- 사원이름이 이관심인 사람이 속해 있는 부서의 사원정보 조회
-- 단일행 비교연산자(=, <>, >, >=, <, <=)는 단일행 서브쿼리로만 비교해야 함.

SELECT 
    EMP_NO , EMP_NM , DEPT_CD    
FROM tb_emp
WHERE DEPT_CD = (SELECT DEPT_CD FROM TB_EMP WHERE EMP_NM = '이관심')
-- '이나라' 는 한명인데 '이관심' 동명이인으로 2명이기때문에 단일행으로 확인해야된다 
;
-- 단일행 비교연산자()는 단일행 서브쿼리로만 비교해야함 

-- 20200525에 받은 급여가 회사 전체의 20200525일 
-- 전체평균 급여보다 높은 사원들의 정보 조회 
-- 사번 , 이름 , 급여지급일 , 받음 급여액수 
SELECT
    A.EMP_NO , A.EMP_NM , B.PAY_DE ,B.PAY_AMT 
FROM TB_EMP A 
JOIN TB_SAL_HIS B
ON A.EMP_NO = B.EMP_NO

-- 조인한 결과물은  TB_EMP 테이블도 아니고 TB_SAL_HIS 테이블도 아니다 
-- 그냥 새로 만들어진 테이블이다 
WHERE B.PAY_DE = '20200525'
AND B.PAY_AMT  >=  (

SELECT AVG(PAY_AMT) 
FROM TB_SAL_HIS
WHERE PAY_DE = '20200525'
                        )
ORDER BY a.emp_no 
;

-- 회사 전체 20200525 급여평균 
SELECT AVG(PAY_AMT) 
FROM TB_SAL_HIS
WHERE PAY_DE = '20200525'
;

-- # 다중행 서브쿼리 
-- 서브쿼리의 조회 건수가 0건 이상인것 
-- ## 다중행 연산자 
-- 1.IN (,) : 메인쿼리의 비교조건이 서브쿼리 결과중에 하나라도 일치하면 참 
--    ex )  salary IN (200, 300, 400)
--            250 ->  200, 300, 400 중에 없으므로 false
-- 2.ANY , SOME : 메인쿼리의 비교조건이 서브쿼리의 검색 결과중 하나 이상 일치하면 참 
--  EX )  : salary > any(200,300,400) = salary > 200
    --        250  > 200 보다 크므로 TRUE 
-- 3. ALL : 메인쿼리의 비교조건이 서브쿼리의 겸색결과와 모두 일치하면 참 
-- EX )  : salary > ALL(200,300,400) == SALLY 가 250일때 FALSE 
-- 왜냐하면 250이 300보다는 작으니까 , salary > ALL(200,300,400) 이 조건에 다 맞아야 성공이다 

-- 4. EXISTS : 메인쿼리의 비교조건이 서브쿼리의 결과 중 만족하는 값이 하나라도 존재하면 참   

-- 한국데이터베이스진흥원에서 발급한 자격증을 가지고 있는
-- 사원의 사원번호와 사원이름과 해당 사원의 한국데이터베이스진흥원에서 
-- 발급한 자격증 개수를 조회

--1 단계 
SELECT
    a.emp_no , a.emp_nm , b.certi_cd   
FROM tb_emp A
join tb_emp_certi B
on a.emp_no = b.emp_no
order by a.emp_no
;
SELECT certi_cd 
FROM tb_certi 
WHERE issue_insti_nm = '한국데이터베이스진흥원'
;

SELECT 
    A.emp_no, A.emp_nm, COUNT(B.certi_cd) "자격증 개수"
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
WHERE B.certi_cd IN (
                        SELECT certi_cd 
                        FROM tb_certi 
                        WHERE issue_insti_nm = '한국데이터베이스진흥원'
                    )
GROUP BY A.emp_no, A.emp_nm
ORDER BY A.emp_no
;

SELECT 
    A.emp_no, A.emp_nm, COUNT(B.certi_cd) "자격증 개수"
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
WHERE B.certi_cd = any (
                        SELECT certi_cd 
                        FROM tb_certi 
                        WHERE issue_insti_nm = '한국데이터베이스진흥원'
                    )
GROUP BY A.emp_no, A.emp_nm
ORDER BY A.emp_no
;

-- EXISTS문 : 메인쿼리의 비교조건이 서브쿼리의 결과 중 만족하는 값이 하나라도 존재하면 참 
-- 주소가 강남인 직원들이 근무하고 있는 부서정보를 조회 (부서코드 , 부서명)

SELECT 
    A.EMP_NO , a.emp_nm , A.ADDR , a.dept_cd
FROM TB_EMP A 
WHERE ADDR LIKE '%강남%';


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
WHERE ADDR LIKE '%강남%'
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
                WHERE ADDR LIKE '%강남%'
                and a.dept_cd = b.dept_cd
                )
;


    -- 강남 , 강난의 차이  있냐 없냐 의 차이다 
 SELECT 
                     --b.dept_cd
                     1
                FROM TB_EMP b 
                WHERE ADDR LIKE '%강남%';
                
 SELECT 
                     --b.dept_cd
                     1
                FROM TB_EMP b 
                WHERE ADDR LIKE '%강난%';


-- # 다중 컬럼 서브쿼리 
-- : 서브쿼리의 조회 컬럼이 2개 이상인 서브쿼리 


-- 부서원이 2명 이상인 부서중에서 각 부서의 
--가장 연장자의 사번과 생년월일rhk 부서코드를 조회 


-- 1단계 
SELECT 
    a.emp_no ,a.emp_nm , a.birth_de , a.dept_cd
FROM tb_emp A
where (a.dept_cd , A.birth_de) in 
(('100001','19690204')
,('100002','19790204')
,('100003','19890204')
,('100004','19490204'))
-- in 괄호 안에 괄호는 and 개념이다  
order by emp_no
;


-- 2단계 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

-- 인라인 뷰 서브쿼리 (from절에 쓴느 서브쿼리 )

-- 각 사원의 사번과 이름과 평균 급여 정보를 조회하고싶다 

--1 단계 ---------------------------------
SELECT 
    A.EMP_NO , A.EMP_NM , AVG(B.PAY_AMT)
FROM TB_EMP A 
JOIN TB_SAL_HIS B
ON A.EMP_NO = B.EMP_NO
GROUP BY a.emp_no ,a.emp_nm
ORDER BY A.EMP_NO 
;

-- 2 단계 --------------------------------
SELECT 
    A.emp_no, A.emp_nm, B.pay_avg
FROM tb_emp A, (
                 SELECT 
                    emp_no, AVG(pay_amt) AS pay_avg
                 FROM tb_sal_his
                 GROUP BY emp_no
                    ) B
                    -- 괄호안에 emp_no,이게 있어야 
                    -- where 안에 B.emp_no 이걸 쓸수있다 
WHERE A.emp_no = B.emp_no
ORDER BY A.emp_no
;


-- 스칼라 서브쿼리 (select절에 쓰는 서브쿼리)
-- 사원의 사번, 사원명 , 부서명 , 생년월일 보유자격증명을 조회 
select
    A.emp_no
    , A.emp_nm
    , (SELECT B.dept_nm FROM tb_dept B WHERE A.dept_cd = B.dept_cd) AS dept_nm
    , A.birth_de
    , A.sex_cd
FROM tb_emp A
;




