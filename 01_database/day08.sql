-- rating별, 개봉연도별 영화 수 구하기
-- 개수가 많은 것부터, 개수가 같다면 개봉연도가 최신부터
select rating
     , substr(open_date, 1, 4) as oy
     , count(*) as "영화 수"
from   movie_n
-- group by rating, substr(open_date, 1, 4)
group by rating, oy
-- group by 1, 2 -- 첫 번째 컬럼, 두 번째 컬럼을 의미하며 추천하지는 않음
having count(*) > 1
order by count(*) desc, oy desc
;

-- 2000년 이전 작품은 고전, 2000이후 작품은 최신으로 분류하고
-- 고전 최신이 각각 몇 개인지 구하기
select case when open_date < '20000101' then '고전'
            else '최신' end as gubun
     , count(*)
from   movie_n
group by gubun
;

-- Challenge(Difficulty : GOD)
-- 영화통계를 구하되
-- 2000년 이전, 2000년대, 2010년대, 2020년대의 건수를 구하시오.\
-- 가로로 출력되도록 작성하시오.
-- 2000년 이전   2000년대    2010년대    2020년대
--         1        10          7          2
select case when open_date < '20000101' 
            then '2000년 이전'
            when open_date between '20000101'
                           and     '20091231'
            then '2000년대'
            when open_date between '20100101'
                           and     '20191231'
            then '2010년대'
            else '2020년대'
            end as gubun
     , count(*)
from   movie_n
group by gubun
;

select sum(case when open_date < '20000101' 
                then 1 else 0 end) as '2000년 이전'
     , sum(case when open_date between '20000101'
                               and     '20091231'
                then 1 else 0 end) as '2000년대'
     , sum(case when open_date between '20100101'
                               and     '20191231'
                then 1 else 0 end) as '2010년대'  
     , sum(case when open_date >= '20200101'
                then 1 else 0 end) as '2020년대'
from   movie_n
;
      
-- 병원 데이터 실습
-- 1. data load 확인
select *
from   hptl_mast
limit  10
;

-- 2. 건수 세어보기
select count(*)
from   hptl_mast
;
-- 77,139건

-- 3. select test
-- 병원 이름이 서울 로 시작하는 병원의 비율
select sum(case when hptl_nm like '%한의원%' 
                then 1 else 0 end) / count(*) * 100 
       as '서울로 시작하는 병원 비율'
from   hptl_mast
;

-- 4. secu_key_cd 컬럼 삭제
alter table hptl_mast drop column secu_key_cd;

-- 5. 실습과제 1
-- 경기에 있는 병원 10곳의 병원이름과 전화번호 맨 뒷자리 4자리 가져오기
select hptl_nm
--      , tel_no
     , substr(tel_no, -4) as last4_telno
from   hptl_mast
where  sido_cd_nm = '경기'
limit  10
;






