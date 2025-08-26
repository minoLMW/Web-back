-- lpad, rpad
-- movie_n 테이블의 개봉일을 10자리로 하고 앞에 *을 붙이시오.
-- rating이 3자리 미만이면 3자리로 맞추시오.

-- target table
-- movie_n
select open_date
     , lpad(open_date, 10, '*')
     , lpad(rating, 3, 0)
from   movie_n
;

with cust as (
	select '390912-1337812' as jn
	from   dual
)
select jn
     , concat(substr(jn, 1, 7), '*******') as sec_jn1
     , rpad(substr(jn, 1, 7), 14, '*') as sec_jn2
from   cust
;

-- 일반의, 인턴, 레지던트 수를 제출하되 
-- 각 데이터를 4자리로 구분자는 ;으로 할 것
select hptl_nm
--      , doc_gnrl_num
--      , doc_int_num
--      , doc_resi_num
     , concat(lpad(doc_gnrl_num, 4, 0), ';',
              lpad(doc_int_num, 4, 0), ';',
              lpad(doc_resi_num, 4, 0)) as data
from   hptl_mast
;
	
-- replace
select "도더리가 -그건 네 자유지-라고 말했다." as original
     , replace("도더리가 -그건 네 자유지-라고 말했다.",
               "그건 네 자유지", "That is your freezone")
       as eng_ver
from   dual
;
	
-- 실습과제2
-- 병원 이름에 병원 > Hospital, 대학교 > Univ.로 대체하시오.
select replace(replace(hptl_nm, '병원', 'Hospital'), 
               '대학교', 'Univ.') as result
from   hptl_mast
;

-- 실습과제3
-- 첫 줄에는 서울에 있는 총 병원수
-- 두 번째 줄에는 서울에 있는 병원의 평균 의사 수
-- 세 번째 줄부터는 서울에 있는 병원 이름, 의사 수
select "서울병원수" as "항목", count(*) as "데이터"
from   hptl_mast
where  sido_cd_nm = '서울'
union all
select "서울병원평균의사수", avg(doc_num) as "데이터"
from   hptl_mast
where  sido_cd_nm = '서울'
union all
select "-----------------------------------", "-----------------"
from   dual
union all
select hptl_nm, doc_num
from   hptl_mast
where  sido_cd_nm = '서울'
;

select *
from   hptl_mast
where  doc_num = 20060331
;

-- 실습과제4
-- sido_cd_nm별 병원 수를 구하고, 병원 수가 많은 시도부터 나열하시오.
select sido_cd_nm, count(*) 
from   hptl_mast
group by sido_cd_nm
order by count(*) desc
;
	
select *
from   hptl_mast
;
	
	
	