

-- 집계 함수 : (다중행 함수 )

-- : 여러 행을 묶어서 함수를 적용 

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
    substr(emp_nm,1,1) 성씨
    ,emp_nm
from tb_emp;

-- 단일행 함수 : 하나하나 다 적용하는것 -- 41건 나옴 


-- GROUP BY 로 소그룹화 하지 않으면 집계함수는 전체 행수를 기준으로 집계한다 .

SELECT

 sum(pay_amt) "지급 총액"
 ,avg(pay_amt) "평균 지급액 "
 , COUNT(pay_amt) "지급 횟수"
  -- ,emp_no // not a single-group group function" 여러개 출력하는게 나옴 같이 쓸수없다 
FROM tb_sal_his
;

SELECT

count(emp_no) "총 사원수" 
,count(direct_manager_emp_no)  "상사 수" --특정 함수나 ,컬럼 , 표현식을 넣으면 NULL 을 세지 않는다 
-- 회장의 상사는 없으니까 ㅋㅋㅋ
,count(*) "다 세기 "
-- tb_emp 다 세는거라서 null을 포함해서 센다  
,Min(birth_de) "최 연소자 "
,max(birth_de) "최 연장자 "

FROM tb_emp
;



SELECT

count(emp_no) "총 사원수" 
,Min(birth_de) "최 연소 사원 이름 " -- 
,emp_nm(Max(birth_de)) "최 장수 사원 이름 "
FROM tb_emp
;
--이거 왜 안나옴 ????????????????????
-- 의도 ..최연소 사람이름을 구하려고 했으나 문법적으로 맞지 않는다 
--ORA-00904: "EMP_NM": invalid identifier
--잘못된 식별자

-- GROUP BY : 지정된 컬럼으로 소그룹화 한 후 집계함수 적용 
-- 부서별로 가장 어린사람의 생년월일 ,연장자의 생년월일 부서별 총 사원 수를 조회 

SELECT * FROM TB_EMP
ORDER BY dept_cd
;
SELECT 
    --emp_nm
    --dept_cd
    MAX(birth_de) 최연장자 
    ,min(birth_de) 최연소자  
    ,count(emp_no) 직원수 
    -- 통계에서 
FROM tb_emp

GROUP BY dept_cd
-- 그룹별로 묶어서
ORDER BY dept_cd
-- 오름차 정렬을 해라
-- 근데 이 거 무슨 기준으로 하는건가요 ? 
;

-- 사원별로 지금까지 회사 에서 받은 총액 
SELECT
    emp_no 사원번호
    ,sum(pay_amt) 받은총액
    --,avg(sum(pay_amt)) 받은총액 // 이것도 안나옴 ... 
FROM tb_sal_his
group BY emp_no --웨어 다음 , 오더바이 전   
ORDER BY emp_no
;
 --,avg(sum(pay_amt)) 받은총액 // 이것도 안나옴 .. 


-- 사원별로 급여를 제일 많이 받았을때 , 제일 적게 받았을때 , 평균적으로 얼마 받았는지 조회 

SELECT 
    emp_no 사원번호
    ,sum(pay_amt) 받은총액
    ,max(pay_amt) "최대 받은 금액"
    ,to_char(max(pay_amt),'L999,999,999') "최대 받은 금액" 
    --  ￦5,890,000
    -- 원으로 만든다
    ,to_char(max(pay_amt),'L999999,999') "최대 받은 금액" 
    --################## 왜 이렇게 나오는건가 ? 
    ,min(pay_amt) "최저 수령액"  
    ,to_char(min(pay_amt),'L999,999,999') "최저 받은 금액"
    
    ,to_char(avg(pay_amt),'L999,999,999') "최저 받은 금액"
    ,avg(pay_amt) 받은평균
    ,round(avg(pay_amt),2) 받은평균 -- 2째자리까지 나온다 
   
   --,round(pay_amt ,2) 이거 안됨 ;; 
   -- 이건 갯수가 너무 많아서 안맞음 
FROM tb_sal_his
group BY emp_no --웨어 다음 , 오더바이 전   
ORDER BY emp_no
;
-- 집계가 끝난 평균 숫자는 단일화 함수는 쓸수있다 


-- -- 사원별로 2019년에 급여를 제일 많이 받았을때 , 제일 적게 받았을때 , 평균적으로 얼마 받았는지 조회 

SELECT
    emp_no 사원번호
    ,sum(pay_amt) 받은총액
    
    ,to_char(max(pay_amt),'L999,999,999') "최대 받은 금액" 
    --  ￦5,890,000
    -- 원으로 만든다 
    
    ,to_char(min(pay_amt),'L999,999,999') "최저 받은 금액"
    ,to_char(avg(pay_amt),'L999,999,999') "최저 평균 금액"
    
    ,round(avg(pay_amt),2) 받은평균 -- 2째자리까지 나온다 
    
    ,to_char(sum(pay_amt),'L999,999,999') "연봉"
   
   --,round(pay_amt ,2) 이거 안됨 ;; 
   -- 이건 갯수가 너무 많아서 안맞음 
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101'AND '20191231'
group BY emp_no --웨어 다음 , 오더바이 전   
ORDER BY emp_no
;

---------------------------HAVING : 그룹화된 결과에서 조건을 걸어 행 수를 제한 

-- 부서별로 가장 어린사람의 생년월일 ,연장자의 생년월일 , 부서별 총 사원 수를 조회 
-- 그런데 부서별 사원이 1명인 부서의 정보는 조회하고 싶지 않음.

SELECT 
   
    dept_cd
    ,MAX(birth_de) 최연장자 
    ,min(birth_de) 최연소자  
    ,count(emp_no) 직원수 
   
FROM tb_emp
GROUP BY dept_cd
HAVING COUNT(emp_no)>1 
ORDER BY dept_cd
;




-- 사원별로 급여를 제일 많이 받았을때 , 제일 적게 받았을때 , 평균적으로 얼마 받았는지 조회 

SELECT 
    emp_no 사원번호
    ,to_char(max(pay_amt),'L999,999,999') "최대 받은 금액" 
    ,to_char(min(pay_amt),'L999,999,999') "최저 받은 금액"
     ,to_char(round(avg(pay_amt),2),'L999,999,999') "평균수령액"
  
  
   
   --,round(pay_amt ,2) 이거 안됨 ;; 
   -- 이건 갯수가 너무 많아서 안맞음 
FROM tb_sal_his
group BY emp_no --웨어 다음 , 오더바이 전
HAVING AVG(pay_amt) >= 4500000
ORDER BY emp_no
;

-- 사원별로 2019년 평균 수령액이 450만원 이상인 사원의 연봉 조회 

SELECT
    emp_no 사원번호
    ,to_char(sum(pay_amt),'L999,999,999') "연봉"
   
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101'AND '20191231'
group BY emp_no --웨어 다음 , 오더바이 전   
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


--*----order by = 정렬 
-- ASC : 오름차 정렬 (기본값), DESC : 내림차 정렬 
-- 항상 SELECT절 맨 마지막에 위치 


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

-- 우선정렬 
SELECT 
    emp_no
    , emp_nm
    ,dept_cd 
FROM tb_emp
ORDER BY dept_cd , emp_nm DESC  
;




SELECT 
    emp_no 사번
    , emp_nm 이름 
    , addr 주소
FROM tb_emp
ORDER BY 이름 DESC
;
-- 별칭으로도 가능하다 !! 




SELECT 
    emp_no
    , emp_nm
    ,dept_cd 
FROM tb_emp
ORDER BY 3 , 2 DESC  
;
-- 자리번째 수로도 정렬이 가능하다 


SELECT 
    emp_no 사번
    , emp_nm 이름
    ,dept_cd 부서코드 
FROM tb_emp
ORDER BY 부서코드 , 2 DESC , emp_no  
;
-- 혼용도 가능하다 


-- 사원별로 2019년 평균 수령액이 450만원 이상인 사원의 연봉 조회 

SELECT
    emp_no 사원번호
    ,to_char(sum(pay_amt),'L999,999,999') "연봉"
   
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101'AND '20191231'
group BY emp_no --웨어 다음 , 오더바이 전   
HAVING AVG(pay_amt) >= 4500000
   
ORDER BY emp_no , sum(pay_amt) DESC ,max(pay_amt)
;
-- order by 는 group BY emp_no 안에있는 놈들만 가능하다 






















