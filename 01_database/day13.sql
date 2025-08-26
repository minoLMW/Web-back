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

-- Subquery
select bh.hptl_nm
     , s.siggu_cd_nm
from   (
		select hptl_nm, siggu_cd
		from   hptl_mast
	    where  doc_num > 1000
       ) as bh -- big hospital
     , siggu_cd_dtl s
where  bh.siggu_cd = s.siggu_cd 
;

with bh as (
	select hptl_nm, siggu_cd, addr, sido_cd, typ_cd
	from   hptl_mast
)
select bh.hptl_nm
     , bh.sido_cd
     , s.siggu_cd_nm
     , bh.addr
from   bh
     , siggu_cd_dtl s
     , typ_cd_dtl t
     , sido_cd_dtl c
where  bh.siggu_cd = s.siggu_cd
and    t.typ_cd = bh.typ_cd
and    c.sido_cd = bh.sido_cd
and    c.sido_cd_nm = '강원'
and    t.typ_cd_nm = '상급종합'
;

-- Scalar Subquery
-- scalar : 값 1개
-- Scalar Subquery는 인풋에 대한 결과가 반드시 1개가 나오는 쿼리로
-- 인풋과 아웃풋 쌍을 일부 저장하고 있다.(caching)
-- select 절에 나타나는 subquery를 일컫는 용어
with bh as (
	select hptl_nm, siggu_cd, addr, sido_cd, typ_cd
	from   hptl_mast
)
select bh.hptl_nm
     , bh.sido_cd
--      , s.siggu_cd_nm
     , (select siggu_cd_nm from siggu_cd_dtl
        where siggu_cd = bh.siggu_cd) as siggu_cd_nm
     , bh.addr
from   bh
--      , siggu_cd_dtl s
     , typ_cd_dtl t
     , sido_cd_dtl c
where  t.typ_cd = bh.typ_cd
and    c.sido_cd = bh.sido_cd
and    c.sido_cd_nm = '강원'
and    t.typ_cd_nm = '상급종합'
;

-- exists + in
-- 데이터 준비
-- 의사 수가 0명인 병원을 blacklist라고 생성한다.
create table blacklist as
select hptl_nm, sido_cd, siggu_cd
from   hptl_mast
where  doc_num = 0
;

select *
from   blacklist
;

-- 서울에 있는 병원 중 blacklist에 존재하는 병원을 찾는 쿼리
select h.hptl_nm
     , addr
     , hptl_url
from   hptl_mast h
     , blacklist b
where  h.hptl_nm = b.hptl_nm
and    h.siggu_cd = b.siggu_cd
and    h.sido_cd = '110000'
;

select hptl_nm
     , addr
     , hptl_url
from   hptl_mast h
where  sido_cd = '110000'
and    exists (select 1
               from   blacklist
               where  hptl_nm = h.hptl_nm
               and    siggu_cd = h.siggu_cd)
;

select hptl_nm
     , addr
     , hptl_url
from   hptl_mast h
where  sido_cd = '110000'
and    (hptl_nm, siggu_cd) in (select hptl_nm, siggu_cd
                               from   blacklist)
;                               





