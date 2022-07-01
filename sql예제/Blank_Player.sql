
drop table blank ;
CREATE TABLE BLANK (	
    QNUM NUMBER(10),
	TEXTS VARCHAR2(1000), 
	ANSWER NUMBER(3)
);

CREATE SEQUENCE qqnum;

select * from blank;

insert into blank values (qqnum.nextval , '네가 참 궁금해 그건 너도 마찬가지
이거면 충분해 쫓고 쫓는 이런 놀이' , 11);
insert into blank values (qqnum.nextval , 
'인간의 욕심은 끝이 없고 같은 실수를 반복하지
너그럽게 살면서 대박을 노린다면 어림 반푼어치
우린 운명의 주사위를 던졌고 한치 오차도 용납 못하지' , 20);
commit;

drop table player;
create table players (
    PNAME VARCHAR2(100) PRIMARY KEY
    , onumber NUMBER(3)
    , plustime NUMBER(3)
);
select * from players;

insert into players values ('남기원',5,30);
commit;



    