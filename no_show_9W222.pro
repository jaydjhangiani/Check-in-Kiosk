create or replace procedure no_show_9W222(cust_p varchar2) is
cust_acc varchar2(20);
begin
select pl9w222_accmmdtn_v into cust_acc  from tb_pssngr_lst_9w222 WHERE pl9w222_pnr_v = cust_p;

if cust_acc = 'MAX_SUPER_SAVE'
then
update tb_flght_admn_bom
set fabom_mx_spr_sv_n = fabom_mx_spr_sv_n +1
where fabom_flght_nmbr_v = '9W222';
update tb_pssngr_lst_9w222
set pl9w222_stts_v = 'NO SHOW//COUNTER CLOSES 45 MINS PRIOR'
WHERE pl9w222_pnr_v = cust_p;
end IF;

if cust_acc = 'MAX_ECO_FLEC'
then
update tb_flght_admn_bom
set fabom_mx_ec_flx_n = fabom_mx_ec_flx_n +1
where fabom_flght_nmbr_v = '9W222';
update tb_pssngr_lst_9w222
set pl9w222_stts_v = 'NO SHOW//COUNTER CLOSES 45 MINS PRIOR'
WHERE pl9w222_pnr_v = cust_p;
end IF;

if cust_acc = 'MAX_CLUB' 
then
update tb_flght_admn_bom
set fabom_mx_clb_n = fabom_mx_clb_n +1
where fabom_flght_nmbr_v = '9W222';
update tb_pssngr_lst_9w222
set pl9w222_stts_v = 'NO SHOW//COUNTER CLOSES 45 MINS PRIOR'
WHERE pl9w222_pnr_v = cust_p;
end IF;

END;
/
