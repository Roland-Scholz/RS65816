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
unsigned char ieee_p_3620187407_sub_3905759485_3965413181(char *, char *, char *, int );
unsigned char ieee_p_3620187407_sub_3908131327_3965413181(char *, char *, char *, int );
unsigned char ieee_p_3620187407_sub_4042748798_3965413181(char *, char *, char *, char *, char *);
char *ieee_p_3620187407_sub_436279890_3965413181(char *, char *, char *, char *, int );
char *ieee_p_3620187407_sub_436351764_3965413181(char *, char *, char *, char *, int );


static void work_a_3282816651_3212880686_p_0(char *t0)
{
    char t3[16];
    char t24[16];
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
    char *t18;
    int t19;
    unsigned char t20;
    char *t21;
    char *t22;
    char *t23;
    char *t25;
    char *t26;
    int t27;
    unsigned char t28;
    unsigned char t29;
    char *t30;
    unsigned char t31;
    unsigned char t32;
    char *t33;
    unsigned char t34;
    unsigned char t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    unsigned char t40;

LAB0:    xsi_set_current_line(55, ng0);
    t1 = (t0 + 992U);
    t2 = ieee_p_2592010699_sub_1258338084_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 5296);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(57, ng0);
    t4 = (t0 + 2632U);
    t5 = *((char **)t4);
    t4 = (t0 + 8180U);
    t6 = ieee_p_3620187407_sub_436279890_3965413181(IEEE_P_3620187407, t3, t5, t4, 1);
    t7 = (t3 + 12U);
    t8 = *((unsigned int *)t7);
    t9 = (1U * t8);
    t10 = (3U != t9);
    if (t10 == 1)
        goto LAB5;

LAB6:    t11 = (t0 + 5424);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t6, 3U);
    xsi_driver_first_trans_fast(t11);
    xsi_set_current_line(59, ng0);
    t1 = (t0 + 2632U);
    t4 = *((char **)t1);
    t1 = (t0 + 8272);
    t16 = xsi_mem_cmp(t1, t4, 3U);
    if (t16 == 1)
        goto LAB8;

LAB11:    t6 = (t0 + 8275);
    t17 = xsi_mem_cmp(t6, t4, 3U);
    if (t17 == 1)
        goto LAB9;

LAB12:
LAB10:
LAB7:    goto LAB3;

LAB5:    xsi_size_not_matching(3U, t9, 0);
    goto LAB6;

LAB8:    xsi_set_current_line(61, ng0);
    t11 = (t0 + 1192U);
    t12 = *((char **)t11);
    t11 = (t0 + 8132U);
    t13 = (t0 + 8278);
    t15 = (t3 + 0U);
    t18 = (t15 + 0U);
    *((int *)t18) = 0;
    t18 = (t15 + 4U);
    *((int *)t18) = 7;
    t18 = (t15 + 8U);
    *((int *)t18) = 1;
    t19 = (7 - 0);
    t8 = (t19 * 1);
    t8 = (t8 + 1);
    t18 = (t15 + 12U);
    *((unsigned int *)t18) = t8;
    t20 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t12, t11, t13, t3);
    if (t20 == 1)
        goto LAB20;

LAB21:    t10 = (unsigned char)0;

LAB22:    if (t10 == 1)
        goto LAB17;

LAB18:    t2 = (unsigned char)0;

LAB19:    if (t2 != 0)
        goto LAB14;

LAB16:
LAB15:    xsi_set_current_line(64, ng0);
    t1 = (t0 + 1192U);
    t4 = *((char **)t1);
    t1 = (t0 + 8132U);
    t5 = (t0 + 8289);
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
    t28 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t4, t1, t5, t3);
    if (t28 == 1)
        goto LAB35;

LAB36:    t20 = (unsigned char)0;

LAB37:    if (t20 == 1)
        goto LAB32;

LAB33:    t10 = (unsigned char)0;

LAB34:    if (t10 == 1)
        goto LAB29;

LAB30:    t2 = (unsigned char)0;

LAB31:    if (t2 != 0)
        goto LAB26;

LAB28:
LAB27:    goto LAB7;

LAB9:    xsi_set_current_line(72, ng0);
    t1 = (t0 + 8303);
    t5 = (t0 + 5424);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t11 = (t7 + 56U);
    t12 = *((char **)t11);
    memcpy(t12, t1, 3U);
    xsi_driver_first_trans_fast(t5);
    xsi_set_current_line(73, ng0);
    t1 = (t0 + 2792U);
    t4 = *((char **)t1);
    t1 = (t0 + 8196U);
    t2 = ieee_p_3620187407_sub_2546418145_3965413181(IEEE_P_3620187407, t4, t1, 0);
    if (t2 != 0)
        goto LAB41;

LAB43:    xsi_set_current_line(76, ng0);
    t1 = (t0 + 2792U);
    t4 = *((char **)t1);
    t1 = (t0 + 8196U);
    t5 = ieee_p_3620187407_sub_436351764_3965413181(IEEE_P_3620187407, t3, t4, t1, 1);
    t6 = (t3 + 12U);
    t8 = *((unsigned int *)t6);
    t9 = (1U * t8);
    t2 = (8U != t9);
    if (t2 == 1)
        goto LAB44;

LAB45:    t7 = (t0 + 5680);
    t11 = (t7 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    memcpy(t14, t5, 8U);
    xsi_driver_first_trans_fast(t7);

LAB42:    xsi_set_current_line(79, ng0);
    t1 = (t0 + 2952U);
    t4 = *((char **)t1);
    t1 = (t0 + 8212U);
    t2 = ieee_p_3620187407_sub_3890342512_3965413181(IEEE_P_3620187407, t4, t1, 0);
    if (t2 != 0)
        goto LAB46;

LAB48:
LAB47:    xsi_set_current_line(86, ng0);
    t1 = (t0 + 5488);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB7;

LAB13:;
LAB14:    xsi_set_current_line(62, ng0);
    t26 = (t0 + 5488);
    t36 = (t26 + 56U);
    t37 = *((char **)t36);
    t38 = (t37 + 56U);
    t39 = *((char **)t38);
    *((unsigned char *)t39) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t26);
    goto LAB15;

LAB17:    t26 = (t0 + 1672U);
    t30 = *((char **)t26);
    t31 = *((unsigned char *)t30);
    t32 = (t31 == (unsigned char)3);
    if (t32 == 1)
        goto LAB23;

LAB24:    t26 = (t0 + 1512U);
    t33 = *((char **)t26);
    t34 = *((unsigned char *)t33);
    t35 = (t34 == (unsigned char)3);
    t29 = t35;

LAB25:    t2 = t29;
    goto LAB19;

LAB20:    t18 = (t0 + 1352U);
    t21 = *((char **)t18);
    t18 = (t0 + 8148U);
    t22 = (t0 + 8286);
    t25 = (t24 + 0U);
    t26 = (t25 + 0U);
    *((int *)t26) = 0;
    t26 = (t25 + 4U);
    *((int *)t26) = 2;
    t26 = (t25 + 8U);
    *((int *)t26) = 1;
    t27 = (2 - 0);
    t8 = (t27 * 1);
    t8 = (t8 + 1);
    t26 = (t25 + 12U);
    *((unsigned int *)t26) = t8;
    t28 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t21, t18, t22, t24);
    t10 = t28;
    goto LAB22;

LAB23:    t29 = (unsigned char)1;
    goto LAB25;

LAB26:    xsi_set_current_line(65, ng0);
    t18 = (t0 + 2952U);
    t23 = *((char **)t18);
    t18 = (t0 + 8212U);
    t40 = ieee_p_3620187407_sub_2546418145_3965413181(IEEE_P_3620187407, t23, t18, 0);
    if (t40 != 0)
        goto LAB38;

LAB40:
LAB39:    goto LAB27;

LAB29:    t18 = (t0 + 1672U);
    t22 = *((char **)t18);
    t34 = *((unsigned char *)t22);
    t35 = (t34 == (unsigned char)2);
    t2 = t35;
    goto LAB31;

LAB32:    t18 = (t0 + 1512U);
    t21 = *((char **)t18);
    t31 = *((unsigned char *)t21);
    t32 = (t31 == (unsigned char)3);
    t10 = t32;
    goto LAB34;

LAB35:    t11 = (t0 + 1352U);
    t12 = *((char **)t11);
    t11 = (t0 + 8148U);
    t13 = (t0 + 8297);
    t15 = (t24 + 0U);
    t18 = (t15 + 0U);
    *((int *)t18) = 0;
    t18 = (t15 + 4U);
    *((int *)t18) = 2;
    t18 = (t15 + 8U);
    *((int *)t18) = 1;
    t17 = (2 - 0);
    t8 = (t17 * 1);
    t8 = (t8 + 1);
    t18 = (t15 + 12U);
    *((unsigned int *)t18) = t8;
    t29 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t12, t11, t13, t24);
    t20 = t29;
    goto LAB37;

LAB38:    xsi_set_current_line(66, ng0);
    t25 = (t0 + 5552);
    t26 = (t25 + 56U);
    t30 = *((char **)t26);
    t33 = (t30 + 56U);
    t36 = *((char **)t33);
    *((unsigned char *)t36) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t25);
    xsi_set_current_line(67, ng0);
    t1 = (t0 + 8300);
    t5 = (t0 + 5616);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t11 = (t7 + 56U);
    t12 = *((char **)t11);
    memcpy(t12, t1, 3U);
    xsi_driver_first_trans_fast(t5);
    goto LAB39;

LAB41:    xsi_set_current_line(74, ng0);
    t5 = (t0 + 3248U);
    t6 = *((char **)t5);
    t5 = (t0 + 5680);
    t7 = (t5 + 56U);
    t11 = *((char **)t7);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    memcpy(t13, t6, 8U);
    xsi_driver_first_trans_fast(t5);
    goto LAB42;

LAB44:    xsi_size_not_matching(8U, t9, 0);
    goto LAB45;

LAB46:    xsi_set_current_line(80, ng0);
    t5 = (t0 + 2952U);
    t6 = *((char **)t5);
    t5 = (t0 + 8212U);
    t7 = ieee_p_3620187407_sub_436279890_3965413181(IEEE_P_3620187407, t3, t6, t5, 1);
    t11 = (t3 + 12U);
    t8 = *((unsigned int *)t11);
    t9 = (1U * t8);
    t10 = (3U != t9);
    if (t10 == 1)
        goto LAB49;

LAB50:    t12 = (t0 + 5616);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    t15 = (t14 + 56U);
    t18 = *((char **)t15);
    memcpy(t18, t7, 3U);
    xsi_driver_first_trans_fast(t12);
    xsi_set_current_line(81, ng0);
    t1 = (t0 + 2952U);
    t4 = *((char **)t1);
    t1 = (t0 + 8212U);
    t2 = ieee_p_3620187407_sub_2546418145_3965413181(IEEE_P_3620187407, t4, t1, 7);
    if (t2 != 0)
        goto LAB51;

LAB53:
LAB52:    goto LAB47;

LAB49:    xsi_size_not_matching(3U, t9, 0);
    goto LAB50;

LAB51:    xsi_set_current_line(82, ng0);
    t5 = (t0 + 5552);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t11 = (t7 + 56U);
    t12 = *((char **)t11);
    *((unsigned char *)t12) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t5);
    goto LAB52;

}

static void work_a_3282816651_3212880686_p_1(char *t0)
{
    unsigned char t1;
    unsigned char t2;
    unsigned char t3;
    char *t4;
    char *t5;
    unsigned char t6;
    char *t7;
    char *t8;
    unsigned char t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    unsigned char t14;
    char *t15;
    char *t16;
    unsigned char t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;

LAB0:    xsi_set_current_line(95, ng0);
    t4 = (t0 + 2632U);
    t5 = *((char **)t4);
    t4 = (t0 + 8180U);
    t6 = ieee_p_3620187407_sub_3908131327_3965413181(IEEE_P_3620187407, t5, t4, 0);
    if (t6 == 1)
        goto LAB11;

LAB12:    t3 = (unsigned char)0;

LAB13:    if (t3 == 1)
        goto LAB8;

LAB9:    t2 = (unsigned char)0;

LAB10:    if (t2 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB3;

LAB4:
LAB14:    t23 = (t0 + 5744);
    t24 = (t23 + 56U);
    t25 = *((char **)t24);
    t26 = (t25 + 56U);
    t27 = *((char **)t26);
    *((unsigned char *)t27) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t23);

LAB2:    t28 = (t0 + 5312);
    *((int *)t28) = 1;

LAB1:    return;
LAB3:    t18 = (t0 + 5744);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    *((unsigned char *)t22) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t18);
    goto LAB2;

LAB5:    t15 = (t0 + 2952U);
    t16 = *((char **)t15);
    t15 = (t0 + 8212U);
    t17 = ieee_p_3620187407_sub_3905759485_3965413181(IEEE_P_3620187407, t16, t15, 1);
    t1 = t17;
    goto LAB7;

LAB8:    t10 = (t0 + 2792U);
    t11 = *((char **)t10);
    t10 = (t0 + 8196U);
    t12 = (t0 + 3248U);
    t13 = *((char **)t12);
    t12 = (t0 + 8164U);
    t14 = ieee_p_3620187407_sub_4042748798_3965413181(IEEE_P_3620187407, t11, t10, t13, t12);
    t2 = t14;
    goto LAB10;

LAB11:    t7 = (t0 + 2632U);
    t8 = *((char **)t7);
    t7 = (t0 + 8180U);
    t9 = ieee_p_3620187407_sub_3905759485_3965413181(IEEE_P_3620187407, t8, t7, 2);
    t3 = t9;
    goto LAB13;

LAB15:    goto LAB2;

}

static void work_a_3282816651_3212880686_p_2(char *t0)
{
    unsigned char t1;
    unsigned char t2;
    char *t3;
    char *t4;
    unsigned char t5;
    char *t6;
    char *t7;
    unsigned char t8;
    unsigned char t9;
    unsigned char t10;
    unsigned char t11;
    unsigned char t12;
    char *t13;
    char *t14;
    unsigned char t15;
    unsigned char t16;
    char *t17;
    unsigned char t18;
    unsigned char t19;
    char *t20;
    unsigned char t21;
    unsigned char t22;
    char *t23;
    unsigned char t24;
    unsigned char t25;
    char *t26;
    unsigned char t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;

LAB0:    xsi_set_current_line(98, ng0);
    t3 = (t0 + 2632U);
    t4 = *((char **)t3);
    t3 = (t0 + 8180U);
    t5 = ieee_p_3620187407_sub_3908131327_3965413181(IEEE_P_3620187407, t4, t3, 2);
    if (t5 == 1)
        goto LAB8;

LAB9:    t2 = (unsigned char)0;

LAB10:    if (t2 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB3;

LAB4:
LAB23:    t33 = (t0 + 5808);
    t34 = (t33 + 56U);
    t35 = *((char **)t34);
    t36 = (t35 + 56U);
    t37 = *((char **)t36);
    *((unsigned char *)t37) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t33);

LAB2:    t38 = (t0 + 5328);
    *((int *)t38) = 1;

LAB1:    return;
LAB3:    t28 = (t0 + 5808);
    t29 = (t28 + 56U);
    t30 = *((char **)t29);
    t31 = (t30 + 56U);
    t32 = *((char **)t31);
    *((unsigned char *)t32) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t28);
    goto LAB2;

LAB5:    t13 = (t0 + 1672U);
    t14 = *((char **)t13);
    t15 = *((unsigned char *)t14);
    t16 = (t15 == (unsigned char)3);
    if (t16 == 1)
        goto LAB20;

LAB21:    t13 = (t0 + 1512U);
    t17 = *((char **)t13);
    t18 = *((unsigned char *)t17);
    t19 = (t18 == (unsigned char)3);
    t12 = t19;

LAB22:    if (t12 == 1)
        goto LAB17;

LAB18:    t11 = (unsigned char)0;

LAB19:    if (t11 == 1)
        goto LAB14;

LAB15:    t10 = (unsigned char)0;

LAB16:    if (t10 == 1)
        goto LAB11;

LAB12:    t13 = (t0 + 2792U);
    t26 = *((char **)t13);
    t13 = (t0 + 8196U);
    t27 = ieee_p_3620187407_sub_2546418145_3965413181(IEEE_P_3620187407, t26, t13, 0);
    t9 = t27;

LAB13:    t1 = t9;
    goto LAB7;

LAB8:    t6 = (t0 + 2632U);
    t7 = *((char **)t6);
    t6 = (t0 + 8180U);
    t8 = ieee_p_3620187407_sub_3905759485_3965413181(IEEE_P_3620187407, t7, t6, 5);
    t2 = t8;
    goto LAB10;

LAB11:    t9 = (unsigned char)1;
    goto LAB13;

LAB14:    t13 = (t0 + 2312U);
    t23 = *((char **)t13);
    t24 = *((unsigned char *)t23);
    t25 = (t24 == (unsigned char)3);
    t10 = t25;
    goto LAB16;

LAB17:    t13 = (t0 + 2152U);
    t20 = *((char **)t13);
    t21 = *((unsigned char *)t20);
    t22 = (t21 == (unsigned char)3);
    t11 = t22;
    goto LAB19;

LAB20:    t12 = (unsigned char)1;
    goto LAB22;

LAB24:    goto LAB2;

}

static void work_a_3282816651_3212880686_p_3(char *t0)
{
    unsigned char t1;
    unsigned char t2;
    unsigned char t3;
    unsigned char t4;
    unsigned char t5;
    unsigned char t6;
    char *t7;
    char *t8;
    unsigned char t9;
    char *t10;
    char *t11;
    unsigned char t12;
    char *t13;
    char *t14;
    unsigned char t15;
    char *t16;
    char *t17;
    unsigned char t18;
    unsigned char t19;
    char *t20;
    unsigned char t21;
    unsigned char t22;
    unsigned char t23;
    char *t24;
    unsigned char t25;
    unsigned char t26;
    char *t27;
    unsigned char t28;
    unsigned char t29;
    unsigned char t30;
    unsigned char t31;
    char *t32;
    unsigned char t33;
    char *t34;
    char *t35;
    unsigned char t36;
    char *t37;
    char *t38;
    unsigned char t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    char *t46;
    char *t47;
    char *t48;
    char *t49;
    char *t50;

LAB0:    xsi_set_current_line(101, ng0);
    t7 = (t0 + 2792U);
    t8 = *((char **)t7);
    t7 = (t0 + 8196U);
    t9 = ieee_p_3620187407_sub_3890342512_3965413181(IEEE_P_3620187407, t8, t7, 0);
    if (t9 == 1)
        goto LAB20;

LAB21:    t6 = (unsigned char)0;

LAB22:    if (t6 == 1)
        goto LAB17;

LAB18:    t5 = (unsigned char)0;

LAB19:    if (t5 == 1)
        goto LAB14;

LAB15:    t4 = (unsigned char)0;

LAB16:    if (t4 == 1)
        goto LAB11;

LAB12:    t3 = (unsigned char)0;

LAB13:    if (t3 == 1)
        goto LAB8;

LAB9:    t2 = (unsigned char)0;

LAB10:    if (t2 == 1)
        goto LAB5;

LAB6:    t16 = (t0 + 2792U);
    t32 = *((char **)t16);
    t16 = (t0 + 8196U);
    t33 = ieee_p_3620187407_sub_2546418145_3965413181(IEEE_P_3620187407, t32, t16, 0);
    if (t33 == 1)
        goto LAB29;

LAB30:    t31 = (unsigned char)0;

LAB31:    if (t31 == 1)
        goto LAB26;

LAB27:    t30 = (unsigned char)0;

LAB28:    t1 = t30;

LAB7:    if (t1 != 0)
        goto LAB3;

LAB4:
LAB32:    t45 = (t0 + 5872);
    t46 = (t45 + 56U);
    t47 = *((char **)t46);
    t48 = (t47 + 56U);
    t49 = *((char **)t48);
    *((unsigned char *)t49) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t45);

LAB2:    t50 = (t0 + 5344);
    *((int *)t50) = 1;

LAB1:    return;
LAB3:    t40 = (t0 + 5872);
    t41 = (t40 + 56U);
    t42 = *((char **)t41);
    t43 = (t42 + 56U);
    t44 = *((char **)t43);
    *((unsigned char *)t44) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t40);
    goto LAB2;

LAB5:    t1 = (unsigned char)1;
    goto LAB7;

LAB8:    t16 = (t0 + 1672U);
    t24 = *((char **)t16);
    t25 = *((unsigned char *)t24);
    t26 = (t25 == (unsigned char)3);
    if (t26 == 1)
        goto LAB23;

LAB24:    t16 = (t0 + 1512U);
    t27 = *((char **)t16);
    t28 = *((unsigned char *)t27);
    t29 = (t28 == (unsigned char)3);
    t23 = t29;

LAB25:    t2 = t23;
    goto LAB10;

LAB11:    t16 = (t0 + 2312U);
    t20 = *((char **)t16);
    t21 = *((unsigned char *)t20);
    t22 = (t21 == (unsigned char)3);
    t3 = t22;
    goto LAB13;

LAB14:    t16 = (t0 + 2152U);
    t17 = *((char **)t16);
    t18 = *((unsigned char *)t17);
    t19 = (t18 == (unsigned char)3);
    t4 = t19;
    goto LAB16;

LAB17:    t13 = (t0 + 2632U);
    t14 = *((char **)t13);
    t13 = (t0 + 8180U);
    t15 = ieee_p_3620187407_sub_3905759485_3965413181(IEEE_P_3620187407, t14, t13, 6);
    t5 = t15;
    goto LAB19;

LAB20:    t10 = (t0 + 2632U);
    t11 = *((char **)t10);
    t10 = (t0 + 8180U);
    t12 = ieee_p_3620187407_sub_3908131327_3965413181(IEEE_P_3620187407, t11, t10, 5);
    t6 = t12;
    goto LAB22;

LAB23:    t23 = (unsigned char)1;
    goto LAB25;

LAB26:    t37 = (t0 + 2632U);
    t38 = *((char **)t37);
    t37 = (t0 + 8180U);
    t39 = ieee_p_3620187407_sub_3905759485_3965413181(IEEE_P_3620187407, t38, t37, 2);
    t30 = t39;
    goto LAB28;

LAB29:    t34 = (t0 + 2632U);
    t35 = *((char **)t34);
    t34 = (t0 + 8180U);
    t36 = ieee_p_3620187407_sub_3908131327_3965413181(IEEE_P_3620187407, t35, t34, 1);
    t31 = t36;
    goto LAB31;

LAB33:    goto LAB2;

}


extern void work_a_3282816651_3212880686_init()
{
	static char *pe[] = {(void *)work_a_3282816651_3212880686_p_0,(void *)work_a_3282816651_3212880686_p_1,(void *)work_a_3282816651_3212880686_p_2,(void *)work_a_3282816651_3212880686_p_3};
	xsi_register_didat("work_a_3282816651_3212880686", "isim/cpumoduleTest_isim_beh.exe.sim/work/a_3282816651_3212880686.didat");
	xsi_register_executes(pe);
}
