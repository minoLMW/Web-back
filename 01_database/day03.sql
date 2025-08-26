-- table creation
create table movie
(
	movie_name	varchar(100),
	open_date	varchar(8) default '99991231',
	rating		int(2)
);

-- Y2K
-- 99년에서 00년으로 넘어갈 때

select * from movie;

-- 장르(genre)를 추가해달라고 함
-- alter
alter table movie add column genre varchar(20);

-- 100세 관람가 => rating이 3으로 변경되어야 함
alter table movie modify column rating int(3);

insert into movie(movie_name) values ('scream');
insert into movie(movie_name) values ('%');

select *
from   movie
where  movie_name like '%\%%'
;

-- mySql에서 like 성능 이슈로 대체해서 쓰는 
-- full text search도 있다?




