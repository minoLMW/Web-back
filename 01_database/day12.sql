-- catesian product를 의도적으로 사용하기

with ye as 
(
	select '2022' as yyyy from dual
	union all
	select '2023' as yyyy from dual
	union all
	select '2024' as yyyy from dual 
), mon as
(
	select '01' as mm from dual	union all
	select '02' from dual union all
	select '03' from dual union all
	select '04' from dual union all
	select '05' from dual union all
	select '06' from dual union all
	select '07' from dual union all
	select '08' from dual union all
	select '09' from dual union all	
	select '10' from dual union all
	select '11' from dual union all
	select '12' from dual
), yyyymm as 
(
	select concat(ye.yyyy, mon.mm) as yyyymm
	from   ye, mon
	order by yyyymm
)
select m.*
from   movie m
     , yyyymm y
where  substr(m.open_date, 1, 6) = y.yyyymm
;

-- 정규화 3단계를 통해 테이블이 분할되었다.
-- 강원도에 있는 상급종합의 병원명, 시군구명, 주소를 구하시오.
-- bak 테이블은 이용하지 마시오.
select h.hptl_nm
     , g.siggu_cd_nm
     , h.addr
from   hptl_mast h
     , sido_cd_dtl s
     , typ_cd_dtl t
     , siggu_cd_dtl g
where  s.sido_cd_nm = '강원'     
and    h.sido_cd = s.sido_cd
and    t.typ_cd_nm = '상급종합'
and    h.typ_cd = t.typ_cd
and    g.siggu_cd = h.siggu_cd
; 









