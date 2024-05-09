  -- 2) 投资积极且偏好理财类产品的客户
--   请用一条SQL语句实现该查询：
with table_cnt_1 as
(
    select pro_c_id, count(distinct(pro_pif_id)) as cnt_1
    from property
    where pro_type = 1
    group by pro_c_id
),#理财产品
table_cnt_3 as
(
    select pro_c_id, count(distinct(pro_pif_id)) as cnt_3
    from property
    where pro_type = 3
    group by pro_c_id
)#基金
select distinct property.pro_c_id
from property 
inner join table_cnt_1 on property.pro_c_id = table_cnt_1.pro_c_id
inner join table_cnt_3 on property.pro_c_id = table_cnt_3.pro_c_id
where pro_type = 1 and cnt_1 > cnt_3
order by pro_c_id;




/*  end  of  your code  */