drop table disney_plus_titles;
CREATE TABLE test.disney_plus_titles (
	show_id VARCHAR(50) NULL,
	typ VARCHAR(50) NULL,
	title VARCHAR(200) NULL,
	director VARCHAR(100) NULL,
	casting VARCHAR(1000) NULL,
	country VARCHAR(500) NULL,
	date_added VARCHAR(50) NULL,
	release_year VARCHAR(4) NULL,
	rating VARCHAR(50) NULL,
	duration VARCHAR(50) NULL,
	listed_in VARCHAR(50) NULL,
	description VARCHAR(128) NULL
);

select count(*)
from   disney_plus_titles dpt
;

select *
from   disney_plus_titles dpt 
order by length(country) desc
;

create table netflix_titles as
select *
from   disney_plus_titles
where  1 = 0
;

create table amazon_prime_titles as
select *
from   disney_plus_titles
where  1 = 0
;

alter table amazon_prime_titles modify column description varchar(2000);
alter table amazon_prime_titles modify column casting varchar(2000);
alter table amazon_prime_titles modify column listed_in varchar(100);
alter table amazon_prime_titles modify column director varchar(2000);
alter table netflix_titles modify column description varchar(2000);
alter table netflix_titles modify column listed_in varchar(1000);
alter table netflix_titles modify column casting varchar(2000);
alter table netflix_titles modify column director varchar(2000);
truncate table amazon_prime_titles;
truncate table netflix_titles;

-- 각 방송사의 프로그램 개수를 구해봅시다.
select 'netflix' as studio, count(*) cnt
from   netflix_titles
union all
select 'amazon prime' as studio, count(*) cnt
from   amazon_prime_titles
union all
select 'disney' as studio, count(*) cnt
from   disney_plus_titles
;

-- 각 스튜디오 별로 타입별(TV Show, Movie 등등) 개수를 구하시오?
with studio_titles as ( 
	select 'netflix' as studio, a.*
	from   netflix_titles a
	union all
	select 'amazon prime' as studio, b.*
	from   amazon_prime_titles b
	union all
	select 'disney' as studio, c.*
	from   disney_plus_titles c
)
select studio, typ, count(*)
from   studio_titles
group by studio, typ
;

-- title이 같은 프로그램이 있는지 조사하시오.
with studio_titles as ( 
	select 'netflix' as studio, a.*
	from   netflix_titles a
	union all
	select 'amazon prime' as studio, b.*
	from   amazon_prime_titles b
	union all
	select 'disney' as studio, c.*
	from   disney_plus_titles c
)
select title, count(*)
from   studio_titles
group by title
having count(*) > 1
;

-- 각 스튜디오 별로 가장 많이 제작한 팀과 제작 개수를 구하시오.(null 제외)
with studio_titles as ( 
	select 'netflix' as studio, a.*
	from   netflix_titles a
	union all
	select 'amazon prime' as studio, b.*
	from   amazon_prime_titles b
	union all
	select 'disney' as studio, c.*
	from   disney_plus_titles c
), stat as (
	select studio, director, count(*)
	     , rank() over(partition by studio order by count(*) desc) rnk
	from   studio_titles
	where  director <> ' '
	group by studio, director
	order by studio, count(*) desc
)
select *
from   stat
where  rnk <= 3
;









