select *
from   movie
;

-- not null
create table movie2
(
	movie_name	varchar(100) not null,
	open_date	varchar(8)	default '99991231'
);

insert into movie2(open_date) values('20240919');
-- movie_name(not null)이 없어서 오류

insert into movie2(open_date, movie_name)
values('20240317', '아바타4');

select * from movie2;

-- default
insert into movie2(movie_name) values('베테랑2');

-- Primary Key
alter table movie2
add constraint movie2_pk primary key(movie_name);
-- PK를 포함한 인덱스는 조회 성능을 좋게 한다.
-- 대신에 데이터 삽입, 수정, 삭제는 성능이 저하된다.
-- 오늘 밤에 데이터를 10억건을 넣어야한다?
-- 매 row마다 인덱스 추가 + PK(Constraint) 검사
-- 인덱스 제거 -> 데이터 적재 -> 인덱스 재구성(rebuild)

insert into movie2(movie_name) values('아바타4');

-- insert into select(특수기술)
insert into movie2
select movie_name, open_date from movie
where  movie_name <> '아바타4'; 

select * from movie2;

-- CTAS
-- create table as select
-- 1) 아바타4 데이터만 가지고 테이블을 생성하고 싶음
--    movie3 생성
create table movie3 as
select * from movie2
where movie_name = '아바타4'
;

-- 2) movie2의 컬럼만 가지고 테이블을 만들고 싶다.
-- 데이터는 필요없다.
create table movie4 as
select *
from   movie2
where  1 = 0
;

-- alias
select avg(m.r) as "평균관람가연령"
     , count(*) as "rating이 있는 총영화건수"
from (
		select movie_name as mn
		     , rating as r
		from   movie
		where  rating is not null
	 ) as m
;

select * from movie;





