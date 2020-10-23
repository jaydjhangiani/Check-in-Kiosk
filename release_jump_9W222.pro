/* Formatted on 6/12/2019 3:32:31 PM (QP5 v5.149.1003.31008) */
CREATE OR REPLACE PROCEDURE release_jump_9W222 (c_pnr      VARCHAR2,
                                                code       VARCHAR2,
                                                consent    VARCHAR2)
IS
   jump_available   NUMBER;
   cap_code         VARCHAR2 (20);
   cust_cat         VARCHAR2 (20);
BEGIN
   SELECT fabom_jmp_sts_lft_n
     INTO JUMP_AVAILABLE
     FROM tb_flght_admn_bom
    WHERE fabom_flght_nmbr_v = '9W222';

   SELECT fabom_cptn_id_v
     INTO cap_code
     FROM tb_flght_admn_bom
    WHERE fabom_flght_nmbr_v = '9W222';

   SELECT pl9w222_ctgry_v
     INTO cust_cat
     FROM tb_pssngr_lst_9w222
    WHERE pl9w222_pnr_v = c_pnr;

   IF cap_code = code
   THEN
      IF cust_cat = 'STAFF'
      THEN
         IF consent = 'YES'
         THEN
           
            IF JUMP_AVAILABLE > 0
            THEN

                                       
               UPDATE tb_pssngr_lst_9w222
               SET  pl9w222_accmmdtn_v = 'JUMP ALLOTED'
               WHERE pl9w222_pnr_v = c_pnr;
               UPDATE tb_flght_admn_bom  SET fabom_jmp_sts_lft_n = jump_available - 1  
               WHERE fabom_flght_nmbr_v = '9W222';

            ELSE
               raise_application_error (-20001, 'NO SEATS LEFT !!!');
            END IF;
         ELSE
            raise_application_error (-20002, 'PERMISSION DECLINED !!!');
         END IF;
      ELSE
         raise_application_error (-20003, 'OUT OF BOUNDS !!!');
      END IF;
   ELSE
      raise_application_error ( -20003,'PLS ENTER CORRECT CODE // CHANGE OF CAPTAIN  !!!');
   END IF;
   
           
END;
/
