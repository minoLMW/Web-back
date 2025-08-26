select *
from   stadium
;

select *
from   schedule;

select *
from   team;

-- 1. schedule 테이블에서 3줄의 데이터만 한 번 살펴보시오.
select *
from   schedule
limit 3
;

-- 2. schedule 테이블의 총 건수를 구하시오.
select count(*)
from   schedule
;

-- 3. 2012년 7월의 schedule은 몇 개인지 구하시오.
select count(*)
from   schedule
where  sche_date like '201207%'
;

-- 4. 각 팀별로 schedule 건수를 구하시오.(홈팀기준)
select hometeam_id, count(*)
from   schedule
group by hometeam_id
;

-- 5. 원정 팀이 승리한 경기의 개수를 구하시오.
select count(*)
from   schedule
where  away_score > home_score
;

-- 6. 원정 팀이 이긴 경기의 경기일자, 승리팀과 패배팀을 구하시오.
--    승리팀과 패배팀은 코드로 표시
select sche_date, awayteam_id, hometeam_id
from   schedule
where  away_score > home_score
;

-- 7. 원정 팀이 이긴 경기의 경기일자, 승리팀과 패배팀을 구하시오.
--    승리팀과 패배팀은 팀명으로 표시 
select sche_date
--      , awayteam_id
--      , hometeam_id
     , (select team_name from team
        where  team_id = s.awayteam_id) as "승리팀"
     , (select team_name from team
        where  team_id = s.hometeam_id) as "패배팀"
from   schedule s
where  away_score > home_score
;

-- 8. 전체 경기 중 홈팀이 승리한 경기의 비율, 무승부인 비율,
--    원정팀 승리 비율을 구하시오.
with tot_game as (
	select count(*) as tot
	from   schedule
)
select  
	(select count(*)
	 from   schedule
	 where  home_score > away_score) / tot * 100 as hw_ratio
   ,(select count(*)
	 from   schedule
	 where  home_score = away_score) / tot * 100 as dr_ratio
   ,(select count(*)
     from   schedule
     where  home_score < away_score) / tot * 100 as aw_ratio
from tot_game
;	 

with stat as (
	select count(*) tot
	     , sum(case when home_score > away_score then 1 else 0 end) hw
	     , sum(case when home_score = away_score then 1 else 0 end) dr
	     , sum(case when home_score < away_score then 1 else 0 end) aw
	from   schedule
)
select hw/tot*100 as hw
     , dr/tot*100 as dr
     , aw/tot*100 as aw
from   stat     
;

select count(*) tot
     , sum(case when home_score > away_score 
                then 1 else 0 end) / count(*) * 100 hw
     , sum(case when home_score = away_score 
                then 1 else 0 end) / count(*) * 100 dr
     , sum(case when home_score < away_score 
                then 1 else 0 end) / count(*) * 100 aw
from   schedule
;

-- 9. 가장 경기를 많이 한 팀을 구하고 그 팀의 평균 득점을 구하시오.
with schedule_new as (
	select hometeam_id as team_id
	     , home_score as score from schedule
	union all
	select awayteam_id, away_score from schedule
), schedule_t as (
	select team_id, avg(score), count(*) as cnt
	from   schedule_new
	group by team_id
	order by cnt desc
)
select *
from   schedule_t
where  cnt = (select max(cnt) from schedule_t)
;



