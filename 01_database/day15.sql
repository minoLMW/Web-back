-- Sequence
create sequence seq_test2 nocache;

select nextval(seq_test)
from   dual;

drop view hptl_mast_v;

create view hptl_mast_v as
select hptl_nm, typ_cd
from   hptl_mast
where  typ_cd = '1'
;

select *
from   hptl_mast_v
limit 3
;

-- 사용자의 편의성을 위해 타입코드명을 보여주기로 한다.
create view hptl_mast_v2 as
select hptl_nm, typ_cd_nm
from   hptl_mast m
     , typ_cd_dtl t
where  m.typ_cd = t.typ_cd
;

select *
from   hptl_mast_v2
where  hptl_nm = '강북삼성병원'
;

-- 10. 승률 1위팀의 팀명과 승률을 구하시오.(무승부는 제외)
with full_sche as (
	select sche_date
	     , case when home_score > away_score then hometeam_id
	            else awayteam_id end as wt
	     , case when home_score < away_score then hometeam_id
	            else awayteam_id end as lt 
	from   schedule
	where  home_score <> away_score
), wstat as (
	select wt, count(*) cnt
	from   full_sche
	group by wt
), lstat as (
	select lt, count(*) cnt
	from   full_sche
	group by lt
), base as (   -- 전승팀 또는 전패팀이 있을 수 있어 기준 팀 리스트를 구성한다.
	select wt as teamid from wstat
	union
	select lt from lstat
)
select (select team_name from team where team_id = b.teamid) as teamname
     , nvl(w.cnt,0) as wins
     , nvl(l.cnt,0) as loses
     , round(nvl(w.cnt,0)/(nvl(w.cnt,0)+nvl(l.cnt,0))*100,0) as win_ratio
from   base b left outer join wstat w on b.teamid = w.wt
              left outer join lstat l on b.teamid = l.lt
order by win_ratio desc            
;











