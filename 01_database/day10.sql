-- 정규화 연습
-- hptl_mast
-- hptl_nm이 PK라고 가정(실제로는 아님)
-- PK가 단일컬럼이라면 진부분 집합이 없다.
-- -> 2차 정규화는 불필요
-- 3차 정규화 대상 => typ_cd로 결정되는 typ_cd_nm
-- 3차 정규화 대상 => sido_cd로 결정되는 sido_cd_nm
-- 3차 정규화 대상 => siggu_cd로 결정되는 siggu_cd_nm

-- 사전 테스트
-- typ_cd의 종류와 그에 따른 typ_cd_nm을 모두 출력하시오.
select typ_cd, typ_cd_nm
from   hptl_mast
group by typ_cd, typ_cd_nm
;

-- typ_cd의 종류 개수를 구하시오.
select count(*)
from (
	select typ_cd, typ_cd_nm
	from   hptl_mast
	group by typ_cd, typ_cd_nm
) as t1
;

select count(distinct typ_cd, typ_cd_nm)
from   hptl_mast
;

-- typ_cd와 typ_cd_nm을 보관하는 테이블을 만드시오.
-- 테이블명 : typ_cd_dtl
create table typ_cd_dtl as
select distinct typ_cd, typ_cd_nm
from   hptl_mast
;

select *
from   typ_cd_dtl
;

create table sido_cd_dtl as
select distinct sido_cd, sido_cd_nm
from   hptl_mast
;

create table siggu_cd_dtl as
select distinct siggu_cd, siggu_cd_nm
from   hptl_mast
;

select *
from   siggu_cd_dtl
;

-- hptl_mast를 hptl_mast_bak에 복제
-- 전체 백업은 실제로는 export를 이용하는 경우가 많음
create table hptl_mast_bak as
select * from hptl_mast
;

-- 3개 nm필드(컬럼) drop
alter table hptl_mast drop column typ_cd_nm;
alter table hptl_mast drop column sido_cd_nm;
alter table hptl_mast drop column siggu_cd_nm;

select * from hptl_mast;

-- Analytic Function
select hptl_nm
     , doc_num
     , rank() over(order by doc_num desc) as "전체등수"
     , rank() over(partition by sido_cd 
                   order by doc_num desc) as "지역내등수"
     , avg(doc_num) over(order by doc_num desc
     		             rows between 1 preceding
     		                  and     1 following
     			     ) as "3평균"
     , sum(doc_num) over(order by doc_num desc
                         rows between unbounded preceding
                              and     current row
                     ) as "의사수누적 합"
     , lead(doc_num) over(order by doc_num desc) as lead_num
     , lag(doc_num) over(order by doc_num desc) as lag_num
     , lag(doc_num) over(order by doc_num desc) - doc_num 
       as "내 앞순위와의 의사수 차이" 
from   hptl_mast
;






