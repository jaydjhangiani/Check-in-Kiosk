create or replace procedure pr_upgrade_9W222(cust_p varchar2, choice varchar2) is 
cust_accomodation varchar2(20);
cust_category varchar2(20);
CL NUMBER;
S NUMBER;
F NUMBER;
f_name varchar2(20);
l_name varchar2(20);
c_id varchar2(20);
begin

select pl9w222_pss_fnm_v into f_name  from tb_pssngr_lst_9w222 WHERE pl9w222_pnr_v = cust_p;
select pl9w222_pss_lnm_v into l_name  from tb_pssngr_lst_9w222 WHERE pl9w222_pnr_v = cust_p;
select JP_ID_v into c_id from tb_jt_prvlg where jp_pss_lnm_v = l_name and jp_pss_fnm_v=f_name;
select pl9w222_accmmdtn_v into cust_accomodation  from tb_pssngr_lst_9w222 WHERE pl9w222_pnr_v = cust_p;
select pl9w222_ctgry_v into cust_category  from tb_pssngr_lst_9w222 WHERE pl9w222_pnr_v = cust_p;
select fabom_mx_clb_n into CL  from tb_flght_admn_bom  WHERE fabom_flght_nmbr_v='9W222';


if cust_category = 'PAID+JP'
then
    if cust_accomodation = 'fabom_mx_spr_sv_n'
    then
        if choice = 'C' 
        then
         raise_application_error(-20001,c_ID);
        REDEEM(C_id,'DOM','CLUB');
        update tb_flght_admn_bom
        set fabom_mx_ec_flx_n = fabom_mx_ec_flx_n +1
        where fabom_flght_nmbr_v = '9W222';
        update tb_flght_admn_bom
        set fabom_mx_clb_n = fabom_mx_clb_n -1
        where fabom_flght_nmbr_v = '9W222';
        update tb_pssngr_lst_9w222
        set pl9w222_stts_v = 'CHECKED IN // UPGRADED TO CLUB'
        WHERE pl9w222_pnr_v = cust_p;
       
        end IF;
       
        if choice = 'E' 
        then
        REDEEM(C_id,'DOM','ECO');
        update tb_flght_admn_bom
        set fabom_mx_spr_sv_n = fabom_mx_spr_sv_n  +1
        where fabom_flght_nmbr_v = '9W222';
        update tb_flght_admn_bom
        set fabom_mx_ec_flx_n = fabom_mx_ec_flx_n - 1
        where fabom_flght_nmbr_v = '9W222';
        update tb_pssngr_lst_9w222
        set pl9w222_stts_v = 'CHECKED IN // UPGRADED TO ECO_FLEX'
        WHERE pl9w222_pnr_v = cust_p;
        
        end IF;
        end if;
        
       if cust_accomodation = 'fabom_mx_ec_flx_n'  
       THEN
       CL:=CL-1;
      IF CL>=0  
       then
        update tb_flght_admn_bom
        set fabom_mx_ec_flx_n = fabom_mx_ec_flx_n + 1
        where fabom_flght_nmbr_v = '9W222';
        update tb_flght_admn_bom
        set fabom_mx_clb_n = fabom_mx_clb_n -1
        where fabom_flght_nmbr_v = '9W222';
         REDEEM(C_id,'DOM','CLUB');
        update tb_pssngr_lst_9w222       set pl9w222_stts_v = 'CHECKED IN // UPGRADED TO CLUB'
        WHERE pl9w222_pnr_v = cust_p;
        ELSE
        RAISE_APPLICATION_ERROR(-20006,'ALL SEATS OCCUPIED');
        end IF;
    end if;
    END IF;
    
       
if cust_category = 'PAID'
then
    if cust_accomodation = 'fabom_mx_spr_sv_n' 
    then
         update tb_flght_admn_bom
        set fabom_mx_spr_sv_n = fabom_mx_spr_sv_n  +1
        where fabom_flght_nmbr_v = '9W222';
        update tb_flght_admn_bom
        set fabom_mx_ec_flx_n = fabom_mx_ec_flx_n - 1
        where fabom_flght_nmbr_v = '9W222';
        update tb_pssngr_lst_9w222
        set pl9w222_stts_v = 'CHECKED IN // UPGRADED TO ECO_FLEX'
        WHERE pl9w222_pnr_v = cust_p;
        end IF;
        
 IF CUST_ACCOMODATION = 'fabom_mx_ec_flx_n'
 THEN 
 raise_application_error(-20009,'CANNOT BE UPGRADED');
 END IF;
 END IF;
 
 
IF cust_category = 'STAFF'  or cust_category = 'JP MILES'
THEN
raise_application_error(-20009,'CANNOT BE UPGRADED');
END IF;
END;
/