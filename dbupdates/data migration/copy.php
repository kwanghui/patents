<?php
error_reporting(E_ALL & ~E_DEPRECATED);

function dbconnect(){
    $servername = "127.0.0.1";
    $dbname = "grantdb_1975_2004_updated";
    $username = "patadmin";
    $password = "6ntwv70FxH(hi}n";

    try {
        $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
        // set the PDO error mode to exception
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        echo "Connected successfully";
        echo "\n";
        return $conn;
    }
    catch(PDOException $e)
    {
        echo "Connection failed: " . $e->getMessage();
    }
}

function get_attempts($recs, $count)
{
    return ($recs - ($recs % $count) + $count)/$count;
    
}

function reccount($conn, $tablename)
{
    try {
        $countsql = "SELECT COUNT(*) FROM " . $tablename. ";"; 
        $stmt = $conn->query($countsql);
        $row = $stmt->fetch();
        return $row[0];
    }catch(PDOException $e)
    {
        echo "\n*** Count Error: *************************************************\n";
        echo $e->getMessage();
        echo "\n";
        echo $countsql;
        echo "\n";
        return 0;
    }
}

function addedcount($conn, $tablename)
{
    try {
        $countsql = "SELECT COUNT(*) FROM " . $tablename. ";"; 
        $stmt = $conn->query($countsql);
        $row = $stmt->fetch();
        return $row[0];
    }catch(PDOException $e)
    {
        echo "\n*** Count Error: *************************************************\n";
        echo $e->getMessage();
        echo "\n";
        echo $countsql;
        echo "\n";
        return 0;
    }
}

function runsql($conn, $sql)
{
    try {
        $conn->exec($sql);
    }catch(PDOException $e)
    {
        echo "\n*** Exec Error: *************************************************\n";
        echo $e->getMessage();
        echo "\n";
        echo $sql;
        echo "\n";
        return 0;
    }
}

function update($conn, $tablename, $targettablename, $sql, $count)
{
    $recs = reccount($conn, $tablename);
    $added = addedcount($conn, $targettablename);
    
    echo "\n Records - " . $recs; 
    $attempts = get_attempts($recs - $added, $count);
    for ($x = 0; $x < $attempts; $x++) {
        $start = $added + ($x * $count);
        $tmp = $sql . " LIMIT " . $start . "," .$count . ";";
        //echo "\n" . $tmp;
        runsql($conn, $tmp);
    }    
}

$conn = dbconnect();
$count = 100000;

echo "Table - patent \n";
$sql = "INSERT INTO `patent`(`id`, `type`, `title`,`num_claims`,`date`,`number`,`PATN_SRC`, `PATN_ART`, `PATN_ECL`, `PATN_EXP`, `PATN_PBL`, `PATN_EXA`, `PATN_NDR`, `PATN_NFG`, `PATN_DCD`, `PATN_NPS`, `PATN_TRM`, `PATN_CLMS_STM`, `PATN_ISSUE_YEAR`, `NUM_INVTS`,  `NUM_ASSGS`, `NUM_CITETO`, `NUM_CITEBY_19762000`, `NUM_OTHERREF`, `NUM_FWD1`, `NUM_FWD3`, `NUM_FWD5`, `NUM_BACK1`, `NUM_BACK3`, `NUM_BACK5`, `FORMAT_OCL`, `FORMAT_XCL`,  `FORMAT_ICL`) 
	SELECT `patn_wku`,`patn_apt`,`patn_ttl`,`patn_ncl`,`patn_isd`,`actual_patn_wku`,`PATN_SRC`, `PATN_ART`, `PATN_ECL`, `PATN_EXP`, `PATN_PBL`, `PATN_EXA`, `PATN_NDR`, `PATN_NFG`, `PATN_DCD`, `PATN_NPS`, `PATN_TRM`, `PATN_CLMS_STM`, `PATN_ISSUE_YEAR`, `NUM_INVTS`,  `NUM_ASSGS`, `NUM_CITETO`, `NUM_CITEBY_19762000`, `NUM_OTHERREF`, `NUM_FWD1`, `NUM_FWD3`, `NUM_FWD5`, `NUM_BACK1`, `NUM_BACK3`, `NUM_BACK5`, `FORMAT_OCL`, `FORMAT_XCL`,  `FORMAT_ICL` FROM `tbl_patn`";
update($conn, 'tbl_patn', 'patent', $sql, $count);
echo "Done - patent\n";  


echo "Table - application \n";
$sql = "INSERT INTO `application`(`uuid`, `application_id`, `patent_id`, `type`, `number`, `date`) 
	SELECT UUID(), YEAR(`patn_apd`) + '/' +`patn_apn`,`patn_wku`,`patn_apt`,`patn_apn`, `patn_apd` FROM `tbl_patn`";
update($conn, 'tbl_patn', 'application', $sql, $count);
echo "Done - application\n";       
    
echo "Table - patent_description\n";    
$sql = "INSERT INTO `patent_description`(`id`, `briefsummarydescription`) 
	SELECT `patn_wku`,`PATN_BSUM`  FROM `tbl_patn`";
update($conn, 'tbl_patn', 'patent_description', $sql, $count);     
echo "Done - patent_description\n";  

echo "Table - rawinventor\n";
$sql = "INSERT INTO `rawinventor`(`uuid`, `patent_id`, `rawlocation_id`,`name_first`,`name_last`) 
	SELECT UUID(),`PATN_WKU`, add_location(`INVT_CTY`,`INVT_STA`,`INVT_CNT`),SUBSTRING_INDEX(SUBSTRING_INDEX(`INVT_NAM`, ';', 1), ' ', -1),
    TRIM( SUBSTR(`INVT_NAM`, LOCATE(';', `INVT_NAM`)) )  FROM tbl_invt";
update($conn, 'tbl_invt', 'rawinventor', $sql, $count);   
echo "Done - rawinventor\n";  

echo "Table - rawassignee\n";
$sql = "INSERT INTO rawassignee(uuid, patent_id, rawlocation_id,name_first,name_last,type) 
	SELECT UUID(),PATN_WKU, add_location(ASSG_CTY,ASSG_STA,ASSG_CNT),SUBSTRING_INDEX(SUBSTRING_INDEX(ASSG_NAM, ';', 1), ' ', -1),
    TRIM( SUBSTR(ASSG_NAM, LOCATE(';', ASSG_NAM)) ),ASSG_COD  FROM tbl_assg";
update($conn, 'tbl_assg', 'rawassignee', $sql, $count);   
echo "Done - rawassignee\n";  

echo "Table - claim\n";
$sql = "INSERT INTO claim(uuid,patent_id,sequence,text) 
	SELECT UUID(),PATN_WKU,CLMS_NUM,clms_text FROM tbl_clms";
update($conn, 'tbl_clms', 'claim', $sql, $count);    
echo "Done - claim\n";  

echo "Table - rawlawyer\n";
$sql = "INSERT INTO rawlawyer(uuid, patent_id, LREP_FRM, LREP_FR2, LREP_AAT, LREP_AGT, LREP_ATT, LREP_REG, LREP_NAM, LREP_STR, LREP_CTY, LREP_STA, LREP_CNT, LREP_ZIP) 
	SELECT UUID(), patn_wku, LREP_FRM, LREP_FR2, LREP_AAT, LREP_AGT, LREP_ATT, LREP_REG, LREP_NAM, LREP_STR, LREP_CTY, LREP_STA, LREP_CNT, LREP_ZIP  FROM tbl_lrep";
update($conn, 'tbl_lrep', 'rawlawyer', $sql, $count);     
echo "Done - rawlawyer\n";  

echo "Table - usapplicationcitation\n";
$sql = "INSERT INTO usapplicationcitation(uuid, patent_id, RLAP_COD, RLAP_APN, RLAP_PSC, RLAP_APD, RLAP_PNO, RLAP_ISD)
	SELECT UUID(), patn_wku, RLAP_COD, RLAP_APN, RLAP_PSC, RLAP_APD, RLAP_PNO, RLAP_ISD FROM tbl_rlap";
update($conn, 'tbl_rlap', 'usapplicationcitation', $sql, $count);    
echo "Done - usapplicationcitation\n";  

echo "Table - pctinfo\n";
$sql = "INSERT INTO pctinfo(uuid, patent_id, PCTA_PCN, PCTA_PD1, PCTA_PD2, PCTA_PD3, PCTA_PCP, PCTA_PCD)
	SELECT UUID(), patn_wku, PCTA_PCN, PCTA_PD1, PCTA_PD2, PCTA_PD3, PCTA_PCP, PCTA_PCD FROM tbl_pcta";
update($conn, 'tbl_pcta', 'pctinfo', $sql, $count);   
echo "Done - pctinfo\n";  

echo "Table - foreignprioritydetails\n";
$sql = "INSERT INTO foreignprioritydetails(uuid, patent_id, PRIR_CNT, PRIR_APD, PRIR_APN)
	SELECT UUID(), patn_wku, PRIR_CNT, PRIR_APD, PRIR_APN FROM tbl_prir";
update($conn, 'tbl_prir', 'foreignprioritydetails', $sql, $count);    
echo "Done - foreignprioritydetails\n";  

echo "Table - designclaims\n";
$sql = "INSERT INTO designclaims(uuid, patent_id, DCLM_TEXT)
	SELECT UUID(), patn_wku, DCLM_TEXT FROM tbl_dclm";
update($conn, 'tbl_dclm', 'designclaims', $sql, $count);     
echo "Done - designclaims\n";  

echo "Table - otherreference\n";
$sql = "INSERT INTO otherreference(uuid, patent_id, OREF_TEXT, GOVT_TEXT, PARN_TEXT, DRWD_TEXT, DETD_TEXT)
	SELECT UUID(), patn_wku, OREF_TEXT, GOVT_TEXT, PARN_TEXT, DRWD_TEXT, DETD_TEXT FROM tbl_others";
update($conn, 'tbl_others', 'otherreference', $sql, $count);   
echo "Done - otherreference\n";  

echo "Table - foreigncitation\n";
$sql = "INSERT INTO foreigncitation(uuid, patent_id, number, date, country, FREF_OCL, FREF_ICL)
	SELECT UUID(), patn_wku, FREF_PNO, FREF_ISD, FREF_CNT, FREF_OCL, FREF_ICL FROM tbl_fref";
update($conn, 'tbl_fref', 'foreigncitation', $sql, $count);    
echo "Done - foreigncitation\n";  

echo "Table - mainclass\n";
$sql = "INSERT INTO mainclass(`id`)
	SELECT DISTINCT CLAS_FSC FROM tbl_clas_fs";
update($conn, 'tbl_clas_fs', 'mainclass', $sql, $count);     
echo "Done - mainclass\n";  

echo "Table - subclass\n";
$sql = "INSERT INTO subclass(`id`)
	SELECT DISTINCT CLAS_FSS FROM tbl_clas_fs";
update($conn, 'tbl_clas_fs', 'subclass', $sql, $count);   
echo "Done - subclass\n";  

echo "Table - uspc\n";
$sql = "INSERT INTO uspc(uuid, patent_id, mainclass_id, subclass_id)
	SELECT UUID(), patn_wku, CLAS_FSC, CLAS_FSS FROM tbl_clas_fs";
update($conn, 'tbl_clas_fs', 'uspc', $sql, $count);     
echo "Done - uspc\n";  

echo "Table - mainuspatentclassification\n";
$sql = "INSERT INTO `mainuspatentclassification`(`uuid`, `patent_id`, `CLAS_OCL`,`CLAS_EDF`)
	SELECT UUID(), `patn_wku`, `CLAS_OCL`,`CLAS_EDF` FROM `tbl_clas`";
update($conn, 'tbl_clas', 'mainuspatentclassification', $sql, $count);    
echo "Done - mainuspatentclassification\n";  

echo "Table - otheruspatentclassification\n";
$sql = "INSERT INTO `otheruspatentclassification`(`uuid`, `patent_id`, `CLAS_XCL`)
	SELECT UUID(), `patn_wku`, `CLAS_XCL` FROM `tbl_clas_xcl`";
update($conn, 'tbl_clas_xcl', 'otheruspatentclassification', $sql, $count);    
echo "Done - otheruspatentclassification\n";  

echo "Table - unofficialreferences\n";
$sql = "INSERT INTO `unofficialreferences`(`uuid`, `patent_id`, `CLAS_UCL`)
	SELECT UUID(), `patn_wku`, `CLAS_UCL` FROM `tbl_clas_ucl`";
update($conn, 'tbl_clas_ucl', 'unofficialreferences', $sql, $count);     
echo "Done - unofficialreferences\n";  

echo "Table - digestreferenes\n";
$sql = "INSERT INTO `digestreferenes`(`uuid`, `patent_id`, `CLAS_DCL`)
	SELECT UUID(), `patn_wku`, `CLAS_DCL` FROM `tbl_clas_dcl`";
update($conn, 'tbl_clas_dcl', 'digestreferenes', $sql, $count);    
echo "Done - digestreferenes\n";  

echo "Table - internationalpatentclassification\n";
$sql = "INSERT INTO `internationalpatentclassification`(`uuid`, `patent_id`, `CLAS_ICL`, `CLAS_EDF`)
	SELECT UUID(), `patn_wku`, `CLAS_ICL`, `CLAS_EDF` FROM `tbl_clas_icl`";
update($conn, 'tbl_clas_icl', 'internationalpatentclassification', $sql, $count);    
echo "Done - internationalpatentclassification\n";  

echo "Table - fieldofsearchclassification\n";
$sql = "INSERT INTO `fieldofsearchclassification`(`uuid`, `patent_id`, `CLAS_FSC`, `CLAS_FSS`)
	SELECT UUID(), `patn_wku`, `CLAS_FSC`, `CLAS_FSS` FROM `tbl_clas_fs`";
update($conn, 'tbl_clas_fs', 'fieldofsearchclassification', $sql, $count);    
echo "Done - fieldofsearchclassification\n";  

echo "Table - currentusclassification\n";
$sql = "INSERT INTO `currentusclassification`(`uuid`, `patent_id`, `CLAS_CCL`)
	SELECT UUID(), `patn_wku`, `CLAS_CCL` FROM `tbl_ccl`";
update($conn, 'tbl_ccl', 'currentusclassification', $sql, $count);    
echo "Done - currentusclassification\n";  

echo "Table - designclaims\n";
$sql = "INSERT INTO `designclaims`(`uuid`, `patent_id`, `DCLM_TEXT`)
	SELECT UUID(), `patn_wku`, `DCLM_TEXT` FROM `tbl_dclm`";
update($conn, 'tbl_dclm', 'designclaims', $sql, $count);  
echo "Done - designclaims\n";  

echo "Table - foreignprioritydetails\n";
$sql = "INSERT INTO `foreignprioritydetails`(`uuid`, `patent_id`, `PRIR_CNT`, `PRIR_APD`, `PRIR_APN`)
	SELECT UUID(), `patn_wku`, `PRIR_CNT`, `PRIR_APD`, `PRIR_APN` FROM `tbl_prir`";
update($conn, 'tbl_prir', 'foreignprioritydetails', $sql, $count);   
echo "Done - foreignprioritydetails\n";  

echo "Table - reissuedetails\n";
$sql = "INSERT INTO `reissuedetails`(`uuid`, `patent_id`, `REIS_COD`, `REIS_APN`, `REIS_APD`, `REIS_PNO`, `REIS_ISD`)
	SELECT UUID(), `patn_wku`,`REIS_COD`, `REIS_APN`, `REIS_APD`, `REIS_PNO`, `REIS_ISD` FROM `tbl_reis`";
update($conn, 'tbl_reis', 'reissuedetails', $sql, $count);   
echo "Done - reissuedetails\n";  

echo "Table - pctinfo\n";
$sql = "INSERT INTO `pctinfo`(`uuid`, `patent_id`, `PCTA_PCN`, `PCTA_PD1`, `PCTA_PD2`, `PCTA_PD3`, `PCTA_PCP`, `PCTA_PCD`)
	SELECT UUID(), `patn_wku`, `PCTA_PCN`, `PCTA_PD1`, `PCTA_PD2`, `PCTA_PD3`, `PCTA_PCP`, `PCTA_PCD` FROM `tbl_pcta`";
update($conn, 'tbl_pcta', 'pctinfo', $sql, $count);     
echo "Done - pctinfo\n";  

echo "Table - uspatentcitation\n";
$sql = "INSERT INTO `uspatentcitation`(`uuid`, `patent_id`, `citation_id`, `date`, `name`, `UREF_OCL`, `UREF_XCL`, `UREF_UCL`)
	SELECT UUID(), `patn_wku`, `UREF_PNO`, `UREF_ISD`, `UREF_NAM`, `UREF_OCL`, `UREF_XCL`, `UREF_UCL` FROM `tbl_uref`";
update($conn, 'tbl_uref', 'uspatentcitation', $sql, $count);     
echo "Done - uspatentcitation\n";  

$conn = null;
