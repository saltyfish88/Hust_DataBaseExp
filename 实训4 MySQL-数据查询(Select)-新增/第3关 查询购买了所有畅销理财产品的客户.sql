select pro_c_id
from
(
   select pro_c_id, count(pro_c_id) as cnt1, cnt2
   from 
   (
      select 
         pro_c_id, 
         pro_pif_id, 
         (
            select count(*)
            from 
            (
               select pro_pif_id
               from property
               where pro_type = 1
               group by pro_pif_id having count(distinct(pro_c_id)) > 2
            ) as t1
         ) as cnt2
      from property as p
      natural join
      (
         select pro_pif_id
         from property
         where pro_type = 1
         group by pro_pif_id having count(distinct(pro_c_id)) > 2
      ) as t2
      where pro_type = 1
      order by pro_c_id
   ) as t3
   group by pro_c_id
) as t4
where cnt1 = cnt2