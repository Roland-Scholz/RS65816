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

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/github/RS65816/RS65816/cpumodule.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_3620187407;

unsigned char ieee_p_2592010699_sub_1258338084_503743352(char *, char *, unsigned int , unsigned int );
unsigned char ieee_p_3620187407_sub_2546418145_3965413181(char *, char *, char *, int );
unsigned char ieee_p_3620187407_sub_3890342512_3965413181(char *, char *, char *, int );
char *ieee_p_3620187407_sub_436279890_3965413181(char *, char *, char *, char *, int );
char *ieee_p_3620187407_sub_436351764_3965413181(char *, char *, char *, char *, int );


static void work_a_3282816651_3212880686_p_0(char *t0)
{
    char t3[16];
    char t34[16];
    char t44[16];
    char t45[16];
    char *t1;
    unsigned char t2;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    unsigned char t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    int t16;
    int t17;
    int t18;
    int t19;
    char *t20;
    int t21;
    char *t22;
    char *t23;
    int t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    unsigned char t32;
    unsigned char t33;
    unsigned char t35;
    unsigned char t36;
    unsigned char t37;
    unsigned char t38;
    unsigned char t39;
    unsigned char t40;
    unsigned char t41;
    unsigned char t42;
    char *t43;
    char *t46;
    char *t47;
    unsigned char t48;
    unsigned char t49;
    unsigned char t50;
    char *t51;
    char *t52;
    unsigned char t53;
    char *t54;
    char *t55;
    unsigned char t56;
    unsigned char t57;
    char *t58;
    unsigned char t59;
    unsigned char t60;
    char *t61;
    char *t62;
    char *t63;
    char *t64;
    int t65;
    int t66;

LAB0:    xsi_set_current_line(91, ng0);
    t1 = (t0 + 992U);
    t2 = ieee_p_2592010699_sub_1258338084_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 6952);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(93, ng0);
    t4 = (t0 + 4872U);
    t5 = *((char **)t4);
    t4 = (t0 + 11196U);
    t6 = ieee_p_3620187407_sub_436279890_3965413181(IEEE_P_3620187407, t3, t5, t4, 1);
    t7 = (t3 + 12U);
    t8 = *((unsigned int *)t7);
    t9 = (1U * t8);
    t10 = (3U != t9);
    if (t10 == 1)
        goto LAB5;

LAB6:    t11 = (t0 + 7032);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t6, 3U);
    xsi_driver_first_trans_fast(t11);
    xsi_set_current_line(95, ng0);
    t1 = (t0 + 4872U);
    t4 = *((char **)t1);
    t1 = (t0 + 11309);
    t16 = xsi_mem_cmp(t1, t4, 3U);
    if (t16 == 1)
        goto LAB8;

LAB15:    t6 = (t0 + 11312);
    t17 = xsi_mem_cmp(t6, t4, 3U);
    if (t17 == 1)
        goto LAB9;

LAB16:    t11 = (t0 + 11315);
    t18 = xsi_mem_cmp(t11, t4, 3U);
    if (t18 == 1)
        goto LAB10;

LAB17:    t13 = (t0 + 11318);
    t19 = xsi_mem_cmp(t13, t4, 3U);
    if (t19 == 1)
        goto LAB11;

LAB18:    t15 = (t0 + 11321);
    t21 = xsi_mem_cmp(t15, t4, 3U);
    if (t21 == 1)
        goto LAB12;

LAB19:    t22 = (t0 + 11324);
    t24 = xsi_mem_cmp(t22, t4, 3U);
    if (t24 == 1)
        goto LAB13;

LAB20:
LAB14:
LAB7:    goto LAB3;

LAB5:    xsi_size_not_matching(3U, t9, 0);
    goto LAB6;

LAB8:    xsi_set_current_line(97, ng0);
    t25 = (t0 + 5032U);
    t26 = *((char **)t25);
    t25 = (t0 + 11212U);
    t2 = ieee_p_3620187407_sub_2546418145_3965413181(IEEE_P_3620187407, t26, t25, 0);
    if (t2 != 0)
        goto LAB22;

LAB24:    xsi_set_current_line(100, ng0);
    t1 = (t0 + 7096);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);

LAB23:    goto LAB7;

LAB9:    xsi_set_current_line(104, ng0);
    t1 = (t0 + 1192U);
    t4 = *((char **)t1);
    t1 = (t0 + 11132U);
    t5 = (t0 + 11327);
    t7 = (t3 + 0U);
    t11 = (t7 + 0U);
    *((int *)t11) = 0;
    t11 = (t7 + 4U);
    *((int *)t11) = 7;
    t11 = (t7 + 8U);
    *((int *)t11) = 1;
    t16 = (7 - 0);
    t8 = (t16 * 1);
    t8 = (t8 + 1);
    t11 = (t7 + 12U);
    *((unsigned int *)t11) = t8;
    t33 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t4, t1, t5, t3);
    if (t33 == 1)
        goto LAB34;

LAB35:    t32 = (unsigned char)0;

LAB36:    if (t32 == 1)
        goto LAB31;

LAB32:    t10 = (unsigned char)0;

LAB33:    if (t10 == 1)
        goto LAB28;

LAB29:    t2 = (unsigned char)0;

LAB30:    if (t2 != 0)
        goto LAB25;

LAB27:    t1 = (t0 + 1192U);
    t4 = *((char **)t1);
    t1 = (t0 + 11132U);
    t5 = (t0 + 11338);
    t7 = (t3 + 0U);
    t11 = (t7 + 0U);
    *((int *)t11) = 0;
    t11 = (t7 + 4U);
    *((int *)t11) = 7;
    t11 = (t7 + 8U);
    *((int *)t11) = 1;
    t16 = (7 - 0);
    t8 = (t16 * 1);
    t8 = (t8 + 1);
    t11 = (t7 + 12U);
    *((unsigned int *)t11) = t8;
    t35 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t4, t1, t5, t3);
    if (t35 == 1)
        goto LAB51;

LAB52:    t33 = (unsigned char)0;

LAB53:    if (t33 == 1)
        goto LAB48;

LAB49:    t32 = (unsigned char)0;

LAB50:    if (t32 == 1)
        goto LAB45;

LAB46:    t10 = (unsigned char)0;

LAB47:    if (t10 == 1)
        goto LAB42;

LAB43:    t2 = (unsigned char)0;

LAB44:    if (t2 != 0)
        goto LAB40;

LAB41:
LAB26:    xsi_set_current_line(110, ng0);
    t1 = (t0 + 1192U);
    t4 = *((char **)t1);
    t1 = (t0 + 11132U);
    t5 = (t0 + 11352);
    t7 = (t3 + 0U);
    t11 = (t7 + 0U);
    *((int *)t11) = 0;
    t11 = (t7 + 4U);
    *((int *)t11) = 7;
    t11 = (t7 + 8U);
    *((int *)t11) = 1;
    t16 = (7 - 0);
    t8 = (t16 * 1);
    t8 = (t8 + 1);
    t11 = (t7 + 12U);
    *((unsigned int *)t11) = t8;
    t35 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t4, t1, t5, t3);
    if (t35 == 1)
        goto LAB66;

LAB67:    t33 = (unsigned char)0;

LAB68:    if (t33 == 1)
        goto LAB63;

LAB64:    t32 = (unsigned char)0;

LAB65:    if (t32 == 1)
        goto LAB60;

LAB61:    t20 = (t0 + 1192U);
    t23 = *((char **)t20);
    t20 = (t0 + 11132U);
    t25 = (t0 + 11363);
    t27 = (t44 + 0U);
    t28 = (t27 + 0U);
    *((int *)t28) = 0;
    t28 = (t27 + 4U);
    *((int *)t28) = 7;
    t28 = (t27 + 8U);
    *((int *)t28) = 1;
    t18 = (7 - 0);
    t8 = (t18 * 1);
    t8 = (t8 + 1);
    t28 = (t27 + 12U);
    *((unsigned int *)t28) = t8;
    t40 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t23, t20, t25, t44);
    if (t40 == 1)
        goto LAB69;

LAB70:    t39 = (unsigned char)0;

LAB71:    t10 = t39;

LAB62:    t42 = (!(t10));
    if (t42 == 1)
        goto LAB57;

LAB58:    t46 = (t0 + 5032U);
    t47 = *((char **)t46);
    t46 = (t0 + 11212U);
    t48 = ieee_p_3620187407_sub_2546418145_3965413181(IEEE_P_3620187407, t47, t46, 0);
    t2 = t48;

LAB59:    if (t2 != 0)
        goto LAB54;

LAB56:
LAB55:    goto LAB7;

LAB10:    xsi_set_current_line(117, ng0);
    t1 = (t0 + 7352);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(118, ng0);
    t1 = (t0 + 7416);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(120, ng0);
    t1 = (t0 + 7096);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB7;

LAB11:    xsi_set_current_line(123, ng0);
    t1 = (t0 + 5032U);
    t4 = *((char **)t1);
    t1 = (t0 + 11212U);
    t33 = ieee_p_3620187407_sub_3890342512_3965413181(IEEE_P_3620187407, t4, t1, 0);
    if (t33 == 1)
        goto LAB90;

LAB91:    t32 = (unsigned char)0;

LAB92:    if (t32 == 1)
        goto LAB87;

LAB88:    t10 = (unsigned char)0;

LAB89:    if (t10 == 1)
        goto LAB84;

LAB85:    t2 = (unsigned char)0;

LAB86:    if (t2 != 0)
        goto LAB81;

LAB83:
LAB82:    goto LAB7;

LAB12:    xsi_set_current_line(134, ng0);
    t1 = (t0 + 7288);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB7;

LAB13:    xsi_set_current_line(137, ng0);
    t1 = (t0 + 7096);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(138, ng0);
    t1 = (t0 + 7480);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(139, ng0);
    t1 = (t0 + 7544);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(140, ng0);
    t1 = (t0 + 7608);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(142, ng0);
    t1 = (t0 + 11382);
    t5 = (t0 + 7032);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t11 = (t7 + 56U);
    t12 = *((char **)t11);
    memcpy(t12, t1, 3U);
    xsi_driver_first_trans_fast(t5);
    xsi_set_current_line(144, ng0);
    t1 = (t0 + 5192U);
    t4 = *((char **)t1);
    t1 = (t0 + 11228U);
    t32 = ieee_p_3620187407_sub_2546418145_3965413181(IEEE_P_3620187407, t4, t1, 0);
    if (t32 == 1)
        goto LAB113;

LAB114:    t5 = (t0 + 5192U);
    t6 = *((char **)t5);
    t5 = (t0 + 11228U);
    t33 = ieee_p_3620187407_sub_2546418145_3965413181(IEEE_P_3620187407, t6, t5, 5);
    t10 = t33;

LAB115:    if (t10 == 1)
        goto LAB110;

LAB111:    t7 = (t0 + 4392U);
    t11 = *((char **)t7);
    t37 = *((unsigned char *)t11);
    t38 = (t37 == (unsigned char)3);
    if (t38 == 1)
        goto LAB119;

LAB120:    t36 = (unsigned char)0;

LAB121:    if (t36 == 1)
        goto LAB116;

LAB117:    t35 = (unsigned char)0;

LAB118:    t2 = t35;

LAB112:    if (t2 != 0)
        goto LAB107;

LAB109:
LAB108:    xsi_set_current_line(149, ng0);
    t1 = (t0 + 5032U);
    t4 = *((char **)t1);
    t1 = (t0 + 11212U);
    t2 = ieee_p_3620187407_sub_2546418145_3965413181(IEEE_P_3620187407, t4, t1, 0);
    if (t2 != 0)
        goto LAB122;

LAB124:    xsi_set_current_line(157, ng0);
    t1 = (t0 + 5032U);
    t4 = *((char **)t1);
    t1 = (t0 + 11212U);
    t5 = ieee_p_3620187407_sub_436351764_3965413181(IEEE_P_3620187407, t3, t4, t1, 1);
    t6 = (t3 + 12U);
    t8 = *((unsigned int *)t6);
    t9 = (1U * t8);
    t2 = (8U != t9);
    if (t2 == 1)
        goto LAB131;

LAB132:    t7 = (t0 + 7672);
    t11 = (t7 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    memcpy(t14, t5, 8U);
    xsi_driver_first_trans_fast(t7);

LAB123:    xsi_set_current_line(160, ng0);
    t1 = (t0 + 5192U);
    t4 = *((char **)t1);
    t1 = (t0 + 11228U);
    t2 = ieee_p_3620187407_sub_3890342512_3965413181(IEEE_P_3620187407, t4, t1, 0);
    if (t2 != 0)
        goto LAB133;

LAB135:
LAB134:    xsi_set_current_line(191, ng0);
    t1 = (t0 + 7160);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB7;

LAB21:;
LAB22:    xsi_set_current_line(98, ng0);
    t27 = (t0 + 7096);
    t28 = (t27 + 56U);
    t29 = *((char **)t28);
    t30 = (t29 + 56U);
    t31 = *((char **)t30);
    *((unsigned char *)t31) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t27);
    goto LAB23;

LAB25:    xsi_set_current_line(105, ng0);
    t20 = (t0 + 7160);
    t26 = (t20 + 56U);
    t27 = *((char **)t26);
    t28 = (t27 + 56U);
    t29 = *((char **)t28);
    *((unsigned char *)t29) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t20);
    goto LAB26;

LAB28:    t20 = (t0 + 1832U);
    t23 = *((char **)t20);
    t39 = *((unsigned char *)t23);
    t40 = (t39 == (unsigned char)3);
    if (t40 == 1)
        goto LAB37;

LAB38:    t20 = (t0 + 1992U);
    t25 = *((char **)t20);
    t41 = *((unsigned char *)t25);
    t42 = (t41 == (unsigned char)3);
    t38 = t42;

LAB39:    t2 = t38;
    goto LAB30;

LAB31:    t20 = (t0 + 2152U);
    t22 = *((char **)t20);
    t36 = *((unsigned char *)t22);
    t37 = (t36 == (unsigned char)3);
    t10 = t37;
    goto LAB33;

LAB34:    t11 = (t0 + 1352U);
    t12 = *((char **)t11);
    t11 = (t0 + 11148U);
    t13 = (t0 + 11335);
    t15 = (t34 + 0U);
    t20 = (t15 + 0U);
    *((int *)t20) = 0;
    t20 = (t15 + 4U);
    *((int *)t20) = 2;
    t20 = (t15 + 8U);
    *((int *)t20) = 1;
    t17 = (2 - 0);
    t8 = (t17 * 1);
    t8 = (t8 + 1);
    t20 = (t15 + 12U);
    *((unsigned int *)t20) = t8;
    t35 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t12, t11, t13, t34);
    t32 = t35;
    goto LAB36;

LAB37:    t38 = (unsigned char)1;
    goto LAB39;

LAB40:    xsi_set_current_line(107, ng0);
    t23 = (t0 + 11349);
    t28 = (t0 + 7224);
    t29 = (t28 + 56U);
    t30 = *((char **)t29);
    t31 = (t30 + 56U);
    t43 = *((char **)t31);
    memcpy(t43, t23, 3U);
    xsi_driver_first_trans_fast(t28);
    goto LAB26;

LAB42:    t23 = (t0 + 1992U);
    t26 = *((char **)t23);
    t40 = *((unsigned char *)t26);
    t41 = (t40 == (unsigned char)2);
    t2 = t41;
    goto LAB44;

LAB45:    t23 = (t0 + 1832U);
    t25 = *((char **)t23);
    t38 = *((unsigned char *)t25);
    t39 = (t38 == (unsigned char)3);
    t10 = t39;
    goto LAB47;

LAB48:    t20 = (t0 + 5192U);
    t22 = *((char **)t20);
    t20 = (t0 + 11228U);
    t37 = ieee_p_3620187407_sub_2546418145_3965413181(IEEE_P_3620187407, t22, t20, 0);
    t32 = t37;
    goto LAB50;

LAB51:    t11 = (t0 + 1352U);
    t12 = *((char **)t11);
    t11 = (t0 + 11148U);
    t13 = (t0 + 11346);
    t15 = (t34 + 0U);
    t20 = (t15 + 0U);
    *((int *)t20) = 0;
    t20 = (t15 + 4U);
    *((int *)t20) = 2;
    t20 = (t15 + 8U);
    *((int *)t20) = 1;
    t17 = (2 - 0);
    t8 = (t17 * 1);
    t8 = (t8 + 1);
    t20 = (t15 + 12U);
    *((unsigned int *)t20) = t8;
    t36 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t12, t11, t13, t34);
    t33 = t36;
    goto LAB53;

LAB54:    xsi_set_current_line(111, ng0);
    t51 = (t0 + 5032U);
    t52 = *((char **)t51);
    t51 = (t0 + 11212U);
    t53 = ieee_p_3620187407_sub_2546418145_3965413181(IEEE_P_3620187407, t52, t51, 0);
    if (t53 == 1)
        goto LAB78;

LAB79:    t54 = (t0 + 1832U);
    t55 = *((char **)t54);
    t56 = *((unsigned char *)t55);
    t57 = (t56 == (unsigned char)3);
    t50 = t57;

LAB80:    if (t50 == 1)
        goto LAB75;

LAB76:    t54 = (t0 + 1992U);
    t58 = *((char **)t54);
    t59 = *((unsigned char *)t58);
    t60 = (t59 == (unsigned char)3);
    t49 = t60;

LAB77:    if (t49 != 0)
        goto LAB72;

LAB74:
LAB73:    goto LAB55;

LAB57:    t2 = (unsigned char)1;
    goto LAB59;

LAB60:    t10 = (unsigned char)1;
    goto LAB62;

LAB63:    t20 = (t0 + 2152U);
    t22 = *((char **)t20);
    t37 = *((unsigned char *)t22);
    t38 = (t37 == (unsigned char)3);
    t32 = t38;
    goto LAB65;

LAB66:    t11 = (t0 + 1352U);
    t12 = *((char **)t11);
    t11 = (t0 + 11148U);
    t13 = (t0 + 11360);
    t15 = (t34 + 0U);
    t20 = (t15 + 0U);
    *((int *)t20) = 0;
    t20 = (t15 + 4U);
    *((int *)t20) = 2;
    t20 = (t15 + 8U);
    *((int *)t20) = 1;
    t17 = (2 - 0);
    t8 = (t17 * 1);
    t8 = (t8 + 1);
    t20 = (t15 + 12U);
    *((unsigned int *)t20) = t8;
    t36 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t12, t11, t13, t34);
    t33 = t36;
    goto LAB68;

LAB69:    t28 = (t0 + 1352U);
    t29 = *((char **)t28);
    t28 = (t0 + 11148U);
    t30 = (t0 + 11371);
    t43 = (t45 + 0U);
    t46 = (t43 + 0U);
    *((int *)t46) = 0;
    t46 = (t43 + 4U);
    *((int *)t46) = 2;
    t46 = (t43 + 8U);
    *((int *)t46) = 1;
    t19 = (2 - 0);
    t8 = (t19 * 1);
    t8 = (t8 + 1);
    t46 = (t43 + 12U);
    *((unsigned int *)t46) = t8;
    t41 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t29, t28, t30, t45);
    t39 = t41;
    goto LAB71;

LAB72:    xsi_set_current_line(112, ng0);
    t54 = (t0 + 7288);
    t61 = (t54 + 56U);
    t62 = *((char **)t61);
    t63 = (t62 + 56U);
    t64 = *((char **)t63);
    *((unsigned char *)t64) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t54);
    goto LAB73;

LAB75:    t49 = (unsigned char)1;
    goto LAB77;

LAB78:    t50 = (unsigned char)1;
    goto LAB80;

LAB81:    xsi_set_current_line(124, ng0);
    t11 = (t0 + 1512U);
    t14 = *((char **)t11);
    t11 = (t0 + 11374);
    t16 = xsi_mem_cmp(t11, t14, 2U);
    if (t16 == 1)
        goto LAB97;

LAB102:    t20 = (t0 + 11376);
    t17 = xsi_mem_cmp(t20, t14, 2U);
    if (t17 == 1)
        goto LAB98;

LAB103:    t23 = (t0 + 11378);
    t18 = xsi_mem_cmp(t23, t14, 2U);
    if (t18 == 1)
        goto LAB99;

LAB104:    t26 = (t0 + 11380);
    t19 = xsi_mem_cmp(t26, t14, 2U);
    if (t19 == 1)
        goto LAB100;

LAB105:
LAB101:
LAB96:    goto LAB82;

LAB84:    t11 = (t0 + 1832U);
    t12 = *((char **)t11);
    t39 = *((unsigned char *)t12);
    t40 = (t39 == (unsigned char)3);
    if (t40 == 1)
        goto LAB93;

LAB94:    t11 = (t0 + 1992U);
    t13 = *((char **)t11);
    t41 = *((unsigned char *)t13);
    t42 = (t41 == (unsigned char)3);
    t38 = t42;

LAB95:    t2 = t38;
    goto LAB86;

LAB87:    t5 = (t0 + 5192U);
    t7 = *((char **)t5);
    t5 = (t0 + 11228U);
    t37 = ieee_p_3620187407_sub_2546418145_3965413181(IEEE_P_3620187407, t7, t5, 0);
    t10 = t37;
    goto LAB89;

LAB90:    t5 = (t0 + 4392U);
    t6 = *((char **)t5);
    t35 = *((unsigned char *)t6);
    t36 = (t35 == (unsigned char)3);
    t32 = t36;
    goto LAB92;

LAB93:    t38 = (unsigned char)1;
    goto LAB95;

LAB97:    xsi_set_current_line(125, ng0);
    t28 = (t0 + 7096);
    t29 = (t28 + 56U);
    t30 = *((char **)t29);
    t31 = (t30 + 56U);
    t43 = *((char **)t31);
    *((unsigned char *)t43) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t28);
    goto LAB96;

LAB98:    xsi_set_current_line(126, ng0);
    t1 = (t0 + 7480);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB96;

LAB99:    xsi_set_current_line(127, ng0);
    t1 = (t0 + 7544);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB96;

LAB100:    xsi_set_current_line(128, ng0);
    t1 = (t0 + 7608);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB96;

LAB106:;
LAB107:    xsi_set_current_line(145, ng0);
    t15 = (t0 + 7352);
    t20 = (t15 + 56U);
    t22 = *((char **)t20);
    t23 = (t22 + 56U);
    t25 = *((char **)t23);
    *((unsigned char *)t25) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t15);
    xsi_set_current_line(146, ng0);
    t1 = (t0 + 7416);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB108;

LAB110:    t2 = (unsigned char)1;
    goto LAB112;

LAB113:    t10 = (unsigned char)1;
    goto LAB115;

LAB116:    t13 = (t0 + 5192U);
    t14 = *((char **)t13);
    t13 = (t0 + 11228U);
    t40 = ieee_p_3620187407_sub_2546418145_3965413181(IEEE_P_3620187407, t14, t13, 0);
    t35 = t40;
    goto LAB118;

LAB119:    t7 = (t0 + 5032U);
    t12 = *((char **)t7);
    t7 = (t0 + 11212U);
    t39 = ieee_p_3620187407_sub_3890342512_3965413181(IEEE_P_3620187407, t12, t7, 0);
    t36 = t39;
    goto LAB121;

LAB122:    xsi_set_current_line(150, ng0);
    t5 = (t0 + 5648U);
    t6 = *((char **)t5);
    t5 = (t0 + 7672);
    t7 = (t5 + 56U);
    t11 = *((char **)t7);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    memcpy(t13, t6, 8U);
    xsi_driver_first_trans_fast(t5);
    xsi_set_current_line(152, ng0);
    t1 = (t0 + 4392U);
    t4 = *((char **)t1);
    t10 = *((unsigned char *)t4);
    t32 = (t10 == (unsigned char)3);
    if (t32 == 1)
        goto LAB128;

LAB129:    t2 = (unsigned char)0;

LAB130:    if (t2 != 0)
        goto LAB125;

LAB127:
LAB126:    goto LAB123;

LAB125:    xsi_set_current_line(153, ng0);
    t6 = (t0 + 7352);
    t7 = (t6 + 56U);
    t11 = *((char **)t7);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    *((unsigned char *)t13) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t6);
    xsi_set_current_line(154, ng0);
    t1 = (t0 + 7416);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB126;

LAB128:    t1 = (t0 + 5192U);
    t5 = *((char **)t1);
    t1 = (t0 + 11228U);
    t33 = ieee_p_3620187407_sub_2546418145_3965413181(IEEE_P_3620187407, t5, t1, 0);
    t2 = t33;
    goto LAB130;

LAB131:    xsi_size_not_matching(8U, t9, 0);
    goto LAB132;

LAB133:    xsi_set_current_line(162, ng0);
    t5 = (t0 + 5192U);
    t6 = *((char **)t5);
    t5 = (t0 + 11228U);
    t7 = ieee_p_3620187407_sub_436279890_3965413181(IEEE_P_3620187407, t3, t6, t5, 1);
    t11 = (t3 + 12U);
    t8 = *((unsigned int *)t11);
    t9 = (1U * t8);
    t10 = (3U != t9);
    if (t10 == 1)
        goto LAB136;

LAB137:    t12 = (t0 + 7224);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    t15 = (t14 + 56U);
    t20 = *((char **)t15);
    memcpy(t20, t7, 3U);
    xsi_driver_first_trans_fast(t12);
    xsi_set_current_line(164, ng0);
    t1 = (t0 + 5192U);
    t4 = *((char **)t1);
    t1 = (t0 + 11228U);
    t2 = ieee_p_3620187407_sub_2546418145_3965413181(IEEE_P_3620187407, t4, t1, 1);
    if (t2 != 0)
        goto LAB138;

LAB140:
LAB139:    xsi_set_current_line(178, ng0);
    t1 = (t0 + 5192U);
    t4 = *((char **)t1);
    t1 = (t0 + 11228U);
    t2 = ieee_p_3620187407_sub_2546418145_3965413181(IEEE_P_3620187407, t4, t1, 5);
    if (t2 != 0)
        goto LAB160;

LAB162:
LAB161:    goto LAB134;

LAB136:    xsi_size_not_matching(3U, t9, 0);
    goto LAB137;

LAB138:    xsi_set_current_line(165, ng0);
    t5 = (t0 + 1512U);
    t6 = *((char **)t5);
    t5 = (t0 + 1672U);
    t7 = *((char **)t5);
    t10 = *((unsigned char *)t7);
    t11 = ((IEEE_P_2592010699) + 4024);
    t12 = (t0 + 11164U);
    t5 = xsi_base_array_concat(t5, t3, t11, (char)97, t6, t12, (char)99, t10, (char)101);
    t13 = (t0 + 11385);
    t16 = xsi_mem_cmp(t13, t5, 3U);
    if (t16 == 1)
        goto LAB142;

LAB151:    t15 = (t0 + 11388);
    t17 = xsi_mem_cmp(t15, t5, 3U);
    if (t17 == 1)
        goto LAB143;

LAB152:    t22 = (t0 + 11391);
    t18 = xsi_mem_cmp(t22, t5, 3U);
    if (t18 == 1)
        goto LAB144;

LAB153:    t25 = (t0 + 11394);
    t19 = xsi_mem_cmp(t25, t5, 3U);
    if (t19 == 1)
        goto LAB145;

LAB154:    t27 = (t0 + 11397);
    t21 = xsi_mem_cmp(t27, t5, 3U);
    if (t21 == 1)
        goto LAB146;

LAB155:    t29 = (t0 + 11400);
    t24 = xsi_mem_cmp(t29, t5, 3U);
    if (t24 == 1)
        goto LAB147;

LAB156:    t31 = (t0 + 11403);
    t65 = xsi_mem_cmp(t31, t5, 3U);
    if (t65 == 1)
        goto LAB148;

LAB157:    t46 = (t0 + 11406);
    t66 = xsi_mem_cmp(t46, t5, 3U);
    if (t66 == 1)
        goto LAB149;

LAB158:
LAB150:
LAB141:    goto LAB139;

LAB142:    xsi_set_current_line(166, ng0);
    t51 = (t0 + 7736);
    t52 = (t51 + 56U);
    t54 = *((char **)t52);
    t55 = (t54 + 56U);
    t58 = *((char **)t55);
    *((unsigned char *)t58) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t51);
    goto LAB141;

LAB143:    xsi_set_current_line(167, ng0);
    t1 = (t0 + 7800);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB141;

LAB144:    xsi_set_current_line(168, ng0);
    t1 = (t0 + 7864);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB141;

LAB145:    xsi_set_current_line(169, ng0);
    t1 = (t0 + 7928);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB141;

LAB146:    xsi_set_current_line(170, ng0);
    t1 = (t0 + 7992);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB141;

LAB147:    xsi_set_current_line(171, ng0);
    t1 = (t0 + 8056);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB141;

LAB148:    xsi_set_current_line(172, ng0);
    t1 = (t0 + 8120);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB141;

LAB149:    xsi_set_current_line(173, ng0);
    t1 = (t0 + 8184);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB141;

LAB159:;
LAB160:    xsi_set_current_line(179, ng0);
    t5 = (t0 + 7736);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t11 = (t7 + 56U);
    t12 = *((char **)t11);
    *((unsigned char *)t12) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t5);
    xsi_set_current_line(180, ng0);
    t1 = (t0 + 7800);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(181, ng0);
    t1 = (t0 + 7864);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(182, ng0);
    t1 = (t0 + 7928);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(183, ng0);
    t1 = (t0 + 7992);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(184, ng0);
    t1 = (t0 + 8056);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(185, ng0);
    t1 = (t0 + 8120);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(186, ng0);
    t1 = (t0 + 8184);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(187, ng0);
    t1 = (t0 + 11409);
    t5 = (t0 + 7224);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t11 = (t7 + 56U);
    t12 = *((char **)t11);
    memcpy(t12, t1, 3U);
    xsi_driver_first_trans_fast(t5);
    goto LAB161;

}


extern void work_a_3282816651_3212880686_init()
{
	static char *pe[] = {(void *)work_a_3282816651_3212880686_p_0};
	xsi_register_didat("work_a_3282816651_3212880686", "isim/cpumoduleTest_isim_beh.exe.sim/work/a_3282816651_3212880686.didat");
	xsi_register_executes(pe);
}
