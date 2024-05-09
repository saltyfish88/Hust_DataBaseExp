use finance1;
drop trigger if exists before_property_inserted;
-- 请在适当的地方补充代码，完成任务要求：
delimiter $$
CREATE TRIGGER before_property_inserted BEFORE INSERT ON property
FOR EACH ROW 
BEGIN
    IF (NEW.pro_type NOT IN (1,2,3)) THEN
    SET @msg = CONCAT('type ', NEW.pro_type, ' is illegal!');
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @msg;
  END IF;
 
  IF (NEW.pro_type = 1) AND (SELECT COUNT(*) FROM finances_product WHERE p_id = NEW.pro_pif_id) = 0 THEN
    SET @msg = CONCAT('finances product #', NEW.pro_pif_id, ' not found!');
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @msg;
  END IF;
 
  IF (NEW.pro_type = 2) AND (SELECT COUNT(*) FROM insurance WHERE i_id = NEW.pro_pif_id) = 0 THEN
    SET @msg = CONCAT('insurance #', NEW.pro_pif_id, ' not found!');
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @msg;
  END IF;
 
  IF (NEW.pro_type = 3) AND (SELECT COUNT(*) FROM fund WHERE f_id = NEW.pro_pif_id) = 0 THEN
    SET @msg = CONCAT('fund #', NEW.pro_pif_id, ' not found!');
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @msg;
  END IF;


END$$
 
delimiter ;

















