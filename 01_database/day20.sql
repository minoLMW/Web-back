select hptl_nm, addr
from   hptl_mast
where  hptl_nm like '%가톨릭%'
order by doc_num desc
limit  10
;