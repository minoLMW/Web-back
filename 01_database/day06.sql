-- case when
select *
from   movie;

-- open_date가 2020년 이전이면 '고전'
--             2024년이면 '최신'
--             2024년 이후라면 '미래'
-- 로 구분하여 영화제목과 구분을 출력하시오.
select movie_name
     , case when open_date <= '20201231' then '고전'
            when open_date like '2024%'  then '최신'
            when open_date >= '20250101' then '미래'
            else '기타' end as gubun
from   movie
;
     
-- with clause의 활용
select * from movie;

with old_movie as (
	select *
	from   movie
	where  open_date < '20200101'
), comedy_movie as (
	select *
	from   movie
	where  genre = 'Comedy'
), old_old_movie as (
	select *
	from   old_movie
	where  open_date < '19500101'
)
select *
from   old_movie
union
select *
from   comedy_movie
;

-- built-in function
-- 1. single-row function
-- 1) numeric
select abs(-88.99) from dual; -- dual 대신 dummy를 쓰는 DB도 존재
select ceil(-4.9), ceil(4.9) from dual;
select round(33.897, 2)
     , round(33.897, -2)
     , round(33.897, -1)
from   dual
;

-- 2) text
select lower('Maria DB'), upper('Heidi SQL') from dual;
select length('q9ouefgwuegfouwegfogefoewg') from dual;
select length('한글은') from dual;

select substr('20231123013122', 1, 8) from dual;
select substr('20231123013122', 9, 6) from dual;
-- 두 번째 인자를 생략하면 끝까지
select substr('Lincoln Mistery', 4) from dual;
-- 음수일 경우 우측부터
select substr('Lincoln Mistery', -4) from dual;

-- 3) to_date(oracle), str_to_date(mysql), to_char
select str_to_date('2024/03-23', '%Y/%m-%d')
from   dual;

select *
from   movie;

-- 아바타6의 개봉일이 100일(년) 밀렸다
select str_to_date(open_date, '%Y%m%d') as date1
     , date_add(str_to_date(open_date, '%Y%m%d'), interval 100 day) as date2
     , to_char(date_add(str_to_date(open_date, '%Y%m%d'), interval 100 day), 'yyyymmdd') as date3
from   movie
where  movie_name = '아바타6'
;

update movie
set    open_date = to_char(date_add(str_to_date(open_date, '%Y%m%d'), interval 10 day), 'yyyymmdd')
where  movie_name = '아바타6' 
;








 