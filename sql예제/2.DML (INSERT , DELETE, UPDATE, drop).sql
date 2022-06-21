

-- DML : 데이터 조작어 
-- 조회 (SELECT) , 갱신(INSERT M UPDATE , DELETE)



INSERT INTO board
    
(bno , title , content , writer ,reg_date)
    VALUES
    (1,'제목이야' ,'라라라라' , '둘리 ' ,   SYSDATE + 1);

INSERT INTO board
    
(bno ,  content , writer )
    VALUES
    (2,'라라라라' , '둘리 ' );
-- NOT NULL 제약조건 위배 

INSERT INTO board  
(bno , title , content , writer )
    VALUES
    (1,'제목이야' ,'라라라라' , '둘리 ' );
-- PK 제약조건 위배 

INSERT INTO board
(bno , title , writer )
    VALUES
    (2,'제목이야' , '짹쨱' );
    -- 가능 ,레그데이트가 디폴트0이기 때문에 기본값이 0 이다 


INSERT INTO board
-- 없어도 되는데 , 없을경우 순서에 맞게 써줘야 한다 
    VALUES
    (3,'제목제목' ,'잭스패로우' , '하하내용 ' ,   SYSDATE + 1);
    -- 컬럼을 명시하지 않았을 경우 반드시 모든 컬럼의 값을 순서대로 채워야함 


-- 데이터 수정 

UPDATE board
SET title = '수정된 제목이야~'
WHERE bno = 3 ;

UPDATE board
SET writer = '수정맨'
    , content = '수정한 내용입니다. fix'
WHERE bno = 2 ;

-- WHERE 절 생략시 벌어지는일 
UPDATE board
SET writer = '나쁜놈';
-- 전체 롸이터를 나쁜놈으로 수정해버린다 .

-- 데이터 삭제 -중간 내용은 못지우고 지우려면 전체 행 하나를 지워야 한다 
DELETE FROM board
WHERE bno = 1 ;

-- 전체 데이터 삭제 
-- 1. WHERE절을 생략한 DELETE절
-- (롤백 가능 , 수동커밋 가능, 로그 남기기 가능)
DELETE FROM board ; 

-- 2. TRUNCATE TABLE
--(롤백 불가능 , 자동커밋 , 로그를 남길 수 없음 , 테이블 생성 초기 상태로 복귀 )

TRUNCATE TABLE board; 

-- 3.   DROP TABLE 
--(롤백 불가능 , 자동커밋 , 로그를 남길 수 없음 , 테이블 구조가 완전 삭제됨 )

7DROP TABLE board; 









COMMIT;

ROLLBACK;

SELECT
    * FROM board;
