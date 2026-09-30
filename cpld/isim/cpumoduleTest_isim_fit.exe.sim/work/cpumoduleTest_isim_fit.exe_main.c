/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

#include "xsi.h"

struct XSI_INFO xsi_info;

char *STD_TEXTIO;
char *STD_STANDARD;
char *SIMPRIM_P_0947159679;
char *IEEE_P_2717149903;
char *IEEE_P_2592010699;
char *SIMPRIM_P_4208868169;
char *IEEE_P_1367372525;


int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    ieee_p_2592010699_init();
    std_textio_init();
    ieee_p_2717149903_init();
    simprim_p_0947159679_init();
    ieee_p_1367372525_init();
    simprim_p_4208868169_init();
    simprim_a_3702995043_2431929443_0433961640_init();
    simprim_a_1859873907_2082082460_init();
    simprim_a_1387470219_3879906181_0433961640_init();
    simprim_a_0860940424_1564065396_0433961640_init();
    simprim_a_4130118134_1564065396_0433961640_init();
    simprim_a_3395610110_2220797900_0433961640_init();
    simprim_a_1509725169_3980060181_0433961640_init();
    simprim_a_1301006634_2399446423_0433961640_init();
    simprim_a_3517292318_4100414846_0433961640_init();
    simprim_a_2249565008_2651207175_0433961640_init();
    simprim_a_2620028433_2341067045_0433961640_init();
    simprim_a_1707600525_2320216850_0433961640_init();
    simprim_a_0839644248_2567937755_0433961640_init();
    simprim_a_4051247876_2563634412_0433961640_init();
    simprim_a_1218176306_2369919950_0433961640_init();
    simprim_a_3975959323_1499938089_0433961640_init();
    simprim_a_2356516096_2592819893_0433961640_init();
    simprim_a_0371088888_2395393952_0433961640_init();
    simprim_a_0740764875_2605260930_0433961640_init();
    simprim_a_0611770434_2357228025_0433961640_init();
    simprim_a_2207905303_2250136819_0433961640_init();
    simprim_a_4181367278_3380326129_0433961640_init();
    work_a_3282816651_0632001823_init();
    work_a_3318198239_2372691052_init();


    xsi_register_tops("work_a_3318198239_2372691052");

    STD_TEXTIO = xsi_get_engine_memory("std_textio");
    STD_STANDARD = xsi_get_engine_memory("std_standard");
    SIMPRIM_P_0947159679 = xsi_get_engine_memory("simprim_p_0947159679");
    IEEE_P_2717149903 = xsi_get_engine_memory("ieee_p_2717149903");
    IEEE_P_2592010699 = xsi_get_engine_memory("ieee_p_2592010699");
    xsi_register_ieee_std_logic_1164(IEEE_P_2592010699);
    SIMPRIM_P_4208868169 = xsi_get_engine_memory("simprim_p_4208868169");
    IEEE_P_1367372525 = xsi_get_engine_memory("ieee_p_1367372525");

    return xsi_run_simulation(argc, argv);

}
