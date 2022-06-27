-- 집합 연산자
-- ## UNION
-- 1. 합집합 연산의 의미입니다.
-- 2. 첫번째 쿼리와 두번째 쿼리의 중복정보는 한번만 보여줍니다.
-- 3. 첫번째 쿼리의 열의 개수와 타입이 두번째 쿼리의 열수와 타입과 동일해야 함.
-- 4. 자동으로 정렬이 일어남 (첫번째 컬럼 오름차가 기본값)
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
-- EMP_NO 를 넣었을때 
-- 사번이 다른 사람은 다른 사람으로 인식되기 때문에  
-- 1000000014	이관심	19780213 
-- 1000000023	이관심	19780213
-- EMP_NO 를 넣고 유니온을 하면 8명이 되는거고 
-- EMP_NO 를 빼고 유니온을 하면 7명이 된다 


-- AS "" 는 위에있는걸로 나옴 
-- 정렬은 항상 유니온이 끝나는 자리 

-- ## UNION ALL
-- 1. UNION과 같이 두 테이블로 수직으로 합쳐서 보여줍니다.
-- 2. UNION과는 달리 중복된 데이터도 한번 더 보여줍니다.
-- 3. 자동 정렬 기능을 지원하지 않아 성능상 유리합니다.

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

-- 정렬 안함 
-- 중복제거 안함 
-- 그래도 컬럼갯수랑 , 타입은 맞아야 함 
-- 그래서 8개가 나옴 이관심 2 명 다 나옴 

-------------------------------------------------------------------------------

-- ## INTERSECT (교 집 합) 
-- 1. 첫번째 쿼리와 두번째 쿼리에서 중복된 행만을 출력합니다.
-- 2. 교집합의 의미입니다.

SELECT 
    A.emp_no, A.emp_nm, A.addr
    , B.certi_cd, C.certi_nm
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
JOIN tb_certi C 
ON B.certi_cd = C.certi_cd 
WHERE C.certi_nm = 'SQLD'
-- 'SQLD' 딴 애들은 누구니 ? 
INTERSECT
SELECT 
    A.emp_no, A.emp_nm, A.addr
    , B.certi_cd, C.certi_nm
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
JOIN tb_certi C 
ON B.certi_cd = C.certi_cd 
WHERE A.addr LIKE '%용인%';
-- 용인사는애중에 자격증 있는애 누구야 ?? 

SELECT 
    A.emp_no, A.emp_nm, A.addr
    , B.certi_cd, C.certi_nm
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
JOIN tb_certi C 
ON B.certi_cd = C.certi_cd 
WHERE A.addr LIKE '%용인%'
    AND C.certi_nm = 'SQLD'
;

-- ## MINUS(EXCEPT) 
-- 1. 두번째 쿼리에는 없고 첫번째 쿼리에만 있는 데이터를 보여줍니다.
-- 2. 차집합의 개념입니다.

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

--계층형 쿼리 
-- START WITH : 계층의 첫 단계를 어디서 시작할 것인지의 대한 조건 
-- CONNECT BY PRIOR 자식 = 부모  -- > 순방향 탐색
-- CONNECT BY 자식 = PRIOR 부모 -- > 역방향 탐색 
-- ORDER SIBILINGS BY : 같은 레벨끼리의 정렬을 정함 .
    

SELECT 
    LEVEL AS LVL,
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "조직인원",
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
--상사가 - NULL 인 애들부터 나열해라 

-- CONNECT BY PRIOR A.emp_no = A.direct_manager_emp_no;
-- CONNECT BY PRIOR 자식 = 부모  -- > 순방향 탐색


SELECT 
    LEVEL AS LVL,
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "조직인원",
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
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "조직인원",
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
---- ORDER SIBILINGS BY : 같은 레벨끼리의 정렬을 정함 .




-- SELF JOIN 
-- 1. 하나의 테이블에서 자기 자신의 테이블끼리 조인하는 기법입니다.
-- 2. 자기 자신 테이블에서 PK와 FK로 동등 조인합니다.


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
, a.EMP_NM "사원 명"
, a.addr "사원 주소"
, a.direct_manager_emp_no
, b.emp_nm "직속상사의 사원명"
, b.addr "직속 상사의 주소"
FROM  tb_emp A
INNER JOIN tb_emp B
on a.direct_manager_emp_no = b.emp_no

ORDER BY emp_no
;
--
alter table tb_emp 
add constraint fk_direct_manager_emp_no --내마음대로 거는거임 
foreign key (direct_manager_emp_no) --누구를 포린키로 할지 정하고 
references tb_emp (emp_no); -- 누구 pk 를 걸꺼야 ? 테이블명 (테이블 pk 컬럼)



SELECT 
  a.EMP_NO 
, a.EMP_NM "사원 명"
, a.addr "사원 주소"
, a.direct_manager_emp_no
, b.emp_nm "직속상사의 사원명"
, b.addr "직속 상사의 주소"
FROM  tb_emp A
left JOIN tb_emp B
on a.direct_manager_emp_no = b.emp_no

ORDER BY emp_no
;



----------------------------------------------------
-----------91번-------------------------------------
----------------------------------------------------


# 보기 1

   부서코드   부서명     상위부서코드    LVL
  =============================
      120      일본지사       100              1
      100      아시아지부    null              2

   부서코드   부서명     상위부서코드    LVL
  =============================
      120      일본지사       100              1
      121      도쿄지점       120              2
      122     오사카지점     120              2



   부서코드   부서명     상위부서코드    LVL
  =============================
      100      아시아지부    null              2
      120      일본지사       100              1
      121      도쿄지점       120              2
      122     오사카지점     120              2


   부서코드   부서명     상위부서코드    LVL     b.매출액   
  =====================================
      100      아시아지부    null              2         null
      120      일본지사       100              1         null
      121      도쿄지점       120              2        1500
      122     오사카지점     120              2        1000


# 보기2 


   부서코드   부서명        상위부서코드    LVL     매출액
  =============================
    100         아시아지부       null             1        null
    110         한국지사         100              2        null
    111         서울지점         110              3        1000 
    112         부산지점         110              3        2000
    120         일본지사         100              2        null
    121         도쿄지점         120              3        1500
    122         오사카지점      120              3        1000
    130         중국지사         100              2        null
    131         베이징지점      130              3        1500
    132         상하이지점      130              3        2000


# 보기3 


   부서코드   부서명        상위부서코드    LVL     매출액
  =============================
    100         아시아지부      null             3        null 
    120         일본지사         100             2        null
    121         도쿄지점         120             1        1500

 
# 보기4 


   부서코드   부서명        상위부서코드    LVL     매출액
  =============================
    100         아시아지부       null             1        null
    110         한국지사         100              2        null
    111         서울지점         110              3        1000 
    112         부산지점         110              3        2000
    120         일본지사         100              2        null
    121         도쿄지점         120              3        1500
    122         오사카지점      120              3        1000
    130         중국지사         100              2        null
    131         베이징지점      130              3        1500
    132         상하이지점      130              3        2000




---------------------------------------------------------------------
---------------------------------93번--------------------------------
---------------------------------------------------------------------                         


# 보기 2

 일자별 매출 A         ||    일자별 매출 B

 A.일자   A.매출액     ||    B.일자     B.매출액

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












