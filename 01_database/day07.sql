-- Aggregate Function
-- count, distinct
select * from movie;
select count(*) from movie;

-- 영화 이름이 아바타로 시작하는 영화 개수는?
select count(*)
from   movie
where  movie_name like '아바타%'
;

-- rating, genre의 종류는 무엇들이 있는가?
select distinct rating, genre
from   movie
;

-- 장르의 종류 수는?
select count(distinct genre)
from   movie
;

-- 12세 이상 관람가인 영화의 장르의 개수는?
select count(distinct genre)
from   movie
where  rating >= 12
;

-- 다양한 집계함수
select min(rating), min(movie_name)
     , round(avg(rating), 1), sum(rating)
from   movie
;

-- 다양한 SQL 연습
-- 1단계 : 데이터 준비
create table movie_n as
select *
from   movie
where  1 = 0
;

select *
from   movie_n
;

insert into movie_n values('무제01','19991201',12,'romance');
insert into movie_n values('무제02','19751001',19,'ani');
insert into movie_n values('무제03','20011201',15,'musical');
insert into movie_n values('무제04','19741201',12,'romance');
insert into movie_n values('무제05','20101201',15,'ani');
insert into movie_n values('무제06','20201201',00,'musical');
insert into movie_n values('무제07','20231201',12,'romance');
insert into movie_n values('무제08','20111201',15,'musical');
insert into movie_n values('무제09','20151201',19,'ani');
insert into movie_n values('무제10','20181201',00,'romance');

-- movie_n에 있는 데이터의 개수는?
select count(*)
from   movie_n
;

-- genre가 모두 대문자가 아닌 데이터는 대문자로 업데이트 하시오.
update movie_n
set    genre = upper(genre)
-- where  genre != upper(genre)
;

-- 연구대상
select genre, upper(genre)
from   movie_n
where  genre = upper(genre) 
;

-- 개봉일자 순으로 오래된 것부터
select *
from   movie_n
order by open_date
;

-- 개봉일자 순으로 최신 것부터
select *
from   movie_n
order by open_date desc
;

-- 2000년 이후 영화는 '최신'
-- 이전 영화는 '고전'으로 표시되는 결과를 만드시오.
-- 영화제목, 개봉일, 최신구분
-- 개봉일 역순으로 배열하시오.
select movie_name, open_date, gubun
from
(
	select movie_name, open_date, '최신' as gubun
	from   movie_n
	where  open_date >= '20000101'
	union
	select movie_name, open_date, '고전' as gubun
	from   movie_n
	where  open_date < '20000101'
) as T1
order by open_date desc
;

select movie_name
     , open_date
     , case when open_date >= '20000101' then '최신'
            else '고전' end as gubun
from   movie_n
order by open_date desc
;

-- rating 별로 영화 수 구하기
-- group by
select rating, count(*)
from   movie_n
group by rating
;

-- rating별, 개봉연도별 영화 수 구하기
-- 개수가 많은 것부터, 개수가 같다면 개봉연도가 최신부터











