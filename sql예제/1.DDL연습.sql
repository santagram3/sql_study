-- DDL : 데이터 정의어 
-- CREATE, ALTER, DROP, RENAME, TRUNCATE

DROP TABLE board;  -- 테이블 지우기 


-- CREATE TABLE : 테이블을 생성
CREATE TABLE board (
 -- 좋아요 , 작성자 , 등등 여러가지 넣자    
 -- 제약조건 , NONT NULL 비어있으면 안됨 , UNIQUE 유일해야됨 , DEFAULT 기본값을 넣겠다 .DEFAULT SYSDATE 기본 실시간 시간 
    bno NUMBER(10) 
    , title VARCHAR2(200) NOT NULL
    , writer VARCHAR2(40) NOT NULL
    , content CLOB
    , reg_date DATE DEFAULT SYSDATE
    , view_count NUMBER(10) DEFAULT 0
    
);

--  ALTER : 데이터 베이스의 구조를 변경 

-- bno 컬럼 수정 

ALTER TABLE board
MODIFY (bno NUMBER(10));

-- pk 설정 -- 외부에서 걸때 
ALTER TABLE board 
ADD CONSTRAINT pk_board_bno
PRIMARY KEY (bno);
-- NOT NULL , UNIQUE 가 자동으로 들어간다 

-- 데이터 추가 
INSERT INTO board 
        (bno, title, writer , content)
VALUES
(1, '안녕', '꾸꾸까가', '아하하하하하핰ㅋㅋㅋㅋ');

INSERT INTO board 
        (bno, title, writer , content)
VALUES
(1, '맛있는 점심 ', '하하호호', '안알렺ㅈㅂㅈ굼ㅋㅋ');
-- bno에서 걸림  



COMMIT;



SELECT * FROM board;


-- 연관관계 설정 
-- 게시물과 댓글의 관계 
-- 1 : M 
-- 게시물 1개당 댓글 여러개 

-- 댓글 테이블 생성 
drop table reply;
CREATE TABLE REPLY (
    rno NUMBER(10)
    , r_content VARCHAR2(400)
    , r_writer VARCHAR2(40) NOT NULL 
    , bno NUMBER(10)
    , CONSTRAINT pk_reply_rno PRIMARY KEY (rno) --pk 설정-- 크리에이트 할때 거는방법  
);

-- 외래키 설정 (FOREIGN KEY) : 테이블 간의 관계 제약 설정 

ALTER TABLE reply
ADD CONSTRAINT fk_reply_bno 
FOREIGN KEY (bno)
REFERENCES board (bno);

-- 컬럼 변경 
-- 컬럼 추가 
ALTER TABLE reply 
ADD (r_reg_date DATE DEFAULT SYSDATE);

SELECT
    * FROM reply ;

-- 컬럼 
ALTER TABLE board 
DROP COLUMN view_count;

-- 컬럼 수정 
ALTER TABLE board 
MODIFY (title VARCHAR2(500));


SELECT *FROM board;

-- 테이블 삭제 
DROP TABLE reply; -- 테이블 구조 자체 날림  
TRUNCATE TABLE board ; -- 테이블 내부 전체 삭제  -- 롤백 불가 

SELECT *FROM board;











