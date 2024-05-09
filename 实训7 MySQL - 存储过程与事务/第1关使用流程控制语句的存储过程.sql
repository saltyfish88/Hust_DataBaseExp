use fib;

-- 创建存储过程`sp_fibonacci(in m int)`，向表fibonacci插入斐波拉契数列的前m项，及其对应的斐波拉契数。fibonacci表初始值为一张空表。请保证你的存储过程可以多次运行而不出错。

drop procedure if exists sp_fibonacci;
delimiter $$
create procedure sp_fibonacci(in m int)
begin
    declare n1 int;
    declare n2 int;
    declare n3 int;
    declare i int;
    set i=0;
    set n1=0;
    set n2=1;
    while(i<m) do 
        if i=0 then insert into fibonacci(n,fibn) values(i,n1); end if;
        if i=1 then insert into fibonacci(n,fibn) values(i,n2); end if;
        if i>=2 then 
            set n3 = n1 + n2;
            set n1 = n2;
            set n2 = n3;
            insert into fibonacci(n,fibn) values(i,n3);
        end if;
        set i=i+1;
    end while;
end $$

delimiter ;