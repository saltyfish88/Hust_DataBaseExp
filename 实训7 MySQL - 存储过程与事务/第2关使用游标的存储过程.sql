-- 编写一存储过程，自动安排某个连续期间的大夜班的值班表:
delimiter $$
create procedure sp_night_shift_arrange(in start_date date, in end_date date)
begin
    declare complete, type, `week` int default false;
    declare doctor, nurse1, nurse2, head char(30);
    declare cursor1 cursor for select e_name from employee where e_type = 3;
    declare cursor2 cursor for select e_type, e_name from employee where e_type < 3;
    declare continue handler for not found set complete = true;
    open cursor1;
    open cursor2;
    while start_date <= end_date do
        fetch cursor1 into nurse1;
        if complete then
            close cursor1;
            open cursor1;
            set complete = false;
            fetch cursor1 into nurse1;
        end if;
        fetch cursor1 into nurse2;

        if complete then
            close cursor1;
            open cursor1;
            set complete = false;
            fetch cursor1 into nurse2;
        end if;

        set `week` = weekday(start_date);
        if `week` = 0 and head is not null then
            set doctor = head;
            set head = null;
        else
            fetch cursor2 into type, doctor;
            if complete then
                close cursor2;
                open cursor2;
                set complete = false;
                fetch cursor2 into type, doctor;
            end if;

            if `week` > 4 and type = 1 then
                set head = doctor;
                fetch cursor2 into type, doctor;
                if complete then
                    close cursor2;
                    open cursor2;
                    set complete = false;
                    fetch cursor2 into type, doctor;
                end if;
            end if;
        end if;
        insert into night_shift_schedule values 
        (start_date, doctor, nurse1, nurse2);
        set start_date = date_add(start_date, interval 1 day);
    end while;

end$$

delimiter ;
/*  end  of  your code  */ 
