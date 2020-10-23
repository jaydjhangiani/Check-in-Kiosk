CREATE OR REPLACE TRIGGER tr_listing_9W222
before insert  ON TESTORA.tb_pssngr_lst_9w222 for each row
begin
if( :new.pl9w222_accmmdtn_v = 'MAX_SUPER_SAVE') 
then
update tb_flght_admn_bom
set 
fabom_mx_spr_sv_n = fabom_mx_spr_sv_n - 1
where fabom_flght_nmbr_v = '9W222';
end if;

if( :new.pl9w222_accmmdtn_v = 'MAX_ECO_FLEC') 
then
update tb_flght_admn_bom
set 
fabom_mx_ec_flx_n = fabom_mx_ec_flx_n - 1
where fabom_flght_nmbr_v = '9W222';
end if;

if( :new.pl9w222_accmmdtn_v = 'MAX_CLUB') 
then
update tb_flght_admn_bom
set 
fabom_mx_clb_n = fabom_mx_clb_n - 1
where fabom_flght_nmbr_v = '9W222';
end if;

end;
/