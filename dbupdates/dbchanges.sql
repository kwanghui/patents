ALTER TABLE `grantdb`.`otherreference` 
CHANGE COLUMN `text` `text` TEXT CHARACTER SET 'utf8mb4' NULL DEFAULT NULL ;

ALTER TABLE `grantdb`.`claim` 
CHANGE COLUMN `text` `text` TEXT CHARACTER SET 'utf8mb4' NULL DEFAULT NULL ;

ALTER TABLE `grantdb`.`patent` 
CHANGE COLUMN `abstract` `abstract` TEXT CHARACTER SET 'utf8mb4' NULL DEFAULT NULL ,
CHANGE COLUMN `title` `title` TEXT CHARACTER SET 'utf8mb4' NULL DEFAULT NULL ;

ALTER TABLE `grantdb`.`lawyer` 
CHANGE COLUMN `organization` `organization` VARCHAR(64) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL ;

ALTER TABLE `grantdb`.`rawlawyer` 
CHANGE COLUMN `organization` `organization` VARCHAR(64) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL ;

ALTER TABLE `grantdb`.`assignee` 
CHANGE COLUMN `organization` `organization` VARCHAR(256) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL ;

ALTER TABLE `grantdb`.`rawassignee` 
CHANGE COLUMN `organization` `organization` VARCHAR(256) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL ;

ALTER TABLE `grantdb`.`location` 
CHANGE COLUMN `city` `city` VARCHAR(128) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL ;

ALTER TABLE `grantdb`.`rawlocation` 
CHANGE COLUMN `city` `city` VARCHAR(128) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL ;


