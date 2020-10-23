create or replace procedure pr_check_in_9W222 (c_p varchar2) IS
cust_category varchar2(20);
CUST_fNAME varchar2(20);
cust_lname varchar2(20);
cust_points number;
cust_grade varchar2(20);
seats number;
begin
SELECT pl9w222_ctgry_v INTO cust_category FROM tb_pssngr_lst_9W222 WHERE pl9w222_pnr_v = c_p;
if cust_category = 'PAID' OR  cust_category = 'JP MILES'
then
update tb_pssngr_lst_9w222
set pl9w222_stts_v = 'CHECKED IN'
WHERE pl9w222_pnr_v = c_p;
END IF;

if cust_category = 'PAID+JP'
then 
SELECT pl9w222_pss_fnm_v INTO cust_fname FROM tb_pssngr_lst_9w222 WHERE pl9w222_pnr_v = c_p;
SELECT pl9w222_pss_lnm_v INTO cust_lname FROM tb_pssngr_lst_9w222 WHERE pl9w222_pnr_v = c_p;
SELECT jp_pss_pnts_n INTO cust_points FROM tb_jt_prvlg WHERE jp_pss_fnm_v = cust_fname and jp_pss_lnm_v = cust_lname;
SELECT jp_pss_grd_v INTO cust_grade FROM tb_jt_prvlg WHERE jp_pss_fnm_v = cust_fname and jp_pss_lnm_v = cust_lname;
    IF  cust_grade = 'PLATINUM' and cust_points > 5000
    then
    UPDATE tb_pssngr_lst_9w222
    SET pl9w222_stts_v = 'CHECKED IN/PLATINUM JP UPGRADE AVAILABLE' WHERE pl9w222_pnr_v = c_p;
    END IF;
    
    IF  cust_grade = 'GOLD' and cust_points > 8000
    then
    UPDATE tb_pssngr_lst_9w222
    SET pl9w222_stts_v = 'CHECKED IN/GOLD JP UPGRADE AVAILABLE' WHERE pl9w222_pnr_v = c_p;
    END IF;
    
   IF  cust_grade = 'BLUE' and cust_points > 5000
    then
    UPDATE tb_pssngr_lst_9w222
    SET pl9w222_stts_v = 'CHECKED IN/BLUE JP UPGRADE AVAILABLE' WHERE pl9w222_pnr_v = c_p;
    END IF;
  END IF;
IF cust_category = 'STAFF'
then
SELECT fabom_mx_spr_sv_n  INTO seats FROM tb_flght_admn_bom WHERE fabom_flght_nmbr_v='9W222';
if seats > 0
then
update tb_pssngr_lst_9w222
set pl9w222_stts_v= 'CHECKED IN'
WHERE pl9w222_pnr_v = c_p;
else
raise_application_error(-20003,'NO SEATS AVAILABLE//SUBJECT TO LOAD');
END IF;
end if;
  
END;
/