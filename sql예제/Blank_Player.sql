
drop table blank ;
CREATE TABLE BLANK (	
    QNUM NUMBER(10),
	TEXTS VARCHAR2(1000), 
	ANSWER NUMBER(3)
);
truncate table blank;
drop SEQUENCE qqnum;
CREATE SEQUENCE qqnum;

select * from blank;

insert into blank values (qqnum.nextval , '네가 참 궁금해 그건 너도 마찬가지
이거면 충분    해 쫓고 쫓는 이런 놀이' , 14);

insert into blank values (qqnum.nextval , 
'인간의 욕심 은끝이 없고 같은 실수를 반복하지
너그럽게 살면서 대박을 노린다면 어림반 푼어 치
우린 운명의 주사위를 던졌고 한치 오차 도 용납 못하지' , 20);

insert into blank values (qqnum.nextval , '준비하시고 (Go) 쏘세요 (Oh)
That that I lik e t hat (Like that)
기분 )좋아 (Babe( (((Babe)
흔들어( 좌) (우 위) 아(래)로 (Sing it)
One twot hree to thefo ur (Si ng it)' , 28);

insert into blank values (qqnum.nextval , '이듬해 질 녘 꽃 피는 봄 한여름 밤의 꿈
가을타겨울 내 릴 눈 1 년 네 번또다시  봄
정들었던내 젊 은 날 이제  는 안녕
아름   답던 우리의 봄 여름 가을 겨울' , 31);

insert into blank values (qqnum.nextval , 'Look at you 넌 못 감당해 날
Ya took off hook
기분은 Coke like brrr
Look at my toe 나의 Ex 이름 Tattoo
I got to drink up now 네가 싫다 해도 좋아' , 28);

insert into blank values (qqnum.nextval , '아침엔 모닝콜 필수던 내가
오늘은 번쩍 번쩍 눈이 떠지는가
데이트 날이라 그 런지 어제 꿈도 좋은 꿈  꿨지
새 신발을 신고' , 18);

insert into blank values (qqnum.nextval , 
'이제야 목적지를 정했지만 가려한 날 막아서네 난 갈 길이 먼데
새빨간 얼굴로 화를 냈던 친구가 생각나네 
이미 난 발걸음을 떼었지만 가려한 날 재촉하네 걷기도 힘든데
새파랗게 겁에 질려 도망간 친구가 뇌에 맴도네' , 28);

insert into blank values (qqnum.nextval , 
'[광고없는 실시간  멜론차트]
2022년 6월 30일 4 주 차 멜론 차 트 반영  최신가 요 K POP 노래모 음' , 19);

commit;

drop table player;
create table players (
    PNAME VARCHAR2(100) PRIMARY KEY
    , onumber NUMBER(3)
    , plustime NUMBER(3)
);
select * from players;
truncate table players;

insert into players values ('구준표',5,92);
insert into players values ('팔준표',5,85);
insert into players values ('장혁',6,115);
insert into players values ('잔혁',6,160);
insert into players values ('간나야',8,330);
commit;



    