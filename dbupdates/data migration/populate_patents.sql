-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `populate_patent`()
BEGIN
	INSERT INTO `patent`(`id`, `type`, `title`,`num_claims`,`date`,`number`,`PATN_SRC`, `PATN_ART`, `PATN_ECL`, `PATN_EXP`, `PATN_PBL`, `PATN_EXA`, `PATN_NDR`, `PATN_NFG`, `PATN_DCD`, `PATN_NPS`, `PATN_TRM`, `PATN_CLMS_STM`, `PATN_ISSUE_YEAR`, `NUM_INVTS`,  `NUM_ASSGS`, `NUM_CITETO`, `NUM_CITEBY_19762000`, `NUM_OTHERREF`, `NUM_FWD1`, `NUM_FWD3`, `NUM_FWD5`, `NUM_BACK1`, `NUM_BACK3`, `NUM_BACK5`, `FORMAT_OCL`, `FORMAT_XCL`,  `FORMAT_ICL`) 
	SELECT `patn_wku`,`patn_apt`,`patn_ttl`,`patn_ncl`,`patn_isd`,`actual_patn_wku`,`PATN_SRC`, `PATN_ART`, `PATN_ECL`, `PATN_EXP`, `PATN_PBL`, `PATN_EXA`, `PATN_NDR`, `PATN_NFG`, `PATN_DCD`, `PATN_NPS`, `PATN_TRM`, `PATN_CLMS_STM`, `PATN_ISSUE_YEAR`, `NUM_INVTS`,  `NUM_ASSGS`, `NUM_CITETO`, `NUM_CITEBY_19762000`, `NUM_OTHERREF`, `NUM_FWD1`, `NUM_FWD3`, `NUM_FWD5`, `NUM_BACK1`, `NUM_BACK3`, `NUM_BACK5`, `FORMAT_OCL`, `FORMAT_XCL`,  `FORMAT_ICL` FROM `grantdb_1975_2004`.`tbl_patn`;

	INSERT INTO `application`(`uuid`, `application_id`, `patent_id`, `type`, `number`, `date`) 
	SELECT UUID(), YEAR(`patn_apd`) + '/' +`patn_apn`,`patn_wku`,`patn_apt`,`patn_apn`, `patn_apd` FROM `grantdb_1975_2004`.`tbl_patn`;

    INSERT INTO `patent_description`(`id`, `briefsummarydescription`) 
	SELECT `patn_wku`,`PATN_BSUM`  FROM `grantdb_1975_2004`.`tbl_patn`;

	INSERT INTO `rawinventor`(`uuid`, `patent_id`, `rawlocation_id`,`name_first`,`name_last`) 
	SELECT UUID(),`PATN_WKU`, add_location(`INVT_CTY`,`INVT_STA`,`INVT_CNT`),SUBSTRING_INDEX(SUBSTRING_INDEX(`INVT_NAM`, ';', 1), ' ', -1),
    TRIM( SUBSTR(`INVT_NAM`, LOCATE(';', `INVT_NAM`)) )  FROM `grantdb_1975_2004`.tbl_invt;

	INSERT INTO rawassignee(uuid, patent_id, rawlocation_id,name_first,name_last,type) 
	SELECT UUID(),PATN_WKU, add_location(ASSG_CTY,ASSG_STA,ASSG_CNT),SUBSTRING_INDEX(SUBSTRING_INDEX(ASSG_NAM, ';', 1), ' ', -1),
    TRIM( SUBSTR(ASSG_NAM, LOCATE(';', ASSG_NAM)) ),ASSG_COD  FROM `grantdb_1975_2004`.tbl_assg;

	INSERT INTO claim(uuid,patent_id,sequence,text) 
	SELECT UUID(),PATN_WKU,CLMS_NUM,clms_text FROM `grantdb_1975_2004`.tbl_clms;

	INSERT INTO rawlawyer(uuid, patent_id, LREP_FRM, LREP_FR2, LREP_AAT, LREP_AGT, LREP_ATT, LREP_REG, LREP_NAM, LREP_STR, LREP_CTY, LREP_STA, LREP_CNT, LREP_ZIP) 
	SELECT UUID(), patn_wku, LREP_FRM, LREP_FR2, LREP_AAT, LREP_AGT, LREP_ATT, LREP_REG, LREP_NAM, LREP_STR, LREP_CTY, LREP_STA, LREP_CNT, LREP_ZIP  FROM `grantdb_1975_2004`.tbl_lrep;

	INSERT INTO usapplicationcitation(uuid, patent_id, RLAP_COD, RLAP_APN, RLAP_PSC, RLAP_APD, RLAP_PNO, RLAP_ISD)
	SELECT UUID(), patn_wku, RLAP_COD, RLAP_APN, RLAP_PSC, RLAP_APD, RLAP_PNO, RLAP_ISD FROM `grantdb_1975_2004`.tbl_rlap;

	INSERT INTO pctinfo(uuid, patent_id, PCTA_PCN, PCTA_PD1, PCTA_PD2, PCTA_PD3, PCTA_PCP, PCTA_PCD)
	SELECT UUID(), patn_wku, PCTA_PCN, PCTA_PD1, PCTA_PD2, PCTA_PD3, PCTA_PCP, PCTA_PCD FROM `grantdb_1975_2004`.tbl_pcta;


	INSERT INTO foreignprioritydetails(uuid, patent_id, PRIR_CNT, PRIR_APD, PRIR_APN)
	SELECT UUID(), patn_wku, PRIR_CNT, PRIR_APD, PRIR_APN FROM `grantdb_1975_2004`.tbl_prir;

	INSERT INTO designclaims(uuid, patent_id, DCLM_TEXT)
	SELECT UUID(), patn_wku, DCLM_TEXT FROM `grantdb_1975_2004`.tbl_dclm;

	INSERT INTO otherreference(uuid, patent_id, OREF_TEXT, GOVT_TEXT, PARN_TEXT, DRWD_TEXT, DETD_TEXT)
	SELECT UUID(), patn_wku, OREF_TEXT, GOVT_TEXT, PARN_TEXT, DRWD_TEXT, DETD_TEXT FROM `grantdb_1975_2004`.tbl_others;

    INSERT INTO foreigncitation(uuid, patent_id, number, date, country, FREF_OCL, FREF_ICL)
	SELECT UUID(), patn_wku, FREF_PNO, FREF_ISD, FREF_CNT, FREF_OCL, FREF_ICL FROM `grantdb_1975_2004`.tbl_fref;

	INSERT INTO mainclass(`id`)
	SELECT DISTINCT CLAS_FSC FROM `grantdb_1975_2004`.tbl_clas_fs;

	INSERT INTO subclass(`id`)
	SELECT DISTINCT CLAS_FSS FROM `grantdb_1975_2004`.tbl_clas_fs;

	INSERT INTO uspc(uuid, patent_id, mainclass_id, subclass_id)
	SELECT UUID(), patn_wku, CLAS_FSC, CLAS_FSS FROM `grantdb_1975_2004`.tbl_clas_fs;

	INSERT INTO `mainuspatentclassification`(`uuid`, `patent_id`, `CLAS_OCL`,`CLAS_EDF`)
	SELECT UUID(), `patn_wku`, `CLAS_OCL`,`CLAS_EDF` FROM `grantdb_1975_2004`.`tbl_clas`;

	INSERT INTO `otheruspatentclassification`(`uuid`, `patent_id`, `CLAS_XCL`)
	SELECT UUID(), `patn_wku`, `CLAS_XCL` FROM `grantdb_1975_2004`.`tbl_clas_xcl`;

	INSERT INTO `unofficialreferences`(`uuid`, `patent_id`, `CLAS_UCL`)
	SELECT UUID(), `patn_wku`, `CLAS_UCL` FROM `grantdb_1975_2004`.`tbl_clas_ucl`;

	INSERT INTO `digestreferenes`(`uuid`, `patent_id`, `CLAS_DCL`)
	SELECT UUID(), `patn_wku`, `CLAS_DCL` FROM `grantdb_1975_2004`.`tbl_clas_dcl`;

	INSERT INTO `internationalpatentclassification`(`uuid`, `patent_id`, `CLAS_ICL`, `CLAS_EDF`)
	SELECT UUID(), `patn_wku`, `CLAS_ICL`, `CLAS_EDF` FROM `grantdb_1975_2004`.`tbl_clas_icl`;

	INSERT INTO `fieldofsearchclassification`(`uuid`, `patent_id`, `CLAS_FSC`, `CLAS_FSS`)
	SELECT UUID(), `patn_wku`, `CLAS_FSC`, `CLAS_FSS` FROM `grantdb_1975_2004`.`tbl_clas_fs`;

	INSERT INTO `currentusclassification`(`uuid`, `patent_id`, `CLAS_CCL`)
	SELECT UUID(), `patn_wku`, `CLAS_CCL` FROM `grantdb_1975_2004`.`tbl_ccl`;

	INSERT INTO `designclaims`(`uuid`, `patent_id`, `DCLM_TEXT`)
	SELECT UUID(), `patn_wku`, `DCLM_TEXT` FROM `grantdb_1975_2004`.`tbl_dclm`;

	INSERT INTO `foreignprioritydetails`(`uuid`, `patent_id`, `PRIR_CNT`, `PRIR_APD`, `PRIR_APN`)
	SELECT UUID(), `patn_wku`, `PRIR_CNT`, `PRIR_APD`, `PRIR_APN` FROM `grantdb_1975_2004`.`tbl_prir`;

	INSERT INTO `reissuedetails`(`uuid`, `patent_id`, `REIS_COD`, `REIS_APN`, `REIS_APD`, `REIS_PNO`, `REIS_ISD`)
	SELECT UUID(), `patn_wku`,`REIS_COD`, `REIS_APN`, `REIS_APD`, `REIS_PNO`, `REIS_ISD` FROM `grantdb_1975_2004`.`tbl_reis`;

	INSERT INTO `pctinfo`(`uuid`, `patent_id`, `PCTA_PCN`, `PCTA_PD1`, `PCTA_PD2`, `PCTA_PD3`, `PCTA_PCP`, `PCTA_PCD`)
	SELECT UUID(), `patn_wku`, `PCTA_PCN`, `PCTA_PD1`, `PCTA_PD2`, `PCTA_PD3`, `PCTA_PCP`, `PCTA_PCD` FROM `grantdb_1975_2004`.`tbl_pcta`;

END