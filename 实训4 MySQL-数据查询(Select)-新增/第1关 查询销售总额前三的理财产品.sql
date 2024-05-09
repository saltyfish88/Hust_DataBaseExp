 -- 1) 查询销售总额前三的理财产品
--   请用一条SQL语句实现该,查询：
select * from
(
    select pyear,
    rank() over(partition by pyear order by sumamount desc) as rk,
    p_id, sumamount
    from 
    (
        select year(pro_purchase_time) as pyear, sum(pro_quantity * p_amount) as sumamount, p_id
        from
        (
        select *from property
        where pro_type = 1 and year(pro_purchase_time) in (2010,2011)
        ) as a inner join finances_product on pro_pif_id = p_id
        group by p_id, pyear
    ) as b
) as c
where rk <= 3;



/*  end  of  your code  */