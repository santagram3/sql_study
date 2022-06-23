

-- 단일행 함수 : 한 행에 대해서 함수를 적용 

-- # 문자열 비교

-- CHAR타입끼리의 비교
DROP TABLE CHAR_COMPARE;
CREATE TABLE CHAR_COMPARE (
    sn CHAR(10),
    char_4 CHAR(4), -- 무조건 어찌됐든 4글자로 만들어버림 
    char_6 CHAR(6) -- 무조건 어찌됐든 6글자로 만들어버림 
);

INSERT INTO char_compare VALUES ('101', 'SQLD', 'SQLD');
INSERT INTO char_compare VALUES ('102', 'SQLD', 'SQLA');
INSERT INTO char_compare VALUES ('103', 'SQLD', ' SQLD');
COMMIT;

SELECT * FROM char_compare;

-- REPLACE(X, a, b) : X에서 a를 찾아 b로 전부 바꿈
-- REPLACE(X, a)    : X에서 a를 찾아 전부 삭제
-- 이거 내부데이터 에는 영향 없고 내가 볼때만 바뀌어서 보임 

SELECT 
    REPLACE(sn, ' ', '+') AS sn,
    REPLACE(char_4, ' ', '+') AS char_4,
    REPLACE(char_6, ' ', '+') AS char_6
FROM char_compare;
-- 이걸로써 알수 있는것 !! 
-- char 타입은 총 길이만큼 안 넣어주면 다 빈공간으로 만들어버림 


SELECT 
    REPLACE(char_4, ' ', '+') AS char_4,
    REPLACE(char_6, ' ', '+') AS char_6
FROM char_compare
WHERE sn = '101'
    AND char_4 = char_6
;
-- 공백이지만 공백을 같은 길이로 맞춰서 비교해서 
-- 결과가 같다고 말해줌 
SELECT 
    REPLACE(char_4, ' ', '+') AS char_4,
    REPLACE(char_6, ' ', '+') AS char_6
FROM char_compare
WHERE sn = '102'
    AND char_4 = char_6
;
-- 이름이 내용이 다르기때문에 비교할수 없어서 비교 안해줌 
SELECT 
    REPLACE(char_4, ' ', '+') AS char_4,
    REPLACE(char_6, ' ', '+') AS char_6
FROM char_compare
WHERE sn = '103'
    AND char_4 = char_6
;
-- 앞공백도 허용 안해줌 


SELECT 
    REPLACE(char_4, ' ', '+') AS char_4,
    REPLACE(char_6, ' ', '+') AS char_6
FROM char_compare
WHERE sn = '102'
    AND char_4 > char_6
;
-- 아스키 코드의 번호로 비교를 한다 
-- a - A = 32 
-- a = 97 , A = 65 

SELECT * FROM char_compare;

-- 한쪽이 VARCHAR타입일 경우의 비교
DROP TABLE VARCHAR_COMPARE;
CREATE TABLE VARCHAR_COMPARE (
    sn CHAR(10),
    char_4 CHAR(4),
    varchar_6 VARCHAR2(6)
);


INSERT INTO varchar_compare VALUES ('101', 'SQLD', 'SQLD  ');
INSERT INTO varchar_compare VALUES ('102', 'SQLD', 'SQLA  ');
INSERT INTO varchar_compare VALUES ('103', 'SQLD', 'SQLD');
COMMIT;

SELECT * FROM varchar_compare;

SELECT 
    REPLACE(char_4, ' ', '+') AS char_4,
    REPLACE(varchar_6, ' ', '+') AS varchar_6
FROM varchar_compare
WHERE sn = '101'
    AND char_4 = varchar_6
;
-- 차와 바차를 비교해봤다 
-- 차는 4개고 바차는 4글자+ 공백 2 개이다 칸이 다르기때문에 서로 다른것으로 인식된다 .

SELECT 
    REPLACE(char_4, ' ', '+') AS char_4,
    REPLACE(varchar_6, ' ', '+') AS varchar_6
FROM varchar_compare
WHERE sn = '101'
    AND char_4 = TRIM(varchar_6)
;
-- TRIM  빈공백 지우는 함수 
-- 빈공백을 지워줬기 때문에 서로 같다고 말한다   





-- 상수문자열과의 비교
SELECT 
    REPLACE(char_4, ' ', '+') AS char_4,
    REPLACE(varchar_6, ' ', '+') AS varchar_6
FROM varchar_compare
WHERE sn = '101'
    AND char_4 = 'SQLD         '
;
-- 차타입이랑 비교하면 차 타입으로 비교한다 - 공백 쌩까고 비교한다 


SELECT 
    REPLACE(char_4, ' ', '+') AS char_4,
    REPLACE(varchar_6, ' ', '+') AS varchar_6
FROM varchar_compare
WHERE sn = '101'
    AND varchar_6 = 'SQLD'
;
-- 바차타입이랑 비교하니까 바차룰로



-- # 단일행 함수
-- ## 문자열 함수
SELECT 
    LOWER('Hello WORLD'),  -- 전부 소문자로 변환
    UPPER('hello World'),  -- 전부 대문자로 변환
    INITCAP('abcdef')      -- 첫글자만 대문자로 나머지는 소문자로 변환
FROM dual;


SELECT
    ASCII('A'), -- 문자를 아스키코드로
    CHR(97)     -- 아스키코드를 문자로
FROM dual;



SELECT 
    CONCAT('SQL', 'Developer'),   -- 문자열을 결합
    SUBSTR('SQL Developer', 1, 3), -- 문자열 자름 1번부터 3개자름 (첫글자가 1번) 1번부터 3개 짤라라 // SQL 
    LENGTH('HELLO WORLD'),         -- 문자열의 길이 // 공백까지 세줌 11 글자나옴 
    TRIM('    HI   ')              -- 좌우 공백 제거
FROM dual;

SELECT 
    RPAD('Steve', 10, '-'), -- 오른쪽에 주어진 문자를 채움 (주어진글자 , 총 칸수, 남은칸에 넣을것 )
    RPAD('Steve', 10, '가'), -- 오른쪽에 주어진 문자를 채움 (주어진글자 , 총 칸수, 남은칸에 넣을것 ) 
    --// 글자는 바이트수가 높아서 1바이트가 남으면 못집어넣는다 
    LPAD('Steve', 10, '*'),  -- 왼쪽에 주어진 문자를 채움
    REPLACE('Java Programmer Java', 'Java', 'BigData') AS "REPLACE" -- 문자를 변경
    , REPLACE('Java Programmer', 'Java') AS "REPLACE" -- 문자를 제거
FROM dual;

-- ## 숫자형 함수
SELECT 
    MOD(27, 5) AS MOD, -- 나머지 값 반환
    CEIL(38.678) AS ceil, -- 올림값 반환
    FLOOR(38.678) AS floor, -- 내림값 반환
    ROUND(38.678, 2) AS round, -- 자리수까지 반올림
    TRUNC(38.678, 2) AS trunc  -- 자리수 이하를 절삭
    , ABS(-20) AS abs   -- 절대값
    , SIGN(99) AS sign  -- 0보다 작으면 -1, 0보다 크면 1, 0이면 0
FROM dual;

-- ## 날짜형 함수

-- 현재 날짜를 조회
SELECT SYSDATE
FROM dual;

SELECT SYSTIMESTAMP
FROM dual;

-- 날짜 연산
-- 날짜 + 숫자 = 날짜  => 일(DAY) 수를 날짜에 더함
-- 날짜 - 숫자 = 날짜  => 날짜에서 일 수를 뺌
-- 날짜 - 날짜 = 일수  => 어떤 날짜에서 다른 날짜를 뺀 일수 // 숫자 로 나옴 6/2 이렇게 안나옴  
-- 날짜 + 숫자/24 = 날짜  => 날짜에 시간을 더함

SELECT 
    SYSDATE AS "현재 시간",
    SYSDATE - 1 AS "SYSDATE - 1",
    (SYSDATE + 10) - SYSDATE AS "날짜 - 날짜",
    SYSDATE - (1/24) AS "1시간 차감",
    SYSDATE - (1/24/60) * 100 AS "100분 차감",
    SYSDATE - (1/24/60/60) * 30 AS "30초 차감"
FROM dual;


-- ## 변환 함수
SELECT * FROM char_compare
WHERE sn = 101;

-- 날짜를 문자로 변환 (TO_CHAR함수)
-- 날짜 포맷형식: Y - 연도, MM - 두자리 월, D - 일수
-- 시간 포맷형식: HH12 - 시(1~12), HH24 (0-23), MI - 분, SS - 초
SELECT
    SYSDATE,
    TO_CHAR(SYSDATE, 'MM - DD') AS "월 - 일",
    TO_CHAR(SYSDATE, 'YYYY/MM/DD') AS "연/월/일",
    TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일"') AS "날짜 - 한글포함",-- TO_CHAR를 쓸때 한글을 쓰고싶으면 한글에 "" 쌍따옴표를 붙여야 한다 
    TO_CHAR(SYSDATE + (1/24) * 6, 'YY/MM/DD HH24:MI:SS') AS "날짜와 시간",
    TO_CHAR(SYSDATE + (1/24) * 6, 'YY/MM/DD AM HH12:MI:SS') AS "날짜와 시간2"
    ,TO_CHAR(SYSDATE - (1/24) * 6, 'YY/MM/DD AM HH12:MI:SS') AS "날짜와 시간2"
    
FROM dual;

-- 숫자를 문자로 변환
-- 숫자 포맷 형식 -  $: 달러표시, L: 지역화폐기호
SELECT
    TO_CHAR(9512 * 1.33, '$999,999.99') AS "달러",
    TO_CHAR(1350000, 'L999,999,999') AS "원화"
FROM dual;

-- 문자를 숫자로 변환
SELECT 
    TO_NUMBER('$5,500', '$999,999') - 4000 AS "계산결과"
FROM dual;


-- CASE표현과 DECODE함수
SELECT * FROM tb_sal;


SELECT 
    sal_cd, sal_nm,
    CASE WHEN sal_cd = '100001' THEN '기본급여'
         WHEN sal_cd = '100002' THEN '보너스급여'
         ELSE '기타'
         END sal_name
FROM tb_sal;

SELECT
    sal_cd,
    DECODE(sal_cd, '100001', '기본급여', '100002', '보너스급여', '기타') AS sal_name
FROM tb_sal;

-- # 널 관련 함수
-- NVL(expr1, expr2)
-- expr1: Null을 가질 수 있는 값이나 표현식
-- expr2: expr1이 Null일 경우 대체할 값
SELECT 
    emp_no
    ,emp_nm
    ,NVL(direct_manager_emp_no, '최상위관리자') AS 관리자
FROM tb_emp;

SELECT 
    NVL(emp_nm, '존재안함') AS emp_nm
FROM tb_emp
WHERE emp_nm = '이정직';

SELECT 
    direct_manager_emp_no
FROM tb_emp
WHERE emp_nm = '김회장'
;


SELECT 
      emp_nm
    --MAX(emp_nm)-- 없는애를 null 로 만듦
    --emp_nm -- 없으면 아무것도 안뜸 // 결과 0건 
    --NVL(MAX(emp_nm), '존재안함') AS emp_nm
FROM tb_emp
WHERE emp_nm = '이경오';

-- NVL2(expr1, expr2, expr3)
-- expr1의 값이 Null이 아니면 expr2를 반환, Null이면 expr3를 반환
SELECT 
    emp_nm,
    NVL2(direct_manager_emp_no, '일반사원', '회장님') AS 직위
    --김회장 말고는 다 일반사원이라고 나옴 
FROM tb_emp;

-- NULLIF(expr1, expr2)
-- 두 값이 같으면 NULL리턴, 다르면 expr1 리턴
SELECT
    NULLIF('박찬호', '박찬호')
FROM dual;

SELECT
    NULLIF('tb_emp', 'tb_emp')
FROM dual;
-- 의도는 테이블끼리 비교할려고 했지만 테이블비교는 안되고 
-- 테이블 비교는 안됨 
-- 이 결과는 문자가 같아서 문자로 비교가 되는것임 
SELECT
    NULLIF('앞에가나옴', '박지성')
FROM dual;

-- COALESCE(expr1, ...)
-- 많은 표현식 중 Null이 아닌 값이 최초로 발견되면 해당 값을 리턴
SELECT 
    COALESCE(NULL, NULL, 3000, 4000)
FROM dual;

SELECT 
    COALESCE(NULL, 5000, NULL, 2000)
FROM dual;

SELECT 
    COALESCE(7000, NULL, NULL, 8000)
FROM dual;