-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`localhost` FUNCTION `add_subclass`(sid VARCHAR(20)) RETURNS varchar(20) CHARSET latin1
BEGIN
	INSERT INTO `subclass`(`id`) VALUES(sid) ON DUPLICATE KEY UPDATE `id`=sid;
RETURN sid;
END