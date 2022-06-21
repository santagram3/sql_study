
-- 문자열 결합 연산자!! 

-- EX ) SQLD (100002) - 한국데이터진흥원 

SELECT

CERTI_NM || ' (  ' || CERTI_CD || '  ) -  ' || ISSUE_INSTI_NM AS "자격증 정보 "

 FROM TB_CERTI; 
 
 -- 더미테이블 (DUAL): 단순 연산 결과를 조회 할 때 사용 
 SELECT 
  3 * 7 AS "연산 결과" 
 FROM DUAL ;
 
 SELECT 
  SYSDATE AS " 현재 날짜 " 
 FROM DUAL ;
 
 
 
 
 
 
 
 
 
 
 