-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`localhost` FUNCTION `add_location`(city VARCHAR(128), state VARCHAR(20), country VARCHAR(10)) RETURNS varchar(256) CHARSET latin1
BEGIN
	DECLARE loc_id VARCHAR(256);
	set loc_id = UUID();
	INSERT INTO rawlocation(`id`, `city`, `state`, `country`) VALUES(loc_id, city, state, country);
RETURN loc_id;
END