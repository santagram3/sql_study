
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

insert into blank values (qqnum.nextval , '�װ� �� �ñ��� �װ� �ʵ� ��������
�̰Ÿ� ���    �� �Ѱ� �Ѵ� �̷� ����' , 14);

insert into blank values (qqnum.nextval , 
'�ΰ��� ��� ������ ���� ���� �Ǽ��� �ݺ�����
�ʱ׷��� ��鼭 ����� �븰�ٸ� ��� Ǭ�� ġ
�츰 ����� �ֻ����� ������ ��ġ ���� �� �볳 ������' , 20);

insert into blank values (qqnum.nextval , '�غ��Ͻð� (Go) ��� (Oh)
That that I lik e t hat (Like that)
��� )���� (Babe( (((Babe)
����( ��) (�� ��) ��(��)�� (Sing it)
One twot hree to thefo ur (Si ng it)' , 28);

insert into blank values (qqnum.nextval , '�̵��� �� �� �� �Ǵ� �� �ѿ��� ���� ��
����Ÿ�ܿ� �� �� �� 1 �� �� ���Ǵٽ�  ��
��������� �� �� �� ����  �� �ȳ�
�Ƹ�   ��� �츮�� �� ���� ���� �ܿ�' , 31);

insert into blank values (qqnum.nextval , 'Look at you �� �� ������ ��
Ya took off hook
����� Coke like brrr
Look at my toe ���� Ex �̸� Tattoo
I got to drink up now �װ� �ȴ� �ص� ����' , 28);

insert into blank values (qqnum.nextval , '��ħ�� ����� �ʼ��� ����
������ ��½ ��½ ���� �����°�
����Ʈ ���̶� �� ���� ���� �޵� ���� ��  ����
�� �Ź��� �Ű�' , 18);

insert into blank values (qqnum.nextval , 
'������ �������� �������� ������ �� ���Ƽ��� �� �� ���� �յ�
������ �󱼷� ȭ�� �´� ģ���� �������� 
�̹� �� �߰����� �������� ������ �� �����ϳ� �ȱ⵵ ���絥
���Ķ��� �̿� ���� ������ ģ���� ���� �ɵ���' , 28);

insert into blank values (qqnum.nextval , 
'[������� �ǽð�  �����Ʈ]
2022�� 6�� 30�� 4 �� �� ��� �� Ʈ �ݿ�  �ֽŰ� �� K POP �뷡�� ��' , 19);

commit;

drop table player;
create table players (
    PNAME VARCHAR2(100) PRIMARY KEY
    , onumber NUMBER(3)
    , plustime NUMBER(3)
);
select * from players;
truncate table players;

insert into players values ('����ǥ',5,92);
insert into players values ('����ǥ',5,85);
insert into players values ('����',6,115);
insert into players values ('����',6,160);
insert into players values ('������',8,330);
commit;



    