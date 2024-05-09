use finance1;

-- 在金融应用场景数据库中，编程实现一个转账操作的存储过程sp_transfer_balance，实现从一个帐户向另一个帐户转账。
-- 请补充代码完成该过程：
delimiter $$
create procedure sp_transfer
(
    IN applicant_id int,      
    IN source_card_id char(30),
    IN receiver_id int, 
    IN dest_card_id char(30),
    IN amount numeric(10,2),
    OUT return_code int)
pro:
BEGIN
    declare src_id, dst_id int;
    declare src_type, dst_type char(20);
    declare src_balance, dst_amount numeric(10, 2) default amount;

    select b_c_id, b_balance, b_type
    into src_id, src_balance, src_type
    from bank_card
    where b_number = source_card_id;

    select b_c_id, b_type
    into dst_id, dst_type
    from bank_card
    where b_number = dest_card_id;#筛选

    if src_id != applicant_id or dst_id != receiver_id  or (src_type = "信用卡" and dst_type = "储蓄卡") or (src_type = "储蓄卡" and src_balance < amount) then#不合法情况
        set return_code = 0;
        leave pro;
    end if;
    if src_type = "信用卡" then
        set amount = -amount;
    end if;
    if dst_type = "信用卡" then
        set dst_amount = -dst_amount;
    end if;
    update bank_card set b_balance = b_balance - amount 
    where b_number = source_card_id;#更新原始余额
    update bank_card set b_balance = b_balance + dst_amount 
    where b_number = dest_card_id;#更新目的余额
    set return_code = 1;
END$$

delimiter ;
/*  end  of  your code  */ 