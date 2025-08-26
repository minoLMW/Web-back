-- 일부만 수행할 때는 일부 선택 후 우클릭
-- 실행 -> SQL 스크립트 실행
select 1 from dual;
select 2 from dual;
select 3 from dual;

-- 테이블 생성하기
create table member 
(
	seq		int(10),
	id		varchar(20),
	name	varchar(50)
);

-- 데이터 추가하기
insert into member values(1, 'mi7', 'tomcruise');
insert into member values(2, 'insideout2', 'Anger');

-- 데이터 조회하기
select *  -- *는 컬럼 전체를 의미한다.
from   member
;

-- 테이블 삭제하기
drop table member;







