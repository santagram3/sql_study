
drop table blank ;
CREATE TABLE BLANK (	
    QNUM NUMBER(10),
	TEXTS VARCHAR2(1000), 
	ANSWER NUMBER(3)
);

CREATE SEQUENCE qqnum;

select * from blank;

insert into blank values (qqnum.nextval , '�װ� �� �ñ��� �װ� �ʵ� ��������
�̰Ÿ� ����� �Ѱ� �Ѵ� �̷� ����' , 11);
insert into blank values (qqnum.nextval , 
'�ΰ��� ����� ���� ���� ���� �Ǽ��� �ݺ�����
�ʱ׷��� ��鼭 ����� �븰�ٸ� � ��Ǭ��ġ
�츰 ����� �ֻ����� ������ ��ġ ������ �볳 ������' , 20);
commit;

drop table player;
create table players (
    PNAME VARCHAR2(100) PRIMARY KEY
    , onumber NUMBER(3)
    , plustime NUMBER(3)
);
select * from players;

insert into players values ('�����',5,30);
commit;



    