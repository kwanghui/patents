-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`localhost` FUNCTION `add_mainclass`(mid VARCHAR(20)) RETURNS varchar(20) CHARSET latin1
BEGIN
	INSERT INTO `mainclass`(`id`) VALUES(mid) ON DUPLICATE KEY UPDATE `id`=mid;
RETURN mid;
END