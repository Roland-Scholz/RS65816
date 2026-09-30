--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: P.20131013
--  \   \         Application: netgen
--  /   /         Filename: cpumodule_timesim.vhd
-- /___/   /\     Timestamp: Wed Sep 30 14:29:39 2026
-- \   \  /  \ 
--  \___\/\___\
--             
-- Command	: -intstyle ise -rpw 100 -ar Structure -tm cpumodule -w -dir netgen/fit -ofmt vhdl -sim cpumodule.nga cpumodule_timesim.vhd 
-- Device	: XC9536-15-PC44 (Speed File: Version 3.0)
-- Input file	: cpumodule.nga
-- Output file	: C:\github\RS65816\cpld\netgen\fit\cpumodule_timesim.vhd
-- # of Entities	: 1
-- Design Name	: cpumodule.nga
-- Xilinx	: C:\Xilinx\14.7\ISE_DS\ISE\
--             
-- Purpose:    
--     This VHDL netlist is a verification model and uses simulation 
--     primitives which may not represent the true implementation of the 
--     device, however the netlist is functionally correct and should not 
--     be modified. This file cannot be synthesized and should only be used 
--     with supported simulation tools.
--             
-- Reference:  
--     Command Line Tools User Guide, Chapter 23
--     Synthesis and Simulation Design Guide, Chapter 6
--             
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library SIMPRIM;
use SIMPRIM.VCOMPONENTS.ALL;
use SIMPRIM.VPACKAGE.ALL;

entity cpumodule is
  port (
    vda : in STD_LOGIC := 'X'; 
    a10 : in STD_LOGIC := 'X'; 
    clk : in STD_LOGIC := 'X'; 
    rw : in STD_LOGIC := 'X'; 
    vpa : in STD_LOGIC := 'X'; 
    rom : inout STD_LOGIC; 
    phi1 : inout STD_LOGIC; 
    cas0 : inout STD_LOGIC; 
    cas1 : inout STD_LOGIC; 
    cas2 : inout STD_LOGIC; 
    cas3 : inout STD_LOGIC; 
    io0 : inout STD_LOGIC; 
    io1 : inout STD_LOGIC; 
    io2 : inout STD_LOGIC; 
    io3 : inout STD_LOGIC; 
    io4 : inout STD_LOGIC; 
    io5 : inout STD_LOGIC; 
    io6 : inout STD_LOGIC; 
    io7 : inout STD_LOGIC; 
    phi0 : inout STD_LOGIC; 
    ras : inout STD_LOGIC; 
    bank : in STD_LOGIC_VECTOR ( 7 downto 0 ); 
    a12_11 : in STD_LOGIC_VECTOR ( 1 downto 0 ); 
    a15_13 : in STD_LOGIC_VECTOR ( 2 downto 0 ) 
  );
end cpumodule;

architecture Structure of cpumodule is
  signal bank_7_IBUF_1 : STD_LOGIC; 
  signal bank_6_IBUF_3 : STD_LOGIC; 
  signal bank_5_IBUF_5 : STD_LOGIC; 
  signal bank_4_IBUF_7 : STD_LOGIC; 
  signal bank_3_IBUF_9 : STD_LOGIC; 
  signal bank_2_IBUF_11 : STD_LOGIC; 
  signal bank_1_IBUF_13 : STD_LOGIC; 
  signal bank_0_IBUF_15 : STD_LOGIC; 
  signal a12_11_1_IBUF_17 : STD_LOGIC; 
  signal a12_11_0_IBUF_19 : STD_LOGIC; 
  signal vda_IBUF_21 : STD_LOGIC; 
  signal a15_13_2_IBUF_23 : STD_LOGIC; 
  signal a15_13_1_IBUF_25 : STD_LOGIC; 
  signal a15_13_0_IBUF_27 : STD_LOGIC; 
  signal a10_IBUF_29 : STD_LOGIC; 
  signal FCLK_IO_0_31 : STD_LOGIC; 
  signal rw_IBUF_33 : STD_LOGIC; 
  signal vpa_IBUF_35 : STD_LOGIC; 
  signal rom_PIN_BUF_Q_37 : STD_LOGIC; 
  signal phi1_PIN_BUF_Q_39 : STD_LOGIC; 
  signal cas0_PIN_BUF_Q_41 : STD_LOGIC; 
  signal cas1_PIN_BUF_Q_43 : STD_LOGIC; 
  signal cas2_PIN_BUF_Q_45 : STD_LOGIC; 
  signal cas3_PIN_BUF_Q_47 : STD_LOGIC; 
  signal io0_PIN_BUF_Q_49 : STD_LOGIC; 
  signal io1_PIN_BUF_Q_51 : STD_LOGIC; 
  signal io2_PIN_BUF_Q_53 : STD_LOGIC; 
  signal io3_PIN_BUF_Q_55 : STD_LOGIC; 
  signal io4_PIN_BUF_Q_57 : STD_LOGIC; 
  signal io5_PIN_BUF_Q_59 : STD_LOGIC; 
  signal io6_PIN_BUF_Q_61 : STD_LOGIC; 
  signal io7_PIN_BUF_Q_63 : STD_LOGIC; 
  signal phi0_PIN_BUF_Q_65 : STD_LOGIC; 
  signal ras_PIN_BUF_Q_67 : STD_LOGIC; 
  signal rom_OBUF_Q_68 : STD_LOGIC; 
  signal phi1_OBUF_Q_69 : STD_LOGIC; 
  signal cas0_OBUF_Q_70 : STD_LOGIC; 
  signal cas1_OBUF_Q_71 : STD_LOGIC; 
  signal cas2_OBUF_Q_72 : STD_LOGIC; 
  signal cas3_OBUF_Q_73 : STD_LOGIC; 
  signal io0_OBUF_Q_74 : STD_LOGIC; 
  signal io1_OBUF_Q_75 : STD_LOGIC; 
  signal io2_OBUF_Q_76 : STD_LOGIC; 
  signal io3_OBUF_Q_77 : STD_LOGIC; 
  signal io4_OBUF_Q_78 : STD_LOGIC; 
  signal io5_OBUF_Q_79 : STD_LOGIC; 
  signal io6_OBUF_Q_80 : STD_LOGIC; 
  signal io7_OBUF_Q_81 : STD_LOGIC; 
  signal phi0_OBUF_Q_82 : STD_LOGIC; 
  signal ras_OBUF_Q_83 : STD_LOGIC; 
  signal rom_OBUF_Q_84 : STD_LOGIC; 
  signal rom_OBUF_D_85 : STD_LOGIC; 
  signal rom_OBUF_tsimcreated_xor_Q_86 : STD_LOGIC; 
  signal Gnd_87 : STD_LOGIC; 
  signal Vcc_88 : STD_LOGIC; 
  signal rom_OBUF_D1_89 : STD_LOGIC; 
  signal rom_OBUF_D2_90 : STD_LOGIC; 
  signal rom_OBUF_D2_PT_0_94 : STD_LOGIC; 
  signal rom_OBUF_D2_PT_1_95 : STD_LOGIC; 
  signal rom_OBUF_D2_PT_2_96 : STD_LOGIC; 
  signal phi1_OBUF_Q_97 : STD_LOGIC; 
  signal phi1_OBUF_D_98 : STD_LOGIC; 
  signal phi1_OBUF_D1_99 : STD_LOGIC; 
  signal phi1_OBUF_D2_100 : STD_LOGIC; 
  signal refcnt_1_EXP_101 : STD_LOGIC; 
  signal phi1_OBUF_D2_PT_0_102 : STD_LOGIC; 
  signal phi1_OBUF_D2_PT_1_103 : STD_LOGIC; 
  signal phi1_OBUF_D2_PT_2_104 : STD_LOGIC; 
  signal phi1_OBUF_D2_PT_3_106 : STD_LOGIC; 
  signal phi1_OBUF_D2_PT_4_107 : STD_LOGIC; 
  signal phi1_OBUF_D2_PT_5_110 : STD_LOGIC; 
  signal cas0_OBUF_Q_111 : STD_LOGIC; 
  signal cas0_OBUF_D_112 : STD_LOGIC; 
  signal cas0_OBUF_D1_113 : STD_LOGIC; 
  signal cas0_OBUF_D2_114 : STD_LOGIC; 
  signal EXP0_EXP_115 : STD_LOGIC; 
  signal cas0_OBUF_D2_PT_0_116 : STD_LOGIC; 
  signal EXP3_EXP_117 : STD_LOGIC; 
  signal cas0_OBUF_D2_PT_1_118 : STD_LOGIC; 
  signal cas0_OBUF_D2_PT_2_119 : STD_LOGIC; 
  signal cas0_OBUF_D2_PT_3_120 : STD_LOGIC; 
  signal cas0_OBUF_D2_PT_4_122 : STD_LOGIC; 
  signal cas0_OBUF_D2_PT_5_124 : STD_LOGIC; 
  signal cas0_OBUF_D2_PT_6_126 : STD_LOGIC; 
  signal cas1_OBUF_Q_127 : STD_LOGIC; 
  signal cas1_OBUF_EXP_tsimrenamed_net_Q_128 : STD_LOGIC; 
  signal cas1_OBUF_EXP_129 : STD_LOGIC; 
  signal cas1_OBUF_D_130 : STD_LOGIC; 
  signal cas1_OBUF_D1_131 : STD_LOGIC; 
  signal cas1_OBUF_D2_132 : STD_LOGIC; 
  signal EXP1_EXP_133 : STD_LOGIC; 
  signal cas1_OBUF_D2_PT_0_134 : STD_LOGIC; 
  signal cas1_OBUF_D2_PT_1_135 : STD_LOGIC; 
  signal cas1_OBUF_D2_PT_2_136 : STD_LOGIC; 
  signal cas1_OBUF_D2_PT_3_137 : STD_LOGIC; 
  signal cas1_OBUF_EXP_PT_0_140 : STD_LOGIC; 
  signal cas1_OBUF_EXP_PT_1_142 : STD_LOGIC; 
  signal cas2_OBUF_Q_143 : STD_LOGIC; 
  signal cas2_OBUF_D_144 : STD_LOGIC; 
  signal cas2_OBUF_D1_145 : STD_LOGIC; 
  signal cas2_OBUF_D2_146 : STD_LOGIC; 
  signal refcnt_2_EXP_147 : STD_LOGIC; 
  signal cas2_OBUF_D2_PT_0_148 : STD_LOGIC; 
  signal refcnt_5_EXP_149 : STD_LOGIC; 
  signal cas2_OBUF_D2_PT_1_150 : STD_LOGIC; 
  signal cas2_OBUF_D2_PT_2_151 : STD_LOGIC; 
  signal cas2_OBUF_D2_PT_3_152 : STD_LOGIC; 
  signal cas2_OBUF_D2_PT_4_153 : STD_LOGIC; 
  signal cas2_OBUF_D2_PT_5_154 : STD_LOGIC; 
  signal cas2_OBUF_D2_PT_6_155 : STD_LOGIC; 
  signal cas3_OBUF_Q_156 : STD_LOGIC; 
  signal cas3_OBUF_D_157 : STD_LOGIC; 
  signal cas3_OBUF_D1_158 : STD_LOGIC; 
  signal cas3_OBUF_D2_159 : STD_LOGIC; 
  signal refcnt_3_EXP_160 : STD_LOGIC; 
  signal cas3_OBUF_D2_PT_0_161 : STD_LOGIC; 
  signal phi0_OBUF_EXP_162 : STD_LOGIC; 
  signal cas3_OBUF_D2_PT_1_163 : STD_LOGIC; 
  signal cas3_OBUF_D2_PT_2_164 : STD_LOGIC; 
  signal cas3_OBUF_D2_PT_3_165 : STD_LOGIC; 
  signal cas3_OBUF_D2_PT_4_166 : STD_LOGIC; 
  signal cas3_OBUF_D2_PT_5_167 : STD_LOGIC; 
  signal cas3_OBUF_D2_PT_6_168 : STD_LOGIC; 
  signal io0_OBUF_Q_169 : STD_LOGIC; 
  signal io0_OBUF_D_170 : STD_LOGIC; 
  signal io0_OBUF_tsimcreated_xor_Q_171 : STD_LOGIC; 
  signal io0_OBUF_D1_172 : STD_LOGIC; 
  signal io0_OBUF_D2_173 : STD_LOGIC; 
  signal io0_OBUF_D2_PT_0_174 : STD_LOGIC; 
  signal io0_OBUF_D2_PT_1_175 : STD_LOGIC; 
  signal io1_OBUF_Q_176 : STD_LOGIC; 
  signal io1_OBUF_D_177 : STD_LOGIC; 
  signal io1_OBUF_tsimcreated_xor_Q_178 : STD_LOGIC; 
  signal io1_OBUF_D1_179 : STD_LOGIC; 
  signal io1_OBUF_D2_180 : STD_LOGIC; 
  signal io1_OBUF_D2_PT_0_181 : STD_LOGIC; 
  signal io1_OBUF_D2_PT_1_182 : STD_LOGIC; 
  signal io2_OBUF_Q_183 : STD_LOGIC; 
  signal io2_OBUF_D_184 : STD_LOGIC; 
  signal io2_OBUF_tsimcreated_xor_Q_185 : STD_LOGIC; 
  signal io2_OBUF_D1_186 : STD_LOGIC; 
  signal io2_OBUF_D2_187 : STD_LOGIC; 
  signal io2_OBUF_D2_PT_0_188 : STD_LOGIC; 
  signal io2_OBUF_D2_PT_1_189 : STD_LOGIC; 
  signal io3_OBUF_Q_190 : STD_LOGIC; 
  signal io3_OBUF_D_191 : STD_LOGIC; 
  signal io3_OBUF_tsimcreated_xor_Q_192 : STD_LOGIC; 
  signal io3_OBUF_D1_193 : STD_LOGIC; 
  signal io3_OBUF_D2_194 : STD_LOGIC; 
  signal io3_OBUF_D2_PT_0_195 : STD_LOGIC; 
  signal io3_OBUF_D2_PT_1_196 : STD_LOGIC; 
  signal io4_OBUF_Q_197 : STD_LOGIC; 
  signal io4_OBUF_D_198 : STD_LOGIC; 
  signal io4_OBUF_tsimcreated_xor_Q_199 : STD_LOGIC; 
  signal io4_OBUF_D1_200 : STD_LOGIC; 
  signal io4_OBUF_D2_201 : STD_LOGIC; 
  signal io4_OBUF_D2_PT_0_202 : STD_LOGIC; 
  signal io4_OBUF_D2_PT_1_203 : STD_LOGIC; 
  signal io5_OBUF_Q_204 : STD_LOGIC; 
  signal io5_OBUF_D_205 : STD_LOGIC; 
  signal io5_OBUF_tsimcreated_xor_Q_206 : STD_LOGIC; 
  signal io5_OBUF_D1_207 : STD_LOGIC; 
  signal io5_OBUF_D2_208 : STD_LOGIC; 
  signal io5_OBUF_D2_PT_0_209 : STD_LOGIC; 
  signal io5_OBUF_D2_PT_1_210 : STD_LOGIC; 
  signal io6_OBUF_Q_211 : STD_LOGIC; 
  signal io6_OBUF_D_212 : STD_LOGIC; 
  signal io6_OBUF_tsimcreated_xor_Q_213 : STD_LOGIC; 
  signal io6_OBUF_D1_214 : STD_LOGIC; 
  signal io6_OBUF_D2_215 : STD_LOGIC; 
  signal io6_OBUF_D2_PT_0_216 : STD_LOGIC; 
  signal io6_OBUF_D2_PT_1_217 : STD_LOGIC; 
  signal io7_OBUF_Q_218 : STD_LOGIC; 
  signal io7_OBUF_D_219 : STD_LOGIC; 
  signal io7_OBUF_tsimcreated_xor_Q_220 : STD_LOGIC; 
  signal io7_OBUF_D1_221 : STD_LOGIC; 
  signal io7_OBUF_D2_222 : STD_LOGIC; 
  signal io7_OBUF_D2_PT_0_223 : STD_LOGIC; 
  signal io7_OBUF_D2_PT_1_224 : STD_LOGIC; 
  signal phi0_OBUF_Q_225 : STD_LOGIC; 
  signal phi0_OBUF_EXP_tsimrenamed_net_Q_226 : STD_LOGIC; 
  signal phi0_OBUF_D_227 : STD_LOGIC; 
  signal phi0_OBUF_D1_228 : STD_LOGIC; 
  signal phi0_OBUF_D2_229 : STD_LOGIC; 
  signal refcnt_7_EXP_230 : STD_LOGIC; 
  signal phi0_OBUF_D2_PT_0_231 : STD_LOGIC; 
  signal phi0_OBUF_D2_PT_1_232 : STD_LOGIC; 
  signal phi0_OBUF_D2_PT_2_233 : STD_LOGIC; 
  signal phi0_OBUF_D2_PT_3_234 : STD_LOGIC; 
  signal phi0_OBUF_EXP_PT_0_235 : STD_LOGIC; 
  signal phi0_OBUF_EXP_PT_1_238 : STD_LOGIC; 
  signal ras_OBUF_Q_239 : STD_LOGIC; 
  signal ras_OBUF_EXP_tsimrenamed_net_Q_240 : STD_LOGIC; 
  signal ras_OBUF_EXP_241 : STD_LOGIC; 
  signal ras_OBUF_D_242 : STD_LOGIC; 
  signal ras_OBUF_D1_243 : STD_LOGIC; 
  signal ras_OBUF_D2_244 : STD_LOGIC; 
  signal EXP2_EXP_245 : STD_LOGIC; 
  signal ras_OBUF_D2_PT_0_246 : STD_LOGIC; 
  signal Q_OpTx_FX_DC_49_UIM_247 : STD_LOGIC; 
  signal ras_OBUF_D2_PT_1_248 : STD_LOGIC; 
  signal ras_OBUF_D2_PT_2_249 : STD_LOGIC; 
  signal ras_OBUF_D2_PT_3_250 : STD_LOGIC; 
  signal ras_OBUF_EXP_PT_0_251 : STD_LOGIC; 
  signal ras_OBUF_EXP_PT_1_252 : STD_LOGIC; 
  signal counter_2_Q_253 : STD_LOGIC; 
  signal counter_2_D_254 : STD_LOGIC; 
  signal counter_2_D1_255 : STD_LOGIC; 
  signal counter_2_D2_256 : STD_LOGIC; 
  signal counter_2_D2_PT_0_257 : STD_LOGIC; 
  signal counter_2_D2_PT_1_258 : STD_LOGIC; 
  signal iocnt_2_Q_259 : STD_LOGIC; 
  signal iocnt_2_D_260 : STD_LOGIC; 
  signal iocnt_2_tsimcreated_xor_Q_261 : STD_LOGIC; 
  signal iocnt_2_D1_262 : STD_LOGIC; 
  signal iocnt_2_D2_263 : STD_LOGIC; 
  signal iocnt_2_D2_PT_0_264 : STD_LOGIC; 
  signal iocnt_2_D2_PT_1_265 : STD_LOGIC; 
  signal counter_0_Q_266 : STD_LOGIC; 
  signal counter_0_D_267 : STD_LOGIC; 
  signal counter_0_tsimcreated_xor_Q_268 : STD_LOGIC; 
  signal counter_0_D1_269 : STD_LOGIC; 
  signal counter_0_D2_270 : STD_LOGIC; 
  signal counter_1_Q_271 : STD_LOGIC; 
  signal counter_1_D_272 : STD_LOGIC; 
  signal counter_1_D1_273 : STD_LOGIC; 
  signal counter_1_D2_274 : STD_LOGIC; 
  signal counter_1_D2_PT_0_275 : STD_LOGIC; 
  signal counter_1_D2_PT_1_276 : STD_LOGIC; 
  signal iocnt_0_Q_277 : STD_LOGIC; 
  signal iocnt_0_D_278 : STD_LOGIC; 
  signal iocnt_0_tsimcreated_xor_Q_279 : STD_LOGIC; 
  signal iocnt_0_D1_280 : STD_LOGIC; 
  signal iocnt_0_D2_281 : STD_LOGIC; 
  signal iocnt_0_D2_PT_0_282 : STD_LOGIC; 
  signal iocnt_0_D2_PT_1_283 : STD_LOGIC; 
  signal iocnt_0_D2_PT_2_284 : STD_LOGIC; 
  signal iocnt_0_D2_PT_3_285 : STD_LOGIC; 
  signal iocnt_1_Q_286 : STD_LOGIC; 
  signal iocnt_1_EXP_tsimrenamed_net_Q_287 : STD_LOGIC; 
  signal iocnt_1_EXP_288 : STD_LOGIC; 
  signal iocnt_1_D_289 : STD_LOGIC; 
  signal iocnt_1_tsimcreated_xor_Q_290 : STD_LOGIC; 
  signal iocnt_1_D1_291 : STD_LOGIC; 
  signal iocnt_1_D2_292 : STD_LOGIC; 
  signal iocnt_1_D2_PT_0_293 : STD_LOGIC; 
  signal iocnt_1_D2_PT_1_294 : STD_LOGIC; 
  signal iocnt_1_EXP_PT_0_295 : STD_LOGIC; 
  signal iocnt_1_EXP_PT_1_296 : STD_LOGIC; 
  signal iocnt_1_EXP_PT_2_297 : STD_LOGIC; 
  signal refcnt_0_Q_298 : STD_LOGIC; 
  signal refcnt_0_D_299 : STD_LOGIC; 
  signal refcnt_0_tsimcreated_xor_Q_300 : STD_LOGIC; 
  signal refcnt_0_D1_301 : STD_LOGIC; 
  signal refcnt_0_D2_302 : STD_LOGIC; 
  signal refcnt_1_Q_303 : STD_LOGIC; 
  signal refcnt_1_EXP_tsimrenamed_net_Q_304 : STD_LOGIC; 
  signal refcnt_1_D_305 : STD_LOGIC; 
  signal refcnt_1_tsimcreated_xor_Q_306 : STD_LOGIC; 
  signal refcnt_1_D1_307 : STD_LOGIC; 
  signal refcnt_1_D2_308 : STD_LOGIC; 
  signal refcnt_1_D2_PT_0_309 : STD_LOGIC; 
  signal refcnt_1_D2_PT_1_310 : STD_LOGIC; 
  signal refcnt_1_D2_PT_2_311 : STD_LOGIC; 
  signal refcnt_1_D2_PT_3_312 : STD_LOGIC; 
  signal refcnt_1_EXP_PT_0_313 : STD_LOGIC; 
  signal refcnt_1_EXP_PT_1_314 : STD_LOGIC; 
  signal refcnt_2_Q_315 : STD_LOGIC; 
  signal refcnt_2_EXP_tsimrenamed_net_Q_316 : STD_LOGIC; 
  signal refcnt_2_D_317 : STD_LOGIC; 
  signal refcnt_2_tsimcreated_xor_Q_318 : STD_LOGIC; 
  signal refcnt_2_D1_319 : STD_LOGIC; 
  signal refcnt_2_D2_320 : STD_LOGIC; 
  signal refcnt_2_EXP_PT_0_321 : STD_LOGIC; 
  signal refcnt_2_EXP_PT_1_322 : STD_LOGIC; 
  signal refcnt_2_EXP_PT_2_323 : STD_LOGIC; 
  signal refcnt_2_EXP_PT_3_324 : STD_LOGIC; 
  signal refcnt_3_Q_325 : STD_LOGIC; 
  signal refcnt_3_EXP_tsimrenamed_net_Q_326 : STD_LOGIC; 
  signal refcnt_3_D_327 : STD_LOGIC; 
  signal refcnt_3_tsimcreated_xor_Q_328 : STD_LOGIC; 
  signal refcnt_3_D1_329 : STD_LOGIC; 
  signal refcnt_3_D2_330 : STD_LOGIC; 
  signal refcnt_3_EXP_PT_0_331 : STD_LOGIC; 
  signal refcnt_3_EXP_PT_1_332 : STD_LOGIC; 
  signal refcnt_3_EXP_PT_2_333 : STD_LOGIC; 
  signal refcnt_3_EXP_PT_3_334 : STD_LOGIC; 
  signal refcnt_4_Q_335 : STD_LOGIC; 
  signal refcnt_4_EXP_tsimrenamed_net_Q_336 : STD_LOGIC; 
  signal refcnt_4_EXP_337 : STD_LOGIC; 
  signal refcnt_4_D_338 : STD_LOGIC; 
  signal refcnt_4_tsimcreated_xor_Q_339 : STD_LOGIC; 
  signal refcnt_4_D1_340 : STD_LOGIC; 
  signal refcnt_4_D2_341 : STD_LOGIC; 
  signal refcnt_4_D2_PT_0_342 : STD_LOGIC; 
  signal refcnt_4_D2_PT_1_343 : STD_LOGIC; 
  signal refcnt_4_D2_PT_2_344 : STD_LOGIC; 
  signal refcnt_4_EXP_PT_0_345 : STD_LOGIC; 
  signal refcnt_4_EXP_PT_1_346 : STD_LOGIC; 
  signal refcnt_4_EXP_PT_2_347 : STD_LOGIC; 
  signal refcnt_5_Q_348 : STD_LOGIC; 
  signal refcnt_5_EXP_tsimrenamed_net_Q_349 : STD_LOGIC; 
  signal refcnt_5_D_350 : STD_LOGIC; 
  signal refcnt_5_tsimcreated_xor_Q_351 : STD_LOGIC; 
  signal refcnt_5_D1_352 : STD_LOGIC; 
  signal refcnt_5_D2_353 : STD_LOGIC; 
  signal refcnt_5_D2_PT_0_354 : STD_LOGIC; 
  signal refcnt_5_D2_PT_1_355 : STD_LOGIC; 
  signal refcnt_5_D2_PT_2_356 : STD_LOGIC; 
  signal refcnt_5_EXP_PT_0_357 : STD_LOGIC; 
  signal refcnt_5_EXP_PT_1_358 : STD_LOGIC; 
  signal refcnt_6_Q_359 : STD_LOGIC; 
  signal refcnt_6_D_360 : STD_LOGIC; 
  signal refcnt_6_tsimcreated_xor_Q_361 : STD_LOGIC; 
  signal refcnt_6_D1_362 : STD_LOGIC; 
  signal refcnt_6_D2_363 : STD_LOGIC; 
  signal FC_1_OUT : STD_LOGIC; 
  signal FC_0_OUT : STD_LOGIC; 
  signal refcnt_7_Q_366 : STD_LOGIC; 
  signal refcnt_7_EXP_tsimrenamed_net_Q_367 : STD_LOGIC; 
  signal refcnt_7_D_368 : STD_LOGIC; 
  signal refcnt_7_tsimcreated_xor_Q_369 : STD_LOGIC; 
  signal refcnt_7_D1_370 : STD_LOGIC; 
  signal refcnt_7_D2_371 : STD_LOGIC; 
  signal refcnt_7_EXP_PT_0_372 : STD_LOGIC; 
  signal refcnt_7_EXP_PT_1_373 : STD_LOGIC; 
  signal refcnt_7_EXP_PT_2_374 : STD_LOGIC; 
  signal refcnt_7_EXP_PT_3_375 : STD_LOGIC; 
  signal Q_OpTx_FX_DC_49_Q_376 : STD_LOGIC; 
  signal Q_OpTx_FX_DC_49_D_377 : STD_LOGIC; 
  signal Q_OpTx_FX_DC_49_D1_378 : STD_LOGIC; 
  signal Q_OpTx_FX_DC_49_D2_379 : STD_LOGIC; 
  signal Q_OpTx_FX_DC_49_D2_PT_0_380 : STD_LOGIC; 
  signal Q_OpTx_FX_DC_49_D2_PT_1_381 : STD_LOGIC; 
  signal Q_OpTx_FX_DC_49_D2_PT_2_382 : STD_LOGIC; 
  signal EXP0_EXP_tsimrenamed_net_Q_383 : STD_LOGIC; 
  signal EXP0_EXP_PT_0_384 : STD_LOGIC; 
  signal EXP0_EXP_PT_1_385 : STD_LOGIC; 
  signal EXP0_EXP_PT_2_386 : STD_LOGIC; 
  signal EXP0_EXP_PT_3_387 : STD_LOGIC; 
  signal EXP0_EXP_PT_4_388 : STD_LOGIC; 
  signal EXP0_EXP_PT_5_389 : STD_LOGIC; 
  signal EXP1_EXP_tsimrenamed_net_Q_390 : STD_LOGIC; 
  signal EXP1_EXP_PT_0_391 : STD_LOGIC; 
  signal EXP1_EXP_PT_1_392 : STD_LOGIC; 
  signal EXP1_EXP_PT_2_393 : STD_LOGIC; 
  signal EXP1_EXP_PT_3_394 : STD_LOGIC; 
  signal EXP1_EXP_PT_4_395 : STD_LOGIC; 
  signal EXP1_EXP_PT_5_396 : STD_LOGIC; 
  signal EXP2_EXP_tsimrenamed_net_Q_397 : STD_LOGIC; 
  signal EXP2_EXP_PT_0_398 : STD_LOGIC; 
  signal EXP2_EXP_PT_1_399 : STD_LOGIC; 
  signal EXP2_EXP_PT_2_400 : STD_LOGIC; 
  signal EXP2_EXP_PT_3_401 : STD_LOGIC; 
  signal EXP2_EXP_PT_4_402 : STD_LOGIC; 
  signal EXP3_EXP_tsimrenamed_net_Q_403 : STD_LOGIC; 
  signal EXP3_EXP_PT_0_404 : STD_LOGIC; 
  signal EXP3_EXP_PT_1_405 : STD_LOGIC; 
  signal EXP3_EXP_PT_2_406 : STD_LOGIC; 
  signal EXP3_EXP_PT_3_407 : STD_LOGIC; 
  signal EXP3_EXP_PT_4_408 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_tsimcreated_xor_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_tsimcreated_xor_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_0_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_1_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_1_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_1_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_1_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_1_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_1_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_1_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_1_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_1_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_1_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_1_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_1_IN16 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_1_IN17 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_1_IN18 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_1_IN19 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_1_IN20 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_1_IN21 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_1_IN22 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_1_IN23 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_1_IN24 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_1_IN25 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_1_IN26 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_1_IN27 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_1_IN28 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_1_IN29 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_1_IN30 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_1_IN31 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_2_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_2_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_2_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_2_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_2_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_2_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_2_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_2_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_2_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_2_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_2_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_2_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_2_IN16 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_2_IN17 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_2_IN18 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_2_IN19 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_2_IN20 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_2_IN21 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_2_IN22 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_2_IN23 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_2_IN24 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_2_IN25 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_2_IN26 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_2_IN27 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_2_IN28 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_2_IN29 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_2_IN30 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_PT_2_IN31 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_phi1_OBUF_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_phi1_OBUF_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_phi1_OBUF_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_phi1_OBUF_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_phi1_OBUF_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_phi1_OBUF_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_phi1_OBUF_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_phi1_OBUF_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_phi1_OBUF_D2_PT_2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_phi1_OBUF_D2_PT_2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_phi1_OBUF_D2_PT_3_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_phi1_OBUF_D2_PT_3_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_phi1_OBUF_D2_PT_4_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_phi1_OBUF_D2_PT_4_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_phi1_OBUF_D2_PT_4_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_phi1_OBUF_D2_PT_5_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_phi1_OBUF_D2_PT_5_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_phi1_OBUF_D2_PT_5_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_phi1_OBUF_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_phi1_OBUF_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_phi1_OBUF_D2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_phi1_OBUF_D2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_phi1_OBUF_D2_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_phi1_OBUF_D2_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_3_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_3_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_4_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_4_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_4_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_5_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_5_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_5_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_6_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_6_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_6_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_3_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_3_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_EXP_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_EXP_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_EXP_PT_0_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_EXP_PT_0_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_EXP_PT_0_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_EXP_PT_0_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_EXP_PT_0_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_EXP_PT_0_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_EXP_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_EXP_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_EXP_PT_1_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_EXP_PT_1_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_EXP_PT_1_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_EXP_PT_1_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_EXP_PT_1_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_EXP_tsimrenamed_net_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_EXP_tsimrenamed_net_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_3_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_3_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_4_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_4_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_5_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_5_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_6_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_6_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_3_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_3_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_4_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_4_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_5_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_5_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_6_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_6_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_io0_OBUF_tsimcreated_xor_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io0_OBUF_tsimcreated_xor_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io0_OBUF_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_io0_OBUF_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_io0_OBUF_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io0_OBUF_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io0_OBUF_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io0_OBUF_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io0_OBUF_D2_PT_0_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_io0_OBUF_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_io0_OBUF_D2_PT_0_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_io0_OBUF_D2_PT_0_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_io0_OBUF_D2_PT_0_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_io0_OBUF_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io0_OBUF_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io0_OBUF_D2_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_io0_OBUF_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_io0_OBUF_D2_PT_1_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_io0_OBUF_D2_PT_1_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_io0_OBUF_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_io0_OBUF_D2_PT_1_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_io0_OBUF_D2_PT_1_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_io0_OBUF_D2_PT_1_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_io0_OBUF_D2_PT_1_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_io0_OBUF_D2_PT_1_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_io0_OBUF_D2_PT_1_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_io0_OBUF_D2_PT_1_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_io0_OBUF_D2_PT_1_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_io0_OBUF_D2_PT_1_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_io0_OBUF_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io0_OBUF_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io1_OBUF_tsimcreated_xor_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io1_OBUF_tsimcreated_xor_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io1_OBUF_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_io1_OBUF_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_io1_OBUF_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io1_OBUF_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io1_OBUF_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io1_OBUF_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io1_OBUF_D2_PT_0_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_io1_OBUF_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_io1_OBUF_D2_PT_0_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_io1_OBUF_D2_PT_0_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_io1_OBUF_D2_PT_0_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_io1_OBUF_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io1_OBUF_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io1_OBUF_D2_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_io1_OBUF_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_io1_OBUF_D2_PT_1_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_io1_OBUF_D2_PT_1_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_io1_OBUF_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_io1_OBUF_D2_PT_1_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_io1_OBUF_D2_PT_1_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_io1_OBUF_D2_PT_1_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_io1_OBUF_D2_PT_1_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_io1_OBUF_D2_PT_1_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_io1_OBUF_D2_PT_1_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_io1_OBUF_D2_PT_1_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_io1_OBUF_D2_PT_1_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_io1_OBUF_D2_PT_1_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_io1_OBUF_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io1_OBUF_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io2_OBUF_tsimcreated_xor_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io2_OBUF_tsimcreated_xor_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io2_OBUF_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_io2_OBUF_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_io2_OBUF_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io2_OBUF_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io2_OBUF_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io2_OBUF_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io2_OBUF_D2_PT_0_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_io2_OBUF_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_io2_OBUF_D2_PT_0_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_io2_OBUF_D2_PT_0_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_io2_OBUF_D2_PT_0_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_io2_OBUF_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io2_OBUF_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io2_OBUF_D2_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_io2_OBUF_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_io2_OBUF_D2_PT_1_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_io2_OBUF_D2_PT_1_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_io2_OBUF_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_io2_OBUF_D2_PT_1_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_io2_OBUF_D2_PT_1_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_io2_OBUF_D2_PT_1_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_io2_OBUF_D2_PT_1_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_io2_OBUF_D2_PT_1_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_io2_OBUF_D2_PT_1_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_io2_OBUF_D2_PT_1_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_io2_OBUF_D2_PT_1_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_io2_OBUF_D2_PT_1_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_io2_OBUF_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io2_OBUF_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io3_OBUF_tsimcreated_xor_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io3_OBUF_tsimcreated_xor_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io3_OBUF_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_io3_OBUF_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_io3_OBUF_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io3_OBUF_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io3_OBUF_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io3_OBUF_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io3_OBUF_D2_PT_0_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_io3_OBUF_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_io3_OBUF_D2_PT_0_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_io3_OBUF_D2_PT_0_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_io3_OBUF_D2_PT_0_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_io3_OBUF_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io3_OBUF_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io3_OBUF_D2_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_io3_OBUF_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_io3_OBUF_D2_PT_1_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_io3_OBUF_D2_PT_1_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_io3_OBUF_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_io3_OBUF_D2_PT_1_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_io3_OBUF_D2_PT_1_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_io3_OBUF_D2_PT_1_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_io3_OBUF_D2_PT_1_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_io3_OBUF_D2_PT_1_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_io3_OBUF_D2_PT_1_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_io3_OBUF_D2_PT_1_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_io3_OBUF_D2_PT_1_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_io3_OBUF_D2_PT_1_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_io3_OBUF_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io3_OBUF_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io4_OBUF_tsimcreated_xor_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io4_OBUF_tsimcreated_xor_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io4_OBUF_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_io4_OBUF_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_io4_OBUF_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io4_OBUF_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io4_OBUF_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io4_OBUF_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io4_OBUF_D2_PT_0_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_io4_OBUF_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_io4_OBUF_D2_PT_0_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_io4_OBUF_D2_PT_0_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_io4_OBUF_D2_PT_0_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_io4_OBUF_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io4_OBUF_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io4_OBUF_D2_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_io4_OBUF_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_io4_OBUF_D2_PT_1_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_io4_OBUF_D2_PT_1_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_io4_OBUF_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_io4_OBUF_D2_PT_1_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_io4_OBUF_D2_PT_1_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_io4_OBUF_D2_PT_1_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_io4_OBUF_D2_PT_1_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_io4_OBUF_D2_PT_1_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_io4_OBUF_D2_PT_1_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_io4_OBUF_D2_PT_1_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_io4_OBUF_D2_PT_1_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_io4_OBUF_D2_PT_1_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_io4_OBUF_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io4_OBUF_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io5_OBUF_tsimcreated_xor_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io5_OBUF_tsimcreated_xor_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io5_OBUF_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_io5_OBUF_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_io5_OBUF_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io5_OBUF_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io5_OBUF_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io5_OBUF_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io5_OBUF_D2_PT_0_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_io5_OBUF_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_io5_OBUF_D2_PT_0_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_io5_OBUF_D2_PT_0_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_io5_OBUF_D2_PT_0_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_io5_OBUF_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io5_OBUF_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io5_OBUF_D2_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_io5_OBUF_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_io5_OBUF_D2_PT_1_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_io5_OBUF_D2_PT_1_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_io5_OBUF_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_io5_OBUF_D2_PT_1_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_io5_OBUF_D2_PT_1_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_io5_OBUF_D2_PT_1_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_io5_OBUF_D2_PT_1_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_io5_OBUF_D2_PT_1_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_io5_OBUF_D2_PT_1_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_io5_OBUF_D2_PT_1_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_io5_OBUF_D2_PT_1_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_io5_OBUF_D2_PT_1_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_io5_OBUF_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io5_OBUF_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io6_OBUF_tsimcreated_xor_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io6_OBUF_tsimcreated_xor_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io6_OBUF_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_io6_OBUF_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_io6_OBUF_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io6_OBUF_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io6_OBUF_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io6_OBUF_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io6_OBUF_D2_PT_0_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_io6_OBUF_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_io6_OBUF_D2_PT_0_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_io6_OBUF_D2_PT_0_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_io6_OBUF_D2_PT_0_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_io6_OBUF_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io6_OBUF_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io6_OBUF_D2_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_io6_OBUF_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_io6_OBUF_D2_PT_1_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_io6_OBUF_D2_PT_1_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_io6_OBUF_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_io6_OBUF_D2_PT_1_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_io6_OBUF_D2_PT_1_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_io6_OBUF_D2_PT_1_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_io6_OBUF_D2_PT_1_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_io6_OBUF_D2_PT_1_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_io6_OBUF_D2_PT_1_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_io6_OBUF_D2_PT_1_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_io6_OBUF_D2_PT_1_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_io6_OBUF_D2_PT_1_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_io6_OBUF_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io6_OBUF_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io7_OBUF_tsimcreated_xor_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io7_OBUF_tsimcreated_xor_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io7_OBUF_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_io7_OBUF_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_io7_OBUF_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io7_OBUF_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io7_OBUF_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io7_OBUF_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io7_OBUF_D2_PT_0_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_io7_OBUF_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_io7_OBUF_D2_PT_0_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_io7_OBUF_D2_PT_0_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_io7_OBUF_D2_PT_0_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_io7_OBUF_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io7_OBUF_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_io7_OBUF_D2_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_io7_OBUF_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_io7_OBUF_D2_PT_1_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_io7_OBUF_D2_PT_1_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_io7_OBUF_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_io7_OBUF_D2_PT_1_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_io7_OBUF_D2_PT_1_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_io7_OBUF_D2_PT_1_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_io7_OBUF_D2_PT_1_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_io7_OBUF_D2_PT_1_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_io7_OBUF_D2_PT_1_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_io7_OBUF_D2_PT_1_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_io7_OBUF_D2_PT_1_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_io7_OBUF_D2_PT_1_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_io7_OBUF_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_io7_OBUF_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_D2_PT_2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_D2_PT_2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_D2_PT_3_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_D2_PT_3_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_D2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_D2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_EXP_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_EXP_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_EXP_PT_0_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_EXP_tsimrenamed_net_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_EXP_tsimrenamed_net_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_3_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_3_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_3_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_EXP_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_EXP_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_EXP_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_EXP_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_EXP_PT_1_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_EXP_PT_1_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_EXP_PT_1_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_EXP_PT_1_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_EXP_tsimrenamed_net_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_EXP_tsimrenamed_net_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_counter_2_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_counter_2_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_counter_2_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_counter_2_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_counter_2_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_counter_2_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_counter_2_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_counter_2_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_counter_2_D2_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_counter_2_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_counter_2_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_2_tsimcreated_xor_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_2_tsimcreated_xor_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_2_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_2_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_2_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_2_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_2_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_2_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_2_D2_PT_0_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_2_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_2_D2_PT_0_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_2_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_2_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_2_D2_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_2_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_2_D2_PT_1_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_2_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_2_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_counter_0_tsimcreated_xor_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_counter_0_tsimcreated_xor_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_counter_0_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_counter_0_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_counter_0_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_counter_0_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_counter_0_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_counter_0_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_counter_0_D2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_counter_1_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_counter_1_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_counter_1_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_counter_1_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_counter_1_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_counter_1_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_counter_1_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_counter_1_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_counter_1_D2_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_counter_1_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_counter_1_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_tsimcreated_xor_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_tsimcreated_xor_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_0_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_3_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_3_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_3_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_3_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_3_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_3_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_3_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_3_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_3_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_3_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_3_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_3_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_3_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_3_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_3_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_3_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_3_IN16 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_3_IN17 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_3_IN18 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_3_IN19 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_3_IN20 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_3_IN21 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_3_IN22 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_3_IN23 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_3_IN24 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_3_IN25 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_3_IN26 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_3_IN27 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_3_IN28 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_3_IN29 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_3_IN30 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_PT_3_IN31 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_0_D2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_tsimcreated_xor_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_tsimcreated_xor_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_D2_PT_0_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_D2_PT_0_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_D2_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_D2_PT_1_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_EXP_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_EXP_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_EXP_PT_0_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_EXP_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_EXP_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_EXP_PT_2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_EXP_PT_2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_EXP_PT_2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_EXP_PT_2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_EXP_PT_2_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_EXP_PT_2_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_EXP_PT_2_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_EXP_PT_2_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_EXP_PT_2_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_EXP_PT_2_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_EXP_PT_2_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_EXP_PT_2_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_EXP_PT_2_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_EXP_PT_2_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_EXP_PT_2_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_EXP_PT_2_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_EXP_tsimrenamed_net_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_EXP_tsimrenamed_net_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_iocnt_1_EXP_tsimrenamed_net_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_0_tsimcreated_xor_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_0_tsimcreated_xor_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_0_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_0_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_0_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_0_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_0_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_0_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_0_D2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_tsimcreated_xor_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_tsimcreated_xor_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_D2_PT_2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_D2_PT_2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_D2_PT_3_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_D2_PT_3_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_D2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_D2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_PT_0_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_PT_1_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_PT_1_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_PT_1_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_PT_1_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_PT_1_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_PT_1_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_PT_1_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_PT_1_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_PT_1_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_PT_1_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_PT_1_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_PT_1_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_PT_1_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_tsimcreated_xor_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_tsimcreated_xor_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_D2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_D2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_D2_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_3_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_3_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_3_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_tsimrenamed_net_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_tsimrenamed_net_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_tsimrenamed_net_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_tsimrenamed_net_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_tsimcreated_xor_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_tsimcreated_xor_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_D2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_D2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_D2_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_D2_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_3_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_3_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_3_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_tsimrenamed_net_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_tsimrenamed_net_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_tsimrenamed_net_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_tsimrenamed_net_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_tsimcreated_xor_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_tsimcreated_xor_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_PT_1_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_PT_1_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_PT_1_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_PT_2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_PT_2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_PT_2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_PT_2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_PT_2_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_PT_2_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_PT_2_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_PT_2_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_EXP_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_EXP_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_EXP_PT_0_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_EXP_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_EXP_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_EXP_PT_1_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_EXP_PT_2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_EXP_PT_2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_EXP_PT_2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_EXP_PT_2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_EXP_PT_2_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_EXP_PT_2_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_EXP_PT_2_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_EXP_PT_2_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_EXP_PT_2_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_EXP_PT_2_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_EXP_PT_2_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_EXP_PT_2_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_EXP_PT_2_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_EXP_PT_2_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_EXP_PT_2_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_EXP_PT_2_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_EXP_tsimrenamed_net_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_EXP_tsimrenamed_net_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_EXP_tsimrenamed_net_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_tsimcreated_xor_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_tsimcreated_xor_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_0_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_0_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_0_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_0_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_0_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_0_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_0_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_0_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_0_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_0_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_0_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_0_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_0_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_1_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_1_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_1_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_1_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_1_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_1_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_1_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_1_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_1_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_1_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_1_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_2_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_2_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_2_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_2_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_2_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_2_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_2_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_2_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_2_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_2_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_2_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_2_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_0_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_1_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_1_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_1_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_1_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_1_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_1_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_1_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_1_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_1_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_1_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_1_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_1_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_1_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_tsimrenamed_net_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_tsimrenamed_net_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_tsimcreated_xor_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_tsimcreated_xor_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_tsimcreated_xor_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_tsimcreated_xor_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_D2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_D2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_D2_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_D2_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_D2_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_D2_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_D2_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_D2_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_D2_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_D2_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_D2_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_D2_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_D2_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_D2_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_0_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_3_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_3_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_3_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_3_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_3_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_3_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_3_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_3_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_3_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_3_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_3_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_3_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_3_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_3_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_3_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_3_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_tsimrenamed_net_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_tsimrenamed_net_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_tsimrenamed_net_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_tsimrenamed_net_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_0_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_OpTx_FX_DC_49_D2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_3_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_3_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_3_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_4_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_4_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_4_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_5_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_5_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_5_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_tsimrenamed_net_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_tsimrenamed_net_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_tsimrenamed_net_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_tsimrenamed_net_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_tsimrenamed_net_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_tsimrenamed_net_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_PT_2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_PT_2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_PT_3_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_PT_3_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_PT_4_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_PT_4_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_PT_5_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_PT_5_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_tsimrenamed_net_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_tsimrenamed_net_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_tsimrenamed_net_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_tsimrenamed_net_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_tsimrenamed_net_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_tsimrenamed_net_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_0_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_0_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_1_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_1_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_1_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_1_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_1_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_1_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_1_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_1_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_1_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_1_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_1_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_1_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_1_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_2_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_2_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_2_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_2_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_2_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_2_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_2_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_2_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_2_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_2_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_2_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_2_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_3_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_3_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_3_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_3_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_3_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_3_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_3_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_3_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_3_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_3_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_3_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_3_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_3_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_3_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_3_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_3_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_4_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_4_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_4_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_4_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_4_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_4_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_4_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_4_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_4_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_4_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_4_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_4_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_4_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_4_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_4_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_PT_4_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_0_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_3_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_3_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_3_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_4_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_4_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_4_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_tsimrenamed_net_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_tsimrenamed_net_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_tsimrenamed_net_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_tsimrenamed_net_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_tsimrenamed_net_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_FC_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_FC_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_FC_0_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_FC_0_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_FC_0_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_FC_0_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_FC_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_FC_1_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_rom_OBUF_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_rom_OBUF_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_rom_OBUF_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_rom_OBUF_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_rom_OBUF_D2_PT_1_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_rom_OBUF_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_rom_OBUF_D2_PT_1_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_rom_OBUF_D2_PT_1_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_rom_OBUF_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_rom_OBUF_D2_PT_1_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_rom_OBUF_D2_PT_1_IN13 : STD_LOGIC; 
  signal NlwInverterSignal_rom_OBUF_D2_PT_1_IN14 : STD_LOGIC; 
  signal NlwInverterSignal_rom_OBUF_D2_PT_2_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_rom_OBUF_D2_PT_2_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_rom_OBUF_D2_PT_2_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_rom_OBUF_D2_PT_2_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_rom_OBUF_D2_PT_2_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_rom_OBUF_D2_PT_2_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_rom_OBUF_D2_PT_2_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_rom_OBUF_D2_PT_2_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_rom_OBUF_D2_PT_2_IN13 : STD_LOGIC; 
  signal NlwInverterSignal_rom_OBUF_D2_PT_2_IN14 : STD_LOGIC; 
  signal NlwInverterSignal_phi1_OBUF_D_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_phi1_OBUF_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_phi1_OBUF_D2_PT_2_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_phi1_OBUF_D2_PT_2_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_phi1_OBUF_D2_PT_3_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_phi1_OBUF_D2_PT_4_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_phi1_OBUF_D2_PT_4_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_phi1_OBUF_D2_PT_5_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_phi1_OBUF_D2_PT_5_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_cas0_OBUF_D2_PT_3_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_cas0_OBUF_D2_PT_4_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_cas0_OBUF_D2_PT_4_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_cas0_OBUF_D2_PT_5_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_cas0_OBUF_D2_PT_5_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_cas0_OBUF_D2_PT_6_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_cas0_OBUF_D2_PT_6_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_EXP_PT_0_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_EXP_PT_0_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_EXP_PT_0_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_EXP_PT_0_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_EXP_PT_0_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_EXP_PT_1_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_EXP_PT_1_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_EXP_PT_1_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_EXP_PT_1_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_EXP_PT_1_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_cas2_OBUF_D2_PT_2_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_cas2_OBUF_D2_PT_3_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_cas3_OBUF_D2_PT_2_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_cas3_OBUF_D2_PT_3_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_io0_OBUF_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_io0_OBUF_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_io0_OBUF_D2_PT_0_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_io0_OBUF_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_io0_OBUF_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_io0_OBUF_D2_PT_1_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_io0_OBUF_D2_PT_1_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_io0_OBUF_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_io0_OBUF_D2_PT_1_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_io1_OBUF_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_io1_OBUF_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_io1_OBUF_D2_PT_0_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_io1_OBUF_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_io1_OBUF_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_io1_OBUF_D2_PT_1_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_io1_OBUF_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_io1_OBUF_D2_PT_1_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_io2_OBUF_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_io2_OBUF_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_io2_OBUF_D2_PT_0_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_io2_OBUF_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_io2_OBUF_D2_PT_1_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_io2_OBUF_D2_PT_1_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_io2_OBUF_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_io2_OBUF_D2_PT_1_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_io3_OBUF_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_io3_OBUF_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_io3_OBUF_D2_PT_0_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_io3_OBUF_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_io3_OBUF_D2_PT_1_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_io3_OBUF_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_io3_OBUF_D2_PT_1_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_io4_OBUF_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_io4_OBUF_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_io4_OBUF_D2_PT_0_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_io4_OBUF_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_io4_OBUF_D2_PT_1_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_io4_OBUF_D2_PT_1_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_io4_OBUF_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_io4_OBUF_D2_PT_1_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_io5_OBUF_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_io5_OBUF_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_io5_OBUF_D2_PT_0_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_io5_OBUF_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_io5_OBUF_D2_PT_1_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_io5_OBUF_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_io5_OBUF_D2_PT_1_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_io6_OBUF_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_io6_OBUF_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_io6_OBUF_D2_PT_0_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_io6_OBUF_D2_PT_1_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_io6_OBUF_D2_PT_1_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_io6_OBUF_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_io6_OBUF_D2_PT_1_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_io7_OBUF_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_io7_OBUF_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_io7_OBUF_D2_PT_0_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_io7_OBUF_D2_PT_1_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_io7_OBUF_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_io7_OBUF_D2_PT_1_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_phi0_OBUF_D2_PT_2_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_phi0_OBUF_EXP_PT_0_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_phi0_OBUF_EXP_PT_0_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_phi0_OBUF_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_phi0_OBUF_EXP_PT_1_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_phi0_OBUF_EXP_PT_1_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_phi0_OBUF_EXP_PT_1_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_phi0_OBUF_EXP_PT_1_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_phi0_OBUF_EXP_PT_1_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_phi0_OBUF_EXP_PT_1_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_phi0_OBUF_EXP_PT_1_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_ras_OBUF_D_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_ras_OBUF_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_ras_OBUF_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_ras_OBUF_D2_PT_1_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_ras_OBUF_D2_PT_2_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_ras_OBUF_D2_PT_2_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_ras_OBUF_D2_PT_2_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_ras_OBUF_D2_PT_3_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_ras_OBUF_D2_PT_3_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_ras_OBUF_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_ras_OBUF_EXP_PT_1_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_ras_OBUF_EXP_PT_1_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_ras_OBUF_EXP_PT_1_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_ras_OBUF_EXP_PT_1_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_ras_OBUF_EXP_PT_1_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_ras_OBUF_EXP_PT_1_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_counter_2_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_counter_2_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_2_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_2_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_counter_0_D_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_counter_0_D2_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_counter_1_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_counter_1_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_counter_1_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_0_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_0_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_0_D2_PT_2_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_0_D2_PT_3_IN12 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_0_D2_PT_3_IN13 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_0_D2_PT_3_IN14 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_0_D2_PT_3_IN16 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_0_D2_PT_3_IN17 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_0_D2_PT_3_IN18 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_1_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_1_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_1_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_1_EXP_PT_0_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_1_EXP_PT_0_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_1_EXP_PT_1_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_1_EXP_PT_2_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_1_EXP_PT_2_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_1_EXP_PT_2_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_1_EXP_PT_2_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_1_EXP_PT_2_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_1_EXP_PT_2_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_1_EXP_PT_2_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_1_EXP_PT_2_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_0_D2_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_D_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_EXP_PT_0_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_EXP_PT_0_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_EXP_PT_1_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_EXP_PT_1_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_EXP_PT_1_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_EXP_PT_1_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_EXP_PT_1_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_EXP_PT_1_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_EXP_PT_1_IN9 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_EXP_PT_1_IN10 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_EXP_PT_1_IN11 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_EXP_PT_1_IN12 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_EXP_PT_1_IN13 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_2_D2_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_2_D2_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_2_D2_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_2_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_2_EXP_PT_3_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_3_D2_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_3_D2_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_3_D2_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_3_D2_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_3_EXP_PT_0_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_3_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_3_EXP_PT_3_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_D2_PT_1_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_D2_PT_1_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_D2_PT_2_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_D2_PT_2_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_D2_PT_2_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_D2_PT_2_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_D2_PT_2_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_EXP_PT_0_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_EXP_PT_1_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_EXP_PT_2_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_EXP_PT_2_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_EXP_PT_2_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_EXP_PT_2_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_EXP_PT_2_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_EXP_PT_2_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_EXP_PT_2_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_EXP_PT_2_IN9 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_D2_PT_0_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_D2_PT_0_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_D2_PT_0_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_D2_PT_0_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_D2_PT_1_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_D2_PT_1_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_D2_PT_1_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_D2_PT_2_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_D2_PT_2_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_D2_PT_2_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_D2_PT_2_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_D2_PT_2_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_D2_PT_2_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_EXP_PT_0_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_EXP_PT_0_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_EXP_PT_1_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_EXP_PT_1_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_EXP_PT_1_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_EXP_PT_1_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_EXP_PT_1_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_EXP_PT_1_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_EXP_PT_1_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_6_D2_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_6_D2_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_D2_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_D2_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_D2_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_D2_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_D2_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_D2_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_D2_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_D2_IN9 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_0_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_0_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_1_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_2_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_3_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_3_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_3_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_3_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_3_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_3_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_3_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_3_IN9 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_3_IN10 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_3_IN11 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_3_IN12 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_3_IN13 : STD_LOGIC; 
  signal NlwInverterSignal_OpTx_FX_DC_49_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_OpTx_FX_DC_49_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_OpTx_FX_DC_49_D2_PT_2_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_OpTx_FX_DC_49_D2_PT_2_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_OpTx_FX_DC_49_D2_PT_2_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_OpTx_FX_DC_49_D2_PT_2_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_OpTx_FX_DC_49_D2_PT_2_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_OpTx_FX_DC_49_D2_PT_2_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_OpTx_FX_DC_49_D2_PT_2_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_OpTx_FX_DC_49_D2_PT_2_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_EXP1_EXP_PT_2_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_EXP1_EXP_PT_3_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_EXP1_EXP_PT_5_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_0_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_0_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_0_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_1_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_1_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_1_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_1_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_1_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_1_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_1_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_1_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_1_IN9 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_2_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_2_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_2_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_2_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_2_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_2_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_2_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_2_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_2_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_2_IN9 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_3_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_3_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_3_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_3_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_3_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_3_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_3_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_3_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_3_IN9 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_4_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_4_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_4_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_4_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_4_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_4_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_4_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_4_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_4_IN9 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_PT_4_IN10 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_0_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_0_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_1_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_2_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_2_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_3_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_3_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_4_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_4_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_FC_0_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_FC_0_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_FC_0_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_FC_0_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_FC_0_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_FC_0_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_FC_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_FC_1_IN1 : STD_LOGIC; 
  signal counter : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal iocnt : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal refcnt : STD_LOGIC_VECTOR ( 7 downto 0 ); 
begin
  bank_7_IBUF : X_BUF
    port map (
      I => bank(7),
      O => bank_7_IBUF_1
    );
  bank_6_IBUF : X_BUF
    port map (
      I => bank(6),
      O => bank_6_IBUF_3
    );
  bank_5_IBUF : X_BUF
    port map (
      I => bank(5),
      O => bank_5_IBUF_5
    );
  bank_4_IBUF : X_BUF
    port map (
      I => bank(4),
      O => bank_4_IBUF_7
    );
  bank_3_IBUF : X_BUF
    port map (
      I => bank(3),
      O => bank_3_IBUF_9
    );
  bank_2_IBUF : X_BUF
    port map (
      I => bank(2),
      O => bank_2_IBUF_11
    );
  bank_1_IBUF : X_BUF
    port map (
      I => bank(1),
      O => bank_1_IBUF_13
    );
  bank_0_IBUF : X_BUF
    port map (
      I => bank(0),
      O => bank_0_IBUF_15
    );
  a12_11_1_IBUF : X_BUF
    port map (
      I => a12_11(1),
      O => a12_11_1_IBUF_17
    );
  a12_11_0_IBUF : X_BUF
    port map (
      I => a12_11(0),
      O => a12_11_0_IBUF_19
    );
  vda_IBUF : X_BUF
    port map (
      I => vda,
      O => vda_IBUF_21
    );
  a15_13_2_IBUF : X_BUF
    port map (
      I => a15_13(2),
      O => a15_13_2_IBUF_23
    );
  a15_13_1_IBUF : X_BUF
    port map (
      I => a15_13(1),
      O => a15_13_1_IBUF_25
    );
  a15_13_0_IBUF : X_BUF
    port map (
      I => a15_13(0),
      O => a15_13_0_IBUF_27
    );
  a10_IBUF : X_BUF
    port map (
      I => a10,
      O => a10_IBUF_29
    );
  FCLK_IO_0 : X_INV
    port map (
      I => clk,
      O => FCLK_IO_0_31
    );
  rw_IBUF : X_BUF
    port map (
      I => rw,
      O => rw_IBUF_33
    );
  vpa_IBUF : X_BUF
    port map (
      I => vpa,
      O => vpa_IBUF_35
    );
  rom_PIN_BUF_Q : X_BUF
    port map (
      I => rom,
      O => rom_PIN_BUF_Q_37
    );
  phi1_PIN_BUF_Q : X_BUF
    port map (
      I => phi1,
      O => phi1_PIN_BUF_Q_39
    );
  cas0_PIN_BUF_Q : X_BUF
    port map (
      I => cas0,
      O => cas0_PIN_BUF_Q_41
    );
  cas1_PIN_BUF_Q : X_BUF
    port map (
      I => cas1,
      O => cas1_PIN_BUF_Q_43
    );
  cas2_PIN_BUF_Q : X_BUF
    port map (
      I => cas2,
      O => cas2_PIN_BUF_Q_45
    );
  cas3_PIN_BUF_Q : X_BUF
    port map (
      I => cas3,
      O => cas3_PIN_BUF_Q_47
    );
  io0_PIN_BUF_Q : X_BUF
    port map (
      I => io0,
      O => io0_PIN_BUF_Q_49
    );
  io1_PIN_BUF_Q : X_BUF
    port map (
      I => io1,
      O => io1_PIN_BUF_Q_51
    );
  io2_PIN_BUF_Q : X_BUF
    port map (
      I => io2,
      O => io2_PIN_BUF_Q_53
    );
  io3_PIN_BUF_Q : X_BUF
    port map (
      I => io3,
      O => io3_PIN_BUF_Q_55
    );
  io4_PIN_BUF_Q : X_BUF
    port map (
      I => io4,
      O => io4_PIN_BUF_Q_57
    );
  io5_PIN_BUF_Q : X_BUF
    port map (
      I => io5,
      O => io5_PIN_BUF_Q_59
    );
  io6_PIN_BUF_Q : X_BUF
    port map (
      I => io6,
      O => io6_PIN_BUF_Q_61
    );
  io7_PIN_BUF_Q : X_BUF
    port map (
      I => io7,
      O => io7_PIN_BUF_Q_63
    );
  phi0_PIN_BUF_Q : X_BUF
    port map (
      I => phi0,
      O => phi0_PIN_BUF_Q_65
    );
  ras_PIN_BUF_Q : X_BUF
    port map (
      I => ras,
      O => ras_PIN_BUF_Q_67
    );
  rom_54 : X_BUF
    port map (
      I => rom_OBUF_Q_68,
      O => rom
    );
  phi1_56 : X_BUF
    port map (
      I => phi1_OBUF_Q_69,
      O => phi1
    );
  cas0_58 : X_BUF
    port map (
      I => cas0_OBUF_Q_70,
      O => cas0
    );
  cas1_60 : X_BUF
    port map (
      I => cas1_OBUF_Q_71,
      O => cas1
    );
  cas2_62 : X_BUF
    port map (
      I => cas2_OBUF_Q_72,
      O => cas2
    );
  cas3_64 : X_BUF
    port map (
      I => cas3_OBUF_Q_73,
      O => cas3
    );
  io0_66 : X_BUF
    port map (
      I => io0_OBUF_Q_74,
      O => io0
    );
  io1_68 : X_BUF
    port map (
      I => io1_OBUF_Q_75,
      O => io1
    );
  io2_70 : X_BUF
    port map (
      I => io2_OBUF_Q_76,
      O => io2
    );
  io3_72 : X_BUF
    port map (
      I => io3_OBUF_Q_77,
      O => io3
    );
  io4_74 : X_BUF
    port map (
      I => io4_OBUF_Q_78,
      O => io4
    );
  io5_76 : X_BUF
    port map (
      I => io5_OBUF_Q_79,
      O => io5
    );
  io6_78 : X_BUF
    port map (
      I => io6_OBUF_Q_80,
      O => io6
    );
  io7_80 : X_BUF
    port map (
      I => io7_OBUF_Q_81,
      O => io7
    );
  phi0_82 : X_BUF
    port map (
      I => phi0_OBUF_Q_82,
      O => phi0
    );
  ras_84 : X_BUF
    port map (
      I => ras_OBUF_Q_83,
      O => ras
    );
  rom_OBUF_Q : X_BUF
    port map (
      I => rom_OBUF_Q_84,
      O => rom_OBUF_Q_68
    );
  rom_OBUF_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_rom_OBUF_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_rom_OBUF_tsimcreated_xor_IN1,
      O => rom_OBUF_tsimcreated_xor_Q_86
    );
  rom_OBUF_REG : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NlwBufferSignal_rom_OBUF_REG_IN,
      CE => Vcc_88,
      CLK => NlwBufferSignal_rom_OBUF_REG_CLK,
      SET => Gnd_87,
      RST => Gnd_87,
      O => rom_OBUF_Q_84
    );
  Gnd : X_ZERO
    port map (
      O => Gnd_87
    );
  Vcc : X_ONE
    port map (
      O => Vcc_88
    );
  rom_OBUF_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_rom_OBUF_D_IN0,
      I1 => NlwBufferSignal_rom_OBUF_D_IN1,
      O => rom_OBUF_D_85
    );
  rom_OBUF_D1 : X_ZERO
    port map (
      O => rom_OBUF_D1_89
    );
  rom_OBUF_D2_PT_0 : X_AND4
    port map (
      I0 => NlwBufferSignal_rom_OBUF_D2_PT_0_IN0,
      I1 => NlwInverterSignal_rom_OBUF_D2_PT_0_IN1,
      I2 => NlwBufferSignal_rom_OBUF_D2_PT_0_IN2,
      I3 => NlwInverterSignal_rom_OBUF_D2_PT_0_IN3,
      O => rom_OBUF_D2_PT_0_94
    );
  rom_OBUF_D2_PT_1 : X_AND32
    port map (
      I0 => NlwInverterSignal_rom_OBUF_D2_PT_1_IN0,
      I1 => NlwInverterSignal_rom_OBUF_D2_PT_1_IN1,
      I2 => NlwInverterSignal_rom_OBUF_D2_PT_1_IN2,
      I3 => NlwInverterSignal_rom_OBUF_D2_PT_1_IN3,
      I4 => NlwInverterSignal_rom_OBUF_D2_PT_1_IN4,
      I5 => NlwInverterSignal_rom_OBUF_D2_PT_1_IN5,
      I6 => NlwInverterSignal_rom_OBUF_D2_PT_1_IN6,
      I7 => NlwInverterSignal_rom_OBUF_D2_PT_1_IN7,
      I8 => NlwBufferSignal_rom_OBUF_D2_PT_1_IN8,
      I9 => NlwBufferSignal_rom_OBUF_D2_PT_1_IN9,
      I10 => NlwBufferSignal_rom_OBUF_D2_PT_1_IN10,
      I11 => NlwBufferSignal_rom_OBUF_D2_PT_1_IN11,
      I12 => NlwBufferSignal_rom_OBUF_D2_PT_1_IN12,
      I13 => NlwInverterSignal_rom_OBUF_D2_PT_1_IN13,
      I14 => NlwInverterSignal_rom_OBUF_D2_PT_1_IN14,
      I15 => NlwBufferSignal_rom_OBUF_D2_PT_1_IN15,
      I16 => NlwBufferSignal_rom_OBUF_D2_PT_1_IN16,
      I17 => NlwBufferSignal_rom_OBUF_D2_PT_1_IN17,
      I18 => NlwBufferSignal_rom_OBUF_D2_PT_1_IN18,
      I19 => NlwBufferSignal_rom_OBUF_D2_PT_1_IN19,
      I20 => NlwBufferSignal_rom_OBUF_D2_PT_1_IN20,
      I21 => NlwBufferSignal_rom_OBUF_D2_PT_1_IN21,
      I22 => NlwBufferSignal_rom_OBUF_D2_PT_1_IN22,
      I23 => NlwBufferSignal_rom_OBUF_D2_PT_1_IN23,
      I24 => NlwBufferSignal_rom_OBUF_D2_PT_1_IN24,
      I25 => NlwBufferSignal_rom_OBUF_D2_PT_1_IN25,
      I26 => NlwBufferSignal_rom_OBUF_D2_PT_1_IN26,
      I27 => NlwBufferSignal_rom_OBUF_D2_PT_1_IN27,
      I28 => NlwBufferSignal_rom_OBUF_D2_PT_1_IN28,
      I29 => NlwBufferSignal_rom_OBUF_D2_PT_1_IN29,
      I30 => NlwBufferSignal_rom_OBUF_D2_PT_1_IN30,
      I31 => NlwBufferSignal_rom_OBUF_D2_PT_1_IN31,
      O => rom_OBUF_D2_PT_1_95
    );
  rom_OBUF_D2_PT_2 : X_AND32
    port map (
      I0 => NlwInverterSignal_rom_OBUF_D2_PT_2_IN0,
      I1 => NlwInverterSignal_rom_OBUF_D2_PT_2_IN1,
      I2 => NlwInverterSignal_rom_OBUF_D2_PT_2_IN2,
      I3 => NlwInverterSignal_rom_OBUF_D2_PT_2_IN3,
      I4 => NlwInverterSignal_rom_OBUF_D2_PT_2_IN4,
      I5 => NlwInverterSignal_rom_OBUF_D2_PT_2_IN5,
      I6 => NlwInverterSignal_rom_OBUF_D2_PT_2_IN6,
      I7 => NlwInverterSignal_rom_OBUF_D2_PT_2_IN7,
      I8 => NlwBufferSignal_rom_OBUF_D2_PT_2_IN8,
      I9 => NlwBufferSignal_rom_OBUF_D2_PT_2_IN9,
      I10 => NlwBufferSignal_rom_OBUF_D2_PT_2_IN10,
      I11 => NlwBufferSignal_rom_OBUF_D2_PT_2_IN11,
      I12 => NlwBufferSignal_rom_OBUF_D2_PT_2_IN12,
      I13 => NlwInverterSignal_rom_OBUF_D2_PT_2_IN13,
      I14 => NlwInverterSignal_rom_OBUF_D2_PT_2_IN14,
      I15 => NlwBufferSignal_rom_OBUF_D2_PT_2_IN15,
      I16 => NlwBufferSignal_rom_OBUF_D2_PT_2_IN16,
      I17 => NlwBufferSignal_rom_OBUF_D2_PT_2_IN17,
      I18 => NlwBufferSignal_rom_OBUF_D2_PT_2_IN18,
      I19 => NlwBufferSignal_rom_OBUF_D2_PT_2_IN19,
      I20 => NlwBufferSignal_rom_OBUF_D2_PT_2_IN20,
      I21 => NlwBufferSignal_rom_OBUF_D2_PT_2_IN21,
      I22 => NlwBufferSignal_rom_OBUF_D2_PT_2_IN22,
      I23 => NlwBufferSignal_rom_OBUF_D2_PT_2_IN23,
      I24 => NlwBufferSignal_rom_OBUF_D2_PT_2_IN24,
      I25 => NlwBufferSignal_rom_OBUF_D2_PT_2_IN25,
      I26 => NlwBufferSignal_rom_OBUF_D2_PT_2_IN26,
      I27 => NlwBufferSignal_rom_OBUF_D2_PT_2_IN27,
      I28 => NlwBufferSignal_rom_OBUF_D2_PT_2_IN28,
      I29 => NlwBufferSignal_rom_OBUF_D2_PT_2_IN29,
      I30 => NlwBufferSignal_rom_OBUF_D2_PT_2_IN30,
      I31 => NlwBufferSignal_rom_OBUF_D2_PT_2_IN31,
      O => rom_OBUF_D2_PT_2_96
    );
  rom_OBUF_D2 : X_OR3
    port map (
      I0 => NlwBufferSignal_rom_OBUF_D2_IN0,
      I1 => NlwBufferSignal_rom_OBUF_D2_IN1,
      I2 => NlwBufferSignal_rom_OBUF_D2_IN2,
      O => rom_OBUF_D2_90
    );
  phi1_OBUF_Q : X_BUF
    port map (
      I => phi1_OBUF_Q_97,
      O => phi1_OBUF_Q_69
    );
  phi1_OBUF_REG : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => NlwBufferSignal_phi1_OBUF_REG_IN,
      CE => Vcc_88,
      CLK => NlwBufferSignal_phi1_OBUF_REG_CLK,
      SET => Gnd_87,
      RST => Gnd_87,
      O => phi1_OBUF_Q_97
    );
  phi1_OBUF_D : X_XOR2
    port map (
      I0 => NlwInverterSignal_phi1_OBUF_D_IN0,
      I1 => NlwBufferSignal_phi1_OBUF_D_IN1,
      O => phi1_OBUF_D_98
    );
  phi1_OBUF_D1 : X_ZERO
    port map (
      O => phi1_OBUF_D1_99
    );
  phi1_OBUF_D2_PT_0 : X_AND2
    port map (
      I0 => NlwBufferSignal_phi1_OBUF_D2_PT_0_IN0,
      I1 => NlwBufferSignal_phi1_OBUF_D2_PT_0_IN1,
      O => phi1_OBUF_D2_PT_0_102
    );
  phi1_OBUF_D2_PT_1 : X_AND2
    port map (
      I0 => NlwBufferSignal_phi1_OBUF_D2_PT_1_IN0,
      I1 => NlwInverterSignal_phi1_OBUF_D2_PT_1_IN1,
      O => phi1_OBUF_D2_PT_1_103
    );
  phi1_OBUF_D2_PT_2 : X_AND2
    port map (
      I0 => NlwInverterSignal_phi1_OBUF_D2_PT_2_IN0,
      I1 => NlwInverterSignal_phi1_OBUF_D2_PT_2_IN1,
      O => phi1_OBUF_D2_PT_2_104
    );
  phi1_OBUF_D2_PT_3 : X_AND2
    port map (
      I0 => NlwBufferSignal_phi1_OBUF_D2_PT_3_IN0,
      I1 => NlwInverterSignal_phi1_OBUF_D2_PT_3_IN1,
      O => phi1_OBUF_D2_PT_3_106
    );
  phi1_OBUF_D2_PT_4 : X_AND3
    port map (
      I0 => NlwInverterSignal_phi1_OBUF_D2_PT_4_IN0,
      I1 => NlwInverterSignal_phi1_OBUF_D2_PT_4_IN1,
      I2 => NlwBufferSignal_phi1_OBUF_D2_PT_4_IN2,
      O => phi1_OBUF_D2_PT_4_107
    );
  phi1_OBUF_D2_PT_5 : X_AND3
    port map (
      I0 => NlwInverterSignal_phi1_OBUF_D2_PT_5_IN0,
      I1 => NlwBufferSignal_phi1_OBUF_D2_PT_5_IN1,
      I2 => NlwInverterSignal_phi1_OBUF_D2_PT_5_IN2,
      O => phi1_OBUF_D2_PT_5_110
    );
  phi1_OBUF_D2 : X_OR6
    port map (
      I0 => NlwBufferSignal_phi1_OBUF_D2_IN0,
      I1 => NlwBufferSignal_phi1_OBUF_D2_IN1,
      I2 => NlwBufferSignal_phi1_OBUF_D2_IN2,
      I3 => NlwBufferSignal_phi1_OBUF_D2_IN3,
      I4 => NlwBufferSignal_phi1_OBUF_D2_IN4,
      I5 => NlwBufferSignal_phi1_OBUF_D2_IN5,
      O => phi1_OBUF_D2_100
    );
  cas0_OBUF_Q : X_BUF
    port map (
      I => cas0_OBUF_Q_111,
      O => cas0_OBUF_Q_70
    );
  cas0_OBUF_REG : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NlwBufferSignal_cas0_OBUF_REG_IN,
      CE => Vcc_88,
      CLK => NlwBufferSignal_cas0_OBUF_REG_CLK,
      SET => Gnd_87,
      RST => Gnd_87,
      O => cas0_OBUF_Q_111
    );
  cas0_OBUF_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_cas0_OBUF_D_IN0,
      I1 => NlwBufferSignal_cas0_OBUF_D_IN1,
      O => cas0_OBUF_D_112
    );
  cas0_OBUF_D1 : X_ZERO
    port map (
      O => cas0_OBUF_D1_113
    );
  cas0_OBUF_D2_PT_0 : X_AND2
    port map (
      I0 => NlwBufferSignal_cas0_OBUF_D2_PT_0_IN0,
      I1 => NlwBufferSignal_cas0_OBUF_D2_PT_0_IN1,
      O => cas0_OBUF_D2_PT_0_116
    );
  cas0_OBUF_D2_PT_1 : X_AND2
    port map (
      I0 => NlwBufferSignal_cas0_OBUF_D2_PT_1_IN0,
      I1 => NlwBufferSignal_cas0_OBUF_D2_PT_1_IN1,
      O => cas0_OBUF_D2_PT_1_118
    );
  cas0_OBUF_D2_PT_2 : X_AND2
    port map (
      I0 => NlwBufferSignal_cas0_OBUF_D2_PT_2_IN0,
      I1 => NlwBufferSignal_cas0_OBUF_D2_PT_2_IN1,
      O => cas0_OBUF_D2_PT_2_119
    );
  cas0_OBUF_D2_PT_3 : X_AND2
    port map (
      I0 => NlwInverterSignal_cas0_OBUF_D2_PT_3_IN0,
      I1 => NlwBufferSignal_cas0_OBUF_D2_PT_3_IN1,
      O => cas0_OBUF_D2_PT_3_120
    );
  cas0_OBUF_D2_PT_4 : X_AND3
    port map (
      I0 => NlwInverterSignal_cas0_OBUF_D2_PT_4_IN0,
      I1 => NlwInverterSignal_cas0_OBUF_D2_PT_4_IN1,
      I2 => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN2,
      O => cas0_OBUF_D2_PT_4_122
    );
  cas0_OBUF_D2_PT_5 : X_AND3
    port map (
      I0 => NlwInverterSignal_cas0_OBUF_D2_PT_5_IN0,
      I1 => NlwInverterSignal_cas0_OBUF_D2_PT_5_IN1,
      I2 => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN2,
      O => cas0_OBUF_D2_PT_5_124
    );
  cas0_OBUF_D2_PT_6 : X_AND3
    port map (
      I0 => NlwInverterSignal_cas0_OBUF_D2_PT_6_IN0,
      I1 => NlwInverterSignal_cas0_OBUF_D2_PT_6_IN1,
      I2 => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN2,
      O => cas0_OBUF_D2_PT_6_126
    );
  cas0_OBUF_D2 : X_OR7
    port map (
      I0 => NlwBufferSignal_cas0_OBUF_D2_IN0,
      I1 => NlwBufferSignal_cas0_OBUF_D2_IN1,
      I2 => NlwBufferSignal_cas0_OBUF_D2_IN2,
      I3 => NlwBufferSignal_cas0_OBUF_D2_IN3,
      I4 => NlwBufferSignal_cas0_OBUF_D2_IN4,
      I5 => NlwBufferSignal_cas0_OBUF_D2_IN5,
      I6 => NlwBufferSignal_cas0_OBUF_D2_IN6,
      O => cas0_OBUF_D2_114
    );
  cas1_OBUF_Q : X_BUF
    port map (
      I => cas1_OBUF_Q_127,
      O => cas1_OBUF_Q_71
    );
  cas1_OBUF_EXP : X_BUF
    port map (
      I => cas1_OBUF_EXP_tsimrenamed_net_Q_128,
      O => cas1_OBUF_EXP_129
    );
  cas1_OBUF_REG : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NlwBufferSignal_cas1_OBUF_REG_IN,
      CE => Vcc_88,
      CLK => NlwBufferSignal_cas1_OBUF_REG_CLK,
      SET => Gnd_87,
      RST => Gnd_87,
      O => cas1_OBUF_Q_127
    );
  cas1_OBUF_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_cas1_OBUF_D_IN0,
      I1 => NlwBufferSignal_cas1_OBUF_D_IN1,
      O => cas1_OBUF_D_130
    );
  cas1_OBUF_D1 : X_ZERO
    port map (
      O => cas1_OBUF_D1_131
    );
  cas1_OBUF_D2_PT_0 : X_AND2
    port map (
      I0 => NlwBufferSignal_cas1_OBUF_D2_PT_0_IN0,
      I1 => NlwBufferSignal_cas1_OBUF_D2_PT_0_IN1,
      O => cas1_OBUF_D2_PT_0_134
    );
  cas1_OBUF_D2_PT_1 : X_AND2
    port map (
      I0 => NlwBufferSignal_cas1_OBUF_D2_PT_1_IN0,
      I1 => NlwBufferSignal_cas1_OBUF_D2_PT_1_IN1,
      O => cas1_OBUF_D2_PT_1_135
    );
  cas1_OBUF_D2_PT_2 : X_AND2
    port map (
      I0 => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN0,
      I1 => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN1,
      O => cas1_OBUF_D2_PT_2_136
    );
  cas1_OBUF_D2_PT_3 : X_AND2
    port map (
      I0 => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN0,
      I1 => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN1,
      O => cas1_OBUF_D2_PT_3_137
    );
  cas1_OBUF_D2 : X_OR4
    port map (
      I0 => NlwBufferSignal_cas1_OBUF_D2_IN0,
      I1 => NlwBufferSignal_cas1_OBUF_D2_IN1,
      I2 => NlwBufferSignal_cas1_OBUF_D2_IN2,
      I3 => NlwBufferSignal_cas1_OBUF_D2_IN3,
      O => cas1_OBUF_D2_132
    );
  cas1_OBUF_EXP_PT_0 : X_AND8
    port map (
      I0 => NlwBufferSignal_cas1_OBUF_EXP_PT_0_IN0,
      I1 => NlwInverterSignal_cas1_OBUF_EXP_PT_0_IN1,
      I2 => NlwBufferSignal_cas1_OBUF_EXP_PT_0_IN2,
      I3 => NlwInverterSignal_cas1_OBUF_EXP_PT_0_IN3,
      I4 => NlwInverterSignal_cas1_OBUF_EXP_PT_0_IN4,
      I5 => NlwInverterSignal_cas1_OBUF_EXP_PT_0_IN5,
      I6 => NlwInverterSignal_cas1_OBUF_EXP_PT_0_IN6,
      I7 => NlwBufferSignal_cas1_OBUF_EXP_PT_0_IN7,
      O => cas1_OBUF_EXP_PT_0_140
    );
  cas1_OBUF_EXP_PT_1 : X_AND8
    port map (
      I0 => NlwBufferSignal_cas1_OBUF_EXP_PT_1_IN0,
      I1 => NlwInverterSignal_cas1_OBUF_EXP_PT_1_IN1,
      I2 => NlwBufferSignal_cas1_OBUF_EXP_PT_1_IN2,
      I3 => NlwInverterSignal_cas1_OBUF_EXP_PT_1_IN3,
      I4 => NlwInverterSignal_cas1_OBUF_EXP_PT_1_IN4,
      I5 => NlwInverterSignal_cas1_OBUF_EXP_PT_1_IN5,
      I6 => NlwInverterSignal_cas1_OBUF_EXP_PT_1_IN6,
      I7 => NlwBufferSignal_cas1_OBUF_EXP_PT_1_IN7,
      O => cas1_OBUF_EXP_PT_1_142
    );
  cas1_OBUF_EXP_tsimrenamed_net_Q : X_OR2
    port map (
      I0 => NlwBufferSignal_cas1_OBUF_EXP_tsimrenamed_net_IN0,
      I1 => NlwBufferSignal_cas1_OBUF_EXP_tsimrenamed_net_IN1,
      O => cas1_OBUF_EXP_tsimrenamed_net_Q_128
    );
  cas2_OBUF_Q : X_BUF
    port map (
      I => cas2_OBUF_Q_143,
      O => cas2_OBUF_Q_72
    );
  cas2_OBUF_REG : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NlwBufferSignal_cas2_OBUF_REG_IN,
      CE => Vcc_88,
      CLK => NlwBufferSignal_cas2_OBUF_REG_CLK,
      SET => Gnd_87,
      RST => Gnd_87,
      O => cas2_OBUF_Q_143
    );
  cas2_OBUF_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_cas2_OBUF_D_IN0,
      I1 => NlwBufferSignal_cas2_OBUF_D_IN1,
      O => cas2_OBUF_D_144
    );
  cas2_OBUF_D1 : X_ZERO
    port map (
      O => cas2_OBUF_D1_145
    );
  cas2_OBUF_D2_PT_0 : X_AND2
    port map (
      I0 => NlwBufferSignal_cas2_OBUF_D2_PT_0_IN0,
      I1 => NlwBufferSignal_cas2_OBUF_D2_PT_0_IN1,
      O => cas2_OBUF_D2_PT_0_148
    );
  cas2_OBUF_D2_PT_1 : X_AND2
    port map (
      I0 => NlwBufferSignal_cas2_OBUF_D2_PT_1_IN0,
      I1 => NlwBufferSignal_cas2_OBUF_D2_PT_1_IN1,
      O => cas2_OBUF_D2_PT_1_150
    );
  cas2_OBUF_D2_PT_2 : X_AND2
    port map (
      I0 => NlwInverterSignal_cas2_OBUF_D2_PT_2_IN0,
      I1 => NlwBufferSignal_cas2_OBUF_D2_PT_2_IN1,
      O => cas2_OBUF_D2_PT_2_151
    );
  cas2_OBUF_D2_PT_3 : X_AND2
    port map (
      I0 => NlwInverterSignal_cas2_OBUF_D2_PT_3_IN0,
      I1 => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN1,
      O => cas2_OBUF_D2_PT_3_152
    );
  cas2_OBUF_D2_PT_4 : X_AND2
    port map (
      I0 => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN0,
      I1 => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN1,
      O => cas2_OBUF_D2_PT_4_153
    );
  cas2_OBUF_D2_PT_5 : X_AND2
    port map (
      I0 => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN0,
      I1 => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN1,
      O => cas2_OBUF_D2_PT_5_154
    );
  cas2_OBUF_D2_PT_6 : X_AND2
    port map (
      I0 => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN0,
      I1 => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN1,
      O => cas2_OBUF_D2_PT_6_155
    );
  cas2_OBUF_D2 : X_OR7
    port map (
      I0 => NlwBufferSignal_cas2_OBUF_D2_IN0,
      I1 => NlwBufferSignal_cas2_OBUF_D2_IN1,
      I2 => NlwBufferSignal_cas2_OBUF_D2_IN2,
      I3 => NlwBufferSignal_cas2_OBUF_D2_IN3,
      I4 => NlwBufferSignal_cas2_OBUF_D2_IN4,
      I5 => NlwBufferSignal_cas2_OBUF_D2_IN5,
      I6 => NlwBufferSignal_cas2_OBUF_D2_IN6,
      O => cas2_OBUF_D2_146
    );
  cas3_OBUF_Q : X_BUF
    port map (
      I => cas3_OBUF_Q_156,
      O => cas3_OBUF_Q_73
    );
  cas3_OBUF_REG : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NlwBufferSignal_cas3_OBUF_REG_IN,
      CE => Vcc_88,
      CLK => NlwBufferSignal_cas3_OBUF_REG_CLK,
      SET => Gnd_87,
      RST => Gnd_87,
      O => cas3_OBUF_Q_156
    );
  cas3_OBUF_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_cas3_OBUF_D_IN0,
      I1 => NlwBufferSignal_cas3_OBUF_D_IN1,
      O => cas3_OBUF_D_157
    );
  cas3_OBUF_D1 : X_ZERO
    port map (
      O => cas3_OBUF_D1_158
    );
  cas3_OBUF_D2_PT_0 : X_AND2
    port map (
      I0 => NlwBufferSignal_cas3_OBUF_D2_PT_0_IN0,
      I1 => NlwBufferSignal_cas3_OBUF_D2_PT_0_IN1,
      O => cas3_OBUF_D2_PT_0_161
    );
  cas3_OBUF_D2_PT_1 : X_AND2
    port map (
      I0 => NlwBufferSignal_cas3_OBUF_D2_PT_1_IN0,
      I1 => NlwBufferSignal_cas3_OBUF_D2_PT_1_IN1,
      O => cas3_OBUF_D2_PT_1_163
    );
  cas3_OBUF_D2_PT_2 : X_AND2
    port map (
      I0 => NlwInverterSignal_cas3_OBUF_D2_PT_2_IN0,
      I1 => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN1,
      O => cas3_OBUF_D2_PT_2_164
    );
  cas3_OBUF_D2_PT_3 : X_AND2
    port map (
      I0 => NlwInverterSignal_cas3_OBUF_D2_PT_3_IN0,
      I1 => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN1,
      O => cas3_OBUF_D2_PT_3_165
    );
  cas3_OBUF_D2_PT_4 : X_AND2
    port map (
      I0 => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN0,
      I1 => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN1,
      O => cas3_OBUF_D2_PT_4_166
    );
  cas3_OBUF_D2_PT_5 : X_AND2
    port map (
      I0 => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN0,
      I1 => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN1,
      O => cas3_OBUF_D2_PT_5_167
    );
  cas3_OBUF_D2_PT_6 : X_AND2
    port map (
      I0 => NlwBufferSignal_cas3_OBUF_D2_PT_6_IN0,
      I1 => NlwBufferSignal_cas3_OBUF_D2_PT_6_IN1,
      O => cas3_OBUF_D2_PT_6_168
    );
  cas3_OBUF_D2 : X_OR7
    port map (
      I0 => NlwBufferSignal_cas3_OBUF_D2_IN0,
      I1 => NlwBufferSignal_cas3_OBUF_D2_IN1,
      I2 => NlwBufferSignal_cas3_OBUF_D2_IN2,
      I3 => NlwBufferSignal_cas3_OBUF_D2_IN3,
      I4 => NlwBufferSignal_cas3_OBUF_D2_IN4,
      I5 => NlwBufferSignal_cas3_OBUF_D2_IN5,
      I6 => NlwBufferSignal_cas3_OBUF_D2_IN6,
      O => cas3_OBUF_D2_159
    );
  io0_OBUF_Q : X_BUF
    port map (
      I => io0_OBUF_Q_169,
      O => io0_OBUF_Q_74
    );
  io0_OBUF_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_io0_OBUF_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_io0_OBUF_tsimcreated_xor_IN1,
      O => io0_OBUF_tsimcreated_xor_Q_171
    );
  io0_OBUF_REG : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NlwBufferSignal_io0_OBUF_REG_IN,
      CE => Vcc_88,
      CLK => NlwBufferSignal_io0_OBUF_REG_CLK,
      SET => Gnd_87,
      RST => Gnd_87,
      O => io0_OBUF_Q_169
    );
  io0_OBUF_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_io0_OBUF_D_IN0,
      I1 => NlwBufferSignal_io0_OBUF_D_IN1,
      O => io0_OBUF_D_170
    );
  io0_OBUF_D1 : X_ZERO
    port map (
      O => io0_OBUF_D1_172
    );
  io0_OBUF_D2_PT_0 : X_AND7
    port map (
      I0 => NlwBufferSignal_io0_OBUF_D2_PT_0_IN0,
      I1 => NlwInverterSignal_io0_OBUF_D2_PT_0_IN1,
      I2 => NlwBufferSignal_io0_OBUF_D2_PT_0_IN2,
      I3 => NlwInverterSignal_io0_OBUF_D2_PT_0_IN3,
      I4 => NlwBufferSignal_io0_OBUF_D2_PT_0_IN4,
      I5 => NlwBufferSignal_io0_OBUF_D2_PT_0_IN5,
      I6 => NlwInverterSignal_io0_OBUF_D2_PT_0_IN6,
      O => io0_OBUF_D2_PT_0_174
    );
  io0_OBUF_D2_PT_1 : X_AND16
    port map (
      I0 => NlwInverterSignal_io0_OBUF_D2_PT_1_IN0,
      I1 => NlwInverterSignal_io0_OBUF_D2_PT_1_IN1,
      I2 => NlwInverterSignal_io0_OBUF_D2_PT_1_IN2,
      I3 => NlwBufferSignal_io0_OBUF_D2_PT_1_IN3,
      I4 => NlwInverterSignal_io0_OBUF_D2_PT_1_IN4,
      I5 => NlwBufferSignal_io0_OBUF_D2_PT_1_IN5,
      I6 => NlwInverterSignal_io0_OBUF_D2_PT_1_IN6,
      I7 => NlwInverterSignal_io0_OBUF_D2_PT_1_IN7,
      I8 => NlwBufferSignal_io0_OBUF_D2_PT_1_IN8,
      I9 => NlwBufferSignal_io0_OBUF_D2_PT_1_IN9,
      I10 => NlwBufferSignal_io0_OBUF_D2_PT_1_IN10,
      I11 => NlwBufferSignal_io0_OBUF_D2_PT_1_IN11,
      I12 => NlwBufferSignal_io0_OBUF_D2_PT_1_IN12,
      I13 => NlwBufferSignal_io0_OBUF_D2_PT_1_IN13,
      I14 => NlwBufferSignal_io0_OBUF_D2_PT_1_IN14,
      I15 => NlwBufferSignal_io0_OBUF_D2_PT_1_IN15,
      O => io0_OBUF_D2_PT_1_175
    );
  io0_OBUF_D2 : X_OR2
    port map (
      I0 => NlwBufferSignal_io0_OBUF_D2_IN0,
      I1 => NlwBufferSignal_io0_OBUF_D2_IN1,
      O => io0_OBUF_D2_173
    );
  io1_OBUF_Q : X_BUF
    port map (
      I => io1_OBUF_Q_176,
      O => io1_OBUF_Q_75
    );
  io1_OBUF_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_io1_OBUF_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_io1_OBUF_tsimcreated_xor_IN1,
      O => io1_OBUF_tsimcreated_xor_Q_178
    );
  io1_OBUF_REG : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NlwBufferSignal_io1_OBUF_REG_IN,
      CE => Vcc_88,
      CLK => NlwBufferSignal_io1_OBUF_REG_CLK,
      SET => Gnd_87,
      RST => Gnd_87,
      O => io1_OBUF_Q_176
    );
  io1_OBUF_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_io1_OBUF_D_IN0,
      I1 => NlwBufferSignal_io1_OBUF_D_IN1,
      O => io1_OBUF_D_177
    );
  io1_OBUF_D1 : X_ZERO
    port map (
      O => io1_OBUF_D1_179
    );
  io1_OBUF_D2_PT_0 : X_AND7
    port map (
      I0 => NlwBufferSignal_io1_OBUF_D2_PT_0_IN0,
      I1 => NlwInverterSignal_io1_OBUF_D2_PT_0_IN1,
      I2 => NlwBufferSignal_io1_OBUF_D2_PT_0_IN2,
      I3 => NlwInverterSignal_io1_OBUF_D2_PT_0_IN3,
      I4 => NlwBufferSignal_io1_OBUF_D2_PT_0_IN4,
      I5 => NlwBufferSignal_io1_OBUF_D2_PT_0_IN5,
      I6 => NlwInverterSignal_io1_OBUF_D2_PT_0_IN6,
      O => io1_OBUF_D2_PT_0_181
    );
  io1_OBUF_D2_PT_1 : X_AND16
    port map (
      I0 => NlwInverterSignal_io1_OBUF_D2_PT_1_IN0,
      I1 => NlwInverterSignal_io1_OBUF_D2_PT_1_IN1,
      I2 => NlwBufferSignal_io1_OBUF_D2_PT_1_IN2,
      I3 => NlwBufferSignal_io1_OBUF_D2_PT_1_IN3,
      I4 => NlwInverterSignal_io1_OBUF_D2_PT_1_IN4,
      I5 => NlwBufferSignal_io1_OBUF_D2_PT_1_IN5,
      I6 => NlwInverterSignal_io1_OBUF_D2_PT_1_IN6,
      I7 => NlwInverterSignal_io1_OBUF_D2_PT_1_IN7,
      I8 => NlwBufferSignal_io1_OBUF_D2_PT_1_IN8,
      I9 => NlwBufferSignal_io1_OBUF_D2_PT_1_IN9,
      I10 => NlwBufferSignal_io1_OBUF_D2_PT_1_IN10,
      I11 => NlwBufferSignal_io1_OBUF_D2_PT_1_IN11,
      I12 => NlwBufferSignal_io1_OBUF_D2_PT_1_IN12,
      I13 => NlwBufferSignal_io1_OBUF_D2_PT_1_IN13,
      I14 => NlwBufferSignal_io1_OBUF_D2_PT_1_IN14,
      I15 => NlwBufferSignal_io1_OBUF_D2_PT_1_IN15,
      O => io1_OBUF_D2_PT_1_182
    );
  io1_OBUF_D2 : X_OR2
    port map (
      I0 => NlwBufferSignal_io1_OBUF_D2_IN0,
      I1 => NlwBufferSignal_io1_OBUF_D2_IN1,
      O => io1_OBUF_D2_180
    );
  io2_OBUF_Q : X_BUF
    port map (
      I => io2_OBUF_Q_183,
      O => io2_OBUF_Q_76
    );
  io2_OBUF_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_io2_OBUF_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_io2_OBUF_tsimcreated_xor_IN1,
      O => io2_OBUF_tsimcreated_xor_Q_185
    );
  io2_OBUF_REG : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NlwBufferSignal_io2_OBUF_REG_IN,
      CE => Vcc_88,
      CLK => NlwBufferSignal_io2_OBUF_REG_CLK,
      SET => Gnd_87,
      RST => Gnd_87,
      O => io2_OBUF_Q_183
    );
  io2_OBUF_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_io2_OBUF_D_IN0,
      I1 => NlwBufferSignal_io2_OBUF_D_IN1,
      O => io2_OBUF_D_184
    );
  io2_OBUF_D1 : X_ZERO
    port map (
      O => io2_OBUF_D1_186
    );
  io2_OBUF_D2_PT_0 : X_AND7
    port map (
      I0 => NlwBufferSignal_io2_OBUF_D2_PT_0_IN0,
      I1 => NlwInverterSignal_io2_OBUF_D2_PT_0_IN1,
      I2 => NlwBufferSignal_io2_OBUF_D2_PT_0_IN2,
      I3 => NlwInverterSignal_io2_OBUF_D2_PT_0_IN3,
      I4 => NlwBufferSignal_io2_OBUF_D2_PT_0_IN4,
      I5 => NlwBufferSignal_io2_OBUF_D2_PT_0_IN5,
      I6 => NlwInverterSignal_io2_OBUF_D2_PT_0_IN6,
      O => io2_OBUF_D2_PT_0_188
    );
  io2_OBUF_D2_PT_1 : X_AND16
    port map (
      I0 => NlwInverterSignal_io2_OBUF_D2_PT_1_IN0,
      I1 => NlwBufferSignal_io2_OBUF_D2_PT_1_IN1,
      I2 => NlwInverterSignal_io2_OBUF_D2_PT_1_IN2,
      I3 => NlwBufferSignal_io2_OBUF_D2_PT_1_IN3,
      I4 => NlwInverterSignal_io2_OBUF_D2_PT_1_IN4,
      I5 => NlwBufferSignal_io2_OBUF_D2_PT_1_IN5,
      I6 => NlwInverterSignal_io2_OBUF_D2_PT_1_IN6,
      I7 => NlwInverterSignal_io2_OBUF_D2_PT_1_IN7,
      I8 => NlwBufferSignal_io2_OBUF_D2_PT_1_IN8,
      I9 => NlwBufferSignal_io2_OBUF_D2_PT_1_IN9,
      I10 => NlwBufferSignal_io2_OBUF_D2_PT_1_IN10,
      I11 => NlwBufferSignal_io2_OBUF_D2_PT_1_IN11,
      I12 => NlwBufferSignal_io2_OBUF_D2_PT_1_IN12,
      I13 => NlwBufferSignal_io2_OBUF_D2_PT_1_IN13,
      I14 => NlwBufferSignal_io2_OBUF_D2_PT_1_IN14,
      I15 => NlwBufferSignal_io2_OBUF_D2_PT_1_IN15,
      O => io2_OBUF_D2_PT_1_189
    );
  io2_OBUF_D2 : X_OR2
    port map (
      I0 => NlwBufferSignal_io2_OBUF_D2_IN0,
      I1 => NlwBufferSignal_io2_OBUF_D2_IN1,
      O => io2_OBUF_D2_187
    );
  io3_OBUF_Q : X_BUF
    port map (
      I => io3_OBUF_Q_190,
      O => io3_OBUF_Q_77
    );
  io3_OBUF_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_io3_OBUF_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_io3_OBUF_tsimcreated_xor_IN1,
      O => io3_OBUF_tsimcreated_xor_Q_192
    );
  io3_OBUF_REG : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NlwBufferSignal_io3_OBUF_REG_IN,
      CE => Vcc_88,
      CLK => NlwBufferSignal_io3_OBUF_REG_CLK,
      SET => Gnd_87,
      RST => Gnd_87,
      O => io3_OBUF_Q_190
    );
  io3_OBUF_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_io3_OBUF_D_IN0,
      I1 => NlwBufferSignal_io3_OBUF_D_IN1,
      O => io3_OBUF_D_191
    );
  io3_OBUF_D1 : X_ZERO
    port map (
      O => io3_OBUF_D1_193
    );
  io3_OBUF_D2_PT_0 : X_AND7
    port map (
      I0 => NlwBufferSignal_io3_OBUF_D2_PT_0_IN0,
      I1 => NlwInverterSignal_io3_OBUF_D2_PT_0_IN1,
      I2 => NlwBufferSignal_io3_OBUF_D2_PT_0_IN2,
      I3 => NlwInverterSignal_io3_OBUF_D2_PT_0_IN3,
      I4 => NlwBufferSignal_io3_OBUF_D2_PT_0_IN4,
      I5 => NlwBufferSignal_io3_OBUF_D2_PT_0_IN5,
      I6 => NlwInverterSignal_io3_OBUF_D2_PT_0_IN6,
      O => io3_OBUF_D2_PT_0_195
    );
  io3_OBUF_D2_PT_1 : X_AND16
    port map (
      I0 => NlwInverterSignal_io3_OBUF_D2_PT_1_IN0,
      I1 => NlwBufferSignal_io3_OBUF_D2_PT_1_IN1,
      I2 => NlwBufferSignal_io3_OBUF_D2_PT_1_IN2,
      I3 => NlwBufferSignal_io3_OBUF_D2_PT_1_IN3,
      I4 => NlwInverterSignal_io3_OBUF_D2_PT_1_IN4,
      I5 => NlwBufferSignal_io3_OBUF_D2_PT_1_IN5,
      I6 => NlwInverterSignal_io3_OBUF_D2_PT_1_IN6,
      I7 => NlwInverterSignal_io3_OBUF_D2_PT_1_IN7,
      I8 => NlwBufferSignal_io3_OBUF_D2_PT_1_IN8,
      I9 => NlwBufferSignal_io3_OBUF_D2_PT_1_IN9,
      I10 => NlwBufferSignal_io3_OBUF_D2_PT_1_IN10,
      I11 => NlwBufferSignal_io3_OBUF_D2_PT_1_IN11,
      I12 => NlwBufferSignal_io3_OBUF_D2_PT_1_IN12,
      I13 => NlwBufferSignal_io3_OBUF_D2_PT_1_IN13,
      I14 => NlwBufferSignal_io3_OBUF_D2_PT_1_IN14,
      I15 => NlwBufferSignal_io3_OBUF_D2_PT_1_IN15,
      O => io3_OBUF_D2_PT_1_196
    );
  io3_OBUF_D2 : X_OR2
    port map (
      I0 => NlwBufferSignal_io3_OBUF_D2_IN0,
      I1 => NlwBufferSignal_io3_OBUF_D2_IN1,
      O => io3_OBUF_D2_194
    );
  io4_OBUF_Q : X_BUF
    port map (
      I => io4_OBUF_Q_197,
      O => io4_OBUF_Q_78
    );
  io4_OBUF_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_io4_OBUF_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_io4_OBUF_tsimcreated_xor_IN1,
      O => io4_OBUF_tsimcreated_xor_Q_199
    );
  io4_OBUF_REG : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NlwBufferSignal_io4_OBUF_REG_IN,
      CE => Vcc_88,
      CLK => NlwBufferSignal_io4_OBUF_REG_CLK,
      SET => Gnd_87,
      RST => Gnd_87,
      O => io4_OBUF_Q_197
    );
  io4_OBUF_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_io4_OBUF_D_IN0,
      I1 => NlwBufferSignal_io4_OBUF_D_IN1,
      O => io4_OBUF_D_198
    );
  io4_OBUF_D1 : X_ZERO
    port map (
      O => io4_OBUF_D1_200
    );
  io4_OBUF_D2_PT_0 : X_AND7
    port map (
      I0 => NlwBufferSignal_io4_OBUF_D2_PT_0_IN0,
      I1 => NlwInverterSignal_io4_OBUF_D2_PT_0_IN1,
      I2 => NlwBufferSignal_io4_OBUF_D2_PT_0_IN2,
      I3 => NlwInverterSignal_io4_OBUF_D2_PT_0_IN3,
      I4 => NlwBufferSignal_io4_OBUF_D2_PT_0_IN4,
      I5 => NlwBufferSignal_io4_OBUF_D2_PT_0_IN5,
      I6 => NlwInverterSignal_io4_OBUF_D2_PT_0_IN6,
      O => io4_OBUF_D2_PT_0_202
    );
  io4_OBUF_D2_PT_1 : X_AND16
    port map (
      I0 => NlwBufferSignal_io4_OBUF_D2_PT_1_IN0,
      I1 => NlwInverterSignal_io4_OBUF_D2_PT_1_IN1,
      I2 => NlwInverterSignal_io4_OBUF_D2_PT_1_IN2,
      I3 => NlwBufferSignal_io4_OBUF_D2_PT_1_IN3,
      I4 => NlwInverterSignal_io4_OBUF_D2_PT_1_IN4,
      I5 => NlwBufferSignal_io4_OBUF_D2_PT_1_IN5,
      I6 => NlwInverterSignal_io4_OBUF_D2_PT_1_IN6,
      I7 => NlwInverterSignal_io4_OBUF_D2_PT_1_IN7,
      I8 => NlwBufferSignal_io4_OBUF_D2_PT_1_IN8,
      I9 => NlwBufferSignal_io4_OBUF_D2_PT_1_IN9,
      I10 => NlwBufferSignal_io4_OBUF_D2_PT_1_IN10,
      I11 => NlwBufferSignal_io4_OBUF_D2_PT_1_IN11,
      I12 => NlwBufferSignal_io4_OBUF_D2_PT_1_IN12,
      I13 => NlwBufferSignal_io4_OBUF_D2_PT_1_IN13,
      I14 => NlwBufferSignal_io4_OBUF_D2_PT_1_IN14,
      I15 => NlwBufferSignal_io4_OBUF_D2_PT_1_IN15,
      O => io4_OBUF_D2_PT_1_203
    );
  io4_OBUF_D2 : X_OR2
    port map (
      I0 => NlwBufferSignal_io4_OBUF_D2_IN0,
      I1 => NlwBufferSignal_io4_OBUF_D2_IN1,
      O => io4_OBUF_D2_201
    );
  io5_OBUF_Q : X_BUF
    port map (
      I => io5_OBUF_Q_204,
      O => io5_OBUF_Q_79
    );
  io5_OBUF_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_io5_OBUF_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_io5_OBUF_tsimcreated_xor_IN1,
      O => io5_OBUF_tsimcreated_xor_Q_206
    );
  io5_OBUF_REG : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NlwBufferSignal_io5_OBUF_REG_IN,
      CE => Vcc_88,
      CLK => NlwBufferSignal_io5_OBUF_REG_CLK,
      SET => Gnd_87,
      RST => Gnd_87,
      O => io5_OBUF_Q_204
    );
  io5_OBUF_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_io5_OBUF_D_IN0,
      I1 => NlwBufferSignal_io5_OBUF_D_IN1,
      O => io5_OBUF_D_205
    );
  io5_OBUF_D1 : X_ZERO
    port map (
      O => io5_OBUF_D1_207
    );
  io5_OBUF_D2_PT_0 : X_AND7
    port map (
      I0 => NlwBufferSignal_io5_OBUF_D2_PT_0_IN0,
      I1 => NlwInverterSignal_io5_OBUF_D2_PT_0_IN1,
      I2 => NlwBufferSignal_io5_OBUF_D2_PT_0_IN2,
      I3 => NlwInverterSignal_io5_OBUF_D2_PT_0_IN3,
      I4 => NlwBufferSignal_io5_OBUF_D2_PT_0_IN4,
      I5 => NlwBufferSignal_io5_OBUF_D2_PT_0_IN5,
      I6 => NlwInverterSignal_io5_OBUF_D2_PT_0_IN6,
      O => io5_OBUF_D2_PT_0_209
    );
  io5_OBUF_D2_PT_1 : X_AND16
    port map (
      I0 => NlwBufferSignal_io5_OBUF_D2_PT_1_IN0,
      I1 => NlwInverterSignal_io5_OBUF_D2_PT_1_IN1,
      I2 => NlwBufferSignal_io5_OBUF_D2_PT_1_IN2,
      I3 => NlwBufferSignal_io5_OBUF_D2_PT_1_IN3,
      I4 => NlwInverterSignal_io5_OBUF_D2_PT_1_IN4,
      I5 => NlwBufferSignal_io5_OBUF_D2_PT_1_IN5,
      I6 => NlwInverterSignal_io5_OBUF_D2_PT_1_IN6,
      I7 => NlwInverterSignal_io5_OBUF_D2_PT_1_IN7,
      I8 => NlwBufferSignal_io5_OBUF_D2_PT_1_IN8,
      I9 => NlwBufferSignal_io5_OBUF_D2_PT_1_IN9,
      I10 => NlwBufferSignal_io5_OBUF_D2_PT_1_IN10,
      I11 => NlwBufferSignal_io5_OBUF_D2_PT_1_IN11,
      I12 => NlwBufferSignal_io5_OBUF_D2_PT_1_IN12,
      I13 => NlwBufferSignal_io5_OBUF_D2_PT_1_IN13,
      I14 => NlwBufferSignal_io5_OBUF_D2_PT_1_IN14,
      I15 => NlwBufferSignal_io5_OBUF_D2_PT_1_IN15,
      O => io5_OBUF_D2_PT_1_210
    );
  io5_OBUF_D2 : X_OR2
    port map (
      I0 => NlwBufferSignal_io5_OBUF_D2_IN0,
      I1 => NlwBufferSignal_io5_OBUF_D2_IN1,
      O => io5_OBUF_D2_208
    );
  io6_OBUF_Q : X_BUF
    port map (
      I => io6_OBUF_Q_211,
      O => io6_OBUF_Q_80
    );
  io6_OBUF_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_io6_OBUF_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_io6_OBUF_tsimcreated_xor_IN1,
      O => io6_OBUF_tsimcreated_xor_Q_213
    );
  io6_OBUF_REG : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NlwBufferSignal_io6_OBUF_REG_IN,
      CE => Vcc_88,
      CLK => NlwBufferSignal_io6_OBUF_REG_CLK,
      SET => Gnd_87,
      RST => Gnd_87,
      O => io6_OBUF_Q_211
    );
  io6_OBUF_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_io6_OBUF_D_IN0,
      I1 => NlwBufferSignal_io6_OBUF_D_IN1,
      O => io6_OBUF_D_212
    );
  io6_OBUF_D1 : X_ZERO
    port map (
      O => io6_OBUF_D1_214
    );
  io6_OBUF_D2_PT_0 : X_AND7
    port map (
      I0 => NlwBufferSignal_io6_OBUF_D2_PT_0_IN0,
      I1 => NlwInverterSignal_io6_OBUF_D2_PT_0_IN1,
      I2 => NlwBufferSignal_io6_OBUF_D2_PT_0_IN2,
      I3 => NlwInverterSignal_io6_OBUF_D2_PT_0_IN3,
      I4 => NlwBufferSignal_io6_OBUF_D2_PT_0_IN4,
      I5 => NlwBufferSignal_io6_OBUF_D2_PT_0_IN5,
      I6 => NlwInverterSignal_io6_OBUF_D2_PT_0_IN6,
      O => io6_OBUF_D2_PT_0_216
    );
  io6_OBUF_D2_PT_1 : X_AND16
    port map (
      I0 => NlwBufferSignal_io6_OBUF_D2_PT_1_IN0,
      I1 => NlwBufferSignal_io6_OBUF_D2_PT_1_IN1,
      I2 => NlwInverterSignal_io6_OBUF_D2_PT_1_IN2,
      I3 => NlwBufferSignal_io6_OBUF_D2_PT_1_IN3,
      I4 => NlwInverterSignal_io6_OBUF_D2_PT_1_IN4,
      I5 => NlwBufferSignal_io6_OBUF_D2_PT_1_IN5,
      I6 => NlwInverterSignal_io6_OBUF_D2_PT_1_IN6,
      I7 => NlwInverterSignal_io6_OBUF_D2_PT_1_IN7,
      I8 => NlwBufferSignal_io6_OBUF_D2_PT_1_IN8,
      I9 => NlwBufferSignal_io6_OBUF_D2_PT_1_IN9,
      I10 => NlwBufferSignal_io6_OBUF_D2_PT_1_IN10,
      I11 => NlwBufferSignal_io6_OBUF_D2_PT_1_IN11,
      I12 => NlwBufferSignal_io6_OBUF_D2_PT_1_IN12,
      I13 => NlwBufferSignal_io6_OBUF_D2_PT_1_IN13,
      I14 => NlwBufferSignal_io6_OBUF_D2_PT_1_IN14,
      I15 => NlwBufferSignal_io6_OBUF_D2_PT_1_IN15,
      O => io6_OBUF_D2_PT_1_217
    );
  io6_OBUF_D2 : X_OR2
    port map (
      I0 => NlwBufferSignal_io6_OBUF_D2_IN0,
      I1 => NlwBufferSignal_io6_OBUF_D2_IN1,
      O => io6_OBUF_D2_215
    );
  io7_OBUF_Q : X_BUF
    port map (
      I => io7_OBUF_Q_218,
      O => io7_OBUF_Q_81
    );
  io7_OBUF_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_io7_OBUF_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_io7_OBUF_tsimcreated_xor_IN1,
      O => io7_OBUF_tsimcreated_xor_Q_220
    );
  io7_OBUF_REG : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NlwBufferSignal_io7_OBUF_REG_IN,
      CE => Vcc_88,
      CLK => NlwBufferSignal_io7_OBUF_REG_CLK,
      SET => Gnd_87,
      RST => Gnd_87,
      O => io7_OBUF_Q_218
    );
  io7_OBUF_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_io7_OBUF_D_IN0,
      I1 => NlwBufferSignal_io7_OBUF_D_IN1,
      O => io7_OBUF_D_219
    );
  io7_OBUF_D1 : X_ZERO
    port map (
      O => io7_OBUF_D1_221
    );
  io7_OBUF_D2_PT_0 : X_AND7
    port map (
      I0 => NlwBufferSignal_io7_OBUF_D2_PT_0_IN0,
      I1 => NlwInverterSignal_io7_OBUF_D2_PT_0_IN1,
      I2 => NlwBufferSignal_io7_OBUF_D2_PT_0_IN2,
      I3 => NlwInverterSignal_io7_OBUF_D2_PT_0_IN3,
      I4 => NlwBufferSignal_io7_OBUF_D2_PT_0_IN4,
      I5 => NlwBufferSignal_io7_OBUF_D2_PT_0_IN5,
      I6 => NlwInverterSignal_io7_OBUF_D2_PT_0_IN6,
      O => io7_OBUF_D2_PT_0_223
    );
  io7_OBUF_D2_PT_1 : X_AND16
    port map (
      I0 => NlwBufferSignal_io7_OBUF_D2_PT_1_IN0,
      I1 => NlwBufferSignal_io7_OBUF_D2_PT_1_IN1,
      I2 => NlwBufferSignal_io7_OBUF_D2_PT_1_IN2,
      I3 => NlwBufferSignal_io7_OBUF_D2_PT_1_IN3,
      I4 => NlwInverterSignal_io7_OBUF_D2_PT_1_IN4,
      I5 => NlwBufferSignal_io7_OBUF_D2_PT_1_IN5,
      I6 => NlwInverterSignal_io7_OBUF_D2_PT_1_IN6,
      I7 => NlwInverterSignal_io7_OBUF_D2_PT_1_IN7,
      I8 => NlwBufferSignal_io7_OBUF_D2_PT_1_IN8,
      I9 => NlwBufferSignal_io7_OBUF_D2_PT_1_IN9,
      I10 => NlwBufferSignal_io7_OBUF_D2_PT_1_IN10,
      I11 => NlwBufferSignal_io7_OBUF_D2_PT_1_IN11,
      I12 => NlwBufferSignal_io7_OBUF_D2_PT_1_IN12,
      I13 => NlwBufferSignal_io7_OBUF_D2_PT_1_IN13,
      I14 => NlwBufferSignal_io7_OBUF_D2_PT_1_IN14,
      I15 => NlwBufferSignal_io7_OBUF_D2_PT_1_IN15,
      O => io7_OBUF_D2_PT_1_224
    );
  io7_OBUF_D2 : X_OR2
    port map (
      I0 => NlwBufferSignal_io7_OBUF_D2_IN0,
      I1 => NlwBufferSignal_io7_OBUF_D2_IN1,
      O => io7_OBUF_D2_222
    );
  phi0_OBUF_Q : X_BUF
    port map (
      I => phi0_OBUF_Q_225,
      O => phi0_OBUF_Q_82
    );
  phi0_OBUF_EXP : X_BUF
    port map (
      I => phi0_OBUF_EXP_tsimrenamed_net_Q_226,
      O => phi0_OBUF_EXP_162
    );
  phi0_OBUF_REG : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NlwBufferSignal_phi0_OBUF_REG_IN,
      CE => Vcc_88,
      CLK => NlwBufferSignal_phi0_OBUF_REG_CLK,
      SET => Gnd_87,
      RST => Gnd_87,
      O => phi0_OBUF_Q_225
    );
  phi0_OBUF_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_phi0_OBUF_D_IN0,
      I1 => NlwBufferSignal_phi0_OBUF_D_IN1,
      O => phi0_OBUF_D_227
    );
  phi0_OBUF_D1 : X_ZERO
    port map (
      O => phi0_OBUF_D1_228
    );
  phi0_OBUF_D2_PT_0 : X_AND2
    port map (
      I0 => NlwBufferSignal_phi0_OBUF_D2_PT_0_IN0,
      I1 => NlwBufferSignal_phi0_OBUF_D2_PT_0_IN1,
      O => phi0_OBUF_D2_PT_0_231
    );
  phi0_OBUF_D2_PT_1 : X_AND2
    port map (
      I0 => NlwBufferSignal_phi0_OBUF_D2_PT_1_IN0,
      I1 => NlwBufferSignal_phi0_OBUF_D2_PT_1_IN1,
      O => phi0_OBUF_D2_PT_1_232
    );
  phi0_OBUF_D2_PT_2 : X_AND2
    port map (
      I0 => NlwInverterSignal_phi0_OBUF_D2_PT_2_IN0,
      I1 => NlwBufferSignal_phi0_OBUF_D2_PT_2_IN1,
      O => phi0_OBUF_D2_PT_2_233
    );
  phi0_OBUF_D2_PT_3 : X_AND2
    port map (
      I0 => NlwBufferSignal_phi0_OBUF_D2_PT_3_IN0,
      I1 => NlwBufferSignal_phi0_OBUF_D2_PT_3_IN1,
      O => phi0_OBUF_D2_PT_3_234
    );
  phi0_OBUF_D2 : X_OR4
    port map (
      I0 => NlwBufferSignal_phi0_OBUF_D2_IN0,
      I1 => NlwBufferSignal_phi0_OBUF_D2_IN1,
      I2 => NlwBufferSignal_phi0_OBUF_D2_IN2,
      I3 => NlwBufferSignal_phi0_OBUF_D2_IN3,
      O => phi0_OBUF_D2_229
    );
  phi0_OBUF_EXP_PT_0 : X_AND3
    port map (
      I0 => NlwInverterSignal_phi0_OBUF_EXP_PT_0_IN0,
      I1 => NlwInverterSignal_phi0_OBUF_EXP_PT_0_IN1,
      I2 => NlwBufferSignal_phi0_OBUF_EXP_PT_0_IN2,
      O => phi0_OBUF_EXP_PT_0_235
    );
  phi0_OBUF_EXP_PT_1 : X_AND16
    port map (
      I0 => NlwInverterSignal_phi0_OBUF_EXP_PT_1_IN0,
      I1 => NlwInverterSignal_phi0_OBUF_EXP_PT_1_IN1,
      I2 => NlwInverterSignal_phi0_OBUF_EXP_PT_1_IN2,
      I3 => NlwInverterSignal_phi0_OBUF_EXP_PT_1_IN3,
      I4 => NlwInverterSignal_phi0_OBUF_EXP_PT_1_IN4,
      I5 => NlwInverterSignal_phi0_OBUF_EXP_PT_1_IN5,
      I6 => NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN6,
      I7 => NlwInverterSignal_phi0_OBUF_EXP_PT_1_IN7,
      I8 => NlwInverterSignal_phi0_OBUF_EXP_PT_1_IN8,
      I9 => NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN9,
      I10 => NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN10,
      I11 => NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN11,
      I12 => NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN12,
      I13 => NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN13,
      I14 => NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN14,
      I15 => NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN15,
      O => phi0_OBUF_EXP_PT_1_238
    );
  phi0_OBUF_EXP_tsimrenamed_net_Q : X_OR2
    port map (
      I0 => NlwBufferSignal_phi0_OBUF_EXP_tsimrenamed_net_IN0,
      I1 => NlwBufferSignal_phi0_OBUF_EXP_tsimrenamed_net_IN1,
      O => phi0_OBUF_EXP_tsimrenamed_net_Q_226
    );
  ras_OBUF_Q : X_BUF
    port map (
      I => ras_OBUF_Q_239,
      O => ras_OBUF_Q_83
    );
  ras_OBUF_EXP : X_BUF
    port map (
      I => ras_OBUF_EXP_tsimrenamed_net_Q_240,
      O => ras_OBUF_EXP_241
    );
  ras_OBUF_REG : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NlwBufferSignal_ras_OBUF_REG_IN,
      CE => Vcc_88,
      CLK => NlwBufferSignal_ras_OBUF_REG_CLK,
      SET => Gnd_87,
      RST => Gnd_87,
      O => ras_OBUF_Q_239
    );
  ras_OBUF_D : X_XOR2
    port map (
      I0 => NlwInverterSignal_ras_OBUF_D_IN0,
      I1 => NlwBufferSignal_ras_OBUF_D_IN1,
      O => ras_OBUF_D_242
    );
  ras_OBUF_D1 : X_ZERO
    port map (
      O => ras_OBUF_D1_243
    );
  ras_OBUF_D2_PT_0 : X_AND2
    port map (
      I0 => NlwBufferSignal_ras_OBUF_D2_PT_0_IN0,
      I1 => NlwBufferSignal_ras_OBUF_D2_PT_0_IN1,
      O => ras_OBUF_D2_PT_0_246
    );
  ras_OBUF_D2_PT_1 : X_AND3
    port map (
      I0 => NlwInverterSignal_ras_OBUF_D2_PT_1_IN0,
      I1 => NlwInverterSignal_ras_OBUF_D2_PT_1_IN1,
      I2 => NlwInverterSignal_ras_OBUF_D2_PT_1_IN2,
      O => ras_OBUF_D2_PT_1_248
    );
  ras_OBUF_D2_PT_2 : X_AND3
    port map (
      I0 => NlwInverterSignal_ras_OBUF_D2_PT_2_IN0,
      I1 => NlwInverterSignal_ras_OBUF_D2_PT_2_IN1,
      I2 => NlwInverterSignal_ras_OBUF_D2_PT_2_IN2,
      O => ras_OBUF_D2_PT_2_249
    );
  ras_OBUF_D2_PT_3 : X_AND3
    port map (
      I0 => NlwBufferSignal_ras_OBUF_D2_PT_3_IN0,
      I1 => NlwInverterSignal_ras_OBUF_D2_PT_3_IN1,
      I2 => NlwInverterSignal_ras_OBUF_D2_PT_3_IN2,
      O => ras_OBUF_D2_PT_3_250
    );
  ras_OBUF_D2 : X_OR4
    port map (
      I0 => NlwBufferSignal_ras_OBUF_D2_IN0,
      I1 => NlwBufferSignal_ras_OBUF_D2_IN1,
      I2 => NlwBufferSignal_ras_OBUF_D2_IN2,
      I3 => NlwBufferSignal_ras_OBUF_D2_IN3,
      O => ras_OBUF_D2_244
    );
  ras_OBUF_EXP_PT_0 : X_AND2
    port map (
      I0 => NlwBufferSignal_ras_OBUF_EXP_PT_0_IN0,
      I1 => NlwBufferSignal_ras_OBUF_EXP_PT_0_IN1,
      O => ras_OBUF_EXP_PT_0_251
    );
  ras_OBUF_EXP_PT_1 : X_AND7
    port map (
      I0 => NlwInverterSignal_ras_OBUF_EXP_PT_1_IN0,
      I1 => NlwInverterSignal_ras_OBUF_EXP_PT_1_IN1,
      I2 => NlwInverterSignal_ras_OBUF_EXP_PT_1_IN2,
      I3 => NlwInverterSignal_ras_OBUF_EXP_PT_1_IN3,
      I4 => NlwInverterSignal_ras_OBUF_EXP_PT_1_IN4,
      I5 => NlwInverterSignal_ras_OBUF_EXP_PT_1_IN5,
      I6 => NlwInverterSignal_ras_OBUF_EXP_PT_1_IN6,
      O => ras_OBUF_EXP_PT_1_252
    );
  ras_OBUF_EXP_tsimrenamed_net_Q : X_OR2
    port map (
      I0 => NlwBufferSignal_ras_OBUF_EXP_tsimrenamed_net_IN0,
      I1 => NlwBufferSignal_ras_OBUF_EXP_tsimrenamed_net_IN1,
      O => ras_OBUF_EXP_tsimrenamed_net_Q_240
    );
  counter_2_Q : X_BUF
    port map (
      I => counter_2_Q_253,
      O => counter(2)
    );
  counter_2_REG : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => NlwBufferSignal_counter_2_REG_IN,
      CE => Vcc_88,
      CLK => NlwBufferSignal_counter_2_REG_CLK,
      SET => Gnd_87,
      RST => Gnd_87,
      O => counter_2_Q_253
    );
  counter_2_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_counter_2_D_IN0,
      I1 => NlwBufferSignal_counter_2_D_IN1,
      O => counter_2_D_254
    );
  counter_2_D1 : X_ZERO
    port map (
      O => counter_2_D1_255
    );
  counter_2_D2_PT_0 : X_AND2
    port map (
      I0 => NlwBufferSignal_counter_2_D2_PT_0_IN0,
      I1 => NlwInverterSignal_counter_2_D2_PT_0_IN1,
      O => counter_2_D2_PT_0_257
    );
  counter_2_D2_PT_1 : X_AND3
    port map (
      I0 => NlwInverterSignal_counter_2_D2_PT_1_IN0,
      I1 => NlwBufferSignal_counter_2_D2_PT_1_IN1,
      I2 => NlwBufferSignal_counter_2_D2_PT_1_IN2,
      O => counter_2_D2_PT_1_258
    );
  counter_2_D2 : X_OR2
    port map (
      I0 => NlwBufferSignal_counter_2_D2_IN0,
      I1 => NlwBufferSignal_counter_2_D2_IN1,
      O => counter_2_D2_256
    );
  iocnt_2_Q : X_BUF
    port map (
      I => iocnt_2_Q_259,
      O => iocnt(2)
    );
  iocnt_2_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_iocnt_2_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_iocnt_2_tsimcreated_xor_IN1,
      O => iocnt_2_tsimcreated_xor_Q_261
    );
  iocnt_2_REG : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => NlwBufferSignal_iocnt_2_REG_IN,
      CE => Vcc_88,
      CLK => NlwBufferSignal_iocnt_2_REG_CLK,
      SET => Gnd_87,
      RST => Gnd_87,
      O => iocnt_2_Q_259
    );
  iocnt_2_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_iocnt_2_D_IN0,
      I1 => NlwBufferSignal_iocnt_2_D_IN1,
      O => iocnt_2_D_260
    );
  iocnt_2_D1 : X_ZERO
    port map (
      O => iocnt_2_D1_262
    );
  iocnt_2_D2_PT_0 : X_AND5
    port map (
      I0 => NlwBufferSignal_iocnt_2_D2_PT_0_IN0,
      I1 => NlwInverterSignal_iocnt_2_D2_PT_0_IN1,
      I2 => NlwBufferSignal_iocnt_2_D2_PT_0_IN2,
      I3 => NlwBufferSignal_iocnt_2_D2_PT_0_IN3,
      I4 => NlwBufferSignal_iocnt_2_D2_PT_0_IN4,
      O => iocnt_2_D2_PT_0_264
    );
  iocnt_2_D2_PT_1 : X_AND5
    port map (
      I0 => NlwBufferSignal_iocnt_2_D2_PT_1_IN0,
      I1 => NlwInverterSignal_iocnt_2_D2_PT_1_IN1,
      I2 => NlwBufferSignal_iocnt_2_D2_PT_1_IN2,
      I3 => NlwBufferSignal_iocnt_2_D2_PT_1_IN3,
      I4 => NlwBufferSignal_iocnt_2_D2_PT_1_IN4,
      O => iocnt_2_D2_PT_1_265
    );
  iocnt_2_D2 : X_OR2
    port map (
      I0 => NlwBufferSignal_iocnt_2_D2_IN0,
      I1 => NlwBufferSignal_iocnt_2_D2_IN1,
      O => iocnt_2_D2_263
    );
  counter_0_Q : X_BUF
    port map (
      I => counter_0_Q_266,
      O => counter(0)
    );
  counter_0_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_counter_0_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_counter_0_tsimcreated_xor_IN1,
      O => counter_0_tsimcreated_xor_Q_268
    );
  counter_0_REG : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => NlwBufferSignal_counter_0_REG_IN,
      CE => Vcc_88,
      CLK => NlwBufferSignal_counter_0_REG_CLK,
      SET => Gnd_87,
      RST => Gnd_87,
      O => counter_0_Q_266
    );
  counter_0_D : X_XOR2
    port map (
      I0 => NlwInverterSignal_counter_0_D_IN0,
      I1 => NlwBufferSignal_counter_0_D_IN1,
      O => counter_0_D_267
    );
  counter_0_D1 : X_ZERO
    port map (
      O => counter_0_D1_269
    );
  counter_0_D2 : X_AND3
    port map (
      I0 => NlwBufferSignal_counter_0_D2_IN0,
      I1 => NlwInverterSignal_counter_0_D2_IN1,
      I2 => NlwBufferSignal_counter_0_D2_IN2,
      O => counter_0_D2_270
    );
  counter_1_Q : X_BUF
    port map (
      I => counter_1_Q_271,
      O => counter(1)
    );
  counter_1_REG : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => NlwBufferSignal_counter_1_REG_IN,
      CE => Vcc_88,
      CLK => NlwBufferSignal_counter_1_REG_CLK,
      SET => Gnd_87,
      RST => Gnd_87,
      O => counter_1_Q_271
    );
  counter_1_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_counter_1_D_IN0,
      I1 => NlwBufferSignal_counter_1_D_IN1,
      O => counter_1_D_272
    );
  counter_1_D1 : X_ZERO
    port map (
      O => counter_1_D1_273
    );
  counter_1_D2_PT_0 : X_AND2
    port map (
      I0 => NlwBufferSignal_counter_1_D2_PT_0_IN0,
      I1 => NlwInverterSignal_counter_1_D2_PT_0_IN1,
      O => counter_1_D2_PT_0_275
    );
  counter_1_D2_PT_1 : X_AND3
    port map (
      I0 => NlwInverterSignal_counter_1_D2_PT_1_IN0,
      I1 => NlwInverterSignal_counter_1_D2_PT_1_IN1,
      I2 => NlwBufferSignal_counter_1_D2_PT_1_IN2,
      O => counter_1_D2_PT_1_276
    );
  counter_1_D2 : X_OR2
    port map (
      I0 => NlwBufferSignal_counter_1_D2_IN0,
      I1 => NlwBufferSignal_counter_1_D2_IN1,
      O => counter_1_D2_274
    );
  iocnt_0_Q : X_BUF
    port map (
      I => iocnt_0_Q_277,
      O => iocnt(0)
    );
  iocnt_0_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_iocnt_0_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_iocnt_0_tsimcreated_xor_IN1,
      O => iocnt_0_tsimcreated_xor_Q_279
    );
  iocnt_0_REG : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => NlwBufferSignal_iocnt_0_REG_IN,
      CE => Vcc_88,
      CLK => NlwBufferSignal_iocnt_0_REG_CLK,
      SET => Gnd_87,
      RST => Gnd_87,
      O => iocnt_0_Q_277
    );
  iocnt_0_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_iocnt_0_D_IN0,
      I1 => NlwBufferSignal_iocnt_0_D_IN1,
      O => iocnt_0_D_278
    );
  iocnt_0_D1 : X_ZERO
    port map (
      O => iocnt_0_D1_280
    );
  iocnt_0_D2_PT_0 : X_AND4
    port map (
      I0 => NlwBufferSignal_iocnt_0_D2_PT_0_IN0,
      I1 => NlwInverterSignal_iocnt_0_D2_PT_0_IN1,
      I2 => NlwBufferSignal_iocnt_0_D2_PT_0_IN2,
      I3 => NlwBufferSignal_iocnt_0_D2_PT_0_IN3,
      O => iocnt_0_D2_PT_0_282
    );
  iocnt_0_D2_PT_1 : X_AND4
    port map (
      I0 => NlwBufferSignal_iocnt_0_D2_PT_1_IN0,
      I1 => NlwInverterSignal_iocnt_0_D2_PT_1_IN1,
      I2 => NlwBufferSignal_iocnt_0_D2_PT_1_IN2,
      I3 => NlwBufferSignal_iocnt_0_D2_PT_1_IN3,
      O => iocnt_0_D2_PT_1_283
    );
  iocnt_0_D2_PT_2 : X_AND4
    port map (
      I0 => NlwBufferSignal_iocnt_0_D2_PT_2_IN0,
      I1 => NlwInverterSignal_iocnt_0_D2_PT_2_IN1,
      I2 => NlwBufferSignal_iocnt_0_D2_PT_2_IN2,
      I3 => NlwBufferSignal_iocnt_0_D2_PT_2_IN3,
      O => iocnt_0_D2_PT_2_284
    );
  iocnt_0_D2_PT_3 : X_AND32
    port map (
      I0 => NlwBufferSignal_iocnt_0_D2_PT_3_IN0,
      I1 => NlwBufferSignal_iocnt_0_D2_PT_3_IN1,
      I2 => NlwBufferSignal_iocnt_0_D2_PT_3_IN2,
      I3 => NlwBufferSignal_iocnt_0_D2_PT_3_IN3,
      I4 => NlwBufferSignal_iocnt_0_D2_PT_3_IN4,
      I5 => NlwBufferSignal_iocnt_0_D2_PT_3_IN5,
      I6 => NlwBufferSignal_iocnt_0_D2_PT_3_IN6,
      I7 => NlwBufferSignal_iocnt_0_D2_PT_3_IN7,
      I8 => NlwBufferSignal_iocnt_0_D2_PT_3_IN8,
      I9 => NlwBufferSignal_iocnt_0_D2_PT_3_IN9,
      I10 => NlwBufferSignal_iocnt_0_D2_PT_3_IN10,
      I11 => NlwBufferSignal_iocnt_0_D2_PT_3_IN11,
      I12 => NlwInverterSignal_iocnt_0_D2_PT_3_IN12,
      I13 => NlwInverterSignal_iocnt_0_D2_PT_3_IN13,
      I14 => NlwInverterSignal_iocnt_0_D2_PT_3_IN14,
      I15 => NlwBufferSignal_iocnt_0_D2_PT_3_IN15,
      I16 => NlwInverterSignal_iocnt_0_D2_PT_3_IN16,
      I17 => NlwInverterSignal_iocnt_0_D2_PT_3_IN17,
      I18 => NlwInverterSignal_iocnt_0_D2_PT_3_IN18,
      I19 => NlwBufferSignal_iocnt_0_D2_PT_3_IN19,
      I20 => NlwBufferSignal_iocnt_0_D2_PT_3_IN20,
      I21 => NlwBufferSignal_iocnt_0_D2_PT_3_IN21,
      I22 => NlwBufferSignal_iocnt_0_D2_PT_3_IN22,
      I23 => NlwBufferSignal_iocnt_0_D2_PT_3_IN23,
      I24 => NlwBufferSignal_iocnt_0_D2_PT_3_IN24,
      I25 => NlwBufferSignal_iocnt_0_D2_PT_3_IN25,
      I26 => NlwBufferSignal_iocnt_0_D2_PT_3_IN26,
      I27 => NlwBufferSignal_iocnt_0_D2_PT_3_IN27,
      I28 => NlwBufferSignal_iocnt_0_D2_PT_3_IN28,
      I29 => NlwBufferSignal_iocnt_0_D2_PT_3_IN29,
      I30 => NlwBufferSignal_iocnt_0_D2_PT_3_IN30,
      I31 => NlwBufferSignal_iocnt_0_D2_PT_3_IN31,
      O => iocnt_0_D2_PT_3_285
    );
  iocnt_0_D2 : X_OR4
    port map (
      I0 => NlwBufferSignal_iocnt_0_D2_IN0,
      I1 => NlwBufferSignal_iocnt_0_D2_IN1,
      I2 => NlwBufferSignal_iocnt_0_D2_IN2,
      I3 => NlwBufferSignal_iocnt_0_D2_IN3,
      O => iocnt_0_D2_281
    );
  iocnt_1_Q : X_BUF
    port map (
      I => iocnt_1_Q_286,
      O => iocnt(1)
    );
  iocnt_1_EXP : X_BUF
    port map (
      I => iocnt_1_EXP_tsimrenamed_net_Q_287,
      O => iocnt_1_EXP_288
    );
  iocnt_1_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_iocnt_1_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_iocnt_1_tsimcreated_xor_IN1,
      O => iocnt_1_tsimcreated_xor_Q_290
    );
  iocnt_1_REG : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => NlwBufferSignal_iocnt_1_REG_IN,
      CE => Vcc_88,
      CLK => NlwBufferSignal_iocnt_1_REG_CLK,
      SET => Gnd_87,
      RST => Gnd_87,
      O => iocnt_1_Q_286
    );
  iocnt_1_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_iocnt_1_D_IN0,
      I1 => NlwBufferSignal_iocnt_1_D_IN1,
      O => iocnt_1_D_289
    );
  iocnt_1_D1 : X_ZERO
    port map (
      O => iocnt_1_D1_291
    );
  iocnt_1_D2_PT_0 : X_AND5
    port map (
      I0 => NlwBufferSignal_iocnt_1_D2_PT_0_IN0,
      I1 => NlwInverterSignal_iocnt_1_D2_PT_0_IN1,
      I2 => NlwBufferSignal_iocnt_1_D2_PT_0_IN2,
      I3 => NlwBufferSignal_iocnt_1_D2_PT_0_IN3,
      I4 => NlwBufferSignal_iocnt_1_D2_PT_0_IN4,
      O => iocnt_1_D2_PT_0_293
    );
  iocnt_1_D2_PT_1 : X_AND5
    port map (
      I0 => NlwBufferSignal_iocnt_1_D2_PT_1_IN0,
      I1 => NlwInverterSignal_iocnt_1_D2_PT_1_IN1,
      I2 => NlwBufferSignal_iocnt_1_D2_PT_1_IN2,
      I3 => NlwInverterSignal_iocnt_1_D2_PT_1_IN3,
      I4 => NlwBufferSignal_iocnt_1_D2_PT_1_IN4,
      O => iocnt_1_D2_PT_1_294
    );
  iocnt_1_D2 : X_OR2
    port map (
      I0 => NlwBufferSignal_iocnt_1_D2_IN0,
      I1 => NlwBufferSignal_iocnt_1_D2_IN1,
      O => iocnt_1_D2_292
    );
  iocnt_1_EXP_PT_0 : X_AND3
    port map (
      I0 => NlwInverterSignal_iocnt_1_EXP_PT_0_IN0,
      I1 => NlwInverterSignal_iocnt_1_EXP_PT_0_IN1,
      I2 => NlwBufferSignal_iocnt_1_EXP_PT_0_IN2,
      O => iocnt_1_EXP_PT_0_295
    );
  iocnt_1_EXP_PT_1 : X_AND3
    port map (
      I0 => NlwBufferSignal_iocnt_1_EXP_PT_1_IN0,
      I1 => NlwInverterSignal_iocnt_1_EXP_PT_1_IN1,
      I2 => NlwBufferSignal_iocnt_1_EXP_PT_1_IN2,
      O => iocnt_1_EXP_PT_1_296
    );
  iocnt_1_EXP_PT_2 : X_AND16
    port map (
      I0 => NlwInverterSignal_iocnt_1_EXP_PT_2_IN0,
      I1 => NlwInverterSignal_iocnt_1_EXP_PT_2_IN1,
      I2 => NlwInverterSignal_iocnt_1_EXP_PT_2_IN2,
      I3 => NlwInverterSignal_iocnt_1_EXP_PT_2_IN3,
      I4 => NlwInverterSignal_iocnt_1_EXP_PT_2_IN4,
      I5 => NlwInverterSignal_iocnt_1_EXP_PT_2_IN5,
      I6 => NlwBufferSignal_iocnt_1_EXP_PT_2_IN6,
      I7 => NlwInverterSignal_iocnt_1_EXP_PT_2_IN7,
      I8 => NlwInverterSignal_iocnt_1_EXP_PT_2_IN8,
      I9 => NlwBufferSignal_iocnt_1_EXP_PT_2_IN9,
      I10 => NlwBufferSignal_iocnt_1_EXP_PT_2_IN10,
      I11 => NlwBufferSignal_iocnt_1_EXP_PT_2_IN11,
      I12 => NlwBufferSignal_iocnt_1_EXP_PT_2_IN12,
      I13 => NlwBufferSignal_iocnt_1_EXP_PT_2_IN13,
      I14 => NlwBufferSignal_iocnt_1_EXP_PT_2_IN14,
      I15 => NlwBufferSignal_iocnt_1_EXP_PT_2_IN15,
      O => iocnt_1_EXP_PT_2_297
    );
  iocnt_1_EXP_tsimrenamed_net_Q : X_OR3
    port map (
      I0 => NlwBufferSignal_iocnt_1_EXP_tsimrenamed_net_IN0,
      I1 => NlwBufferSignal_iocnt_1_EXP_tsimrenamed_net_IN1,
      I2 => NlwBufferSignal_iocnt_1_EXP_tsimrenamed_net_IN2,
      O => iocnt_1_EXP_tsimrenamed_net_Q_287
    );
  refcnt_0_Q : X_BUF
    port map (
      I => refcnt_0_Q_298,
      O => refcnt(0)
    );
  refcnt_0_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_refcnt_0_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_refcnt_0_tsimcreated_xor_IN1,
      O => refcnt_0_tsimcreated_xor_Q_300
    );
  refcnt_0_REG : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => NlwBufferSignal_refcnt_0_REG_IN,
      CE => Vcc_88,
      CLK => NlwBufferSignal_refcnt_0_REG_CLK,
      SET => Gnd_87,
      RST => Gnd_87,
      O => refcnt_0_Q_298
    );
  refcnt_0_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_refcnt_0_D_IN0,
      I1 => NlwBufferSignal_refcnt_0_D_IN1,
      O => refcnt_0_D_299
    );
  refcnt_0_D1 : X_ZERO
    port map (
      O => refcnt_0_D1_301
    );
  refcnt_0_D2 : X_AND3
    port map (
      I0 => NlwBufferSignal_refcnt_0_D2_IN0,
      I1 => NlwInverterSignal_refcnt_0_D2_IN1,
      I2 => NlwBufferSignal_refcnt_0_D2_IN2,
      O => refcnt_0_D2_302
    );
  refcnt_1_Q : X_BUF
    port map (
      I => refcnt_1_Q_303,
      O => refcnt(1)
    );
  refcnt_1_EXP : X_BUF
    port map (
      I => refcnt_1_EXP_tsimrenamed_net_Q_304,
      O => refcnt_1_EXP_101
    );
  refcnt_1_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_refcnt_1_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_refcnt_1_tsimcreated_xor_IN1,
      O => refcnt_1_tsimcreated_xor_Q_306
    );
  refcnt_1_REG : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => NlwBufferSignal_refcnt_1_REG_IN,
      CE => Vcc_88,
      CLK => NlwBufferSignal_refcnt_1_REG_CLK,
      SET => Gnd_87,
      RST => Gnd_87,
      O => refcnt_1_Q_303
    );
  refcnt_1_D : X_XOR2
    port map (
      I0 => NlwInverterSignal_refcnt_1_D_IN0,
      I1 => NlwBufferSignal_refcnt_1_D_IN1,
      O => refcnt_1_D_305
    );
  refcnt_1_D1 : X_ZERO
    port map (
      O => refcnt_1_D1_307
    );
  refcnt_1_D2_PT_0 : X_AND2
    port map (
      I0 => NlwInverterSignal_refcnt_1_D2_PT_0_IN0,
      I1 => NlwInverterSignal_refcnt_1_D2_PT_0_IN1,
      O => refcnt_1_D2_PT_0_309
    );
  refcnt_1_D2_PT_1 : X_AND2
    port map (
      I0 => NlwInverterSignal_refcnt_1_D2_PT_1_IN0,
      I1 => NlwInverterSignal_refcnt_1_D2_PT_1_IN1,
      O => refcnt_1_D2_PT_1_310
    );
  refcnt_1_D2_PT_2 : X_AND2
    port map (
      I0 => NlwBufferSignal_refcnt_1_D2_PT_2_IN0,
      I1 => NlwBufferSignal_refcnt_1_D2_PT_2_IN1,
      O => refcnt_1_D2_PT_2_311
    );
  refcnt_1_D2_PT_3 : X_AND2
    port map (
      I0 => NlwBufferSignal_refcnt_1_D2_PT_3_IN0,
      I1 => NlwBufferSignal_refcnt_1_D2_PT_3_IN1,
      O => refcnt_1_D2_PT_3_312
    );
  refcnt_1_D2 : X_OR4
    port map (
      I0 => NlwBufferSignal_refcnt_1_D2_IN0,
      I1 => NlwBufferSignal_refcnt_1_D2_IN1,
      I2 => NlwBufferSignal_refcnt_1_D2_IN2,
      I3 => NlwBufferSignal_refcnt_1_D2_IN3,
      O => refcnt_1_D2_308
    );
  refcnt_1_EXP_PT_0 : X_AND3
    port map (
      I0 => NlwBufferSignal_refcnt_1_EXP_PT_0_IN0,
      I1 => NlwInverterSignal_refcnt_1_EXP_PT_0_IN1,
      I2 => NlwInverterSignal_refcnt_1_EXP_PT_0_IN2,
      O => refcnt_1_EXP_PT_0_313
    );
  refcnt_1_EXP_PT_1 : X_AND16
    port map (
      I0 => NlwInverterSignal_refcnt_1_EXP_PT_1_IN0,
      I1 => NlwBufferSignal_refcnt_1_EXP_PT_1_IN1,
      I2 => NlwBufferSignal_refcnt_1_EXP_PT_1_IN2,
      I3 => NlwInverterSignal_refcnt_1_EXP_PT_1_IN3,
      I4 => NlwInverterSignal_refcnt_1_EXP_PT_1_IN4,
      I5 => NlwInverterSignal_refcnt_1_EXP_PT_1_IN5,
      I6 => NlwInverterSignal_refcnt_1_EXP_PT_1_IN6,
      I7 => NlwInverterSignal_refcnt_1_EXP_PT_1_IN7,
      I8 => NlwInverterSignal_refcnt_1_EXP_PT_1_IN8,
      I9 => NlwInverterSignal_refcnt_1_EXP_PT_1_IN9,
      I10 => NlwInverterSignal_refcnt_1_EXP_PT_1_IN10,
      I11 => NlwInverterSignal_refcnt_1_EXP_PT_1_IN11,
      I12 => NlwInverterSignal_refcnt_1_EXP_PT_1_IN12,
      I13 => NlwInverterSignal_refcnt_1_EXP_PT_1_IN13,
      I14 => NlwBufferSignal_refcnt_1_EXP_PT_1_IN14,
      I15 => NlwBufferSignal_refcnt_1_EXP_PT_1_IN15,
      O => refcnt_1_EXP_PT_1_314
    );
  refcnt_1_EXP_tsimrenamed_net_Q : X_OR2
    port map (
      I0 => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN0,
      I1 => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN1,
      O => refcnt_1_EXP_tsimrenamed_net_Q_304
    );
  refcnt_2_Q : X_BUF
    port map (
      I => refcnt_2_Q_315,
      O => refcnt(2)
    );
  refcnt_2_EXP : X_BUF
    port map (
      I => refcnt_2_EXP_tsimrenamed_net_Q_316,
      O => refcnt_2_EXP_147
    );
  refcnt_2_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_refcnt_2_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_refcnt_2_tsimcreated_xor_IN1,
      O => refcnt_2_tsimcreated_xor_Q_318
    );
  refcnt_2_REG : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NlwBufferSignal_refcnt_2_REG_IN,
      CE => Vcc_88,
      CLK => NlwBufferSignal_refcnt_2_REG_CLK,
      SET => Gnd_87,
      RST => Gnd_87,
      O => refcnt_2_Q_315
    );
  refcnt_2_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_refcnt_2_D_IN0,
      I1 => NlwBufferSignal_refcnt_2_D_IN1,
      O => refcnt_2_D_317
    );
  refcnt_2_D1 : X_ZERO
    port map (
      O => refcnt_2_D1_319
    );
  refcnt_2_D2 : X_AND5
    port map (
      I0 => NlwBufferSignal_refcnt_2_D2_IN0,
      I1 => NlwInverterSignal_refcnt_2_D2_IN1,
      I2 => NlwBufferSignal_refcnt_2_D2_IN2,
      I3 => NlwInverterSignal_refcnt_2_D2_IN3,
      I4 => NlwInverterSignal_refcnt_2_D2_IN4,
      O => refcnt_2_D2_320
    );
  refcnt_2_EXP_PT_0 : X_AND2
    port map (
      I0 => NlwBufferSignal_refcnt_2_EXP_PT_0_IN0,
      I1 => NlwBufferSignal_refcnt_2_EXP_PT_0_IN1,
      O => refcnt_2_EXP_PT_0_321
    );
  refcnt_2_EXP_PT_1 : X_AND2
    port map (
      I0 => NlwInverterSignal_refcnt_2_EXP_PT_1_IN0,
      I1 => NlwBufferSignal_refcnt_2_EXP_PT_1_IN1,
      O => refcnt_2_EXP_PT_1_322
    );
  refcnt_2_EXP_PT_2 : X_AND2
    port map (
      I0 => NlwBufferSignal_refcnt_2_EXP_PT_2_IN0,
      I1 => NlwBufferSignal_refcnt_2_EXP_PT_2_IN1,
      O => refcnt_2_EXP_PT_2_323
    );
  refcnt_2_EXP_PT_3 : X_AND3
    port map (
      I0 => NlwBufferSignal_refcnt_2_EXP_PT_3_IN0,
      I1 => NlwInverterSignal_refcnt_2_EXP_PT_3_IN1,
      I2 => NlwBufferSignal_refcnt_2_EXP_PT_3_IN2,
      O => refcnt_2_EXP_PT_3_324
    );
  refcnt_2_EXP_tsimrenamed_net_Q : X_OR4
    port map (
      I0 => NlwBufferSignal_refcnt_2_EXP_tsimrenamed_net_IN0,
      I1 => NlwBufferSignal_refcnt_2_EXP_tsimrenamed_net_IN1,
      I2 => NlwBufferSignal_refcnt_2_EXP_tsimrenamed_net_IN2,
      I3 => NlwBufferSignal_refcnt_2_EXP_tsimrenamed_net_IN3,
      O => refcnt_2_EXP_tsimrenamed_net_Q_316
    );
  refcnt_3_Q : X_BUF
    port map (
      I => refcnt_3_Q_325,
      O => refcnt(3)
    );
  refcnt_3_EXP : X_BUF
    port map (
      I => refcnt_3_EXP_tsimrenamed_net_Q_326,
      O => refcnt_3_EXP_160
    );
  refcnt_3_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_refcnt_3_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_refcnt_3_tsimcreated_xor_IN1,
      O => refcnt_3_tsimcreated_xor_Q_328
    );
  refcnt_3_REG : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => NlwBufferSignal_refcnt_3_REG_IN,
      CE => Vcc_88,
      CLK => NlwBufferSignal_refcnt_3_REG_CLK,
      SET => Gnd_87,
      RST => Gnd_87,
      O => refcnt_3_Q_325
    );
  refcnt_3_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_refcnt_3_D_IN0,
      I1 => NlwBufferSignal_refcnt_3_D_IN1,
      O => refcnt_3_D_327
    );
  refcnt_3_D1 : X_ZERO
    port map (
      O => refcnt_3_D1_329
    );
  refcnt_3_D2 : X_AND6
    port map (
      I0 => NlwBufferSignal_refcnt_3_D2_IN0,
      I1 => NlwInverterSignal_refcnt_3_D2_IN1,
      I2 => NlwBufferSignal_refcnt_3_D2_IN2,
      I3 => NlwInverterSignal_refcnt_3_D2_IN3,
      I4 => NlwInverterSignal_refcnt_3_D2_IN4,
      I5 => NlwInverterSignal_refcnt_3_D2_IN5,
      O => refcnt_3_D2_330
    );
  refcnt_3_EXP_PT_0 : X_AND2
    port map (
      I0 => NlwInverterSignal_refcnt_3_EXP_PT_0_IN0,
      I1 => NlwBufferSignal_refcnt_3_EXP_PT_0_IN1,
      O => refcnt_3_EXP_PT_0_331
    );
  refcnt_3_EXP_PT_1 : X_AND2
    port map (
      I0 => NlwInverterSignal_refcnt_3_EXP_PT_1_IN0,
      I1 => NlwBufferSignal_refcnt_3_EXP_PT_1_IN1,
      O => refcnt_3_EXP_PT_1_332
    );
  refcnt_3_EXP_PT_2 : X_AND2
    port map (
      I0 => NlwBufferSignal_refcnt_3_EXP_PT_2_IN0,
      I1 => NlwBufferSignal_refcnt_3_EXP_PT_2_IN1,
      O => refcnt_3_EXP_PT_2_333
    );
  refcnt_3_EXP_PT_3 : X_AND3
    port map (
      I0 => NlwBufferSignal_refcnt_3_EXP_PT_3_IN0,
      I1 => NlwInverterSignal_refcnt_3_EXP_PT_3_IN1,
      I2 => NlwBufferSignal_refcnt_3_EXP_PT_3_IN2,
      O => refcnt_3_EXP_PT_3_334
    );
  refcnt_3_EXP_tsimrenamed_net_Q : X_OR4
    port map (
      I0 => NlwBufferSignal_refcnt_3_EXP_tsimrenamed_net_IN0,
      I1 => NlwBufferSignal_refcnt_3_EXP_tsimrenamed_net_IN1,
      I2 => NlwBufferSignal_refcnt_3_EXP_tsimrenamed_net_IN2,
      I3 => NlwBufferSignal_refcnt_3_EXP_tsimrenamed_net_IN3,
      O => refcnt_3_EXP_tsimrenamed_net_Q_326
    );
  refcnt_4_Q : X_BUF
    port map (
      I => refcnt_4_Q_335,
      O => refcnt(4)
    );
  refcnt_4_EXP : X_BUF
    port map (
      I => refcnt_4_EXP_tsimrenamed_net_Q_336,
      O => refcnt_4_EXP_337
    );
  refcnt_4_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_refcnt_4_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_refcnt_4_tsimcreated_xor_IN1,
      O => refcnt_4_tsimcreated_xor_Q_339
    );
  refcnt_4_REG : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => NlwBufferSignal_refcnt_4_REG_IN,
      CE => Vcc_88,
      CLK => NlwBufferSignal_refcnt_4_REG_CLK,
      SET => Gnd_87,
      RST => Gnd_87,
      O => refcnt_4_Q_335
    );
  refcnt_4_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_refcnt_4_D_IN0,
      I1 => NlwBufferSignal_refcnt_4_D_IN1,
      O => refcnt_4_D_338
    );
  refcnt_4_D1 : X_ZERO
    port map (
      O => refcnt_4_D1_340
    );
  refcnt_4_D2_PT_0 : X_AND2
    port map (
      I0 => NlwBufferSignal_refcnt_4_D2_PT_0_IN0,
      I1 => NlwBufferSignal_refcnt_4_D2_PT_0_IN1,
      O => refcnt_4_D2_PT_0_342
    );
  refcnt_4_D2_PT_1 : X_AND8
    port map (
      I0 => NlwBufferSignal_refcnt_4_D2_PT_1_IN0,
      I1 => NlwInverterSignal_refcnt_4_D2_PT_1_IN1,
      I2 => NlwBufferSignal_refcnt_4_D2_PT_1_IN2,
      I3 => NlwInverterSignal_refcnt_4_D2_PT_1_IN3,
      I4 => NlwInverterSignal_refcnt_4_D2_PT_1_IN4,
      I5 => NlwInverterSignal_refcnt_4_D2_PT_1_IN5,
      I6 => NlwInverterSignal_refcnt_4_D2_PT_1_IN6,
      I7 => NlwBufferSignal_refcnt_4_D2_PT_1_IN7,
      O => refcnt_4_D2_PT_1_343
    );
  refcnt_4_D2_PT_2 : X_AND8
    port map (
      I0 => NlwBufferSignal_refcnt_4_D2_PT_2_IN0,
      I1 => NlwInverterSignal_refcnt_4_D2_PT_2_IN1,
      I2 => NlwBufferSignal_refcnt_4_D2_PT_2_IN2,
      I3 => NlwInverterSignal_refcnt_4_D2_PT_2_IN3,
      I4 => NlwInverterSignal_refcnt_4_D2_PT_2_IN4,
      I5 => NlwInverterSignal_refcnt_4_D2_PT_2_IN5,
      I6 => NlwInverterSignal_refcnt_4_D2_PT_2_IN6,
      I7 => NlwBufferSignal_refcnt_4_D2_PT_2_IN7,
      O => refcnt_4_D2_PT_2_344
    );
  refcnt_4_D2 : X_OR3
    port map (
      I0 => NlwBufferSignal_refcnt_4_D2_IN0,
      I1 => NlwBufferSignal_refcnt_4_D2_IN1,
      I2 => NlwBufferSignal_refcnt_4_D2_IN2,
      O => refcnt_4_D2_341
    );
  refcnt_4_EXP_PT_0 : X_AND3
    port map (
      I0 => NlwBufferSignal_refcnt_4_EXP_PT_0_IN0,
      I1 => NlwInverterSignal_refcnt_4_EXP_PT_0_IN1,
      I2 => NlwBufferSignal_refcnt_4_EXP_PT_0_IN2,
      O => refcnt_4_EXP_PT_0_345
    );
  refcnt_4_EXP_PT_1 : X_AND4
    port map (
      I0 => NlwInverterSignal_refcnt_4_EXP_PT_1_IN0,
      I1 => NlwInverterSignal_refcnt_4_EXP_PT_1_IN1,
      I2 => NlwBufferSignal_refcnt_4_EXP_PT_1_IN2,
      I3 => NlwBufferSignal_refcnt_4_EXP_PT_1_IN3,
      O => refcnt_4_EXP_PT_1_346
    );
  refcnt_4_EXP_PT_2 : X_AND16
    port map (
      I0 => NlwBufferSignal_refcnt_4_EXP_PT_2_IN0,
      I1 => NlwInverterSignal_refcnt_4_EXP_PT_2_IN1,
      I2 => NlwInverterSignal_refcnt_4_EXP_PT_2_IN2,
      I3 => NlwInverterSignal_refcnt_4_EXP_PT_2_IN3,
      I4 => NlwBufferSignal_refcnt_4_EXP_PT_2_IN4,
      I5 => NlwInverterSignal_refcnt_4_EXP_PT_2_IN5,
      I6 => NlwInverterSignal_refcnt_4_EXP_PT_2_IN6,
      I7 => NlwInverterSignal_refcnt_4_EXP_PT_2_IN7,
      I8 => NlwInverterSignal_refcnt_4_EXP_PT_2_IN8,
      I9 => NlwInverterSignal_refcnt_4_EXP_PT_2_IN9,
      I10 => NlwBufferSignal_refcnt_4_EXP_PT_2_IN10,
      I11 => NlwBufferSignal_refcnt_4_EXP_PT_2_IN11,
      I12 => NlwBufferSignal_refcnt_4_EXP_PT_2_IN12,
      I13 => NlwBufferSignal_refcnt_4_EXP_PT_2_IN13,
      I14 => NlwBufferSignal_refcnt_4_EXP_PT_2_IN14,
      I15 => NlwBufferSignal_refcnt_4_EXP_PT_2_IN15,
      O => refcnt_4_EXP_PT_2_347
    );
  refcnt_4_EXP_tsimrenamed_net_Q : X_OR3
    port map (
      I0 => NlwBufferSignal_refcnt_4_EXP_tsimrenamed_net_IN0,
      I1 => NlwBufferSignal_refcnt_4_EXP_tsimrenamed_net_IN1,
      I2 => NlwBufferSignal_refcnt_4_EXP_tsimrenamed_net_IN2,
      O => refcnt_4_EXP_tsimrenamed_net_Q_336
    );
  refcnt_5_Q : X_BUF
    port map (
      I => refcnt_5_Q_348,
      O => refcnt(5)
    );
  refcnt_5_EXP : X_BUF
    port map (
      I => refcnt_5_EXP_tsimrenamed_net_Q_349,
      O => refcnt_5_EXP_149
    );
  refcnt_5_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_refcnt_5_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_refcnt_5_tsimcreated_xor_IN1,
      O => refcnt_5_tsimcreated_xor_Q_351
    );
  refcnt_5_REG : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => NlwBufferSignal_refcnt_5_REG_IN,
      CE => Vcc_88,
      CLK => NlwBufferSignal_refcnt_5_REG_CLK,
      SET => Gnd_87,
      RST => Gnd_87,
      O => refcnt_5_Q_348
    );
  refcnt_5_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_refcnt_5_D_IN0,
      I1 => NlwBufferSignal_refcnt_5_D_IN1,
      O => refcnt_5_D_350
    );
  refcnt_5_D1 : X_ZERO
    port map (
      O => refcnt_5_D1_352
    );
  refcnt_5_D2_PT_0 : X_AND16
    port map (
      I0 => NlwBufferSignal_refcnt_5_D2_PT_0_IN0,
      I1 => NlwInverterSignal_refcnt_5_D2_PT_0_IN1,
      I2 => NlwBufferSignal_refcnt_5_D2_PT_0_IN2,
      I3 => NlwInverterSignal_refcnt_5_D2_PT_0_IN3,
      I4 => NlwInverterSignal_refcnt_5_D2_PT_0_IN4,
      I5 => NlwInverterSignal_refcnt_5_D2_PT_0_IN5,
      I6 => NlwInverterSignal_refcnt_5_D2_PT_0_IN6,
      I7 => NlwBufferSignal_refcnt_5_D2_PT_0_IN7,
      I8 => NlwInverterSignal_refcnt_5_D2_PT_0_IN8,
      I9 => NlwBufferSignal_refcnt_5_D2_PT_0_IN9,
      I10 => NlwBufferSignal_refcnt_5_D2_PT_0_IN10,
      I11 => NlwBufferSignal_refcnt_5_D2_PT_0_IN11,
      I12 => NlwBufferSignal_refcnt_5_D2_PT_0_IN12,
      I13 => NlwBufferSignal_refcnt_5_D2_PT_0_IN13,
      I14 => NlwBufferSignal_refcnt_5_D2_PT_0_IN14,
      I15 => NlwBufferSignal_refcnt_5_D2_PT_0_IN15,
      O => refcnt_5_D2_PT_0_354
    );
  refcnt_5_D2_PT_1 : X_AND16
    port map (
      I0 => NlwBufferSignal_refcnt_5_D2_PT_1_IN0,
      I1 => NlwInverterSignal_refcnt_5_D2_PT_1_IN1,
      I2 => NlwBufferSignal_refcnt_5_D2_PT_1_IN2,
      I3 => NlwInverterSignal_refcnt_5_D2_PT_1_IN3,
      I4 => NlwInverterSignal_refcnt_5_D2_PT_1_IN4,
      I5 => NlwInverterSignal_refcnt_5_D2_PT_1_IN5,
      I6 => NlwInverterSignal_refcnt_5_D2_PT_1_IN6,
      I7 => NlwBufferSignal_refcnt_5_D2_PT_1_IN7,
      I8 => NlwInverterSignal_refcnt_5_D2_PT_1_IN8,
      I9 => NlwBufferSignal_refcnt_5_D2_PT_1_IN9,
      I10 => NlwBufferSignal_refcnt_5_D2_PT_1_IN10,
      I11 => NlwBufferSignal_refcnt_5_D2_PT_1_IN11,
      I12 => NlwBufferSignal_refcnt_5_D2_PT_1_IN12,
      I13 => NlwBufferSignal_refcnt_5_D2_PT_1_IN13,
      I14 => NlwBufferSignal_refcnt_5_D2_PT_1_IN14,
      I15 => NlwBufferSignal_refcnt_5_D2_PT_1_IN15,
      O => refcnt_5_D2_PT_1_355
    );
  refcnt_5_D2_PT_2 : X_AND16
    port map (
      I0 => NlwBufferSignal_refcnt_5_D2_PT_2_IN0,
      I1 => NlwInverterSignal_refcnt_5_D2_PT_2_IN1,
      I2 => NlwBufferSignal_refcnt_5_D2_PT_2_IN2,
      I3 => NlwInverterSignal_refcnt_5_D2_PT_2_IN3,
      I4 => NlwInverterSignal_refcnt_5_D2_PT_2_IN4,
      I5 => NlwInverterSignal_refcnt_5_D2_PT_2_IN5,
      I6 => NlwInverterSignal_refcnt_5_D2_PT_2_IN6,
      I7 => NlwInverterSignal_refcnt_5_D2_PT_2_IN7,
      I8 => NlwBufferSignal_refcnt_5_D2_PT_2_IN8,
      I9 => NlwBufferSignal_refcnt_5_D2_PT_2_IN9,
      I10 => NlwBufferSignal_refcnt_5_D2_PT_2_IN10,
      I11 => NlwBufferSignal_refcnt_5_D2_PT_2_IN11,
      I12 => NlwBufferSignal_refcnt_5_D2_PT_2_IN12,
      I13 => NlwBufferSignal_refcnt_5_D2_PT_2_IN13,
      I14 => NlwBufferSignal_refcnt_5_D2_PT_2_IN14,
      I15 => NlwBufferSignal_refcnt_5_D2_PT_2_IN15,
      O => refcnt_5_D2_PT_2_356
    );
  refcnt_5_D2 : X_OR3
    port map (
      I0 => NlwBufferSignal_refcnt_5_D2_IN0,
      I1 => NlwBufferSignal_refcnt_5_D2_IN1,
      I2 => NlwBufferSignal_refcnt_5_D2_IN2,
      O => refcnt_5_D2_353
    );
  refcnt_5_EXP_PT_0 : X_AND3
    port map (
      I0 => NlwInverterSignal_refcnt_5_EXP_PT_0_IN0,
      I1 => NlwInverterSignal_refcnt_5_EXP_PT_0_IN1,
      I2 => NlwBufferSignal_refcnt_5_EXP_PT_0_IN2,
      O => refcnt_5_EXP_PT_0_357
    );
  refcnt_5_EXP_PT_1 : X_AND16
    port map (
      I0 => NlwInverterSignal_refcnt_5_EXP_PT_1_IN0,
      I1 => NlwInverterSignal_refcnt_5_EXP_PT_1_IN1,
      I2 => NlwInverterSignal_refcnt_5_EXP_PT_1_IN2,
      I3 => NlwInverterSignal_refcnt_5_EXP_PT_1_IN3,
      I4 => NlwInverterSignal_refcnt_5_EXP_PT_1_IN4,
      I5 => NlwInverterSignal_refcnt_5_EXP_PT_1_IN5,
      I6 => NlwBufferSignal_refcnt_5_EXP_PT_1_IN6,
      I7 => NlwInverterSignal_refcnt_5_EXP_PT_1_IN7,
      I8 => NlwInverterSignal_refcnt_5_EXP_PT_1_IN8,
      I9 => NlwBufferSignal_refcnt_5_EXP_PT_1_IN9,
      I10 => NlwBufferSignal_refcnt_5_EXP_PT_1_IN10,
      I11 => NlwBufferSignal_refcnt_5_EXP_PT_1_IN11,
      I12 => NlwBufferSignal_refcnt_5_EXP_PT_1_IN12,
      I13 => NlwBufferSignal_refcnt_5_EXP_PT_1_IN13,
      I14 => NlwBufferSignal_refcnt_5_EXP_PT_1_IN14,
      I15 => NlwBufferSignal_refcnt_5_EXP_PT_1_IN15,
      O => refcnt_5_EXP_PT_1_358
    );
  refcnt_5_EXP_tsimrenamed_net_Q : X_OR2
    port map (
      I0 => NlwBufferSignal_refcnt_5_EXP_tsimrenamed_net_IN0,
      I1 => NlwBufferSignal_refcnt_5_EXP_tsimrenamed_net_IN1,
      O => refcnt_5_EXP_tsimrenamed_net_Q_349
    );
  refcnt_6_Q : X_BUF
    port map (
      I => refcnt_6_Q_359,
      O => refcnt(6)
    );
  refcnt_6_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_refcnt_6_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_refcnt_6_tsimcreated_xor_IN1,
      O => refcnt_6_tsimcreated_xor_Q_361
    );
  refcnt_6_REG : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => NlwBufferSignal_refcnt_6_REG_IN,
      CE => Vcc_88,
      CLK => NlwBufferSignal_refcnt_6_REG_CLK,
      SET => Gnd_87,
      RST => Gnd_87,
      O => refcnt_6_Q_359
    );
  refcnt_6_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_refcnt_6_D_IN0,
      I1 => NlwBufferSignal_refcnt_6_D_IN1,
      O => refcnt_6_D_360
    );
  refcnt_6_D1 : X_ZERO
    port map (
      O => refcnt_6_D1_362
    );
  refcnt_6_D2 : X_AND5
    port map (
      I0 => NlwBufferSignal_refcnt_6_D2_IN0,
      I1 => NlwInverterSignal_refcnt_6_D2_IN1,
      I2 => NlwBufferSignal_refcnt_6_D2_IN2,
      I3 => NlwInverterSignal_refcnt_6_D2_IN3,
      I4 => NlwBufferSignal_refcnt_6_D2_IN4,
      O => refcnt_6_D2_363
    );
  refcnt_7_Q : X_BUF
    port map (
      I => refcnt_7_Q_366,
      O => refcnt(7)
    );
  refcnt_7_EXP : X_BUF
    port map (
      I => refcnt_7_EXP_tsimrenamed_net_Q_367,
      O => refcnt_7_EXP_230
    );
  refcnt_7_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_refcnt_7_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_refcnt_7_tsimcreated_xor_IN1,
      O => refcnt_7_tsimcreated_xor_Q_369
    );
  refcnt_7_REG : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NlwBufferSignal_refcnt_7_REG_IN,
      CE => Vcc_88,
      CLK => NlwBufferSignal_refcnt_7_REG_CLK,
      SET => Gnd_87,
      RST => Gnd_87,
      O => refcnt_7_Q_366
    );
  refcnt_7_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_refcnt_7_D_IN0,
      I1 => NlwBufferSignal_refcnt_7_D_IN1,
      O => refcnt_7_D_368
    );
  refcnt_7_D1 : X_ZERO
    port map (
      O => refcnt_7_D1_370
    );
  refcnt_7_D2 : X_AND16
    port map (
      I0 => NlwBufferSignal_refcnt_7_D2_IN0,
      I1 => NlwInverterSignal_refcnt_7_D2_IN1,
      I2 => NlwBufferSignal_refcnt_7_D2_IN2,
      I3 => NlwInverterSignal_refcnt_7_D2_IN3,
      I4 => NlwInverterSignal_refcnt_7_D2_IN4,
      I5 => NlwInverterSignal_refcnt_7_D2_IN5,
      I6 => NlwInverterSignal_refcnt_7_D2_IN6,
      I7 => NlwInverterSignal_refcnt_7_D2_IN7,
      I8 => NlwInverterSignal_refcnt_7_D2_IN8,
      I9 => NlwInverterSignal_refcnt_7_D2_IN9,
      I10 => NlwBufferSignal_refcnt_7_D2_IN10,
      I11 => NlwBufferSignal_refcnt_7_D2_IN11,
      I12 => NlwBufferSignal_refcnt_7_D2_IN12,
      I13 => NlwBufferSignal_refcnt_7_D2_IN13,
      I14 => NlwBufferSignal_refcnt_7_D2_IN14,
      I15 => NlwBufferSignal_refcnt_7_D2_IN15,
      O => refcnt_7_D2_371
    );
  refcnt_7_EXP_PT_0 : X_AND3
    port map (
      I0 => NlwInverterSignal_refcnt_7_EXP_PT_0_IN0,
      I1 => NlwInverterSignal_refcnt_7_EXP_PT_0_IN1,
      I2 => NlwBufferSignal_refcnt_7_EXP_PT_0_IN2,
      O => refcnt_7_EXP_PT_0_372
    );
  refcnt_7_EXP_PT_1 : X_AND3
    port map (
      I0 => NlwBufferSignal_refcnt_7_EXP_PT_1_IN0,
      I1 => NlwInverterSignal_refcnt_7_EXP_PT_1_IN1,
      I2 => NlwBufferSignal_refcnt_7_EXP_PT_1_IN2,
      O => refcnt_7_EXP_PT_1_373
    );
  refcnt_7_EXP_PT_2 : X_AND3
    port map (
      I0 => NlwInverterSignal_refcnt_7_EXP_PT_2_IN0,
      I1 => NlwBufferSignal_refcnt_7_EXP_PT_2_IN1,
      I2 => NlwBufferSignal_refcnt_7_EXP_PT_2_IN2,
      O => refcnt_7_EXP_PT_2_374
    );
  refcnt_7_EXP_PT_3 : X_AND16
    port map (
      I0 => NlwInverterSignal_refcnt_7_EXP_PT_3_IN0,
      I1 => NlwBufferSignal_refcnt_7_EXP_PT_3_IN1,
      I2 => NlwBufferSignal_refcnt_7_EXP_PT_3_IN2,
      I3 => NlwInverterSignal_refcnt_7_EXP_PT_3_IN3,
      I4 => NlwInverterSignal_refcnt_7_EXP_PT_3_IN4,
      I5 => NlwInverterSignal_refcnt_7_EXP_PT_3_IN5,
      I6 => NlwInverterSignal_refcnt_7_EXP_PT_3_IN6,
      I7 => NlwInverterSignal_refcnt_7_EXP_PT_3_IN7,
      I8 => NlwInverterSignal_refcnt_7_EXP_PT_3_IN8,
      I9 => NlwInverterSignal_refcnt_7_EXP_PT_3_IN9,
      I10 => NlwInverterSignal_refcnt_7_EXP_PT_3_IN10,
      I11 => NlwInverterSignal_refcnt_7_EXP_PT_3_IN11,
      I12 => NlwInverterSignal_refcnt_7_EXP_PT_3_IN12,
      I13 => NlwInverterSignal_refcnt_7_EXP_PT_3_IN13,
      I14 => NlwBufferSignal_refcnt_7_EXP_PT_3_IN14,
      I15 => NlwBufferSignal_refcnt_7_EXP_PT_3_IN15,
      O => refcnt_7_EXP_PT_3_375
    );
  refcnt_7_EXP_tsimrenamed_net_Q : X_OR4
    port map (
      I0 => NlwBufferSignal_refcnt_7_EXP_tsimrenamed_net_IN0,
      I1 => NlwBufferSignal_refcnt_7_EXP_tsimrenamed_net_IN1,
      I2 => NlwBufferSignal_refcnt_7_EXP_tsimrenamed_net_IN2,
      I3 => NlwBufferSignal_refcnt_7_EXP_tsimrenamed_net_IN3,
      O => refcnt_7_EXP_tsimrenamed_net_Q_367
    );
  Q_OpTx_FX_DC_49_UIM : X_BUF
    port map (
      I => Q_OpTx_FX_DC_49_Q_376,
      O => Q_OpTx_FX_DC_49_UIM_247
    );
  Q_OpTx_FX_DC_49_Q : X_BUF
    port map (
      I => Q_OpTx_FX_DC_49_D_377,
      O => Q_OpTx_FX_DC_49_Q_376
    );
  Q_OpTx_FX_DC_49_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_OpTx_FX_DC_49_D_IN0,
      I1 => NlwBufferSignal_OpTx_FX_DC_49_D_IN1,
      O => Q_OpTx_FX_DC_49_D_377
    );
  Q_OpTx_FX_DC_49_D1 : X_ZERO
    port map (
      O => Q_OpTx_FX_DC_49_D1_378
    );
  Q_OpTx_FX_DC_49_D2_PT_0 : X_AND3
    port map (
      I0 => NlwInverterSignal_OpTx_FX_DC_49_D2_PT_0_IN0,
      I1 => NlwInverterSignal_OpTx_FX_DC_49_D2_PT_0_IN1,
      I2 => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_0_IN2,
      O => Q_OpTx_FX_DC_49_D2_PT_0_380
    );
  Q_OpTx_FX_DC_49_D2_PT_1 : X_AND16
    port map (
      I0 => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN0,
      I1 => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN1,
      I2 => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN2,
      I3 => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN3,
      I4 => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN4,
      I5 => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN5,
      I6 => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN6,
      I7 => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN7,
      I8 => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN8,
      I9 => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN9,
      I10 => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN10,
      I11 => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN11,
      I12 => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN12,
      I13 => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN13,
      I14 => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN14,
      I15 => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN15,
      O => Q_OpTx_FX_DC_49_D2_PT_1_381
    );
  Q_OpTx_FX_DC_49_D2_PT_2 : X_AND16
    port map (
      I0 => NlwInverterSignal_OpTx_FX_DC_49_D2_PT_2_IN0,
      I1 => NlwInverterSignal_OpTx_FX_DC_49_D2_PT_2_IN1,
      I2 => NlwInverterSignal_OpTx_FX_DC_49_D2_PT_2_IN2,
      I3 => NlwInverterSignal_OpTx_FX_DC_49_D2_PT_2_IN3,
      I4 => NlwInverterSignal_OpTx_FX_DC_49_D2_PT_2_IN4,
      I5 => NlwInverterSignal_OpTx_FX_DC_49_D2_PT_2_IN5,
      I6 => NlwInverterSignal_OpTx_FX_DC_49_D2_PT_2_IN6,
      I7 => NlwInverterSignal_OpTx_FX_DC_49_D2_PT_2_IN7,
      I8 => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN8,
      I9 => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN9,
      I10 => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN10,
      I11 => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN11,
      I12 => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN12,
      I13 => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN13,
      I14 => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN14,
      I15 => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN15,
      O => Q_OpTx_FX_DC_49_D2_PT_2_382
    );
  Q_OpTx_FX_DC_49_D2 : X_OR3
    port map (
      I0 => NlwBufferSignal_OpTx_FX_DC_49_D2_IN0,
      I1 => NlwBufferSignal_OpTx_FX_DC_49_D2_IN1,
      I2 => NlwBufferSignal_OpTx_FX_DC_49_D2_IN2,
      O => Q_OpTx_FX_DC_49_D2_379
    );
  EXP0_EXP : X_BUF
    port map (
      I => EXP0_EXP_tsimrenamed_net_Q_383,
      O => EXP0_EXP_115
    );
  EXP0_EXP_PT_0 : X_AND2
    port map (
      I0 => NlwBufferSignal_EXP0_EXP_PT_0_IN0,
      I1 => NlwBufferSignal_EXP0_EXP_PT_0_IN1,
      O => EXP0_EXP_PT_0_384
    );
  EXP0_EXP_PT_1 : X_AND3
    port map (
      I0 => NlwBufferSignal_EXP0_EXP_PT_1_IN0,
      I1 => NlwBufferSignal_EXP0_EXP_PT_1_IN1,
      I2 => NlwBufferSignal_EXP0_EXP_PT_1_IN2,
      O => EXP0_EXP_PT_1_385
    );
  EXP0_EXP_PT_2 : X_AND3
    port map (
      I0 => NlwBufferSignal_EXP0_EXP_PT_2_IN0,
      I1 => NlwBufferSignal_EXP0_EXP_PT_2_IN1,
      I2 => NlwBufferSignal_EXP0_EXP_PT_2_IN2,
      O => EXP0_EXP_PT_2_386
    );
  EXP0_EXP_PT_3 : X_AND3
    port map (
      I0 => NlwBufferSignal_EXP0_EXP_PT_3_IN0,
      I1 => NlwBufferSignal_EXP0_EXP_PT_3_IN1,
      I2 => NlwBufferSignal_EXP0_EXP_PT_3_IN2,
      O => EXP0_EXP_PT_3_387
    );
  EXP0_EXP_PT_4 : X_AND3
    port map (
      I0 => NlwBufferSignal_EXP0_EXP_PT_4_IN0,
      I1 => NlwBufferSignal_EXP0_EXP_PT_4_IN1,
      I2 => NlwBufferSignal_EXP0_EXP_PT_4_IN2,
      O => EXP0_EXP_PT_4_388
    );
  EXP0_EXP_PT_5 : X_AND3
    port map (
      I0 => NlwBufferSignal_EXP0_EXP_PT_5_IN0,
      I1 => NlwBufferSignal_EXP0_EXP_PT_5_IN1,
      I2 => NlwBufferSignal_EXP0_EXP_PT_5_IN2,
      O => EXP0_EXP_PT_5_389
    );
  EXP0_EXP_tsimrenamed_net_Q : X_OR6
    port map (
      I0 => NlwBufferSignal_EXP0_EXP_tsimrenamed_net_IN0,
      I1 => NlwBufferSignal_EXP0_EXP_tsimrenamed_net_IN1,
      I2 => NlwBufferSignal_EXP0_EXP_tsimrenamed_net_IN2,
      I3 => NlwBufferSignal_EXP0_EXP_tsimrenamed_net_IN3,
      I4 => NlwBufferSignal_EXP0_EXP_tsimrenamed_net_IN4,
      I5 => NlwBufferSignal_EXP0_EXP_tsimrenamed_net_IN5,
      O => EXP0_EXP_tsimrenamed_net_Q_383
    );
  EXP1_EXP : X_BUF
    port map (
      I => EXP1_EXP_tsimrenamed_net_Q_390,
      O => EXP1_EXP_133
    );
  EXP1_EXP_PT_0 : X_AND2
    port map (
      I0 => NlwBufferSignal_EXP1_EXP_PT_0_IN0,
      I1 => NlwBufferSignal_EXP1_EXP_PT_0_IN1,
      O => EXP1_EXP_PT_0_391
    );
  EXP1_EXP_PT_1 : X_AND2
    port map (
      I0 => NlwBufferSignal_EXP1_EXP_PT_1_IN0,
      I1 => NlwBufferSignal_EXP1_EXP_PT_1_IN1,
      O => EXP1_EXP_PT_1_392
    );
  EXP1_EXP_PT_2 : X_AND2
    port map (
      I0 => NlwInverterSignal_EXP1_EXP_PT_2_IN0,
      I1 => NlwBufferSignal_EXP1_EXP_PT_2_IN1,
      O => EXP1_EXP_PT_2_393
    );
  EXP1_EXP_PT_3 : X_AND2
    port map (
      I0 => NlwInverterSignal_EXP1_EXP_PT_3_IN0,
      I1 => NlwBufferSignal_EXP1_EXP_PT_3_IN1,
      O => EXP1_EXP_PT_3_394
    );
  EXP1_EXP_PT_4 : X_AND2
    port map (
      I0 => NlwBufferSignal_EXP1_EXP_PT_4_IN0,
      I1 => NlwBufferSignal_EXP1_EXP_PT_4_IN1,
      O => EXP1_EXP_PT_4_395
    );
  EXP1_EXP_PT_5 : X_AND2
    port map (
      I0 => NlwInverterSignal_EXP1_EXP_PT_5_IN0,
      I1 => NlwBufferSignal_EXP1_EXP_PT_5_IN1,
      O => EXP1_EXP_PT_5_396
    );
  EXP1_EXP_tsimrenamed_net_Q : X_OR6
    port map (
      I0 => NlwBufferSignal_EXP1_EXP_tsimrenamed_net_IN0,
      I1 => NlwBufferSignal_EXP1_EXP_tsimrenamed_net_IN1,
      I2 => NlwBufferSignal_EXP1_EXP_tsimrenamed_net_IN2,
      I3 => NlwBufferSignal_EXP1_EXP_tsimrenamed_net_IN3,
      I4 => NlwBufferSignal_EXP1_EXP_tsimrenamed_net_IN4,
      I5 => NlwBufferSignal_EXP1_EXP_tsimrenamed_net_IN5,
      O => EXP1_EXP_tsimrenamed_net_Q_390
    );
  EXP2_EXP : X_BUF
    port map (
      I => EXP2_EXP_tsimrenamed_net_Q_397,
      O => EXP2_EXP_245
    );
  EXP2_EXP_PT_0 : X_AND4
    port map (
      I0 => NlwInverterSignal_EXP2_EXP_PT_0_IN0,
      I1 => NlwInverterSignal_EXP2_EXP_PT_0_IN1,
      I2 => NlwBufferSignal_EXP2_EXP_PT_0_IN2,
      I3 => NlwInverterSignal_EXP2_EXP_PT_0_IN3,
      O => EXP2_EXP_PT_0_398
    );
  EXP2_EXP_PT_1 : X_AND16
    port map (
      I0 => NlwInverterSignal_EXP2_EXP_PT_1_IN0,
      I1 => NlwInverterSignal_EXP2_EXP_PT_1_IN1,
      I2 => NlwInverterSignal_EXP2_EXP_PT_1_IN2,
      I3 => NlwInverterSignal_EXP2_EXP_PT_1_IN3,
      I4 => NlwInverterSignal_EXP2_EXP_PT_1_IN4,
      I5 => NlwInverterSignal_EXP2_EXP_PT_1_IN5,
      I6 => NlwInverterSignal_EXP2_EXP_PT_1_IN6,
      I7 => NlwInverterSignal_EXP2_EXP_PT_1_IN7,
      I8 => NlwInverterSignal_EXP2_EXP_PT_1_IN8,
      I9 => NlwInverterSignal_EXP2_EXP_PT_1_IN9,
      I10 => NlwBufferSignal_EXP2_EXP_PT_1_IN10,
      I11 => NlwBufferSignal_EXP2_EXP_PT_1_IN11,
      I12 => NlwBufferSignal_EXP2_EXP_PT_1_IN12,
      I13 => NlwBufferSignal_EXP2_EXP_PT_1_IN13,
      I14 => NlwBufferSignal_EXP2_EXP_PT_1_IN14,
      I15 => NlwBufferSignal_EXP2_EXP_PT_1_IN15,
      O => EXP2_EXP_PT_1_399
    );
  EXP2_EXP_PT_2 : X_AND16
    port map (
      I0 => NlwInverterSignal_EXP2_EXP_PT_2_IN0,
      I1 => NlwInverterSignal_EXP2_EXP_PT_2_IN1,
      I2 => NlwInverterSignal_EXP2_EXP_PT_2_IN2,
      I3 => NlwInverterSignal_EXP2_EXP_PT_2_IN3,
      I4 => NlwInverterSignal_EXP2_EXP_PT_2_IN4,
      I5 => NlwInverterSignal_EXP2_EXP_PT_2_IN5,
      I6 => NlwInverterSignal_EXP2_EXP_PT_2_IN6,
      I7 => NlwInverterSignal_EXP2_EXP_PT_2_IN7,
      I8 => NlwInverterSignal_EXP2_EXP_PT_2_IN8,
      I9 => NlwInverterSignal_EXP2_EXP_PT_2_IN9,
      I10 => NlwBufferSignal_EXP2_EXP_PT_2_IN10,
      I11 => NlwBufferSignal_EXP2_EXP_PT_2_IN11,
      I12 => NlwBufferSignal_EXP2_EXP_PT_2_IN12,
      I13 => NlwBufferSignal_EXP2_EXP_PT_2_IN13,
      I14 => NlwBufferSignal_EXP2_EXP_PT_2_IN14,
      I15 => NlwBufferSignal_EXP2_EXP_PT_2_IN15,
      O => EXP2_EXP_PT_2_400
    );
  EXP2_EXP_PT_3 : X_AND16
    port map (
      I0 => NlwBufferSignal_EXP2_EXP_PT_3_IN0,
      I1 => NlwInverterSignal_EXP2_EXP_PT_3_IN1,
      I2 => NlwInverterSignal_EXP2_EXP_PT_3_IN2,
      I3 => NlwInverterSignal_EXP2_EXP_PT_3_IN3,
      I4 => NlwInverterSignal_EXP2_EXP_PT_3_IN4,
      I5 => NlwInverterSignal_EXP2_EXP_PT_3_IN5,
      I6 => NlwInverterSignal_EXP2_EXP_PT_3_IN6,
      I7 => NlwInverterSignal_EXP2_EXP_PT_3_IN7,
      I8 => NlwInverterSignal_EXP2_EXP_PT_3_IN8,
      I9 => NlwInverterSignal_EXP2_EXP_PT_3_IN9,
      I10 => NlwBufferSignal_EXP2_EXP_PT_3_IN10,
      I11 => NlwBufferSignal_EXP2_EXP_PT_3_IN11,
      I12 => NlwBufferSignal_EXP2_EXP_PT_3_IN12,
      I13 => NlwBufferSignal_EXP2_EXP_PT_3_IN13,
      I14 => NlwBufferSignal_EXP2_EXP_PT_3_IN14,
      I15 => NlwBufferSignal_EXP2_EXP_PT_3_IN15,
      O => EXP2_EXP_PT_3_401
    );
  EXP2_EXP_PT_4 : X_AND16
    port map (
      I0 => NlwInverterSignal_EXP2_EXP_PT_4_IN0,
      I1 => NlwInverterSignal_EXP2_EXP_PT_4_IN1,
      I2 => NlwBufferSignal_EXP2_EXP_PT_4_IN2,
      I3 => NlwInverterSignal_EXP2_EXP_PT_4_IN3,
      I4 => NlwInverterSignal_EXP2_EXP_PT_4_IN4,
      I5 => NlwInverterSignal_EXP2_EXP_PT_4_IN5,
      I6 => NlwInverterSignal_EXP2_EXP_PT_4_IN6,
      I7 => NlwInverterSignal_EXP2_EXP_PT_4_IN7,
      I8 => NlwInverterSignal_EXP2_EXP_PT_4_IN8,
      I9 => NlwInverterSignal_EXP2_EXP_PT_4_IN9,
      I10 => NlwInverterSignal_EXP2_EXP_PT_4_IN10,
      I11 => NlwBufferSignal_EXP2_EXP_PT_4_IN11,
      I12 => NlwBufferSignal_EXP2_EXP_PT_4_IN12,
      I13 => NlwBufferSignal_EXP2_EXP_PT_4_IN13,
      I14 => NlwBufferSignal_EXP2_EXP_PT_4_IN14,
      I15 => NlwBufferSignal_EXP2_EXP_PT_4_IN15,
      O => EXP2_EXP_PT_4_402
    );
  EXP2_EXP_tsimrenamed_net_Q : X_OR5
    port map (
      I0 => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN0,
      I1 => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN1,
      I2 => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN2,
      I3 => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN3,
      I4 => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN4,
      O => EXP2_EXP_tsimrenamed_net_Q_397
    );
  EXP3_EXP : X_BUF
    port map (
      I => EXP3_EXP_tsimrenamed_net_Q_403,
      O => EXP3_EXP_117
    );
  EXP3_EXP_PT_0 : X_AND3
    port map (
      I0 => NlwInverterSignal_EXP3_EXP_PT_0_IN0,
      I1 => NlwInverterSignal_EXP3_EXP_PT_0_IN1,
      I2 => NlwBufferSignal_EXP3_EXP_PT_0_IN2,
      O => EXP3_EXP_PT_0_404
    );
  EXP3_EXP_PT_1 : X_AND3
    port map (
      I0 => NlwInverterSignal_EXP3_EXP_PT_1_IN0,
      I1 => NlwInverterSignal_EXP3_EXP_PT_1_IN1,
      I2 => NlwBufferSignal_EXP3_EXP_PT_1_IN2,
      O => EXP3_EXP_PT_1_405
    );
  EXP3_EXP_PT_2 : X_AND3
    port map (
      I0 => NlwInverterSignal_EXP3_EXP_PT_2_IN0,
      I1 => NlwInverterSignal_EXP3_EXP_PT_2_IN1,
      I2 => NlwBufferSignal_EXP3_EXP_PT_2_IN2,
      O => EXP3_EXP_PT_2_406
    );
  EXP3_EXP_PT_3 : X_AND3
    port map (
      I0 => NlwInverterSignal_EXP3_EXP_PT_3_IN0,
      I1 => NlwInverterSignal_EXP3_EXP_PT_3_IN1,
      I2 => NlwBufferSignal_EXP3_EXP_PT_3_IN2,
      O => EXP3_EXP_PT_3_407
    );
  EXP3_EXP_PT_4 : X_AND3
    port map (
      I0 => NlwInverterSignal_EXP3_EXP_PT_4_IN0,
      I1 => NlwInverterSignal_EXP3_EXP_PT_4_IN1,
      I2 => NlwBufferSignal_EXP3_EXP_PT_4_IN2,
      O => EXP3_EXP_PT_4_408
    );
  EXP3_EXP_tsimrenamed_net_Q : X_OR5
    port map (
      I0 => NlwBufferSignal_EXP3_EXP_tsimrenamed_net_IN0,
      I1 => NlwBufferSignal_EXP3_EXP_tsimrenamed_net_IN1,
      I2 => NlwBufferSignal_EXP3_EXP_tsimrenamed_net_IN2,
      I3 => NlwBufferSignal_EXP3_EXP_tsimrenamed_net_IN3,
      I4 => NlwBufferSignal_EXP3_EXP_tsimrenamed_net_IN4,
      O => EXP3_EXP_tsimrenamed_net_Q_403
    );
  FC_0_Q : X_AND6
    port map (
      I0 => NlwInverterSignal_FC_0_IN0,
      I1 => NlwInverterSignal_FC_0_IN1,
      I2 => NlwInverterSignal_FC_0_IN2,
      I3 => NlwInverterSignal_FC_0_IN3,
      I4 => NlwInverterSignal_FC_0_IN4,
      I5 => NlwInverterSignal_FC_0_IN5,
      O => FC_0_OUT
    );
  FC_1_Q : X_AND2
    port map (
      I0 => NlwInverterSignal_FC_1_IN0,
      I1 => NlwInverterSignal_FC_1_IN1,
      O => FC_1_OUT
    );
  NlwBufferBlock_rom_OBUF_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => rom_OBUF_D_85,
      O => NlwBufferSignal_rom_OBUF_tsimcreated_xor_IN0
    );
  NlwBufferBlock_rom_OBUF_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => rom_OBUF_Q_84,
      O => NlwBufferSignal_rom_OBUF_tsimcreated_xor_IN1
    );
  NlwBufferBlock_rom_OBUF_REG_IN : X_BUF
    port map (
      I => rom_OBUF_tsimcreated_xor_Q_86,
      O => NlwBufferSignal_rom_OBUF_REG_IN
    );
  NlwBufferBlock_rom_OBUF_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_rom_OBUF_REG_CLK
    );
  NlwBufferBlock_rom_OBUF_D_IN0 : X_BUF
    port map (
      I => rom_OBUF_D1_89,
      O => NlwBufferSignal_rom_OBUF_D_IN0
    );
  NlwBufferBlock_rom_OBUF_D_IN1 : X_BUF
    port map (
      I => rom_OBUF_D2_90,
      O => NlwBufferSignal_rom_OBUF_D_IN1
    );
  NlwBufferBlock_rom_OBUF_D2_PT_0_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_rom_OBUF_D2_PT_0_IN0
    );
  NlwBufferBlock_rom_OBUF_D2_PT_0_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_rom_OBUF_D2_PT_0_IN1
    );
  NlwBufferBlock_rom_OBUF_D2_PT_0_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_rom_OBUF_D2_PT_0_IN2
    );
  NlwBufferBlock_rom_OBUF_D2_PT_0_IN3 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_37,
      O => NlwBufferSignal_rom_OBUF_D2_PT_0_IN3
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN0 : X_BUF
    port map (
      I => bank_7_IBUF_1,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN0
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN1 : X_BUF
    port map (
      I => bank_6_IBUF_3,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN1
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN2 : X_BUF
    port map (
      I => bank_5_IBUF_5,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN2
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN3 : X_BUF
    port map (
      I => bank_4_IBUF_7,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN3
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN4 : X_BUF
    port map (
      I => bank_3_IBUF_9,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN4
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN5 : X_BUF
    port map (
      I => bank_2_IBUF_11,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN5
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN6 : X_BUF
    port map (
      I => bank_1_IBUF_13,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN6
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN7 : X_BUF
    port map (
      I => bank_0_IBUF_15,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN7
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN8 : X_BUF
    port map (
      I => vda_IBUF_21,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN8
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN9 : X_BUF
    port map (
      I => a15_13_2_IBUF_23,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN9
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN10 : X_BUF
    port map (
      I => a15_13_1_IBUF_25,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN10
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN11 : X_BUF
    port map (
      I => a15_13_0_IBUF_27,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN11
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN12 : X_BUF
    port map (
      I => rw_IBUF_33,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN12
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN13 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN13
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN14 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN14
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN15 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN15
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN16 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_37,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN16
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN17 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN17
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN18 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN18
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN19 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN19
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN20 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN20
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN21 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN21
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN22 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN22
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN23 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN23
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN24 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN24
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN25 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN25
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN26 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN26
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN27 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN27
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN28 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN28
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN29 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN29
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN30 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN30
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN31 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN31
    );
  NlwBufferBlock_rom_OBUF_D2_PT_2_IN0 : X_BUF
    port map (
      I => bank_7_IBUF_1,
      O => NlwBufferSignal_rom_OBUF_D2_PT_2_IN0
    );
  NlwBufferBlock_rom_OBUF_D2_PT_2_IN1 : X_BUF
    port map (
      I => bank_6_IBUF_3,
      O => NlwBufferSignal_rom_OBUF_D2_PT_2_IN1
    );
  NlwBufferBlock_rom_OBUF_D2_PT_2_IN2 : X_BUF
    port map (
      I => bank_5_IBUF_5,
      O => NlwBufferSignal_rom_OBUF_D2_PT_2_IN2
    );
  NlwBufferBlock_rom_OBUF_D2_PT_2_IN3 : X_BUF
    port map (
      I => bank_4_IBUF_7,
      O => NlwBufferSignal_rom_OBUF_D2_PT_2_IN3
    );
  NlwBufferBlock_rom_OBUF_D2_PT_2_IN4 : X_BUF
    port map (
      I => bank_3_IBUF_9,
      O => NlwBufferSignal_rom_OBUF_D2_PT_2_IN4
    );
  NlwBufferBlock_rom_OBUF_D2_PT_2_IN5 : X_BUF
    port map (
      I => bank_2_IBUF_11,
      O => NlwBufferSignal_rom_OBUF_D2_PT_2_IN5
    );
  NlwBufferBlock_rom_OBUF_D2_PT_2_IN6 : X_BUF
    port map (
      I => bank_1_IBUF_13,
      O => NlwBufferSignal_rom_OBUF_D2_PT_2_IN6
    );
  NlwBufferBlock_rom_OBUF_D2_PT_2_IN7 : X_BUF
    port map (
      I => bank_0_IBUF_15,
      O => NlwBufferSignal_rom_OBUF_D2_PT_2_IN7
    );
  NlwBufferBlock_rom_OBUF_D2_PT_2_IN8 : X_BUF
    port map (
      I => a15_13_2_IBUF_23,
      O => NlwBufferSignal_rom_OBUF_D2_PT_2_IN8
    );
  NlwBufferBlock_rom_OBUF_D2_PT_2_IN9 : X_BUF
    port map (
      I => a15_13_1_IBUF_25,
      O => NlwBufferSignal_rom_OBUF_D2_PT_2_IN9
    );
  NlwBufferBlock_rom_OBUF_D2_PT_2_IN10 : X_BUF
    port map (
      I => a15_13_0_IBUF_27,
      O => NlwBufferSignal_rom_OBUF_D2_PT_2_IN10
    );
  NlwBufferBlock_rom_OBUF_D2_PT_2_IN11 : X_BUF
    port map (
      I => rw_IBUF_33,
      O => NlwBufferSignal_rom_OBUF_D2_PT_2_IN11
    );
  NlwBufferBlock_rom_OBUF_D2_PT_2_IN12 : X_BUF
    port map (
      I => vpa_IBUF_35,
      O => NlwBufferSignal_rom_OBUF_D2_PT_2_IN12
    );
  NlwBufferBlock_rom_OBUF_D2_PT_2_IN13 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_rom_OBUF_D2_PT_2_IN13
    );
  NlwBufferBlock_rom_OBUF_D2_PT_2_IN14 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_rom_OBUF_D2_PT_2_IN14
    );
  NlwBufferBlock_rom_OBUF_D2_PT_2_IN15 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_rom_OBUF_D2_PT_2_IN15
    );
  NlwBufferBlock_rom_OBUF_D2_PT_2_IN16 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_37,
      O => NlwBufferSignal_rom_OBUF_D2_PT_2_IN16
    );
  NlwBufferBlock_rom_OBUF_D2_PT_2_IN17 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_rom_OBUF_D2_PT_2_IN17
    );
  NlwBufferBlock_rom_OBUF_D2_PT_2_IN18 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_rom_OBUF_D2_PT_2_IN18
    );
  NlwBufferBlock_rom_OBUF_D2_PT_2_IN19 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_rom_OBUF_D2_PT_2_IN19
    );
  NlwBufferBlock_rom_OBUF_D2_PT_2_IN20 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_rom_OBUF_D2_PT_2_IN20
    );
  NlwBufferBlock_rom_OBUF_D2_PT_2_IN21 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_rom_OBUF_D2_PT_2_IN21
    );
  NlwBufferBlock_rom_OBUF_D2_PT_2_IN22 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_rom_OBUF_D2_PT_2_IN22
    );
  NlwBufferBlock_rom_OBUF_D2_PT_2_IN23 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_rom_OBUF_D2_PT_2_IN23
    );
  NlwBufferBlock_rom_OBUF_D2_PT_2_IN24 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_rom_OBUF_D2_PT_2_IN24
    );
  NlwBufferBlock_rom_OBUF_D2_PT_2_IN25 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_rom_OBUF_D2_PT_2_IN25
    );
  NlwBufferBlock_rom_OBUF_D2_PT_2_IN26 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_rom_OBUF_D2_PT_2_IN26
    );
  NlwBufferBlock_rom_OBUF_D2_PT_2_IN27 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_rom_OBUF_D2_PT_2_IN27
    );
  NlwBufferBlock_rom_OBUF_D2_PT_2_IN28 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_rom_OBUF_D2_PT_2_IN28
    );
  NlwBufferBlock_rom_OBUF_D2_PT_2_IN29 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_rom_OBUF_D2_PT_2_IN29
    );
  NlwBufferBlock_rom_OBUF_D2_PT_2_IN30 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_rom_OBUF_D2_PT_2_IN30
    );
  NlwBufferBlock_rom_OBUF_D2_PT_2_IN31 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_rom_OBUF_D2_PT_2_IN31
    );
  NlwBufferBlock_rom_OBUF_D2_IN0 : X_BUF
    port map (
      I => rom_OBUF_D2_PT_0_94,
      O => NlwBufferSignal_rom_OBUF_D2_IN0
    );
  NlwBufferBlock_rom_OBUF_D2_IN1 : X_BUF
    port map (
      I => rom_OBUF_D2_PT_1_95,
      O => NlwBufferSignal_rom_OBUF_D2_IN1
    );
  NlwBufferBlock_rom_OBUF_D2_IN2 : X_BUF
    port map (
      I => rom_OBUF_D2_PT_2_96,
      O => NlwBufferSignal_rom_OBUF_D2_IN2
    );
  NlwBufferBlock_phi1_OBUF_REG_IN : X_BUF
    port map (
      I => phi1_OBUF_D_98,
      O => NlwBufferSignal_phi1_OBUF_REG_IN
    );
  NlwBufferBlock_phi1_OBUF_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_phi1_OBUF_REG_CLK
    );
  NlwBufferBlock_phi1_OBUF_D_IN0 : X_BUF
    port map (
      I => phi1_OBUF_D1_99,
      O => NlwBufferSignal_phi1_OBUF_D_IN0
    );
  NlwBufferBlock_phi1_OBUF_D_IN1 : X_BUF
    port map (
      I => phi1_OBUF_D2_100,
      O => NlwBufferSignal_phi1_OBUF_D_IN1
    );
  NlwBufferBlock_phi1_OBUF_D2_PT_0_IN0 : X_BUF
    port map (
      I => refcnt_1_EXP_101,
      O => NlwBufferSignal_phi1_OBUF_D2_PT_0_IN0
    );
  NlwBufferBlock_phi1_OBUF_D2_PT_0_IN1 : X_BUF
    port map (
      I => refcnt_1_EXP_101,
      O => NlwBufferSignal_phi1_OBUF_D2_PT_0_IN1
    );
  NlwBufferBlock_phi1_OBUF_D2_PT_1_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_phi1_OBUF_D2_PT_1_IN0
    );
  NlwBufferBlock_phi1_OBUF_D2_PT_1_IN1 : X_BUF
    port map (
      I => phi1_PIN_BUF_Q_39,
      O => NlwBufferSignal_phi1_OBUF_D2_PT_1_IN1
    );
  NlwBufferBlock_phi1_OBUF_D2_PT_2_IN0 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_phi1_OBUF_D2_PT_2_IN0
    );
  NlwBufferBlock_phi1_OBUF_D2_PT_2_IN1 : X_BUF
    port map (
      I => phi1_PIN_BUF_Q_39,
      O => NlwBufferSignal_phi1_OBUF_D2_PT_2_IN1
    );
  NlwBufferBlock_phi1_OBUF_D2_PT_3_IN0 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_phi1_OBUF_D2_PT_3_IN0
    );
  NlwBufferBlock_phi1_OBUF_D2_PT_3_IN1 : X_BUF
    port map (
      I => phi1_PIN_BUF_Q_39,
      O => NlwBufferSignal_phi1_OBUF_D2_PT_3_IN1
    );
  NlwBufferBlock_phi1_OBUF_D2_PT_4_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_phi1_OBUF_D2_PT_4_IN0
    );
  NlwBufferBlock_phi1_OBUF_D2_PT_4_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_phi1_OBUF_D2_PT_4_IN1
    );
  NlwBufferBlock_phi1_OBUF_D2_PT_4_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_phi1_OBUF_D2_PT_4_IN2
    );
  NlwBufferBlock_phi1_OBUF_D2_PT_5_IN0 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_phi1_OBUF_D2_PT_5_IN0
    );
  NlwBufferBlock_phi1_OBUF_D2_PT_5_IN1 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_phi1_OBUF_D2_PT_5_IN1
    );
  NlwBufferBlock_phi1_OBUF_D2_PT_5_IN2 : X_BUF
    port map (
      I => phi1_PIN_BUF_Q_39,
      O => NlwBufferSignal_phi1_OBUF_D2_PT_5_IN2
    );
  NlwBufferBlock_phi1_OBUF_D2_IN0 : X_BUF
    port map (
      I => phi1_OBUF_D2_PT_0_102,
      O => NlwBufferSignal_phi1_OBUF_D2_IN0
    );
  NlwBufferBlock_phi1_OBUF_D2_IN1 : X_BUF
    port map (
      I => phi1_OBUF_D2_PT_1_103,
      O => NlwBufferSignal_phi1_OBUF_D2_IN1
    );
  NlwBufferBlock_phi1_OBUF_D2_IN2 : X_BUF
    port map (
      I => phi1_OBUF_D2_PT_2_104,
      O => NlwBufferSignal_phi1_OBUF_D2_IN2
    );
  NlwBufferBlock_phi1_OBUF_D2_IN3 : X_BUF
    port map (
      I => phi1_OBUF_D2_PT_3_106,
      O => NlwBufferSignal_phi1_OBUF_D2_IN3
    );
  NlwBufferBlock_phi1_OBUF_D2_IN4 : X_BUF
    port map (
      I => phi1_OBUF_D2_PT_4_107,
      O => NlwBufferSignal_phi1_OBUF_D2_IN4
    );
  NlwBufferBlock_phi1_OBUF_D2_IN5 : X_BUF
    port map (
      I => phi1_OBUF_D2_PT_5_110,
      O => NlwBufferSignal_phi1_OBUF_D2_IN5
    );
  NlwBufferBlock_cas0_OBUF_REG_IN : X_BUF
    port map (
      I => cas0_OBUF_D_112,
      O => NlwBufferSignal_cas0_OBUF_REG_IN
    );
  NlwBufferBlock_cas0_OBUF_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_cas0_OBUF_REG_CLK
    );
  NlwBufferBlock_cas0_OBUF_D_IN0 : X_BUF
    port map (
      I => cas0_OBUF_D1_113,
      O => NlwBufferSignal_cas0_OBUF_D_IN0
    );
  NlwBufferBlock_cas0_OBUF_D_IN1 : X_BUF
    port map (
      I => cas0_OBUF_D2_114,
      O => NlwBufferSignal_cas0_OBUF_D_IN1
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_0_IN0 : X_BUF
    port map (
      I => EXP0_EXP_115,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_0_IN0
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_0_IN1 : X_BUF
    port map (
      I => EXP0_EXP_115,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_0_IN1
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_1_IN0 : X_BUF
    port map (
      I => EXP3_EXP_117,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_1_IN0
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_1_IN1 : X_BUF
    port map (
      I => EXP3_EXP_117,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_1_IN1
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_2_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_2_IN0
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_2_IN1 : X_BUF
    port map (
      I => cas0_PIN_BUF_Q_41,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_2_IN1
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_3_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_3_IN0
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_3_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_3_IN1
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_4_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN0
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_4_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN1
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_4_IN2 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN2
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_5_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN0
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_5_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN1
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_5_IN2 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN2
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_6_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN0
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_6_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN1
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_6_IN2 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN2
    );
  NlwBufferBlock_cas0_OBUF_D2_IN0 : X_BUF
    port map (
      I => cas0_OBUF_D2_PT_0_116,
      O => NlwBufferSignal_cas0_OBUF_D2_IN0
    );
  NlwBufferBlock_cas0_OBUF_D2_IN1 : X_BUF
    port map (
      I => cas0_OBUF_D2_PT_1_118,
      O => NlwBufferSignal_cas0_OBUF_D2_IN1
    );
  NlwBufferBlock_cas0_OBUF_D2_IN2 : X_BUF
    port map (
      I => cas0_OBUF_D2_PT_2_119,
      O => NlwBufferSignal_cas0_OBUF_D2_IN2
    );
  NlwBufferBlock_cas0_OBUF_D2_IN3 : X_BUF
    port map (
      I => cas0_OBUF_D2_PT_3_120,
      O => NlwBufferSignal_cas0_OBUF_D2_IN3
    );
  NlwBufferBlock_cas0_OBUF_D2_IN4 : X_BUF
    port map (
      I => cas0_OBUF_D2_PT_4_122,
      O => NlwBufferSignal_cas0_OBUF_D2_IN4
    );
  NlwBufferBlock_cas0_OBUF_D2_IN5 : X_BUF
    port map (
      I => cas0_OBUF_D2_PT_5_124,
      O => NlwBufferSignal_cas0_OBUF_D2_IN5
    );
  NlwBufferBlock_cas0_OBUF_D2_IN6 : X_BUF
    port map (
      I => cas0_OBUF_D2_PT_6_126,
      O => NlwBufferSignal_cas0_OBUF_D2_IN6
    );
  NlwBufferBlock_cas1_OBUF_REG_IN : X_BUF
    port map (
      I => cas1_OBUF_D_130,
      O => NlwBufferSignal_cas1_OBUF_REG_IN
    );
  NlwBufferBlock_cas1_OBUF_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_cas1_OBUF_REG_CLK
    );
  NlwBufferBlock_cas1_OBUF_D_IN0 : X_BUF
    port map (
      I => cas1_OBUF_D1_131,
      O => NlwBufferSignal_cas1_OBUF_D_IN0
    );
  NlwBufferBlock_cas1_OBUF_D_IN1 : X_BUF
    port map (
      I => cas1_OBUF_D2_132,
      O => NlwBufferSignal_cas1_OBUF_D_IN1
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_0_IN0 : X_BUF
    port map (
      I => EXP1_EXP_133,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_0_IN0
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_0_IN1 : X_BUF
    port map (
      I => EXP1_EXP_133,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_0_IN1
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_1_IN0 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_cas1_OBUF_D2_PT_1_IN0
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_1_IN1 : X_BUF
    port map (
      I => cas1_PIN_BUF_Q_43,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_1_IN1
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_2_IN0 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN0
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_2_IN1 : X_BUF
    port map (
      I => cas1_PIN_BUF_Q_43,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN1
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_3_IN0 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN0
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_3_IN1 : X_BUF
    port map (
      I => cas1_PIN_BUF_Q_43,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN1
    );
  NlwBufferBlock_cas1_OBUF_D2_IN0 : X_BUF
    port map (
      I => cas1_OBUF_D2_PT_0_134,
      O => NlwBufferSignal_cas1_OBUF_D2_IN0
    );
  NlwBufferBlock_cas1_OBUF_D2_IN1 : X_BUF
    port map (
      I => cas1_OBUF_D2_PT_1_135,
      O => NlwBufferSignal_cas1_OBUF_D2_IN1
    );
  NlwBufferBlock_cas1_OBUF_D2_IN2 : X_BUF
    port map (
      I => cas1_OBUF_D2_PT_2_136,
      O => NlwBufferSignal_cas1_OBUF_D2_IN2
    );
  NlwBufferBlock_cas1_OBUF_D2_IN3 : X_BUF
    port map (
      I => cas1_OBUF_D2_PT_3_137,
      O => NlwBufferSignal_cas1_OBUF_D2_IN3
    );
  NlwBufferBlock_cas1_OBUF_EXP_PT_0_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_cas1_OBUF_EXP_PT_0_IN0
    );
  NlwBufferBlock_cas1_OBUF_EXP_PT_0_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_cas1_OBUF_EXP_PT_0_IN1
    );
  NlwBufferBlock_cas1_OBUF_EXP_PT_0_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_cas1_OBUF_EXP_PT_0_IN2
    );
  NlwBufferBlock_cas1_OBUF_EXP_PT_0_IN3 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_cas1_OBUF_EXP_PT_0_IN3
    );
  NlwBufferBlock_cas1_OBUF_EXP_PT_0_IN4 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_cas1_OBUF_EXP_PT_0_IN4
    );
  NlwBufferBlock_cas1_OBUF_EXP_PT_0_IN5 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_cas1_OBUF_EXP_PT_0_IN5
    );
  NlwBufferBlock_cas1_OBUF_EXP_PT_0_IN6 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_cas1_OBUF_EXP_PT_0_IN6
    );
  NlwBufferBlock_cas1_OBUF_EXP_PT_0_IN7 : X_BUF
    port map (
      I => refcnt(6),
      O => NlwBufferSignal_cas1_OBUF_EXP_PT_0_IN7
    );
  NlwBufferBlock_cas1_OBUF_EXP_PT_1_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_cas1_OBUF_EXP_PT_1_IN0
    );
  NlwBufferBlock_cas1_OBUF_EXP_PT_1_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_cas1_OBUF_EXP_PT_1_IN1
    );
  NlwBufferBlock_cas1_OBUF_EXP_PT_1_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_cas1_OBUF_EXP_PT_1_IN2
    );
  NlwBufferBlock_cas1_OBUF_EXP_PT_1_IN3 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_cas1_OBUF_EXP_PT_1_IN3
    );
  NlwBufferBlock_cas1_OBUF_EXP_PT_1_IN4 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_cas1_OBUF_EXP_PT_1_IN4
    );
  NlwBufferBlock_cas1_OBUF_EXP_PT_1_IN5 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_cas1_OBUF_EXP_PT_1_IN5
    );
  NlwBufferBlock_cas1_OBUF_EXP_PT_1_IN6 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_cas1_OBUF_EXP_PT_1_IN6
    );
  NlwBufferBlock_cas1_OBUF_EXP_PT_1_IN7 : X_BUF
    port map (
      I => refcnt(7),
      O => NlwBufferSignal_cas1_OBUF_EXP_PT_1_IN7
    );
  NlwBufferBlock_cas1_OBUF_EXP_tsimrenamed_net_IN0 : X_BUF
    port map (
      I => cas1_OBUF_EXP_PT_0_140,
      O => NlwBufferSignal_cas1_OBUF_EXP_tsimrenamed_net_IN0
    );
  NlwBufferBlock_cas1_OBUF_EXP_tsimrenamed_net_IN1 : X_BUF
    port map (
      I => cas1_OBUF_EXP_PT_1_142,
      O => NlwBufferSignal_cas1_OBUF_EXP_tsimrenamed_net_IN1
    );
  NlwBufferBlock_cas2_OBUF_REG_IN : X_BUF
    port map (
      I => cas2_OBUF_D_144,
      O => NlwBufferSignal_cas2_OBUF_REG_IN
    );
  NlwBufferBlock_cas2_OBUF_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_cas2_OBUF_REG_CLK
    );
  NlwBufferBlock_cas2_OBUF_D_IN0 : X_BUF
    port map (
      I => cas2_OBUF_D1_145,
      O => NlwBufferSignal_cas2_OBUF_D_IN0
    );
  NlwBufferBlock_cas2_OBUF_D_IN1 : X_BUF
    port map (
      I => cas2_OBUF_D2_146,
      O => NlwBufferSignal_cas2_OBUF_D_IN1
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_0_IN0 : X_BUF
    port map (
      I => refcnt_2_EXP_147,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_0_IN0
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_0_IN1 : X_BUF
    port map (
      I => refcnt_2_EXP_147,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_0_IN1
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_1_IN0 : X_BUF
    port map (
      I => refcnt_5_EXP_149,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_1_IN0
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_1_IN1 : X_BUF
    port map (
      I => refcnt_5_EXP_149,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_1_IN1
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_2_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_17,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_2_IN0
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_2_IN1 : X_BUF
    port map (
      I => cas2_PIN_BUF_Q_45,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_2_IN1
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_3_IN0 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_37,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN0
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_3_IN1 : X_BUF
    port map (
      I => cas2_PIN_BUF_Q_45,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN1
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_4_IN0 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN0
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_4_IN1 : X_BUF
    port map (
      I => cas2_PIN_BUF_Q_45,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN1
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_5_IN0 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN0
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_5_IN1 : X_BUF
    port map (
      I => cas2_PIN_BUF_Q_45,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN1
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_6_IN0 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN0
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_6_IN1 : X_BUF
    port map (
      I => cas2_PIN_BUF_Q_45,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN1
    );
  NlwBufferBlock_cas2_OBUF_D2_IN0 : X_BUF
    port map (
      I => cas2_OBUF_D2_PT_0_148,
      O => NlwBufferSignal_cas2_OBUF_D2_IN0
    );
  NlwBufferBlock_cas2_OBUF_D2_IN1 : X_BUF
    port map (
      I => cas2_OBUF_D2_PT_1_150,
      O => NlwBufferSignal_cas2_OBUF_D2_IN1
    );
  NlwBufferBlock_cas2_OBUF_D2_IN2 : X_BUF
    port map (
      I => cas2_OBUF_D2_PT_2_151,
      O => NlwBufferSignal_cas2_OBUF_D2_IN2
    );
  NlwBufferBlock_cas2_OBUF_D2_IN3 : X_BUF
    port map (
      I => cas2_OBUF_D2_PT_3_152,
      O => NlwBufferSignal_cas2_OBUF_D2_IN3
    );
  NlwBufferBlock_cas2_OBUF_D2_IN4 : X_BUF
    port map (
      I => cas2_OBUF_D2_PT_4_153,
      O => NlwBufferSignal_cas2_OBUF_D2_IN4
    );
  NlwBufferBlock_cas2_OBUF_D2_IN5 : X_BUF
    port map (
      I => cas2_OBUF_D2_PT_5_154,
      O => NlwBufferSignal_cas2_OBUF_D2_IN5
    );
  NlwBufferBlock_cas2_OBUF_D2_IN6 : X_BUF
    port map (
      I => cas2_OBUF_D2_PT_6_155,
      O => NlwBufferSignal_cas2_OBUF_D2_IN6
    );
  NlwBufferBlock_cas3_OBUF_REG_IN : X_BUF
    port map (
      I => cas3_OBUF_D_157,
      O => NlwBufferSignal_cas3_OBUF_REG_IN
    );
  NlwBufferBlock_cas3_OBUF_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_cas3_OBUF_REG_CLK
    );
  NlwBufferBlock_cas3_OBUF_D_IN0 : X_BUF
    port map (
      I => cas3_OBUF_D1_158,
      O => NlwBufferSignal_cas3_OBUF_D_IN0
    );
  NlwBufferBlock_cas3_OBUF_D_IN1 : X_BUF
    port map (
      I => cas3_OBUF_D2_159,
      O => NlwBufferSignal_cas3_OBUF_D_IN1
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_0_IN0 : X_BUF
    port map (
      I => refcnt_3_EXP_160,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_0_IN0
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_0_IN1 : X_BUF
    port map (
      I => refcnt_3_EXP_160,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_0_IN1
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_1_IN0 : X_BUF
    port map (
      I => phi0_OBUF_EXP_162,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_1_IN0
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_1_IN1 : X_BUF
    port map (
      I => phi0_OBUF_EXP_162,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_1_IN1
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_2_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_17,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN0
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_2_IN1 : X_BUF
    port map (
      I => cas3_PIN_BUF_Q_47,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN1
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_3_IN0 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_37,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN0
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_3_IN1 : X_BUF
    port map (
      I => cas3_PIN_BUF_Q_47,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN1
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_4_IN0 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN0
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_4_IN1 : X_BUF
    port map (
      I => cas3_PIN_BUF_Q_47,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN1
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_5_IN0 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN0
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_5_IN1 : X_BUF
    port map (
      I => cas3_PIN_BUF_Q_47,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN1
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_6_IN0 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_cas3_OBUF_D2_PT_6_IN0
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_6_IN1 : X_BUF
    port map (
      I => cas3_PIN_BUF_Q_47,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_6_IN1
    );
  NlwBufferBlock_cas3_OBUF_D2_IN0 : X_BUF
    port map (
      I => cas3_OBUF_D2_PT_0_161,
      O => NlwBufferSignal_cas3_OBUF_D2_IN0
    );
  NlwBufferBlock_cas3_OBUF_D2_IN1 : X_BUF
    port map (
      I => cas3_OBUF_D2_PT_1_163,
      O => NlwBufferSignal_cas3_OBUF_D2_IN1
    );
  NlwBufferBlock_cas3_OBUF_D2_IN2 : X_BUF
    port map (
      I => cas3_OBUF_D2_PT_2_164,
      O => NlwBufferSignal_cas3_OBUF_D2_IN2
    );
  NlwBufferBlock_cas3_OBUF_D2_IN3 : X_BUF
    port map (
      I => cas3_OBUF_D2_PT_3_165,
      O => NlwBufferSignal_cas3_OBUF_D2_IN3
    );
  NlwBufferBlock_cas3_OBUF_D2_IN4 : X_BUF
    port map (
      I => cas3_OBUF_D2_PT_4_166,
      O => NlwBufferSignal_cas3_OBUF_D2_IN4
    );
  NlwBufferBlock_cas3_OBUF_D2_IN5 : X_BUF
    port map (
      I => cas3_OBUF_D2_PT_5_167,
      O => NlwBufferSignal_cas3_OBUF_D2_IN5
    );
  NlwBufferBlock_cas3_OBUF_D2_IN6 : X_BUF
    port map (
      I => cas3_OBUF_D2_PT_6_168,
      O => NlwBufferSignal_cas3_OBUF_D2_IN6
    );
  NlwBufferBlock_io0_OBUF_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => io0_OBUF_D_170,
      O => NlwBufferSignal_io0_OBUF_tsimcreated_xor_IN0
    );
  NlwBufferBlock_io0_OBUF_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => io0_OBUF_Q_169,
      O => NlwBufferSignal_io0_OBUF_tsimcreated_xor_IN1
    );
  NlwBufferBlock_io0_OBUF_REG_IN : X_BUF
    port map (
      I => io0_OBUF_tsimcreated_xor_Q_171,
      O => NlwBufferSignal_io0_OBUF_REG_IN
    );
  NlwBufferBlock_io0_OBUF_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_io0_OBUF_REG_CLK
    );
  NlwBufferBlock_io0_OBUF_D_IN0 : X_BUF
    port map (
      I => io0_OBUF_D1_172,
      O => NlwBufferSignal_io0_OBUF_D_IN0
    );
  NlwBufferBlock_io0_OBUF_D_IN1 : X_BUF
    port map (
      I => io0_OBUF_D2_173,
      O => NlwBufferSignal_io0_OBUF_D_IN1
    );
  NlwBufferBlock_io0_OBUF_D2_PT_0_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_io0_OBUF_D2_PT_0_IN0
    );
  NlwBufferBlock_io0_OBUF_D2_PT_0_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_io0_OBUF_D2_PT_0_IN1
    );
  NlwBufferBlock_io0_OBUF_D2_PT_0_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_io0_OBUF_D2_PT_0_IN2
    );
  NlwBufferBlock_io0_OBUF_D2_PT_0_IN3 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_io0_OBUF_D2_PT_0_IN3
    );
  NlwBufferBlock_io0_OBUF_D2_PT_0_IN4 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_io0_OBUF_D2_PT_0_IN4
    );
  NlwBufferBlock_io0_OBUF_D2_PT_0_IN5 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_io0_OBUF_D2_PT_0_IN5
    );
  NlwBufferBlock_io0_OBUF_D2_PT_0_IN6 : X_BUF
    port map (
      I => io0_PIN_BUF_Q_49,
      O => NlwBufferSignal_io0_OBUF_D2_PT_0_IN6
    );
  NlwBufferBlock_io0_OBUF_D2_PT_1_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_17,
      O => NlwBufferSignal_io0_OBUF_D2_PT_1_IN0
    );
  NlwBufferBlock_io0_OBUF_D2_PT_1_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_19,
      O => NlwBufferSignal_io0_OBUF_D2_PT_1_IN1
    );
  NlwBufferBlock_io0_OBUF_D2_PT_1_IN2 : X_BUF
    port map (
      I => a10_IBUF_29,
      O => NlwBufferSignal_io0_OBUF_D2_PT_1_IN2
    );
  NlwBufferBlock_io0_OBUF_D2_PT_1_IN3 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_io0_OBUF_D2_PT_1_IN3
    );
  NlwBufferBlock_io0_OBUF_D2_PT_1_IN4 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_io0_OBUF_D2_PT_1_IN4
    );
  NlwBufferBlock_io0_OBUF_D2_PT_1_IN5 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_io0_OBUF_D2_PT_1_IN5
    );
  NlwBufferBlock_io0_OBUF_D2_PT_1_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_io0_OBUF_D2_PT_1_IN6
    );
  NlwBufferBlock_io0_OBUF_D2_PT_1_IN7 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_io0_OBUF_D2_PT_1_IN7
    );
  NlwBufferBlock_io0_OBUF_D2_PT_1_IN8 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_io0_OBUF_D2_PT_1_IN8
    );
  NlwBufferBlock_io0_OBUF_D2_PT_1_IN9 : X_BUF
    port map (
      I => io0_PIN_BUF_Q_49,
      O => NlwBufferSignal_io0_OBUF_D2_PT_1_IN9
    );
  NlwBufferBlock_io0_OBUF_D2_PT_1_IN10 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io0_OBUF_D2_PT_1_IN10
    );
  NlwBufferBlock_io0_OBUF_D2_PT_1_IN11 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io0_OBUF_D2_PT_1_IN11
    );
  NlwBufferBlock_io0_OBUF_D2_PT_1_IN12 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io0_OBUF_D2_PT_1_IN12
    );
  NlwBufferBlock_io0_OBUF_D2_PT_1_IN13 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io0_OBUF_D2_PT_1_IN13
    );
  NlwBufferBlock_io0_OBUF_D2_PT_1_IN14 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io0_OBUF_D2_PT_1_IN14
    );
  NlwBufferBlock_io0_OBUF_D2_PT_1_IN15 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io0_OBUF_D2_PT_1_IN15
    );
  NlwBufferBlock_io0_OBUF_D2_IN0 : X_BUF
    port map (
      I => io0_OBUF_D2_PT_0_174,
      O => NlwBufferSignal_io0_OBUF_D2_IN0
    );
  NlwBufferBlock_io0_OBUF_D2_IN1 : X_BUF
    port map (
      I => io0_OBUF_D2_PT_1_175,
      O => NlwBufferSignal_io0_OBUF_D2_IN1
    );
  NlwBufferBlock_io1_OBUF_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => io1_OBUF_D_177,
      O => NlwBufferSignal_io1_OBUF_tsimcreated_xor_IN0
    );
  NlwBufferBlock_io1_OBUF_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => io1_OBUF_Q_176,
      O => NlwBufferSignal_io1_OBUF_tsimcreated_xor_IN1
    );
  NlwBufferBlock_io1_OBUF_REG_IN : X_BUF
    port map (
      I => io1_OBUF_tsimcreated_xor_Q_178,
      O => NlwBufferSignal_io1_OBUF_REG_IN
    );
  NlwBufferBlock_io1_OBUF_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_io1_OBUF_REG_CLK
    );
  NlwBufferBlock_io1_OBUF_D_IN0 : X_BUF
    port map (
      I => io1_OBUF_D1_179,
      O => NlwBufferSignal_io1_OBUF_D_IN0
    );
  NlwBufferBlock_io1_OBUF_D_IN1 : X_BUF
    port map (
      I => io1_OBUF_D2_180,
      O => NlwBufferSignal_io1_OBUF_D_IN1
    );
  NlwBufferBlock_io1_OBUF_D2_PT_0_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_io1_OBUF_D2_PT_0_IN0
    );
  NlwBufferBlock_io1_OBUF_D2_PT_0_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_io1_OBUF_D2_PT_0_IN1
    );
  NlwBufferBlock_io1_OBUF_D2_PT_0_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_io1_OBUF_D2_PT_0_IN2
    );
  NlwBufferBlock_io1_OBUF_D2_PT_0_IN3 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_io1_OBUF_D2_PT_0_IN3
    );
  NlwBufferBlock_io1_OBUF_D2_PT_0_IN4 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_io1_OBUF_D2_PT_0_IN4
    );
  NlwBufferBlock_io1_OBUF_D2_PT_0_IN5 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_io1_OBUF_D2_PT_0_IN5
    );
  NlwBufferBlock_io1_OBUF_D2_PT_0_IN6 : X_BUF
    port map (
      I => io1_PIN_BUF_Q_51,
      O => NlwBufferSignal_io1_OBUF_D2_PT_0_IN6
    );
  NlwBufferBlock_io1_OBUF_D2_PT_1_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_17,
      O => NlwBufferSignal_io1_OBUF_D2_PT_1_IN0
    );
  NlwBufferBlock_io1_OBUF_D2_PT_1_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_19,
      O => NlwBufferSignal_io1_OBUF_D2_PT_1_IN1
    );
  NlwBufferBlock_io1_OBUF_D2_PT_1_IN2 : X_BUF
    port map (
      I => a10_IBUF_29,
      O => NlwBufferSignal_io1_OBUF_D2_PT_1_IN2
    );
  NlwBufferBlock_io1_OBUF_D2_PT_1_IN3 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_io1_OBUF_D2_PT_1_IN3
    );
  NlwBufferBlock_io1_OBUF_D2_PT_1_IN4 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_io1_OBUF_D2_PT_1_IN4
    );
  NlwBufferBlock_io1_OBUF_D2_PT_1_IN5 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_io1_OBUF_D2_PT_1_IN5
    );
  NlwBufferBlock_io1_OBUF_D2_PT_1_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_io1_OBUF_D2_PT_1_IN6
    );
  NlwBufferBlock_io1_OBUF_D2_PT_1_IN7 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_io1_OBUF_D2_PT_1_IN7
    );
  NlwBufferBlock_io1_OBUF_D2_PT_1_IN8 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_io1_OBUF_D2_PT_1_IN8
    );
  NlwBufferBlock_io1_OBUF_D2_PT_1_IN9 : X_BUF
    port map (
      I => io1_PIN_BUF_Q_51,
      O => NlwBufferSignal_io1_OBUF_D2_PT_1_IN9
    );
  NlwBufferBlock_io1_OBUF_D2_PT_1_IN10 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io1_OBUF_D2_PT_1_IN10
    );
  NlwBufferBlock_io1_OBUF_D2_PT_1_IN11 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io1_OBUF_D2_PT_1_IN11
    );
  NlwBufferBlock_io1_OBUF_D2_PT_1_IN12 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io1_OBUF_D2_PT_1_IN12
    );
  NlwBufferBlock_io1_OBUF_D2_PT_1_IN13 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io1_OBUF_D2_PT_1_IN13
    );
  NlwBufferBlock_io1_OBUF_D2_PT_1_IN14 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io1_OBUF_D2_PT_1_IN14
    );
  NlwBufferBlock_io1_OBUF_D2_PT_1_IN15 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io1_OBUF_D2_PT_1_IN15
    );
  NlwBufferBlock_io1_OBUF_D2_IN0 : X_BUF
    port map (
      I => io1_OBUF_D2_PT_0_181,
      O => NlwBufferSignal_io1_OBUF_D2_IN0
    );
  NlwBufferBlock_io1_OBUF_D2_IN1 : X_BUF
    port map (
      I => io1_OBUF_D2_PT_1_182,
      O => NlwBufferSignal_io1_OBUF_D2_IN1
    );
  NlwBufferBlock_io2_OBUF_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => io2_OBUF_D_184,
      O => NlwBufferSignal_io2_OBUF_tsimcreated_xor_IN0
    );
  NlwBufferBlock_io2_OBUF_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => io2_OBUF_Q_183,
      O => NlwBufferSignal_io2_OBUF_tsimcreated_xor_IN1
    );
  NlwBufferBlock_io2_OBUF_REG_IN : X_BUF
    port map (
      I => io2_OBUF_tsimcreated_xor_Q_185,
      O => NlwBufferSignal_io2_OBUF_REG_IN
    );
  NlwBufferBlock_io2_OBUF_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_io2_OBUF_REG_CLK
    );
  NlwBufferBlock_io2_OBUF_D_IN0 : X_BUF
    port map (
      I => io2_OBUF_D1_186,
      O => NlwBufferSignal_io2_OBUF_D_IN0
    );
  NlwBufferBlock_io2_OBUF_D_IN1 : X_BUF
    port map (
      I => io2_OBUF_D2_187,
      O => NlwBufferSignal_io2_OBUF_D_IN1
    );
  NlwBufferBlock_io2_OBUF_D2_PT_0_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_io2_OBUF_D2_PT_0_IN0
    );
  NlwBufferBlock_io2_OBUF_D2_PT_0_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_io2_OBUF_D2_PT_0_IN1
    );
  NlwBufferBlock_io2_OBUF_D2_PT_0_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_io2_OBUF_D2_PT_0_IN2
    );
  NlwBufferBlock_io2_OBUF_D2_PT_0_IN3 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_io2_OBUF_D2_PT_0_IN3
    );
  NlwBufferBlock_io2_OBUF_D2_PT_0_IN4 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_io2_OBUF_D2_PT_0_IN4
    );
  NlwBufferBlock_io2_OBUF_D2_PT_0_IN5 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_io2_OBUF_D2_PT_0_IN5
    );
  NlwBufferBlock_io2_OBUF_D2_PT_0_IN6 : X_BUF
    port map (
      I => io2_PIN_BUF_Q_53,
      O => NlwBufferSignal_io2_OBUF_D2_PT_0_IN6
    );
  NlwBufferBlock_io2_OBUF_D2_PT_1_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_17,
      O => NlwBufferSignal_io2_OBUF_D2_PT_1_IN0
    );
  NlwBufferBlock_io2_OBUF_D2_PT_1_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_19,
      O => NlwBufferSignal_io2_OBUF_D2_PT_1_IN1
    );
  NlwBufferBlock_io2_OBUF_D2_PT_1_IN2 : X_BUF
    port map (
      I => a10_IBUF_29,
      O => NlwBufferSignal_io2_OBUF_D2_PT_1_IN2
    );
  NlwBufferBlock_io2_OBUF_D2_PT_1_IN3 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_io2_OBUF_D2_PT_1_IN3
    );
  NlwBufferBlock_io2_OBUF_D2_PT_1_IN4 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_io2_OBUF_D2_PT_1_IN4
    );
  NlwBufferBlock_io2_OBUF_D2_PT_1_IN5 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_io2_OBUF_D2_PT_1_IN5
    );
  NlwBufferBlock_io2_OBUF_D2_PT_1_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_io2_OBUF_D2_PT_1_IN6
    );
  NlwBufferBlock_io2_OBUF_D2_PT_1_IN7 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_io2_OBUF_D2_PT_1_IN7
    );
  NlwBufferBlock_io2_OBUF_D2_PT_1_IN8 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_io2_OBUF_D2_PT_1_IN8
    );
  NlwBufferBlock_io2_OBUF_D2_PT_1_IN9 : X_BUF
    port map (
      I => io2_PIN_BUF_Q_53,
      O => NlwBufferSignal_io2_OBUF_D2_PT_1_IN9
    );
  NlwBufferBlock_io2_OBUF_D2_PT_1_IN10 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io2_OBUF_D2_PT_1_IN10
    );
  NlwBufferBlock_io2_OBUF_D2_PT_1_IN11 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io2_OBUF_D2_PT_1_IN11
    );
  NlwBufferBlock_io2_OBUF_D2_PT_1_IN12 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io2_OBUF_D2_PT_1_IN12
    );
  NlwBufferBlock_io2_OBUF_D2_PT_1_IN13 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io2_OBUF_D2_PT_1_IN13
    );
  NlwBufferBlock_io2_OBUF_D2_PT_1_IN14 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io2_OBUF_D2_PT_1_IN14
    );
  NlwBufferBlock_io2_OBUF_D2_PT_1_IN15 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io2_OBUF_D2_PT_1_IN15
    );
  NlwBufferBlock_io2_OBUF_D2_IN0 : X_BUF
    port map (
      I => io2_OBUF_D2_PT_0_188,
      O => NlwBufferSignal_io2_OBUF_D2_IN0
    );
  NlwBufferBlock_io2_OBUF_D2_IN1 : X_BUF
    port map (
      I => io2_OBUF_D2_PT_1_189,
      O => NlwBufferSignal_io2_OBUF_D2_IN1
    );
  NlwBufferBlock_io3_OBUF_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => io3_OBUF_D_191,
      O => NlwBufferSignal_io3_OBUF_tsimcreated_xor_IN0
    );
  NlwBufferBlock_io3_OBUF_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => io3_OBUF_Q_190,
      O => NlwBufferSignal_io3_OBUF_tsimcreated_xor_IN1
    );
  NlwBufferBlock_io3_OBUF_REG_IN : X_BUF
    port map (
      I => io3_OBUF_tsimcreated_xor_Q_192,
      O => NlwBufferSignal_io3_OBUF_REG_IN
    );
  NlwBufferBlock_io3_OBUF_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_io3_OBUF_REG_CLK
    );
  NlwBufferBlock_io3_OBUF_D_IN0 : X_BUF
    port map (
      I => io3_OBUF_D1_193,
      O => NlwBufferSignal_io3_OBUF_D_IN0
    );
  NlwBufferBlock_io3_OBUF_D_IN1 : X_BUF
    port map (
      I => io3_OBUF_D2_194,
      O => NlwBufferSignal_io3_OBUF_D_IN1
    );
  NlwBufferBlock_io3_OBUF_D2_PT_0_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_io3_OBUF_D2_PT_0_IN0
    );
  NlwBufferBlock_io3_OBUF_D2_PT_0_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_io3_OBUF_D2_PT_0_IN1
    );
  NlwBufferBlock_io3_OBUF_D2_PT_0_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_io3_OBUF_D2_PT_0_IN2
    );
  NlwBufferBlock_io3_OBUF_D2_PT_0_IN3 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_io3_OBUF_D2_PT_0_IN3
    );
  NlwBufferBlock_io3_OBUF_D2_PT_0_IN4 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_io3_OBUF_D2_PT_0_IN4
    );
  NlwBufferBlock_io3_OBUF_D2_PT_0_IN5 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_io3_OBUF_D2_PT_0_IN5
    );
  NlwBufferBlock_io3_OBUF_D2_PT_0_IN6 : X_BUF
    port map (
      I => io3_PIN_BUF_Q_55,
      O => NlwBufferSignal_io3_OBUF_D2_PT_0_IN6
    );
  NlwBufferBlock_io3_OBUF_D2_PT_1_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_17,
      O => NlwBufferSignal_io3_OBUF_D2_PT_1_IN0
    );
  NlwBufferBlock_io3_OBUF_D2_PT_1_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_19,
      O => NlwBufferSignal_io3_OBUF_D2_PT_1_IN1
    );
  NlwBufferBlock_io3_OBUF_D2_PT_1_IN2 : X_BUF
    port map (
      I => a10_IBUF_29,
      O => NlwBufferSignal_io3_OBUF_D2_PT_1_IN2
    );
  NlwBufferBlock_io3_OBUF_D2_PT_1_IN3 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_io3_OBUF_D2_PT_1_IN3
    );
  NlwBufferBlock_io3_OBUF_D2_PT_1_IN4 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_io3_OBUF_D2_PT_1_IN4
    );
  NlwBufferBlock_io3_OBUF_D2_PT_1_IN5 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_io3_OBUF_D2_PT_1_IN5
    );
  NlwBufferBlock_io3_OBUF_D2_PT_1_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_io3_OBUF_D2_PT_1_IN6
    );
  NlwBufferBlock_io3_OBUF_D2_PT_1_IN7 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_io3_OBUF_D2_PT_1_IN7
    );
  NlwBufferBlock_io3_OBUF_D2_PT_1_IN8 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_io3_OBUF_D2_PT_1_IN8
    );
  NlwBufferBlock_io3_OBUF_D2_PT_1_IN9 : X_BUF
    port map (
      I => io3_PIN_BUF_Q_55,
      O => NlwBufferSignal_io3_OBUF_D2_PT_1_IN9
    );
  NlwBufferBlock_io3_OBUF_D2_PT_1_IN10 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io3_OBUF_D2_PT_1_IN10
    );
  NlwBufferBlock_io3_OBUF_D2_PT_1_IN11 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io3_OBUF_D2_PT_1_IN11
    );
  NlwBufferBlock_io3_OBUF_D2_PT_1_IN12 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io3_OBUF_D2_PT_1_IN12
    );
  NlwBufferBlock_io3_OBUF_D2_PT_1_IN13 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io3_OBUF_D2_PT_1_IN13
    );
  NlwBufferBlock_io3_OBUF_D2_PT_1_IN14 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io3_OBUF_D2_PT_1_IN14
    );
  NlwBufferBlock_io3_OBUF_D2_PT_1_IN15 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io3_OBUF_D2_PT_1_IN15
    );
  NlwBufferBlock_io3_OBUF_D2_IN0 : X_BUF
    port map (
      I => io3_OBUF_D2_PT_0_195,
      O => NlwBufferSignal_io3_OBUF_D2_IN0
    );
  NlwBufferBlock_io3_OBUF_D2_IN1 : X_BUF
    port map (
      I => io3_OBUF_D2_PT_1_196,
      O => NlwBufferSignal_io3_OBUF_D2_IN1
    );
  NlwBufferBlock_io4_OBUF_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => io4_OBUF_D_198,
      O => NlwBufferSignal_io4_OBUF_tsimcreated_xor_IN0
    );
  NlwBufferBlock_io4_OBUF_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => io4_OBUF_Q_197,
      O => NlwBufferSignal_io4_OBUF_tsimcreated_xor_IN1
    );
  NlwBufferBlock_io4_OBUF_REG_IN : X_BUF
    port map (
      I => io4_OBUF_tsimcreated_xor_Q_199,
      O => NlwBufferSignal_io4_OBUF_REG_IN
    );
  NlwBufferBlock_io4_OBUF_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_io4_OBUF_REG_CLK
    );
  NlwBufferBlock_io4_OBUF_D_IN0 : X_BUF
    port map (
      I => io4_OBUF_D1_200,
      O => NlwBufferSignal_io4_OBUF_D_IN0
    );
  NlwBufferBlock_io4_OBUF_D_IN1 : X_BUF
    port map (
      I => io4_OBUF_D2_201,
      O => NlwBufferSignal_io4_OBUF_D_IN1
    );
  NlwBufferBlock_io4_OBUF_D2_PT_0_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_io4_OBUF_D2_PT_0_IN0
    );
  NlwBufferBlock_io4_OBUF_D2_PT_0_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_io4_OBUF_D2_PT_0_IN1
    );
  NlwBufferBlock_io4_OBUF_D2_PT_0_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_io4_OBUF_D2_PT_0_IN2
    );
  NlwBufferBlock_io4_OBUF_D2_PT_0_IN3 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_io4_OBUF_D2_PT_0_IN3
    );
  NlwBufferBlock_io4_OBUF_D2_PT_0_IN4 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_io4_OBUF_D2_PT_0_IN4
    );
  NlwBufferBlock_io4_OBUF_D2_PT_0_IN5 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_io4_OBUF_D2_PT_0_IN5
    );
  NlwBufferBlock_io4_OBUF_D2_PT_0_IN6 : X_BUF
    port map (
      I => io4_PIN_BUF_Q_57,
      O => NlwBufferSignal_io4_OBUF_D2_PT_0_IN6
    );
  NlwBufferBlock_io4_OBUF_D2_PT_1_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_17,
      O => NlwBufferSignal_io4_OBUF_D2_PT_1_IN0
    );
  NlwBufferBlock_io4_OBUF_D2_PT_1_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_19,
      O => NlwBufferSignal_io4_OBUF_D2_PT_1_IN1
    );
  NlwBufferBlock_io4_OBUF_D2_PT_1_IN2 : X_BUF
    port map (
      I => a10_IBUF_29,
      O => NlwBufferSignal_io4_OBUF_D2_PT_1_IN2
    );
  NlwBufferBlock_io4_OBUF_D2_PT_1_IN3 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_io4_OBUF_D2_PT_1_IN3
    );
  NlwBufferBlock_io4_OBUF_D2_PT_1_IN4 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_io4_OBUF_D2_PT_1_IN4
    );
  NlwBufferBlock_io4_OBUF_D2_PT_1_IN5 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_io4_OBUF_D2_PT_1_IN5
    );
  NlwBufferBlock_io4_OBUF_D2_PT_1_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_io4_OBUF_D2_PT_1_IN6
    );
  NlwBufferBlock_io4_OBUF_D2_PT_1_IN7 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_io4_OBUF_D2_PT_1_IN7
    );
  NlwBufferBlock_io4_OBUF_D2_PT_1_IN8 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_io4_OBUF_D2_PT_1_IN8
    );
  NlwBufferBlock_io4_OBUF_D2_PT_1_IN9 : X_BUF
    port map (
      I => io4_PIN_BUF_Q_57,
      O => NlwBufferSignal_io4_OBUF_D2_PT_1_IN9
    );
  NlwBufferBlock_io4_OBUF_D2_PT_1_IN10 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io4_OBUF_D2_PT_1_IN10
    );
  NlwBufferBlock_io4_OBUF_D2_PT_1_IN11 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io4_OBUF_D2_PT_1_IN11
    );
  NlwBufferBlock_io4_OBUF_D2_PT_1_IN12 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io4_OBUF_D2_PT_1_IN12
    );
  NlwBufferBlock_io4_OBUF_D2_PT_1_IN13 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io4_OBUF_D2_PT_1_IN13
    );
  NlwBufferBlock_io4_OBUF_D2_PT_1_IN14 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io4_OBUF_D2_PT_1_IN14
    );
  NlwBufferBlock_io4_OBUF_D2_PT_1_IN15 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io4_OBUF_D2_PT_1_IN15
    );
  NlwBufferBlock_io4_OBUF_D2_IN0 : X_BUF
    port map (
      I => io4_OBUF_D2_PT_0_202,
      O => NlwBufferSignal_io4_OBUF_D2_IN0
    );
  NlwBufferBlock_io4_OBUF_D2_IN1 : X_BUF
    port map (
      I => io4_OBUF_D2_PT_1_203,
      O => NlwBufferSignal_io4_OBUF_D2_IN1
    );
  NlwBufferBlock_io5_OBUF_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => io5_OBUF_D_205,
      O => NlwBufferSignal_io5_OBUF_tsimcreated_xor_IN0
    );
  NlwBufferBlock_io5_OBUF_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => io5_OBUF_Q_204,
      O => NlwBufferSignal_io5_OBUF_tsimcreated_xor_IN1
    );
  NlwBufferBlock_io5_OBUF_REG_IN : X_BUF
    port map (
      I => io5_OBUF_tsimcreated_xor_Q_206,
      O => NlwBufferSignal_io5_OBUF_REG_IN
    );
  NlwBufferBlock_io5_OBUF_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_io5_OBUF_REG_CLK
    );
  NlwBufferBlock_io5_OBUF_D_IN0 : X_BUF
    port map (
      I => io5_OBUF_D1_207,
      O => NlwBufferSignal_io5_OBUF_D_IN0
    );
  NlwBufferBlock_io5_OBUF_D_IN1 : X_BUF
    port map (
      I => io5_OBUF_D2_208,
      O => NlwBufferSignal_io5_OBUF_D_IN1
    );
  NlwBufferBlock_io5_OBUF_D2_PT_0_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_io5_OBUF_D2_PT_0_IN0
    );
  NlwBufferBlock_io5_OBUF_D2_PT_0_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_io5_OBUF_D2_PT_0_IN1
    );
  NlwBufferBlock_io5_OBUF_D2_PT_0_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_io5_OBUF_D2_PT_0_IN2
    );
  NlwBufferBlock_io5_OBUF_D2_PT_0_IN3 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_io5_OBUF_D2_PT_0_IN3
    );
  NlwBufferBlock_io5_OBUF_D2_PT_0_IN4 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_io5_OBUF_D2_PT_0_IN4
    );
  NlwBufferBlock_io5_OBUF_D2_PT_0_IN5 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_io5_OBUF_D2_PT_0_IN5
    );
  NlwBufferBlock_io5_OBUF_D2_PT_0_IN6 : X_BUF
    port map (
      I => io5_PIN_BUF_Q_59,
      O => NlwBufferSignal_io5_OBUF_D2_PT_0_IN6
    );
  NlwBufferBlock_io5_OBUF_D2_PT_1_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_17,
      O => NlwBufferSignal_io5_OBUF_D2_PT_1_IN0
    );
  NlwBufferBlock_io5_OBUF_D2_PT_1_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_19,
      O => NlwBufferSignal_io5_OBUF_D2_PT_1_IN1
    );
  NlwBufferBlock_io5_OBUF_D2_PT_1_IN2 : X_BUF
    port map (
      I => a10_IBUF_29,
      O => NlwBufferSignal_io5_OBUF_D2_PT_1_IN2
    );
  NlwBufferBlock_io5_OBUF_D2_PT_1_IN3 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_io5_OBUF_D2_PT_1_IN3
    );
  NlwBufferBlock_io5_OBUF_D2_PT_1_IN4 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_io5_OBUF_D2_PT_1_IN4
    );
  NlwBufferBlock_io5_OBUF_D2_PT_1_IN5 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_io5_OBUF_D2_PT_1_IN5
    );
  NlwBufferBlock_io5_OBUF_D2_PT_1_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_io5_OBUF_D2_PT_1_IN6
    );
  NlwBufferBlock_io5_OBUF_D2_PT_1_IN7 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_io5_OBUF_D2_PT_1_IN7
    );
  NlwBufferBlock_io5_OBUF_D2_PT_1_IN8 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_io5_OBUF_D2_PT_1_IN8
    );
  NlwBufferBlock_io5_OBUF_D2_PT_1_IN9 : X_BUF
    port map (
      I => io5_PIN_BUF_Q_59,
      O => NlwBufferSignal_io5_OBUF_D2_PT_1_IN9
    );
  NlwBufferBlock_io5_OBUF_D2_PT_1_IN10 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io5_OBUF_D2_PT_1_IN10
    );
  NlwBufferBlock_io5_OBUF_D2_PT_1_IN11 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io5_OBUF_D2_PT_1_IN11
    );
  NlwBufferBlock_io5_OBUF_D2_PT_1_IN12 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io5_OBUF_D2_PT_1_IN12
    );
  NlwBufferBlock_io5_OBUF_D2_PT_1_IN13 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io5_OBUF_D2_PT_1_IN13
    );
  NlwBufferBlock_io5_OBUF_D2_PT_1_IN14 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io5_OBUF_D2_PT_1_IN14
    );
  NlwBufferBlock_io5_OBUF_D2_PT_1_IN15 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io5_OBUF_D2_PT_1_IN15
    );
  NlwBufferBlock_io5_OBUF_D2_IN0 : X_BUF
    port map (
      I => io5_OBUF_D2_PT_0_209,
      O => NlwBufferSignal_io5_OBUF_D2_IN0
    );
  NlwBufferBlock_io5_OBUF_D2_IN1 : X_BUF
    port map (
      I => io5_OBUF_D2_PT_1_210,
      O => NlwBufferSignal_io5_OBUF_D2_IN1
    );
  NlwBufferBlock_io6_OBUF_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => io6_OBUF_D_212,
      O => NlwBufferSignal_io6_OBUF_tsimcreated_xor_IN0
    );
  NlwBufferBlock_io6_OBUF_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => io6_OBUF_Q_211,
      O => NlwBufferSignal_io6_OBUF_tsimcreated_xor_IN1
    );
  NlwBufferBlock_io6_OBUF_REG_IN : X_BUF
    port map (
      I => io6_OBUF_tsimcreated_xor_Q_213,
      O => NlwBufferSignal_io6_OBUF_REG_IN
    );
  NlwBufferBlock_io6_OBUF_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_io6_OBUF_REG_CLK
    );
  NlwBufferBlock_io6_OBUF_D_IN0 : X_BUF
    port map (
      I => io6_OBUF_D1_214,
      O => NlwBufferSignal_io6_OBUF_D_IN0
    );
  NlwBufferBlock_io6_OBUF_D_IN1 : X_BUF
    port map (
      I => io6_OBUF_D2_215,
      O => NlwBufferSignal_io6_OBUF_D_IN1
    );
  NlwBufferBlock_io6_OBUF_D2_PT_0_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_io6_OBUF_D2_PT_0_IN0
    );
  NlwBufferBlock_io6_OBUF_D2_PT_0_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_io6_OBUF_D2_PT_0_IN1
    );
  NlwBufferBlock_io6_OBUF_D2_PT_0_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_io6_OBUF_D2_PT_0_IN2
    );
  NlwBufferBlock_io6_OBUF_D2_PT_0_IN3 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_io6_OBUF_D2_PT_0_IN3
    );
  NlwBufferBlock_io6_OBUF_D2_PT_0_IN4 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_io6_OBUF_D2_PT_0_IN4
    );
  NlwBufferBlock_io6_OBUF_D2_PT_0_IN5 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_io6_OBUF_D2_PT_0_IN5
    );
  NlwBufferBlock_io6_OBUF_D2_PT_0_IN6 : X_BUF
    port map (
      I => io6_PIN_BUF_Q_61,
      O => NlwBufferSignal_io6_OBUF_D2_PT_0_IN6
    );
  NlwBufferBlock_io6_OBUF_D2_PT_1_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_17,
      O => NlwBufferSignal_io6_OBUF_D2_PT_1_IN0
    );
  NlwBufferBlock_io6_OBUF_D2_PT_1_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_19,
      O => NlwBufferSignal_io6_OBUF_D2_PT_1_IN1
    );
  NlwBufferBlock_io6_OBUF_D2_PT_1_IN2 : X_BUF
    port map (
      I => a10_IBUF_29,
      O => NlwBufferSignal_io6_OBUF_D2_PT_1_IN2
    );
  NlwBufferBlock_io6_OBUF_D2_PT_1_IN3 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_io6_OBUF_D2_PT_1_IN3
    );
  NlwBufferBlock_io6_OBUF_D2_PT_1_IN4 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_io6_OBUF_D2_PT_1_IN4
    );
  NlwBufferBlock_io6_OBUF_D2_PT_1_IN5 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_io6_OBUF_D2_PT_1_IN5
    );
  NlwBufferBlock_io6_OBUF_D2_PT_1_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_io6_OBUF_D2_PT_1_IN6
    );
  NlwBufferBlock_io6_OBUF_D2_PT_1_IN7 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_io6_OBUF_D2_PT_1_IN7
    );
  NlwBufferBlock_io6_OBUF_D2_PT_1_IN8 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_io6_OBUF_D2_PT_1_IN8
    );
  NlwBufferBlock_io6_OBUF_D2_PT_1_IN9 : X_BUF
    port map (
      I => io6_PIN_BUF_Q_61,
      O => NlwBufferSignal_io6_OBUF_D2_PT_1_IN9
    );
  NlwBufferBlock_io6_OBUF_D2_PT_1_IN10 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io6_OBUF_D2_PT_1_IN10
    );
  NlwBufferBlock_io6_OBUF_D2_PT_1_IN11 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io6_OBUF_D2_PT_1_IN11
    );
  NlwBufferBlock_io6_OBUF_D2_PT_1_IN12 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io6_OBUF_D2_PT_1_IN12
    );
  NlwBufferBlock_io6_OBUF_D2_PT_1_IN13 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io6_OBUF_D2_PT_1_IN13
    );
  NlwBufferBlock_io6_OBUF_D2_PT_1_IN14 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io6_OBUF_D2_PT_1_IN14
    );
  NlwBufferBlock_io6_OBUF_D2_PT_1_IN15 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io6_OBUF_D2_PT_1_IN15
    );
  NlwBufferBlock_io6_OBUF_D2_IN0 : X_BUF
    port map (
      I => io6_OBUF_D2_PT_0_216,
      O => NlwBufferSignal_io6_OBUF_D2_IN0
    );
  NlwBufferBlock_io6_OBUF_D2_IN1 : X_BUF
    port map (
      I => io6_OBUF_D2_PT_1_217,
      O => NlwBufferSignal_io6_OBUF_D2_IN1
    );
  NlwBufferBlock_io7_OBUF_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => io7_OBUF_D_219,
      O => NlwBufferSignal_io7_OBUF_tsimcreated_xor_IN0
    );
  NlwBufferBlock_io7_OBUF_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => io7_OBUF_Q_218,
      O => NlwBufferSignal_io7_OBUF_tsimcreated_xor_IN1
    );
  NlwBufferBlock_io7_OBUF_REG_IN : X_BUF
    port map (
      I => io7_OBUF_tsimcreated_xor_Q_220,
      O => NlwBufferSignal_io7_OBUF_REG_IN
    );
  NlwBufferBlock_io7_OBUF_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_io7_OBUF_REG_CLK
    );
  NlwBufferBlock_io7_OBUF_D_IN0 : X_BUF
    port map (
      I => io7_OBUF_D1_221,
      O => NlwBufferSignal_io7_OBUF_D_IN0
    );
  NlwBufferBlock_io7_OBUF_D_IN1 : X_BUF
    port map (
      I => io7_OBUF_D2_222,
      O => NlwBufferSignal_io7_OBUF_D_IN1
    );
  NlwBufferBlock_io7_OBUF_D2_PT_0_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_io7_OBUF_D2_PT_0_IN0
    );
  NlwBufferBlock_io7_OBUF_D2_PT_0_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_io7_OBUF_D2_PT_0_IN1
    );
  NlwBufferBlock_io7_OBUF_D2_PT_0_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_io7_OBUF_D2_PT_0_IN2
    );
  NlwBufferBlock_io7_OBUF_D2_PT_0_IN3 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_io7_OBUF_D2_PT_0_IN3
    );
  NlwBufferBlock_io7_OBUF_D2_PT_0_IN4 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_io7_OBUF_D2_PT_0_IN4
    );
  NlwBufferBlock_io7_OBUF_D2_PT_0_IN5 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_io7_OBUF_D2_PT_0_IN5
    );
  NlwBufferBlock_io7_OBUF_D2_PT_0_IN6 : X_BUF
    port map (
      I => io7_PIN_BUF_Q_63,
      O => NlwBufferSignal_io7_OBUF_D2_PT_0_IN6
    );
  NlwBufferBlock_io7_OBUF_D2_PT_1_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_17,
      O => NlwBufferSignal_io7_OBUF_D2_PT_1_IN0
    );
  NlwBufferBlock_io7_OBUF_D2_PT_1_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_19,
      O => NlwBufferSignal_io7_OBUF_D2_PT_1_IN1
    );
  NlwBufferBlock_io7_OBUF_D2_PT_1_IN2 : X_BUF
    port map (
      I => a10_IBUF_29,
      O => NlwBufferSignal_io7_OBUF_D2_PT_1_IN2
    );
  NlwBufferBlock_io7_OBUF_D2_PT_1_IN3 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_io7_OBUF_D2_PT_1_IN3
    );
  NlwBufferBlock_io7_OBUF_D2_PT_1_IN4 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_io7_OBUF_D2_PT_1_IN4
    );
  NlwBufferBlock_io7_OBUF_D2_PT_1_IN5 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_io7_OBUF_D2_PT_1_IN5
    );
  NlwBufferBlock_io7_OBUF_D2_PT_1_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_io7_OBUF_D2_PT_1_IN6
    );
  NlwBufferBlock_io7_OBUF_D2_PT_1_IN7 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_io7_OBUF_D2_PT_1_IN7
    );
  NlwBufferBlock_io7_OBUF_D2_PT_1_IN8 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_io7_OBUF_D2_PT_1_IN8
    );
  NlwBufferBlock_io7_OBUF_D2_PT_1_IN9 : X_BUF
    port map (
      I => io7_PIN_BUF_Q_63,
      O => NlwBufferSignal_io7_OBUF_D2_PT_1_IN9
    );
  NlwBufferBlock_io7_OBUF_D2_PT_1_IN10 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io7_OBUF_D2_PT_1_IN10
    );
  NlwBufferBlock_io7_OBUF_D2_PT_1_IN11 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io7_OBUF_D2_PT_1_IN11
    );
  NlwBufferBlock_io7_OBUF_D2_PT_1_IN12 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io7_OBUF_D2_PT_1_IN12
    );
  NlwBufferBlock_io7_OBUF_D2_PT_1_IN13 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io7_OBUF_D2_PT_1_IN13
    );
  NlwBufferBlock_io7_OBUF_D2_PT_1_IN14 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io7_OBUF_D2_PT_1_IN14
    );
  NlwBufferBlock_io7_OBUF_D2_PT_1_IN15 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_io7_OBUF_D2_PT_1_IN15
    );
  NlwBufferBlock_io7_OBUF_D2_IN0 : X_BUF
    port map (
      I => io7_OBUF_D2_PT_0_223,
      O => NlwBufferSignal_io7_OBUF_D2_IN0
    );
  NlwBufferBlock_io7_OBUF_D2_IN1 : X_BUF
    port map (
      I => io7_OBUF_D2_PT_1_224,
      O => NlwBufferSignal_io7_OBUF_D2_IN1
    );
  NlwBufferBlock_phi0_OBUF_REG_IN : X_BUF
    port map (
      I => phi0_OBUF_D_227,
      O => NlwBufferSignal_phi0_OBUF_REG_IN
    );
  NlwBufferBlock_phi0_OBUF_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_phi0_OBUF_REG_CLK
    );
  NlwBufferBlock_phi0_OBUF_D_IN0 : X_BUF
    port map (
      I => phi0_OBUF_D1_228,
      O => NlwBufferSignal_phi0_OBUF_D_IN0
    );
  NlwBufferBlock_phi0_OBUF_D_IN1 : X_BUF
    port map (
      I => phi0_OBUF_D2_229,
      O => NlwBufferSignal_phi0_OBUF_D_IN1
    );
  NlwBufferBlock_phi0_OBUF_D2_PT_0_IN0 : X_BUF
    port map (
      I => refcnt_7_EXP_230,
      O => NlwBufferSignal_phi0_OBUF_D2_PT_0_IN0
    );
  NlwBufferBlock_phi0_OBUF_D2_PT_0_IN1 : X_BUF
    port map (
      I => refcnt_7_EXP_230,
      O => NlwBufferSignal_phi0_OBUF_D2_PT_0_IN1
    );
  NlwBufferBlock_phi0_OBUF_D2_PT_1_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_phi0_OBUF_D2_PT_1_IN0
    );
  NlwBufferBlock_phi0_OBUF_D2_PT_1_IN1 : X_BUF
    port map (
      I => phi0_PIN_BUF_Q_65,
      O => NlwBufferSignal_phi0_OBUF_D2_PT_1_IN1
    );
  NlwBufferBlock_phi0_OBUF_D2_PT_2_IN0 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_phi0_OBUF_D2_PT_2_IN0
    );
  NlwBufferBlock_phi0_OBUF_D2_PT_2_IN1 : X_BUF
    port map (
      I => phi0_PIN_BUF_Q_65,
      O => NlwBufferSignal_phi0_OBUF_D2_PT_2_IN1
    );
  NlwBufferBlock_phi0_OBUF_D2_PT_3_IN0 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_phi0_OBUF_D2_PT_3_IN0
    );
  NlwBufferBlock_phi0_OBUF_D2_PT_3_IN1 : X_BUF
    port map (
      I => phi0_PIN_BUF_Q_65,
      O => NlwBufferSignal_phi0_OBUF_D2_PT_3_IN1
    );
  NlwBufferBlock_phi0_OBUF_D2_IN0 : X_BUF
    port map (
      I => phi0_OBUF_D2_PT_0_231,
      O => NlwBufferSignal_phi0_OBUF_D2_IN0
    );
  NlwBufferBlock_phi0_OBUF_D2_IN1 : X_BUF
    port map (
      I => phi0_OBUF_D2_PT_1_232,
      O => NlwBufferSignal_phi0_OBUF_D2_IN1
    );
  NlwBufferBlock_phi0_OBUF_D2_IN2 : X_BUF
    port map (
      I => phi0_OBUF_D2_PT_2_233,
      O => NlwBufferSignal_phi0_OBUF_D2_IN2
    );
  NlwBufferBlock_phi0_OBUF_D2_IN3 : X_BUF
    port map (
      I => phi0_OBUF_D2_PT_3_234,
      O => NlwBufferSignal_phi0_OBUF_D2_IN3
    );
  NlwBufferBlock_phi0_OBUF_EXP_PT_0_IN0 : X_BUF
    port map (
      I => vda_IBUF_21,
      O => NlwBufferSignal_phi0_OBUF_EXP_PT_0_IN0
    );
  NlwBufferBlock_phi0_OBUF_EXP_PT_0_IN1 : X_BUF
    port map (
      I => vpa_IBUF_35,
      O => NlwBufferSignal_phi0_OBUF_EXP_PT_0_IN1
    );
  NlwBufferBlock_phi0_OBUF_EXP_PT_0_IN2 : X_BUF
    port map (
      I => cas3_PIN_BUF_Q_47,
      O => NlwBufferSignal_phi0_OBUF_EXP_PT_0_IN2
    );
  NlwBufferBlock_phi0_OBUF_EXP_PT_1_IN0 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN0
    );
  NlwBufferBlock_phi0_OBUF_EXP_PT_1_IN1 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN1
    );
  NlwBufferBlock_phi0_OBUF_EXP_PT_1_IN2 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN2
    );
  NlwBufferBlock_phi0_OBUF_EXP_PT_1_IN3 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN3
    );
  NlwBufferBlock_phi0_OBUF_EXP_PT_1_IN4 : X_BUF
    port map (
      I => refcnt(6),
      O => NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN4
    );
  NlwBufferBlock_phi0_OBUF_EXP_PT_1_IN5 : X_BUF
    port map (
      I => refcnt(7),
      O => NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN5
    );
  NlwBufferBlock_phi0_OBUF_EXP_PT_1_IN6 : X_BUF
    port map (
      I => cas3_PIN_BUF_Q_47,
      O => NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN6
    );
  NlwBufferBlock_phi0_OBUF_EXP_PT_1_IN7 : X_BUF
    port map (
      I => refcnt(4),
      O => NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN7
    );
  NlwBufferBlock_phi0_OBUF_EXP_PT_1_IN8 : X_BUF
    port map (
      I => refcnt(5),
      O => NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN8
    );
  NlwBufferBlock_phi0_OBUF_EXP_PT_1_IN9 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN9
    );
  NlwBufferBlock_phi0_OBUF_EXP_PT_1_IN10 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN10
    );
  NlwBufferBlock_phi0_OBUF_EXP_PT_1_IN11 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN11
    );
  NlwBufferBlock_phi0_OBUF_EXP_PT_1_IN12 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN12
    );
  NlwBufferBlock_phi0_OBUF_EXP_PT_1_IN13 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN13
    );
  NlwBufferBlock_phi0_OBUF_EXP_PT_1_IN14 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN14
    );
  NlwBufferBlock_phi0_OBUF_EXP_PT_1_IN15 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN15
    );
  NlwBufferBlock_phi0_OBUF_EXP_tsimrenamed_net_IN0 : X_BUF
    port map (
      I => phi0_OBUF_EXP_PT_0_235,
      O => NlwBufferSignal_phi0_OBUF_EXP_tsimrenamed_net_IN0
    );
  NlwBufferBlock_phi0_OBUF_EXP_tsimrenamed_net_IN1 : X_BUF
    port map (
      I => phi0_OBUF_EXP_PT_1_238,
      O => NlwBufferSignal_phi0_OBUF_EXP_tsimrenamed_net_IN1
    );
  NlwBufferBlock_ras_OBUF_REG_IN : X_BUF
    port map (
      I => ras_OBUF_D_242,
      O => NlwBufferSignal_ras_OBUF_REG_IN
    );
  NlwBufferBlock_ras_OBUF_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_ras_OBUF_REG_CLK
    );
  NlwBufferBlock_ras_OBUF_D_IN0 : X_BUF
    port map (
      I => ras_OBUF_D1_243,
      O => NlwBufferSignal_ras_OBUF_D_IN0
    );
  NlwBufferBlock_ras_OBUF_D_IN1 : X_BUF
    port map (
      I => ras_OBUF_D2_244,
      O => NlwBufferSignal_ras_OBUF_D_IN1
    );
  NlwBufferBlock_ras_OBUF_D2_PT_0_IN0 : X_BUF
    port map (
      I => EXP2_EXP_245,
      O => NlwBufferSignal_ras_OBUF_D2_PT_0_IN0
    );
  NlwBufferBlock_ras_OBUF_D2_PT_0_IN1 : X_BUF
    port map (
      I => EXP2_EXP_245,
      O => NlwBufferSignal_ras_OBUF_D2_PT_0_IN1
    );
  NlwBufferBlock_ras_OBUF_D2_PT_1_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_ras_OBUF_D2_PT_1_IN0
    );
  NlwBufferBlock_ras_OBUF_D2_PT_1_IN1 : X_BUF
    port map (
      I => Q_OpTx_FX_DC_49_UIM_247,
      O => NlwBufferSignal_ras_OBUF_D2_PT_1_IN1
    );
  NlwBufferBlock_ras_OBUF_D2_PT_1_IN2 : X_BUF
    port map (
      I => ras_PIN_BUF_Q_67,
      O => NlwBufferSignal_ras_OBUF_D2_PT_1_IN2
    );
  NlwBufferBlock_ras_OBUF_D2_PT_2_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_ras_OBUF_D2_PT_2_IN0
    );
  NlwBufferBlock_ras_OBUF_D2_PT_2_IN1 : X_BUF
    port map (
      I => Q_OpTx_FX_DC_49_UIM_247,
      O => NlwBufferSignal_ras_OBUF_D2_PT_2_IN1
    );
  NlwBufferBlock_ras_OBUF_D2_PT_2_IN2 : X_BUF
    port map (
      I => ras_PIN_BUF_Q_67,
      O => NlwBufferSignal_ras_OBUF_D2_PT_2_IN2
    );
  NlwBufferBlock_ras_OBUF_D2_PT_3_IN0 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_ras_OBUF_D2_PT_3_IN0
    );
  NlwBufferBlock_ras_OBUF_D2_PT_3_IN1 : X_BUF
    port map (
      I => Q_OpTx_FX_DC_49_UIM_247,
      O => NlwBufferSignal_ras_OBUF_D2_PT_3_IN1
    );
  NlwBufferBlock_ras_OBUF_D2_PT_3_IN2 : X_BUF
    port map (
      I => ras_PIN_BUF_Q_67,
      O => NlwBufferSignal_ras_OBUF_D2_PT_3_IN2
    );
  NlwBufferBlock_ras_OBUF_D2_IN0 : X_BUF
    port map (
      I => ras_OBUF_D2_PT_0_246,
      O => NlwBufferSignal_ras_OBUF_D2_IN0
    );
  NlwBufferBlock_ras_OBUF_D2_IN1 : X_BUF
    port map (
      I => ras_OBUF_D2_PT_1_248,
      O => NlwBufferSignal_ras_OBUF_D2_IN1
    );
  NlwBufferBlock_ras_OBUF_D2_IN2 : X_BUF
    port map (
      I => ras_OBUF_D2_PT_2_249,
      O => NlwBufferSignal_ras_OBUF_D2_IN2
    );
  NlwBufferBlock_ras_OBUF_D2_IN3 : X_BUF
    port map (
      I => ras_OBUF_D2_PT_3_250,
      O => NlwBufferSignal_ras_OBUF_D2_IN3
    );
  NlwBufferBlock_ras_OBUF_EXP_PT_0_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_ras_OBUF_EXP_PT_0_IN0
    );
  NlwBufferBlock_ras_OBUF_EXP_PT_0_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_ras_OBUF_EXP_PT_0_IN1
    );
  NlwBufferBlock_ras_OBUF_EXP_PT_1_IN0 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_ras_OBUF_EXP_PT_1_IN0
    );
  NlwBufferBlock_ras_OBUF_EXP_PT_1_IN1 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_ras_OBUF_EXP_PT_1_IN1
    );
  NlwBufferBlock_ras_OBUF_EXP_PT_1_IN2 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_ras_OBUF_EXP_PT_1_IN2
    );
  NlwBufferBlock_ras_OBUF_EXP_PT_1_IN3 : X_BUF
    port map (
      I => refcnt(6),
      O => NlwBufferSignal_ras_OBUF_EXP_PT_1_IN3
    );
  NlwBufferBlock_ras_OBUF_EXP_PT_1_IN4 : X_BUF
    port map (
      I => refcnt(7),
      O => NlwBufferSignal_ras_OBUF_EXP_PT_1_IN4
    );
  NlwBufferBlock_ras_OBUF_EXP_PT_1_IN5 : X_BUF
    port map (
      I => refcnt(4),
      O => NlwBufferSignal_ras_OBUF_EXP_PT_1_IN5
    );
  NlwBufferBlock_ras_OBUF_EXP_PT_1_IN6 : X_BUF
    port map (
      I => refcnt(5),
      O => NlwBufferSignal_ras_OBUF_EXP_PT_1_IN6
    );
  NlwBufferBlock_ras_OBUF_EXP_tsimrenamed_net_IN0 : X_BUF
    port map (
      I => ras_OBUF_EXP_PT_0_251,
      O => NlwBufferSignal_ras_OBUF_EXP_tsimrenamed_net_IN0
    );
  NlwBufferBlock_ras_OBUF_EXP_tsimrenamed_net_IN1 : X_BUF
    port map (
      I => ras_OBUF_EXP_PT_1_252,
      O => NlwBufferSignal_ras_OBUF_EXP_tsimrenamed_net_IN1
    );
  NlwBufferBlock_counter_2_REG_IN : X_BUF
    port map (
      I => counter_2_D_254,
      O => NlwBufferSignal_counter_2_REG_IN
    );
  NlwBufferBlock_counter_2_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_counter_2_REG_CLK
    );
  NlwBufferBlock_counter_2_D_IN0 : X_BUF
    port map (
      I => counter_2_D1_255,
      O => NlwBufferSignal_counter_2_D_IN0
    );
  NlwBufferBlock_counter_2_D_IN1 : X_BUF
    port map (
      I => counter_2_D2_256,
      O => NlwBufferSignal_counter_2_D_IN1
    );
  NlwBufferBlock_counter_2_D2_PT_0_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_counter_2_D2_PT_0_IN0
    );
  NlwBufferBlock_counter_2_D2_PT_0_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_counter_2_D2_PT_0_IN1
    );
  NlwBufferBlock_counter_2_D2_PT_1_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_counter_2_D2_PT_1_IN0
    );
  NlwBufferBlock_counter_2_D2_PT_1_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_counter_2_D2_PT_1_IN1
    );
  NlwBufferBlock_counter_2_D2_PT_1_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_counter_2_D2_PT_1_IN2
    );
  NlwBufferBlock_counter_2_D2_IN0 : X_BUF
    port map (
      I => counter_2_D2_PT_0_257,
      O => NlwBufferSignal_counter_2_D2_IN0
    );
  NlwBufferBlock_counter_2_D2_IN1 : X_BUF
    port map (
      I => counter_2_D2_PT_1_258,
      O => NlwBufferSignal_counter_2_D2_IN1
    );
  NlwBufferBlock_iocnt_2_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => iocnt_2_D_260,
      O => NlwBufferSignal_iocnt_2_tsimcreated_xor_IN0
    );
  NlwBufferBlock_iocnt_2_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => iocnt_2_Q_259,
      O => NlwBufferSignal_iocnt_2_tsimcreated_xor_IN1
    );
  NlwBufferBlock_iocnt_2_REG_IN : X_BUF
    port map (
      I => iocnt_2_tsimcreated_xor_Q_261,
      O => NlwBufferSignal_iocnt_2_REG_IN
    );
  NlwBufferBlock_iocnt_2_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_iocnt_2_REG_CLK
    );
  NlwBufferBlock_iocnt_2_D_IN0 : X_BUF
    port map (
      I => iocnt_2_D1_262,
      O => NlwBufferSignal_iocnt_2_D_IN0
    );
  NlwBufferBlock_iocnt_2_D_IN1 : X_BUF
    port map (
      I => iocnt_2_D2_263,
      O => NlwBufferSignal_iocnt_2_D_IN1
    );
  NlwBufferBlock_iocnt_2_D2_PT_0_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_iocnt_2_D2_PT_0_IN0
    );
  NlwBufferBlock_iocnt_2_D2_PT_0_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_iocnt_2_D2_PT_0_IN1
    );
  NlwBufferBlock_iocnt_2_D2_PT_0_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_iocnt_2_D2_PT_0_IN2
    );
  NlwBufferBlock_iocnt_2_D2_PT_0_IN3 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_iocnt_2_D2_PT_0_IN3
    );
  NlwBufferBlock_iocnt_2_D2_PT_0_IN4 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_iocnt_2_D2_PT_0_IN4
    );
  NlwBufferBlock_iocnt_2_D2_PT_1_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_iocnt_2_D2_PT_1_IN0
    );
  NlwBufferBlock_iocnt_2_D2_PT_1_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_iocnt_2_D2_PT_1_IN1
    );
  NlwBufferBlock_iocnt_2_D2_PT_1_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_iocnt_2_D2_PT_1_IN2
    );
  NlwBufferBlock_iocnt_2_D2_PT_1_IN3 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_iocnt_2_D2_PT_1_IN3
    );
  NlwBufferBlock_iocnt_2_D2_PT_1_IN4 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_iocnt_2_D2_PT_1_IN4
    );
  NlwBufferBlock_iocnt_2_D2_IN0 : X_BUF
    port map (
      I => iocnt_2_D2_PT_0_264,
      O => NlwBufferSignal_iocnt_2_D2_IN0
    );
  NlwBufferBlock_iocnt_2_D2_IN1 : X_BUF
    port map (
      I => iocnt_2_D2_PT_1_265,
      O => NlwBufferSignal_iocnt_2_D2_IN1
    );
  NlwBufferBlock_counter_0_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => counter_0_D_267,
      O => NlwBufferSignal_counter_0_tsimcreated_xor_IN0
    );
  NlwBufferBlock_counter_0_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => counter_0_Q_266,
      O => NlwBufferSignal_counter_0_tsimcreated_xor_IN1
    );
  NlwBufferBlock_counter_0_REG_IN : X_BUF
    port map (
      I => counter_0_tsimcreated_xor_Q_268,
      O => NlwBufferSignal_counter_0_REG_IN
    );
  NlwBufferBlock_counter_0_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_counter_0_REG_CLK
    );
  NlwBufferBlock_counter_0_D_IN0 : X_BUF
    port map (
      I => counter_0_D1_269,
      O => NlwBufferSignal_counter_0_D_IN0
    );
  NlwBufferBlock_counter_0_D_IN1 : X_BUF
    port map (
      I => counter_0_D2_270,
      O => NlwBufferSignal_counter_0_D_IN1
    );
  NlwBufferBlock_counter_0_D2_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_counter_0_D2_IN0
    );
  NlwBufferBlock_counter_0_D2_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_counter_0_D2_IN1
    );
  NlwBufferBlock_counter_0_D2_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_counter_0_D2_IN2
    );
  NlwBufferBlock_counter_1_REG_IN : X_BUF
    port map (
      I => counter_1_D_272,
      O => NlwBufferSignal_counter_1_REG_IN
    );
  NlwBufferBlock_counter_1_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_counter_1_REG_CLK
    );
  NlwBufferBlock_counter_1_D_IN0 : X_BUF
    port map (
      I => counter_1_D1_273,
      O => NlwBufferSignal_counter_1_D_IN0
    );
  NlwBufferBlock_counter_1_D_IN1 : X_BUF
    port map (
      I => counter_1_D2_274,
      O => NlwBufferSignal_counter_1_D_IN1
    );
  NlwBufferBlock_counter_1_D2_PT_0_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_counter_1_D2_PT_0_IN0
    );
  NlwBufferBlock_counter_1_D2_PT_0_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_counter_1_D2_PT_0_IN1
    );
  NlwBufferBlock_counter_1_D2_PT_1_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_counter_1_D2_PT_1_IN0
    );
  NlwBufferBlock_counter_1_D2_PT_1_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_counter_1_D2_PT_1_IN1
    );
  NlwBufferBlock_counter_1_D2_PT_1_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_counter_1_D2_PT_1_IN2
    );
  NlwBufferBlock_counter_1_D2_IN0 : X_BUF
    port map (
      I => counter_1_D2_PT_0_275,
      O => NlwBufferSignal_counter_1_D2_IN0
    );
  NlwBufferBlock_counter_1_D2_IN1 : X_BUF
    port map (
      I => counter_1_D2_PT_1_276,
      O => NlwBufferSignal_counter_1_D2_IN1
    );
  NlwBufferBlock_iocnt_0_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => iocnt_0_D_278,
      O => NlwBufferSignal_iocnt_0_tsimcreated_xor_IN0
    );
  NlwBufferBlock_iocnt_0_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => iocnt_0_Q_277,
      O => NlwBufferSignal_iocnt_0_tsimcreated_xor_IN1
    );
  NlwBufferBlock_iocnt_0_REG_IN : X_BUF
    port map (
      I => iocnt_0_tsimcreated_xor_Q_279,
      O => NlwBufferSignal_iocnt_0_REG_IN
    );
  NlwBufferBlock_iocnt_0_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_iocnt_0_REG_CLK
    );
  NlwBufferBlock_iocnt_0_D_IN0 : X_BUF
    port map (
      I => iocnt_0_D1_280,
      O => NlwBufferSignal_iocnt_0_D_IN0
    );
  NlwBufferBlock_iocnt_0_D_IN1 : X_BUF
    port map (
      I => iocnt_0_D2_281,
      O => NlwBufferSignal_iocnt_0_D_IN1
    );
  NlwBufferBlock_iocnt_0_D2_PT_0_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_iocnt_0_D2_PT_0_IN0
    );
  NlwBufferBlock_iocnt_0_D2_PT_0_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_iocnt_0_D2_PT_0_IN1
    );
  NlwBufferBlock_iocnt_0_D2_PT_0_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_iocnt_0_D2_PT_0_IN2
    );
  NlwBufferBlock_iocnt_0_D2_PT_0_IN3 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_iocnt_0_D2_PT_0_IN3
    );
  NlwBufferBlock_iocnt_0_D2_PT_1_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_iocnt_0_D2_PT_1_IN0
    );
  NlwBufferBlock_iocnt_0_D2_PT_1_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_iocnt_0_D2_PT_1_IN1
    );
  NlwBufferBlock_iocnt_0_D2_PT_1_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_iocnt_0_D2_PT_1_IN2
    );
  NlwBufferBlock_iocnt_0_D2_PT_1_IN3 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_iocnt_0_D2_PT_1_IN3
    );
  NlwBufferBlock_iocnt_0_D2_PT_2_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_iocnt_0_D2_PT_2_IN0
    );
  NlwBufferBlock_iocnt_0_D2_PT_2_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_iocnt_0_D2_PT_2_IN1
    );
  NlwBufferBlock_iocnt_0_D2_PT_2_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_iocnt_0_D2_PT_2_IN2
    );
  NlwBufferBlock_iocnt_0_D2_PT_2_IN3 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_iocnt_0_D2_PT_2_IN3
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN0 : X_BUF
    port map (
      I => bank_7_IBUF_1,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN0
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN1 : X_BUF
    port map (
      I => bank_6_IBUF_3,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN1
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN2 : X_BUF
    port map (
      I => bank_5_IBUF_5,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN2
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN3 : X_BUF
    port map (
      I => bank_4_IBUF_7,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN3
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN4 : X_BUF
    port map (
      I => bank_3_IBUF_9,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN4
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN5 : X_BUF
    port map (
      I => bank_2_IBUF_11,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN5
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN6 : X_BUF
    port map (
      I => bank_1_IBUF_13,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN6
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN7 : X_BUF
    port map (
      I => bank_0_IBUF_15,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN7
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN8 : X_BUF
    port map (
      I => vda_IBUF_21,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN8
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN9 : X_BUF
    port map (
      I => a15_13_2_IBUF_23,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN9
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN10 : X_BUF
    port map (
      I => a15_13_1_IBUF_25,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN10
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN11 : X_BUF
    port map (
      I => a15_13_0_IBUF_27,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN11
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN12 : X_BUF
    port map (
      I => vpa_IBUF_35,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN12
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN13 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN13
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN14 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN14
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN15 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN15
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN16 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN16
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN17 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN17
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN18 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN18
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN19 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN19
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN20 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN20
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN21 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN21
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN22 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN22
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN23 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN23
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN24 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN24
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN25 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN25
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN26 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN26
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN27 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN27
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN28 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN28
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN29 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN29
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN30 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN30
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN31 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN31
    );
  NlwBufferBlock_iocnt_0_D2_IN0 : X_BUF
    port map (
      I => iocnt_0_D2_PT_0_282,
      O => NlwBufferSignal_iocnt_0_D2_IN0
    );
  NlwBufferBlock_iocnt_0_D2_IN1 : X_BUF
    port map (
      I => iocnt_0_D2_PT_1_283,
      O => NlwBufferSignal_iocnt_0_D2_IN1
    );
  NlwBufferBlock_iocnt_0_D2_IN2 : X_BUF
    port map (
      I => iocnt_0_D2_PT_2_284,
      O => NlwBufferSignal_iocnt_0_D2_IN2
    );
  NlwBufferBlock_iocnt_0_D2_IN3 : X_BUF
    port map (
      I => iocnt_0_D2_PT_3_285,
      O => NlwBufferSignal_iocnt_0_D2_IN3
    );
  NlwBufferBlock_iocnt_1_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => iocnt_1_D_289,
      O => NlwBufferSignal_iocnt_1_tsimcreated_xor_IN0
    );
  NlwBufferBlock_iocnt_1_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => iocnt_1_Q_286,
      O => NlwBufferSignal_iocnt_1_tsimcreated_xor_IN1
    );
  NlwBufferBlock_iocnt_1_REG_IN : X_BUF
    port map (
      I => iocnt_1_tsimcreated_xor_Q_290,
      O => NlwBufferSignal_iocnt_1_REG_IN
    );
  NlwBufferBlock_iocnt_1_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_iocnt_1_REG_CLK
    );
  NlwBufferBlock_iocnt_1_D_IN0 : X_BUF
    port map (
      I => iocnt_1_D1_291,
      O => NlwBufferSignal_iocnt_1_D_IN0
    );
  NlwBufferBlock_iocnt_1_D_IN1 : X_BUF
    port map (
      I => iocnt_1_D2_292,
      O => NlwBufferSignal_iocnt_1_D_IN1
    );
  NlwBufferBlock_iocnt_1_D2_PT_0_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_iocnt_1_D2_PT_0_IN0
    );
  NlwBufferBlock_iocnt_1_D2_PT_0_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_iocnt_1_D2_PT_0_IN1
    );
  NlwBufferBlock_iocnt_1_D2_PT_0_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_iocnt_1_D2_PT_0_IN2
    );
  NlwBufferBlock_iocnt_1_D2_PT_0_IN3 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_iocnt_1_D2_PT_0_IN3
    );
  NlwBufferBlock_iocnt_1_D2_PT_0_IN4 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_iocnt_1_D2_PT_0_IN4
    );
  NlwBufferBlock_iocnt_1_D2_PT_1_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_iocnt_1_D2_PT_1_IN0
    );
  NlwBufferBlock_iocnt_1_D2_PT_1_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_iocnt_1_D2_PT_1_IN1
    );
  NlwBufferBlock_iocnt_1_D2_PT_1_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_iocnt_1_D2_PT_1_IN2
    );
  NlwBufferBlock_iocnt_1_D2_PT_1_IN3 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_iocnt_1_D2_PT_1_IN3
    );
  NlwBufferBlock_iocnt_1_D2_PT_1_IN4 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_iocnt_1_D2_PT_1_IN4
    );
  NlwBufferBlock_iocnt_1_D2_IN0 : X_BUF
    port map (
      I => iocnt_1_D2_PT_0_293,
      O => NlwBufferSignal_iocnt_1_D2_IN0
    );
  NlwBufferBlock_iocnt_1_D2_IN1 : X_BUF
    port map (
      I => iocnt_1_D2_PT_1_294,
      O => NlwBufferSignal_iocnt_1_D2_IN1
    );
  NlwBufferBlock_iocnt_1_EXP_PT_0_IN0 : X_BUF
    port map (
      I => vda_IBUF_21,
      O => NlwBufferSignal_iocnt_1_EXP_PT_0_IN0
    );
  NlwBufferBlock_iocnt_1_EXP_PT_0_IN1 : X_BUF
    port map (
      I => vpa_IBUF_35,
      O => NlwBufferSignal_iocnt_1_EXP_PT_0_IN1
    );
  NlwBufferBlock_iocnt_1_EXP_PT_0_IN2 : X_BUF
    port map (
      I => cas1_PIN_BUF_Q_43,
      O => NlwBufferSignal_iocnt_1_EXP_PT_0_IN2
    );
  NlwBufferBlock_iocnt_1_EXP_PT_1_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_iocnt_1_EXP_PT_1_IN0
    );
  NlwBufferBlock_iocnt_1_EXP_PT_1_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_iocnt_1_EXP_PT_1_IN1
    );
  NlwBufferBlock_iocnt_1_EXP_PT_1_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_iocnt_1_EXP_PT_1_IN2
    );
  NlwBufferBlock_iocnt_1_EXP_PT_2_IN0 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_iocnt_1_EXP_PT_2_IN0
    );
  NlwBufferBlock_iocnt_1_EXP_PT_2_IN1 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_iocnt_1_EXP_PT_2_IN1
    );
  NlwBufferBlock_iocnt_1_EXP_PT_2_IN2 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_iocnt_1_EXP_PT_2_IN2
    );
  NlwBufferBlock_iocnt_1_EXP_PT_2_IN3 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_iocnt_1_EXP_PT_2_IN3
    );
  NlwBufferBlock_iocnt_1_EXP_PT_2_IN4 : X_BUF
    port map (
      I => refcnt(6),
      O => NlwBufferSignal_iocnt_1_EXP_PT_2_IN4
    );
  NlwBufferBlock_iocnt_1_EXP_PT_2_IN5 : X_BUF
    port map (
      I => refcnt(7),
      O => NlwBufferSignal_iocnt_1_EXP_PT_2_IN5
    );
  NlwBufferBlock_iocnt_1_EXP_PT_2_IN6 : X_BUF
    port map (
      I => cas1_PIN_BUF_Q_43,
      O => NlwBufferSignal_iocnt_1_EXP_PT_2_IN6
    );
  NlwBufferBlock_iocnt_1_EXP_PT_2_IN7 : X_BUF
    port map (
      I => refcnt(4),
      O => NlwBufferSignal_iocnt_1_EXP_PT_2_IN7
    );
  NlwBufferBlock_iocnt_1_EXP_PT_2_IN8 : X_BUF
    port map (
      I => refcnt(5),
      O => NlwBufferSignal_iocnt_1_EXP_PT_2_IN8
    );
  NlwBufferBlock_iocnt_1_EXP_PT_2_IN9 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_iocnt_1_EXP_PT_2_IN9
    );
  NlwBufferBlock_iocnt_1_EXP_PT_2_IN10 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_iocnt_1_EXP_PT_2_IN10
    );
  NlwBufferBlock_iocnt_1_EXP_PT_2_IN11 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_iocnt_1_EXP_PT_2_IN11
    );
  NlwBufferBlock_iocnt_1_EXP_PT_2_IN12 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_iocnt_1_EXP_PT_2_IN12
    );
  NlwBufferBlock_iocnt_1_EXP_PT_2_IN13 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_iocnt_1_EXP_PT_2_IN13
    );
  NlwBufferBlock_iocnt_1_EXP_PT_2_IN14 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_iocnt_1_EXP_PT_2_IN14
    );
  NlwBufferBlock_iocnt_1_EXP_PT_2_IN15 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_iocnt_1_EXP_PT_2_IN15
    );
  NlwBufferBlock_iocnt_1_EXP_tsimrenamed_net_IN0 : X_BUF
    port map (
      I => iocnt_1_EXP_PT_0_295,
      O => NlwBufferSignal_iocnt_1_EXP_tsimrenamed_net_IN0
    );
  NlwBufferBlock_iocnt_1_EXP_tsimrenamed_net_IN1 : X_BUF
    port map (
      I => iocnt_1_EXP_PT_1_296,
      O => NlwBufferSignal_iocnt_1_EXP_tsimrenamed_net_IN1
    );
  NlwBufferBlock_iocnt_1_EXP_tsimrenamed_net_IN2 : X_BUF
    port map (
      I => iocnt_1_EXP_PT_2_297,
      O => NlwBufferSignal_iocnt_1_EXP_tsimrenamed_net_IN2
    );
  NlwBufferBlock_refcnt_0_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => refcnt_0_D_299,
      O => NlwBufferSignal_refcnt_0_tsimcreated_xor_IN0
    );
  NlwBufferBlock_refcnt_0_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => refcnt_0_Q_298,
      O => NlwBufferSignal_refcnt_0_tsimcreated_xor_IN1
    );
  NlwBufferBlock_refcnt_0_REG_IN : X_BUF
    port map (
      I => refcnt_0_tsimcreated_xor_Q_300,
      O => NlwBufferSignal_refcnt_0_REG_IN
    );
  NlwBufferBlock_refcnt_0_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_refcnt_0_REG_CLK
    );
  NlwBufferBlock_refcnt_0_D_IN0 : X_BUF
    port map (
      I => refcnt_0_D1_301,
      O => NlwBufferSignal_refcnt_0_D_IN0
    );
  NlwBufferBlock_refcnt_0_D_IN1 : X_BUF
    port map (
      I => refcnt_0_D2_302,
      O => NlwBufferSignal_refcnt_0_D_IN1
    );
  NlwBufferBlock_refcnt_0_D2_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_0_D2_IN0
    );
  NlwBufferBlock_refcnt_0_D2_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_0_D2_IN1
    );
  NlwBufferBlock_refcnt_0_D2_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_0_D2_IN2
    );
  NlwBufferBlock_refcnt_1_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => refcnt_1_D_305,
      O => NlwBufferSignal_refcnt_1_tsimcreated_xor_IN0
    );
  NlwBufferBlock_refcnt_1_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => refcnt_1_Q_303,
      O => NlwBufferSignal_refcnt_1_tsimcreated_xor_IN1
    );
  NlwBufferBlock_refcnt_1_REG_IN : X_BUF
    port map (
      I => refcnt_1_tsimcreated_xor_Q_306,
      O => NlwBufferSignal_refcnt_1_REG_IN
    );
  NlwBufferBlock_refcnt_1_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_refcnt_1_REG_CLK
    );
  NlwBufferBlock_refcnt_1_D_IN0 : X_BUF
    port map (
      I => refcnt_1_D1_307,
      O => NlwBufferSignal_refcnt_1_D_IN0
    );
  NlwBufferBlock_refcnt_1_D_IN1 : X_BUF
    port map (
      I => refcnt_1_D2_308,
      O => NlwBufferSignal_refcnt_1_D_IN1
    );
  NlwBufferBlock_refcnt_1_D2_PT_0_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_1_D2_PT_0_IN0
    );
  NlwBufferBlock_refcnt_1_D2_PT_0_IN1 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_1_D2_PT_0_IN1
    );
  NlwBufferBlock_refcnt_1_D2_PT_1_IN0 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_1_D2_PT_1_IN0
    );
  NlwBufferBlock_refcnt_1_D2_PT_1_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_1_D2_PT_1_IN1
    );
  NlwBufferBlock_refcnt_1_D2_PT_2_IN0 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_refcnt_1_D2_PT_2_IN0
    );
  NlwBufferBlock_refcnt_1_D2_PT_2_IN1 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_refcnt_1_D2_PT_2_IN1
    );
  NlwBufferBlock_refcnt_1_D2_PT_3_IN0 : X_BUF
    port map (
      I => ras_OBUF_EXP_241,
      O => NlwBufferSignal_refcnt_1_D2_PT_3_IN0
    );
  NlwBufferBlock_refcnt_1_D2_PT_3_IN1 : X_BUF
    port map (
      I => ras_OBUF_EXP_241,
      O => NlwBufferSignal_refcnt_1_D2_PT_3_IN1
    );
  NlwBufferBlock_refcnt_1_D2_IN0 : X_BUF
    port map (
      I => refcnt_1_D2_PT_0_309,
      O => NlwBufferSignal_refcnt_1_D2_IN0
    );
  NlwBufferBlock_refcnt_1_D2_IN1 : X_BUF
    port map (
      I => refcnt_1_D2_PT_1_310,
      O => NlwBufferSignal_refcnt_1_D2_IN1
    );
  NlwBufferBlock_refcnt_1_D2_IN2 : X_BUF
    port map (
      I => refcnt_1_D2_PT_2_311,
      O => NlwBufferSignal_refcnt_1_D2_IN2
    );
  NlwBufferBlock_refcnt_1_D2_IN3 : X_BUF
    port map (
      I => refcnt_1_D2_PT_3_312,
      O => NlwBufferSignal_refcnt_1_D2_IN3
    );
  NlwBufferBlock_refcnt_1_EXP_PT_0_IN0 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_refcnt_1_EXP_PT_0_IN0
    );
  NlwBufferBlock_refcnt_1_EXP_PT_0_IN1 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_refcnt_1_EXP_PT_0_IN1
    );
  NlwBufferBlock_refcnt_1_EXP_PT_0_IN2 : X_BUF
    port map (
      I => phi1_PIN_BUF_Q_39,
      O => NlwBufferSignal_refcnt_1_EXP_PT_0_IN2
    );
  NlwBufferBlock_refcnt_1_EXP_PT_1_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_1_EXP_PT_1_IN0
    );
  NlwBufferBlock_refcnt_1_EXP_PT_1_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_1_EXP_PT_1_IN1
    );
  NlwBufferBlock_refcnt_1_EXP_PT_1_IN2 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_37,
      O => NlwBufferSignal_refcnt_1_EXP_PT_1_IN2
    );
  NlwBufferBlock_refcnt_1_EXP_PT_1_IN3 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_refcnt_1_EXP_PT_1_IN3
    );
  NlwBufferBlock_refcnt_1_EXP_PT_1_IN4 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_refcnt_1_EXP_PT_1_IN4
    );
  NlwBufferBlock_refcnt_1_EXP_PT_1_IN5 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_refcnt_1_EXP_PT_1_IN5
    );
  NlwBufferBlock_refcnt_1_EXP_PT_1_IN6 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_refcnt_1_EXP_PT_1_IN6
    );
  NlwBufferBlock_refcnt_1_EXP_PT_1_IN7 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_refcnt_1_EXP_PT_1_IN7
    );
  NlwBufferBlock_refcnt_1_EXP_PT_1_IN8 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_refcnt_1_EXP_PT_1_IN8
    );
  NlwBufferBlock_refcnt_1_EXP_PT_1_IN9 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_refcnt_1_EXP_PT_1_IN9
    );
  NlwBufferBlock_refcnt_1_EXP_PT_1_IN10 : X_BUF
    port map (
      I => refcnt(6),
      O => NlwBufferSignal_refcnt_1_EXP_PT_1_IN10
    );
  NlwBufferBlock_refcnt_1_EXP_PT_1_IN11 : X_BUF
    port map (
      I => refcnt(7),
      O => NlwBufferSignal_refcnt_1_EXP_PT_1_IN11
    );
  NlwBufferBlock_refcnt_1_EXP_PT_1_IN12 : X_BUF
    port map (
      I => refcnt(4),
      O => NlwBufferSignal_refcnt_1_EXP_PT_1_IN12
    );
  NlwBufferBlock_refcnt_1_EXP_PT_1_IN13 : X_BUF
    port map (
      I => refcnt(5),
      O => NlwBufferSignal_refcnt_1_EXP_PT_1_IN13
    );
  NlwBufferBlock_refcnt_1_EXP_PT_1_IN14 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_1_EXP_PT_1_IN14
    );
  NlwBufferBlock_refcnt_1_EXP_PT_1_IN15 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_1_EXP_PT_1_IN15
    );
  NlwBufferBlock_refcnt_1_EXP_tsimrenamed_net_IN0 : X_BUF
    port map (
      I => refcnt_1_EXP_PT_0_313,
      O => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN0
    );
  NlwBufferBlock_refcnt_1_EXP_tsimrenamed_net_IN1 : X_BUF
    port map (
      I => refcnt_1_EXP_PT_1_314,
      O => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN1
    );
  NlwBufferBlock_refcnt_2_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => refcnt_2_D_317,
      O => NlwBufferSignal_refcnt_2_tsimcreated_xor_IN0
    );
  NlwBufferBlock_refcnt_2_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => refcnt_2_Q_315,
      O => NlwBufferSignal_refcnt_2_tsimcreated_xor_IN1
    );
  NlwBufferBlock_refcnt_2_REG_IN : X_BUF
    port map (
      I => refcnt_2_tsimcreated_xor_Q_318,
      O => NlwBufferSignal_refcnt_2_REG_IN
    );
  NlwBufferBlock_refcnt_2_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_refcnt_2_REG_CLK
    );
  NlwBufferBlock_refcnt_2_D_IN0 : X_BUF
    port map (
      I => refcnt_2_D1_319,
      O => NlwBufferSignal_refcnt_2_D_IN0
    );
  NlwBufferBlock_refcnt_2_D_IN1 : X_BUF
    port map (
      I => refcnt_2_D2_320,
      O => NlwBufferSignal_refcnt_2_D_IN1
    );
  NlwBufferBlock_refcnt_2_D2_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_2_D2_IN0
    );
  NlwBufferBlock_refcnt_2_D2_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_2_D2_IN1
    );
  NlwBufferBlock_refcnt_2_D2_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_2_D2_IN2
    );
  NlwBufferBlock_refcnt_2_D2_IN3 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_refcnt_2_D2_IN3
    );
  NlwBufferBlock_refcnt_2_D2_IN4 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_refcnt_2_D2_IN4
    );
  NlwBufferBlock_refcnt_2_EXP_PT_0_IN0 : X_BUF
    port map (
      I => a12_11_0_IBUF_19,
      O => NlwBufferSignal_refcnt_2_EXP_PT_0_IN0
    );
  NlwBufferBlock_refcnt_2_EXP_PT_0_IN1 : X_BUF
    port map (
      I => cas2_PIN_BUF_Q_45,
      O => NlwBufferSignal_refcnt_2_EXP_PT_0_IN1
    );
  NlwBufferBlock_refcnt_2_EXP_PT_1_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_2_EXP_PT_1_IN0
    );
  NlwBufferBlock_refcnt_2_EXP_PT_1_IN1 : X_BUF
    port map (
      I => cas2_PIN_BUF_Q_45,
      O => NlwBufferSignal_refcnt_2_EXP_PT_1_IN1
    );
  NlwBufferBlock_refcnt_2_EXP_PT_2_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_2_EXP_PT_2_IN0
    );
  NlwBufferBlock_refcnt_2_EXP_PT_2_IN1 : X_BUF
    port map (
      I => cas2_PIN_BUF_Q_45,
      O => NlwBufferSignal_refcnt_2_EXP_PT_2_IN1
    );
  NlwBufferBlock_refcnt_2_EXP_PT_3_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_2_EXP_PT_3_IN0
    );
  NlwBufferBlock_refcnt_2_EXP_PT_3_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_2_EXP_PT_3_IN1
    );
  NlwBufferBlock_refcnt_2_EXP_PT_3_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_2_EXP_PT_3_IN2
    );
  NlwBufferBlock_refcnt_2_EXP_tsimrenamed_net_IN0 : X_BUF
    port map (
      I => refcnt_2_EXP_PT_0_321,
      O => NlwBufferSignal_refcnt_2_EXP_tsimrenamed_net_IN0
    );
  NlwBufferBlock_refcnt_2_EXP_tsimrenamed_net_IN1 : X_BUF
    port map (
      I => refcnt_2_EXP_PT_1_322,
      O => NlwBufferSignal_refcnt_2_EXP_tsimrenamed_net_IN1
    );
  NlwBufferBlock_refcnt_2_EXP_tsimrenamed_net_IN2 : X_BUF
    port map (
      I => refcnt_2_EXP_PT_2_323,
      O => NlwBufferSignal_refcnt_2_EXP_tsimrenamed_net_IN2
    );
  NlwBufferBlock_refcnt_2_EXP_tsimrenamed_net_IN3 : X_BUF
    port map (
      I => refcnt_2_EXP_PT_3_324,
      O => NlwBufferSignal_refcnt_2_EXP_tsimrenamed_net_IN3
    );
  NlwBufferBlock_refcnt_3_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => refcnt_3_D_327,
      O => NlwBufferSignal_refcnt_3_tsimcreated_xor_IN0
    );
  NlwBufferBlock_refcnt_3_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => refcnt_3_Q_325,
      O => NlwBufferSignal_refcnt_3_tsimcreated_xor_IN1
    );
  NlwBufferBlock_refcnt_3_REG_IN : X_BUF
    port map (
      I => refcnt_3_tsimcreated_xor_Q_328,
      O => NlwBufferSignal_refcnt_3_REG_IN
    );
  NlwBufferBlock_refcnt_3_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_refcnt_3_REG_CLK
    );
  NlwBufferBlock_refcnt_3_D_IN0 : X_BUF
    port map (
      I => refcnt_3_D1_329,
      O => NlwBufferSignal_refcnt_3_D_IN0
    );
  NlwBufferBlock_refcnt_3_D_IN1 : X_BUF
    port map (
      I => refcnt_3_D2_330,
      O => NlwBufferSignal_refcnt_3_D_IN1
    );
  NlwBufferBlock_refcnt_3_D2_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_3_D2_IN0
    );
  NlwBufferBlock_refcnt_3_D2_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_3_D2_IN1
    );
  NlwBufferBlock_refcnt_3_D2_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_3_D2_IN2
    );
  NlwBufferBlock_refcnt_3_D2_IN3 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_refcnt_3_D2_IN3
    );
  NlwBufferBlock_refcnt_3_D2_IN4 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_refcnt_3_D2_IN4
    );
  NlwBufferBlock_refcnt_3_D2_IN5 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_refcnt_3_D2_IN5
    );
  NlwBufferBlock_refcnt_3_EXP_PT_0_IN0 : X_BUF
    port map (
      I => a12_11_0_IBUF_19,
      O => NlwBufferSignal_refcnt_3_EXP_PT_0_IN0
    );
  NlwBufferBlock_refcnt_3_EXP_PT_0_IN1 : X_BUF
    port map (
      I => cas3_PIN_BUF_Q_47,
      O => NlwBufferSignal_refcnt_3_EXP_PT_0_IN1
    );
  NlwBufferBlock_refcnt_3_EXP_PT_1_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_3_EXP_PT_1_IN0
    );
  NlwBufferBlock_refcnt_3_EXP_PT_1_IN1 : X_BUF
    port map (
      I => cas3_PIN_BUF_Q_47,
      O => NlwBufferSignal_refcnt_3_EXP_PT_1_IN1
    );
  NlwBufferBlock_refcnt_3_EXP_PT_2_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_3_EXP_PT_2_IN0
    );
  NlwBufferBlock_refcnt_3_EXP_PT_2_IN1 : X_BUF
    port map (
      I => cas3_PIN_BUF_Q_47,
      O => NlwBufferSignal_refcnt_3_EXP_PT_2_IN1
    );
  NlwBufferBlock_refcnt_3_EXP_PT_3_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_3_EXP_PT_3_IN0
    );
  NlwBufferBlock_refcnt_3_EXP_PT_3_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_3_EXP_PT_3_IN1
    );
  NlwBufferBlock_refcnt_3_EXP_PT_3_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_3_EXP_PT_3_IN2
    );
  NlwBufferBlock_refcnt_3_EXP_tsimrenamed_net_IN0 : X_BUF
    port map (
      I => refcnt_3_EXP_PT_0_331,
      O => NlwBufferSignal_refcnt_3_EXP_tsimrenamed_net_IN0
    );
  NlwBufferBlock_refcnt_3_EXP_tsimrenamed_net_IN1 : X_BUF
    port map (
      I => refcnt_3_EXP_PT_1_332,
      O => NlwBufferSignal_refcnt_3_EXP_tsimrenamed_net_IN1
    );
  NlwBufferBlock_refcnt_3_EXP_tsimrenamed_net_IN2 : X_BUF
    port map (
      I => refcnt_3_EXP_PT_2_333,
      O => NlwBufferSignal_refcnt_3_EXP_tsimrenamed_net_IN2
    );
  NlwBufferBlock_refcnt_3_EXP_tsimrenamed_net_IN3 : X_BUF
    port map (
      I => refcnt_3_EXP_PT_3_334,
      O => NlwBufferSignal_refcnt_3_EXP_tsimrenamed_net_IN3
    );
  NlwBufferBlock_refcnt_4_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => refcnt_4_D_338,
      O => NlwBufferSignal_refcnt_4_tsimcreated_xor_IN0
    );
  NlwBufferBlock_refcnt_4_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => refcnt_4_Q_335,
      O => NlwBufferSignal_refcnt_4_tsimcreated_xor_IN1
    );
  NlwBufferBlock_refcnt_4_REG_IN : X_BUF
    port map (
      I => refcnt_4_tsimcreated_xor_Q_339,
      O => NlwBufferSignal_refcnt_4_REG_IN
    );
  NlwBufferBlock_refcnt_4_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_refcnt_4_REG_CLK
    );
  NlwBufferBlock_refcnt_4_D_IN0 : X_BUF
    port map (
      I => refcnt_4_D1_340,
      O => NlwBufferSignal_refcnt_4_D_IN0
    );
  NlwBufferBlock_refcnt_4_D_IN1 : X_BUF
    port map (
      I => refcnt_4_D2_341,
      O => NlwBufferSignal_refcnt_4_D_IN1
    );
  NlwBufferBlock_refcnt_4_D2_PT_0_IN0 : X_BUF
    port map (
      I => cas1_OBUF_EXP_129,
      O => NlwBufferSignal_refcnt_4_D2_PT_0_IN0
    );
  NlwBufferBlock_refcnt_4_D2_PT_0_IN1 : X_BUF
    port map (
      I => cas1_OBUF_EXP_129,
      O => NlwBufferSignal_refcnt_4_D2_PT_0_IN1
    );
  NlwBufferBlock_refcnt_4_D2_PT_1_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_4_D2_PT_1_IN0
    );
  NlwBufferBlock_refcnt_4_D2_PT_1_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_4_D2_PT_1_IN1
    );
  NlwBufferBlock_refcnt_4_D2_PT_1_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_4_D2_PT_1_IN2
    );
  NlwBufferBlock_refcnt_4_D2_PT_1_IN3 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_refcnt_4_D2_PT_1_IN3
    );
  NlwBufferBlock_refcnt_4_D2_PT_1_IN4 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_refcnt_4_D2_PT_1_IN4
    );
  NlwBufferBlock_refcnt_4_D2_PT_1_IN5 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_refcnt_4_D2_PT_1_IN5
    );
  NlwBufferBlock_refcnt_4_D2_PT_1_IN6 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_refcnt_4_D2_PT_1_IN6
    );
  NlwBufferBlock_refcnt_4_D2_PT_1_IN7 : X_BUF
    port map (
      I => refcnt(4),
      O => NlwBufferSignal_refcnt_4_D2_PT_1_IN7
    );
  NlwBufferBlock_refcnt_4_D2_PT_2_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_4_D2_PT_2_IN0
    );
  NlwBufferBlock_refcnt_4_D2_PT_2_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_4_D2_PT_2_IN1
    );
  NlwBufferBlock_refcnt_4_D2_PT_2_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_4_D2_PT_2_IN2
    );
  NlwBufferBlock_refcnt_4_D2_PT_2_IN3 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_refcnt_4_D2_PT_2_IN3
    );
  NlwBufferBlock_refcnt_4_D2_PT_2_IN4 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_refcnt_4_D2_PT_2_IN4
    );
  NlwBufferBlock_refcnt_4_D2_PT_2_IN5 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_refcnt_4_D2_PT_2_IN5
    );
  NlwBufferBlock_refcnt_4_D2_PT_2_IN6 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_refcnt_4_D2_PT_2_IN6
    );
  NlwBufferBlock_refcnt_4_D2_PT_2_IN7 : X_BUF
    port map (
      I => refcnt(5),
      O => NlwBufferSignal_refcnt_4_D2_PT_2_IN7
    );
  NlwBufferBlock_refcnt_4_D2_IN0 : X_BUF
    port map (
      I => refcnt_4_D2_PT_0_342,
      O => NlwBufferSignal_refcnt_4_D2_IN0
    );
  NlwBufferBlock_refcnt_4_D2_IN1 : X_BUF
    port map (
      I => refcnt_4_D2_PT_1_343,
      O => NlwBufferSignal_refcnt_4_D2_IN1
    );
  NlwBufferBlock_refcnt_4_D2_IN2 : X_BUF
    port map (
      I => refcnt_4_D2_PT_2_344,
      O => NlwBufferSignal_refcnt_4_D2_IN2
    );
  NlwBufferBlock_refcnt_4_EXP_PT_0_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_4_EXP_PT_0_IN0
    );
  NlwBufferBlock_refcnt_4_EXP_PT_0_IN1 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_37,
      O => NlwBufferSignal_refcnt_4_EXP_PT_0_IN1
    );
  NlwBufferBlock_refcnt_4_EXP_PT_0_IN2 : X_BUF
    port map (
      I => cas0_PIN_BUF_Q_41,
      O => NlwBufferSignal_refcnt_4_EXP_PT_0_IN2
    );
  NlwBufferBlock_refcnt_4_EXP_PT_1_IN0 : X_BUF
    port map (
      I => vda_IBUF_21,
      O => NlwBufferSignal_refcnt_4_EXP_PT_1_IN0
    );
  NlwBufferBlock_refcnt_4_EXP_PT_1_IN1 : X_BUF
    port map (
      I => vpa_IBUF_35,
      O => NlwBufferSignal_refcnt_4_EXP_PT_1_IN1
    );
  NlwBufferBlock_refcnt_4_EXP_PT_1_IN2 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_4_EXP_PT_1_IN2
    );
  NlwBufferBlock_refcnt_4_EXP_PT_1_IN3 : X_BUF
    port map (
      I => cas0_PIN_BUF_Q_41,
      O => NlwBufferSignal_refcnt_4_EXP_PT_1_IN3
    );
  NlwBufferBlock_refcnt_4_EXP_PT_2_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_4_EXP_PT_2_IN0
    );
  NlwBufferBlock_refcnt_4_EXP_PT_2_IN1 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_refcnt_4_EXP_PT_2_IN1
    );
  NlwBufferBlock_refcnt_4_EXP_PT_2_IN2 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_refcnt_4_EXP_PT_2_IN2
    );
  NlwBufferBlock_refcnt_4_EXP_PT_2_IN3 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_refcnt_4_EXP_PT_2_IN3
    );
  NlwBufferBlock_refcnt_4_EXP_PT_2_IN4 : X_BUF
    port map (
      I => cas0_PIN_BUF_Q_41,
      O => NlwBufferSignal_refcnt_4_EXP_PT_2_IN4
    );
  NlwBufferBlock_refcnt_4_EXP_PT_2_IN5 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_refcnt_4_EXP_PT_2_IN5
    );
  NlwBufferBlock_refcnt_4_EXP_PT_2_IN6 : X_BUF
    port map (
      I => refcnt(6),
      O => NlwBufferSignal_refcnt_4_EXP_PT_2_IN6
    );
  NlwBufferBlock_refcnt_4_EXP_PT_2_IN7 : X_BUF
    port map (
      I => refcnt(7),
      O => NlwBufferSignal_refcnt_4_EXP_PT_2_IN7
    );
  NlwBufferBlock_refcnt_4_EXP_PT_2_IN8 : X_BUF
    port map (
      I => refcnt(4),
      O => NlwBufferSignal_refcnt_4_EXP_PT_2_IN8
    );
  NlwBufferBlock_refcnt_4_EXP_PT_2_IN9 : X_BUF
    port map (
      I => refcnt(5),
      O => NlwBufferSignal_refcnt_4_EXP_PT_2_IN9
    );
  NlwBufferBlock_refcnt_4_EXP_PT_2_IN10 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_4_EXP_PT_2_IN10
    );
  NlwBufferBlock_refcnt_4_EXP_PT_2_IN11 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_4_EXP_PT_2_IN11
    );
  NlwBufferBlock_refcnt_4_EXP_PT_2_IN12 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_4_EXP_PT_2_IN12
    );
  NlwBufferBlock_refcnt_4_EXP_PT_2_IN13 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_4_EXP_PT_2_IN13
    );
  NlwBufferBlock_refcnt_4_EXP_PT_2_IN14 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_4_EXP_PT_2_IN14
    );
  NlwBufferBlock_refcnt_4_EXP_PT_2_IN15 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_4_EXP_PT_2_IN15
    );
  NlwBufferBlock_refcnt_4_EXP_tsimrenamed_net_IN0 : X_BUF
    port map (
      I => refcnt_4_EXP_PT_0_345,
      O => NlwBufferSignal_refcnt_4_EXP_tsimrenamed_net_IN0
    );
  NlwBufferBlock_refcnt_4_EXP_tsimrenamed_net_IN1 : X_BUF
    port map (
      I => refcnt_4_EXP_PT_1_346,
      O => NlwBufferSignal_refcnt_4_EXP_tsimrenamed_net_IN1
    );
  NlwBufferBlock_refcnt_4_EXP_tsimrenamed_net_IN2 : X_BUF
    port map (
      I => refcnt_4_EXP_PT_2_347,
      O => NlwBufferSignal_refcnt_4_EXP_tsimrenamed_net_IN2
    );
  NlwBufferBlock_refcnt_5_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => refcnt_5_D_350,
      O => NlwBufferSignal_refcnt_5_tsimcreated_xor_IN0
    );
  NlwBufferBlock_refcnt_5_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => refcnt_5_Q_348,
      O => NlwBufferSignal_refcnt_5_tsimcreated_xor_IN1
    );
  NlwBufferBlock_refcnt_5_REG_IN : X_BUF
    port map (
      I => refcnt_5_tsimcreated_xor_Q_351,
      O => NlwBufferSignal_refcnt_5_REG_IN
    );
  NlwBufferBlock_refcnt_5_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_refcnt_5_REG_CLK
    );
  NlwBufferBlock_refcnt_5_D_IN0 : X_BUF
    port map (
      I => refcnt_5_D1_352,
      O => NlwBufferSignal_refcnt_5_D_IN0
    );
  NlwBufferBlock_refcnt_5_D_IN1 : X_BUF
    port map (
      I => refcnt_5_D2_353,
      O => NlwBufferSignal_refcnt_5_D_IN1
    );
  NlwBufferBlock_refcnt_5_D2_PT_0_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_5_D2_PT_0_IN0
    );
  NlwBufferBlock_refcnt_5_D2_PT_0_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_5_D2_PT_0_IN1
    );
  NlwBufferBlock_refcnt_5_D2_PT_0_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_5_D2_PT_0_IN2
    );
  NlwBufferBlock_refcnt_5_D2_PT_0_IN3 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_refcnt_5_D2_PT_0_IN3
    );
  NlwBufferBlock_refcnt_5_D2_PT_0_IN4 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_refcnt_5_D2_PT_0_IN4
    );
  NlwBufferBlock_refcnt_5_D2_PT_0_IN5 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_refcnt_5_D2_PT_0_IN5
    );
  NlwBufferBlock_refcnt_5_D2_PT_0_IN6 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_refcnt_5_D2_PT_0_IN6
    );
  NlwBufferBlock_refcnt_5_D2_PT_0_IN7 : X_BUF
    port map (
      I => refcnt(6),
      O => NlwBufferSignal_refcnt_5_D2_PT_0_IN7
    );
  NlwBufferBlock_refcnt_5_D2_PT_0_IN8 : X_BUF
    port map (
      I => refcnt(4),
      O => NlwBufferSignal_refcnt_5_D2_PT_0_IN8
    );
  NlwBufferBlock_refcnt_5_D2_PT_0_IN9 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_5_D2_PT_0_IN9
    );
  NlwBufferBlock_refcnt_5_D2_PT_0_IN10 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_5_D2_PT_0_IN10
    );
  NlwBufferBlock_refcnt_5_D2_PT_0_IN11 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_5_D2_PT_0_IN11
    );
  NlwBufferBlock_refcnt_5_D2_PT_0_IN12 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_5_D2_PT_0_IN12
    );
  NlwBufferBlock_refcnt_5_D2_PT_0_IN13 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_5_D2_PT_0_IN13
    );
  NlwBufferBlock_refcnt_5_D2_PT_0_IN14 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_5_D2_PT_0_IN14
    );
  NlwBufferBlock_refcnt_5_D2_PT_0_IN15 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_5_D2_PT_0_IN15
    );
  NlwBufferBlock_refcnt_5_D2_PT_1_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_5_D2_PT_1_IN0
    );
  NlwBufferBlock_refcnt_5_D2_PT_1_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_5_D2_PT_1_IN1
    );
  NlwBufferBlock_refcnt_5_D2_PT_1_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_5_D2_PT_1_IN2
    );
  NlwBufferBlock_refcnt_5_D2_PT_1_IN3 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_refcnt_5_D2_PT_1_IN3
    );
  NlwBufferBlock_refcnt_5_D2_PT_1_IN4 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_refcnt_5_D2_PT_1_IN4
    );
  NlwBufferBlock_refcnt_5_D2_PT_1_IN5 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_refcnt_5_D2_PT_1_IN5
    );
  NlwBufferBlock_refcnt_5_D2_PT_1_IN6 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_refcnt_5_D2_PT_1_IN6
    );
  NlwBufferBlock_refcnt_5_D2_PT_1_IN7 : X_BUF
    port map (
      I => refcnt(7),
      O => NlwBufferSignal_refcnt_5_D2_PT_1_IN7
    );
  NlwBufferBlock_refcnt_5_D2_PT_1_IN8 : X_BUF
    port map (
      I => refcnt(4),
      O => NlwBufferSignal_refcnt_5_D2_PT_1_IN8
    );
  NlwBufferBlock_refcnt_5_D2_PT_1_IN9 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_5_D2_PT_1_IN9
    );
  NlwBufferBlock_refcnt_5_D2_PT_1_IN10 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_5_D2_PT_1_IN10
    );
  NlwBufferBlock_refcnt_5_D2_PT_1_IN11 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_5_D2_PT_1_IN11
    );
  NlwBufferBlock_refcnt_5_D2_PT_1_IN12 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_5_D2_PT_1_IN12
    );
  NlwBufferBlock_refcnt_5_D2_PT_1_IN13 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_5_D2_PT_1_IN13
    );
  NlwBufferBlock_refcnt_5_D2_PT_1_IN14 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_5_D2_PT_1_IN14
    );
  NlwBufferBlock_refcnt_5_D2_PT_1_IN15 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_5_D2_PT_1_IN15
    );
  NlwBufferBlock_refcnt_5_D2_PT_2_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_5_D2_PT_2_IN0
    );
  NlwBufferBlock_refcnt_5_D2_PT_2_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_5_D2_PT_2_IN1
    );
  NlwBufferBlock_refcnt_5_D2_PT_2_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_5_D2_PT_2_IN2
    );
  NlwBufferBlock_refcnt_5_D2_PT_2_IN3 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_refcnt_5_D2_PT_2_IN3
    );
  NlwBufferBlock_refcnt_5_D2_PT_2_IN4 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_refcnt_5_D2_PT_2_IN4
    );
  NlwBufferBlock_refcnt_5_D2_PT_2_IN5 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_refcnt_5_D2_PT_2_IN5
    );
  NlwBufferBlock_refcnt_5_D2_PT_2_IN6 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_refcnt_5_D2_PT_2_IN6
    );
  NlwBufferBlock_refcnt_5_D2_PT_2_IN7 : X_BUF
    port map (
      I => refcnt(4),
      O => NlwBufferSignal_refcnt_5_D2_PT_2_IN7
    );
  NlwBufferBlock_refcnt_5_D2_PT_2_IN8 : X_BUF
    port map (
      I => refcnt(5),
      O => NlwBufferSignal_refcnt_5_D2_PT_2_IN8
    );
  NlwBufferBlock_refcnt_5_D2_PT_2_IN9 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_5_D2_PT_2_IN9
    );
  NlwBufferBlock_refcnt_5_D2_PT_2_IN10 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_5_D2_PT_2_IN10
    );
  NlwBufferBlock_refcnt_5_D2_PT_2_IN11 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_5_D2_PT_2_IN11
    );
  NlwBufferBlock_refcnt_5_D2_PT_2_IN12 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_5_D2_PT_2_IN12
    );
  NlwBufferBlock_refcnt_5_D2_PT_2_IN13 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_5_D2_PT_2_IN13
    );
  NlwBufferBlock_refcnt_5_D2_PT_2_IN14 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_5_D2_PT_2_IN14
    );
  NlwBufferBlock_refcnt_5_D2_PT_2_IN15 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_5_D2_PT_2_IN15
    );
  NlwBufferBlock_refcnt_5_D2_IN0 : X_BUF
    port map (
      I => refcnt_5_D2_PT_0_354,
      O => NlwBufferSignal_refcnt_5_D2_IN0
    );
  NlwBufferBlock_refcnt_5_D2_IN1 : X_BUF
    port map (
      I => refcnt_5_D2_PT_1_355,
      O => NlwBufferSignal_refcnt_5_D2_IN1
    );
  NlwBufferBlock_refcnt_5_D2_IN2 : X_BUF
    port map (
      I => refcnt_5_D2_PT_2_356,
      O => NlwBufferSignal_refcnt_5_D2_IN2
    );
  NlwBufferBlock_refcnt_5_EXP_PT_0_IN0 : X_BUF
    port map (
      I => vda_IBUF_21,
      O => NlwBufferSignal_refcnt_5_EXP_PT_0_IN0
    );
  NlwBufferBlock_refcnt_5_EXP_PT_0_IN1 : X_BUF
    port map (
      I => vpa_IBUF_35,
      O => NlwBufferSignal_refcnt_5_EXP_PT_0_IN1
    );
  NlwBufferBlock_refcnt_5_EXP_PT_0_IN2 : X_BUF
    port map (
      I => cas2_PIN_BUF_Q_45,
      O => NlwBufferSignal_refcnt_5_EXP_PT_0_IN2
    );
  NlwBufferBlock_refcnt_5_EXP_PT_1_IN0 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_refcnt_5_EXP_PT_1_IN0
    );
  NlwBufferBlock_refcnt_5_EXP_PT_1_IN1 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_refcnt_5_EXP_PT_1_IN1
    );
  NlwBufferBlock_refcnt_5_EXP_PT_1_IN2 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_refcnt_5_EXP_PT_1_IN2
    );
  NlwBufferBlock_refcnt_5_EXP_PT_1_IN3 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_refcnt_5_EXP_PT_1_IN3
    );
  NlwBufferBlock_refcnt_5_EXP_PT_1_IN4 : X_BUF
    port map (
      I => refcnt(6),
      O => NlwBufferSignal_refcnt_5_EXP_PT_1_IN4
    );
  NlwBufferBlock_refcnt_5_EXP_PT_1_IN5 : X_BUF
    port map (
      I => refcnt(7),
      O => NlwBufferSignal_refcnt_5_EXP_PT_1_IN5
    );
  NlwBufferBlock_refcnt_5_EXP_PT_1_IN6 : X_BUF
    port map (
      I => cas2_PIN_BUF_Q_45,
      O => NlwBufferSignal_refcnt_5_EXP_PT_1_IN6
    );
  NlwBufferBlock_refcnt_5_EXP_PT_1_IN7 : X_BUF
    port map (
      I => refcnt(4),
      O => NlwBufferSignal_refcnt_5_EXP_PT_1_IN7
    );
  NlwBufferBlock_refcnt_5_EXP_PT_1_IN8 : X_BUF
    port map (
      I => refcnt(5),
      O => NlwBufferSignal_refcnt_5_EXP_PT_1_IN8
    );
  NlwBufferBlock_refcnt_5_EXP_PT_1_IN9 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_5_EXP_PT_1_IN9
    );
  NlwBufferBlock_refcnt_5_EXP_PT_1_IN10 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_5_EXP_PT_1_IN10
    );
  NlwBufferBlock_refcnt_5_EXP_PT_1_IN11 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_5_EXP_PT_1_IN11
    );
  NlwBufferBlock_refcnt_5_EXP_PT_1_IN12 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_5_EXP_PT_1_IN12
    );
  NlwBufferBlock_refcnt_5_EXP_PT_1_IN13 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_5_EXP_PT_1_IN13
    );
  NlwBufferBlock_refcnt_5_EXP_PT_1_IN14 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_5_EXP_PT_1_IN14
    );
  NlwBufferBlock_refcnt_5_EXP_PT_1_IN15 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_5_EXP_PT_1_IN15
    );
  NlwBufferBlock_refcnt_5_EXP_tsimrenamed_net_IN0 : X_BUF
    port map (
      I => refcnt_5_EXP_PT_0_357,
      O => NlwBufferSignal_refcnt_5_EXP_tsimrenamed_net_IN0
    );
  NlwBufferBlock_refcnt_5_EXP_tsimrenamed_net_IN1 : X_BUF
    port map (
      I => refcnt_5_EXP_PT_1_358,
      O => NlwBufferSignal_refcnt_5_EXP_tsimrenamed_net_IN1
    );
  NlwBufferBlock_refcnt_6_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => refcnt_6_D_360,
      O => NlwBufferSignal_refcnt_6_tsimcreated_xor_IN0
    );
  NlwBufferBlock_refcnt_6_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => refcnt_6_Q_359,
      O => NlwBufferSignal_refcnt_6_tsimcreated_xor_IN1
    );
  NlwBufferBlock_refcnt_6_REG_IN : X_BUF
    port map (
      I => refcnt_6_tsimcreated_xor_Q_361,
      O => NlwBufferSignal_refcnt_6_REG_IN
    );
  NlwBufferBlock_refcnt_6_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_refcnt_6_REG_CLK
    );
  NlwBufferBlock_refcnt_6_D_IN0 : X_BUF
    port map (
      I => refcnt_6_D1_362,
      O => NlwBufferSignal_refcnt_6_D_IN0
    );
  NlwBufferBlock_refcnt_6_D_IN1 : X_BUF
    port map (
      I => refcnt_6_D2_363,
      O => NlwBufferSignal_refcnt_6_D_IN1
    );
  NlwBufferBlock_refcnt_6_D2_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_6_D2_IN0
    );
  NlwBufferBlock_refcnt_6_D2_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_6_D2_IN1
    );
  NlwBufferBlock_refcnt_6_D2_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_6_D2_IN2
    );
  NlwBufferBlock_refcnt_6_D2_IN3 : X_BUF
    port map (
      I => FC_1_OUT,
      O => NlwBufferSignal_refcnt_6_D2_IN3
    );
  NlwBufferBlock_refcnt_6_D2_IN4 : X_BUF
    port map (
      I => FC_0_OUT,
      O => NlwBufferSignal_refcnt_6_D2_IN4
    );
  NlwBufferBlock_refcnt_7_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => refcnt_7_D_368,
      O => NlwBufferSignal_refcnt_7_tsimcreated_xor_IN0
    );
  NlwBufferBlock_refcnt_7_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => refcnt_7_Q_366,
      O => NlwBufferSignal_refcnt_7_tsimcreated_xor_IN1
    );
  NlwBufferBlock_refcnt_7_REG_IN : X_BUF
    port map (
      I => refcnt_7_tsimcreated_xor_Q_369,
      O => NlwBufferSignal_refcnt_7_REG_IN
    );
  NlwBufferBlock_refcnt_7_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_refcnt_7_REG_CLK
    );
  NlwBufferBlock_refcnt_7_D_IN0 : X_BUF
    port map (
      I => refcnt_7_D1_370,
      O => NlwBufferSignal_refcnt_7_D_IN0
    );
  NlwBufferBlock_refcnt_7_D_IN1 : X_BUF
    port map (
      I => refcnt_7_D2_371,
      O => NlwBufferSignal_refcnt_7_D_IN1
    );
  NlwBufferBlock_refcnt_7_D2_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_7_D2_IN0
    );
  NlwBufferBlock_refcnt_7_D2_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_7_D2_IN1
    );
  NlwBufferBlock_refcnt_7_D2_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_7_D2_IN2
    );
  NlwBufferBlock_refcnt_7_D2_IN3 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_refcnt_7_D2_IN3
    );
  NlwBufferBlock_refcnt_7_D2_IN4 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_refcnt_7_D2_IN4
    );
  NlwBufferBlock_refcnt_7_D2_IN5 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_refcnt_7_D2_IN5
    );
  NlwBufferBlock_refcnt_7_D2_IN6 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_refcnt_7_D2_IN6
    );
  NlwBufferBlock_refcnt_7_D2_IN7 : X_BUF
    port map (
      I => refcnt(6),
      O => NlwBufferSignal_refcnt_7_D2_IN7
    );
  NlwBufferBlock_refcnt_7_D2_IN8 : X_BUF
    port map (
      I => refcnt(4),
      O => NlwBufferSignal_refcnt_7_D2_IN8
    );
  NlwBufferBlock_refcnt_7_D2_IN9 : X_BUF
    port map (
      I => refcnt(5),
      O => NlwBufferSignal_refcnt_7_D2_IN9
    );
  NlwBufferBlock_refcnt_7_D2_IN10 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_7_D2_IN10
    );
  NlwBufferBlock_refcnt_7_D2_IN11 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_7_D2_IN11
    );
  NlwBufferBlock_refcnt_7_D2_IN12 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_7_D2_IN12
    );
  NlwBufferBlock_refcnt_7_D2_IN13 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_7_D2_IN13
    );
  NlwBufferBlock_refcnt_7_D2_IN14 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_7_D2_IN14
    );
  NlwBufferBlock_refcnt_7_D2_IN15 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_7_D2_IN15
    );
  NlwBufferBlock_refcnt_7_EXP_PT_0_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_7_EXP_PT_0_IN0
    );
  NlwBufferBlock_refcnt_7_EXP_PT_0_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_7_EXP_PT_0_IN1
    );
  NlwBufferBlock_refcnt_7_EXP_PT_0_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_7_EXP_PT_0_IN2
    );
  NlwBufferBlock_refcnt_7_EXP_PT_1_IN0 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_refcnt_7_EXP_PT_1_IN0
    );
  NlwBufferBlock_refcnt_7_EXP_PT_1_IN1 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_refcnt_7_EXP_PT_1_IN1
    );
  NlwBufferBlock_refcnt_7_EXP_PT_1_IN2 : X_BUF
    port map (
      I => phi0_PIN_BUF_Q_65,
      O => NlwBufferSignal_refcnt_7_EXP_PT_1_IN2
    );
  NlwBufferBlock_refcnt_7_EXP_PT_2_IN0 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_refcnt_7_EXP_PT_2_IN0
    );
  NlwBufferBlock_refcnt_7_EXP_PT_2_IN1 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_refcnt_7_EXP_PT_2_IN1
    );
  NlwBufferBlock_refcnt_7_EXP_PT_2_IN2 : X_BUF
    port map (
      I => phi0_PIN_BUF_Q_65,
      O => NlwBufferSignal_refcnt_7_EXP_PT_2_IN2
    );
  NlwBufferBlock_refcnt_7_EXP_PT_3_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_7_EXP_PT_3_IN0
    );
  NlwBufferBlock_refcnt_7_EXP_PT_3_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_7_EXP_PT_3_IN1
    );
  NlwBufferBlock_refcnt_7_EXP_PT_3_IN2 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_37,
      O => NlwBufferSignal_refcnt_7_EXP_PT_3_IN2
    );
  NlwBufferBlock_refcnt_7_EXP_PT_3_IN3 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_refcnt_7_EXP_PT_3_IN3
    );
  NlwBufferBlock_refcnt_7_EXP_PT_3_IN4 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_refcnt_7_EXP_PT_3_IN4
    );
  NlwBufferBlock_refcnt_7_EXP_PT_3_IN5 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_refcnt_7_EXP_PT_3_IN5
    );
  NlwBufferBlock_refcnt_7_EXP_PT_3_IN6 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_refcnt_7_EXP_PT_3_IN6
    );
  NlwBufferBlock_refcnt_7_EXP_PT_3_IN7 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_refcnt_7_EXP_PT_3_IN7
    );
  NlwBufferBlock_refcnt_7_EXP_PT_3_IN8 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_refcnt_7_EXP_PT_3_IN8
    );
  NlwBufferBlock_refcnt_7_EXP_PT_3_IN9 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_refcnt_7_EXP_PT_3_IN9
    );
  NlwBufferBlock_refcnt_7_EXP_PT_3_IN10 : X_BUF
    port map (
      I => refcnt(6),
      O => NlwBufferSignal_refcnt_7_EXP_PT_3_IN10
    );
  NlwBufferBlock_refcnt_7_EXP_PT_3_IN11 : X_BUF
    port map (
      I => refcnt(7),
      O => NlwBufferSignal_refcnt_7_EXP_PT_3_IN11
    );
  NlwBufferBlock_refcnt_7_EXP_PT_3_IN12 : X_BUF
    port map (
      I => refcnt(4),
      O => NlwBufferSignal_refcnt_7_EXP_PT_3_IN12
    );
  NlwBufferBlock_refcnt_7_EXP_PT_3_IN13 : X_BUF
    port map (
      I => refcnt(5),
      O => NlwBufferSignal_refcnt_7_EXP_PT_3_IN13
    );
  NlwBufferBlock_refcnt_7_EXP_PT_3_IN14 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_7_EXP_PT_3_IN14
    );
  NlwBufferBlock_refcnt_7_EXP_PT_3_IN15 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_refcnt_7_EXP_PT_3_IN15
    );
  NlwBufferBlock_refcnt_7_EXP_tsimrenamed_net_IN0 : X_BUF
    port map (
      I => refcnt_7_EXP_PT_0_372,
      O => NlwBufferSignal_refcnt_7_EXP_tsimrenamed_net_IN0
    );
  NlwBufferBlock_refcnt_7_EXP_tsimrenamed_net_IN1 : X_BUF
    port map (
      I => refcnt_7_EXP_PT_1_373,
      O => NlwBufferSignal_refcnt_7_EXP_tsimrenamed_net_IN1
    );
  NlwBufferBlock_refcnt_7_EXP_tsimrenamed_net_IN2 : X_BUF
    port map (
      I => refcnt_7_EXP_PT_2_374,
      O => NlwBufferSignal_refcnt_7_EXP_tsimrenamed_net_IN2
    );
  NlwBufferBlock_refcnt_7_EXP_tsimrenamed_net_IN3 : X_BUF
    port map (
      I => refcnt_7_EXP_PT_3_375,
      O => NlwBufferSignal_refcnt_7_EXP_tsimrenamed_net_IN3
    );
  NlwBufferBlock_OpTx_FX_DC_49_D_IN0 : X_BUF
    port map (
      I => Q_OpTx_FX_DC_49_D1_378,
      O => NlwBufferSignal_OpTx_FX_DC_49_D_IN0
    );
  NlwBufferBlock_OpTx_FX_DC_49_D_IN1 : X_BUF
    port map (
      I => Q_OpTx_FX_DC_49_D2_379,
      O => NlwBufferSignal_OpTx_FX_DC_49_D_IN1
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_0_IN0 : X_BUF
    port map (
      I => vda_IBUF_21,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_0_IN0
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_0_IN1 : X_BUF
    port map (
      I => vpa_IBUF_35,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_0_IN1
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_0_IN2 : X_BUF
    port map (
      I => ras_PIN_BUF_Q_67,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_0_IN2
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_1_IN0 : X_BUF
    port map (
      I => bank_7_IBUF_1,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN0
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_1_IN1 : X_BUF
    port map (
      I => bank_6_IBUF_3,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN1
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_1_IN2 : X_BUF
    port map (
      I => bank_5_IBUF_5,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN2
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_1_IN3 : X_BUF
    port map (
      I => bank_4_IBUF_7,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN3
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_1_IN4 : X_BUF
    port map (
      I => bank_3_IBUF_9,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN4
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_1_IN5 : X_BUF
    port map (
      I => bank_2_IBUF_11,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN5
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_1_IN6 : X_BUF
    port map (
      I => bank_1_IBUF_13,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN6
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_1_IN7 : X_BUF
    port map (
      I => bank_0_IBUF_15,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN7
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_1_IN8 : X_BUF
    port map (
      I => a15_13_2_IBUF_23,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN8
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_1_IN9 : X_BUF
    port map (
      I => a15_13_1_IBUF_25,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN9
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_1_IN10 : X_BUF
    port map (
      I => a15_13_0_IBUF_27,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN10
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_1_IN11 : X_BUF
    port map (
      I => ras_PIN_BUF_Q_67,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN11
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_1_IN12 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN12
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_1_IN13 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN13
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_1_IN14 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN14
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_1_IN15 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_1_IN15
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_2_IN0 : X_BUF
    port map (
      I => bank_7_IBUF_1,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN0
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_2_IN1 : X_BUF
    port map (
      I => bank_6_IBUF_3,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN1
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_2_IN2 : X_BUF
    port map (
      I => bank_5_IBUF_5,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN2
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_2_IN3 : X_BUF
    port map (
      I => bank_4_IBUF_7,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN3
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_2_IN4 : X_BUF
    port map (
      I => bank_3_IBUF_9,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN4
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_2_IN5 : X_BUF
    port map (
      I => bank_2_IBUF_11,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN5
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_2_IN6 : X_BUF
    port map (
      I => bank_1_IBUF_13,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN6
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_2_IN7 : X_BUF
    port map (
      I => bank_0_IBUF_15,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN7
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_2_IN8 : X_BUF
    port map (
      I => a15_13_2_IBUF_23,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN8
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_2_IN9 : X_BUF
    port map (
      I => a15_13_1_IBUF_25,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN9
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_2_IN10 : X_BUF
    port map (
      I => a15_13_0_IBUF_27,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN10
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_2_IN11 : X_BUF
    port map (
      I => rw_IBUF_33,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN11
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_2_IN12 : X_BUF
    port map (
      I => ras_PIN_BUF_Q_67,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN12
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_2_IN13 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN13
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_2_IN14 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN14
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_PT_2_IN15 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN15
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_IN0 : X_BUF
    port map (
      I => Q_OpTx_FX_DC_49_D2_PT_0_380,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_IN0
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_IN1 : X_BUF
    port map (
      I => Q_OpTx_FX_DC_49_D2_PT_1_381,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_IN1
    );
  NlwBufferBlock_OpTx_FX_DC_49_D2_IN2 : X_BUF
    port map (
      I => Q_OpTx_FX_DC_49_D2_PT_2_382,
      O => NlwBufferSignal_OpTx_FX_DC_49_D2_IN2
    );
  NlwBufferBlock_EXP0_EXP_PT_0_IN0 : X_BUF
    port map (
      I => refcnt_4_EXP_337,
      O => NlwBufferSignal_EXP0_EXP_PT_0_IN0
    );
  NlwBufferBlock_EXP0_EXP_PT_0_IN1 : X_BUF
    port map (
      I => refcnt_4_EXP_337,
      O => NlwBufferSignal_EXP0_EXP_PT_0_IN1
    );
  NlwBufferBlock_EXP0_EXP_PT_1_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_17,
      O => NlwBufferSignal_EXP0_EXP_PT_1_IN0
    );
  NlwBufferBlock_EXP0_EXP_PT_1_IN1 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_EXP0_EXP_PT_1_IN1
    );
  NlwBufferBlock_EXP0_EXP_PT_1_IN2 : X_BUF
    port map (
      I => cas0_PIN_BUF_Q_41,
      O => NlwBufferSignal_EXP0_EXP_PT_1_IN2
    );
  NlwBufferBlock_EXP0_EXP_PT_2_IN0 : X_BUF
    port map (
      I => a12_11_0_IBUF_19,
      O => NlwBufferSignal_EXP0_EXP_PT_2_IN0
    );
  NlwBufferBlock_EXP0_EXP_PT_2_IN1 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_EXP0_EXP_PT_2_IN1
    );
  NlwBufferBlock_EXP0_EXP_PT_2_IN2 : X_BUF
    port map (
      I => cas0_PIN_BUF_Q_41,
      O => NlwBufferSignal_EXP0_EXP_PT_2_IN2
    );
  NlwBufferBlock_EXP0_EXP_PT_3_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_EXP0_EXP_PT_3_IN0
    );
  NlwBufferBlock_EXP0_EXP_PT_3_IN1 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_EXP0_EXP_PT_3_IN1
    );
  NlwBufferBlock_EXP0_EXP_PT_3_IN2 : X_BUF
    port map (
      I => cas0_PIN_BUF_Q_41,
      O => NlwBufferSignal_EXP0_EXP_PT_3_IN2
    );
  NlwBufferBlock_EXP0_EXP_PT_4_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_EXP0_EXP_PT_4_IN0
    );
  NlwBufferBlock_EXP0_EXP_PT_4_IN1 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_EXP0_EXP_PT_4_IN1
    );
  NlwBufferBlock_EXP0_EXP_PT_4_IN2 : X_BUF
    port map (
      I => cas0_PIN_BUF_Q_41,
      O => NlwBufferSignal_EXP0_EXP_PT_4_IN2
    );
  NlwBufferBlock_EXP0_EXP_PT_5_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_EXP0_EXP_PT_5_IN0
    );
  NlwBufferBlock_EXP0_EXP_PT_5_IN1 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_EXP0_EXP_PT_5_IN1
    );
  NlwBufferBlock_EXP0_EXP_PT_5_IN2 : X_BUF
    port map (
      I => cas0_PIN_BUF_Q_41,
      O => NlwBufferSignal_EXP0_EXP_PT_5_IN2
    );
  NlwBufferBlock_EXP0_EXP_tsimrenamed_net_IN0 : X_BUF
    port map (
      I => EXP0_EXP_PT_0_384,
      O => NlwBufferSignal_EXP0_EXP_tsimrenamed_net_IN0
    );
  NlwBufferBlock_EXP0_EXP_tsimrenamed_net_IN1 : X_BUF
    port map (
      I => EXP0_EXP_PT_1_385,
      O => NlwBufferSignal_EXP0_EXP_tsimrenamed_net_IN1
    );
  NlwBufferBlock_EXP0_EXP_tsimrenamed_net_IN2 : X_BUF
    port map (
      I => EXP0_EXP_PT_2_386,
      O => NlwBufferSignal_EXP0_EXP_tsimrenamed_net_IN2
    );
  NlwBufferBlock_EXP0_EXP_tsimrenamed_net_IN3 : X_BUF
    port map (
      I => EXP0_EXP_PT_3_387,
      O => NlwBufferSignal_EXP0_EXP_tsimrenamed_net_IN3
    );
  NlwBufferBlock_EXP0_EXP_tsimrenamed_net_IN4 : X_BUF
    port map (
      I => EXP0_EXP_PT_4_388,
      O => NlwBufferSignal_EXP0_EXP_tsimrenamed_net_IN4
    );
  NlwBufferBlock_EXP0_EXP_tsimrenamed_net_IN5 : X_BUF
    port map (
      I => EXP0_EXP_PT_5_389,
      O => NlwBufferSignal_EXP0_EXP_tsimrenamed_net_IN5
    );
  NlwBufferBlock_EXP1_EXP_PT_0_IN0 : X_BUF
    port map (
      I => iocnt_1_EXP_288,
      O => NlwBufferSignal_EXP1_EXP_PT_0_IN0
    );
  NlwBufferBlock_EXP1_EXP_PT_0_IN1 : X_BUF
    port map (
      I => iocnt_1_EXP_288,
      O => NlwBufferSignal_EXP1_EXP_PT_0_IN1
    );
  NlwBufferBlock_EXP1_EXP_PT_1_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_17,
      O => NlwBufferSignal_EXP1_EXP_PT_1_IN0
    );
  NlwBufferBlock_EXP1_EXP_PT_1_IN1 : X_BUF
    port map (
      I => cas1_PIN_BUF_Q_43,
      O => NlwBufferSignal_EXP1_EXP_PT_1_IN1
    );
  NlwBufferBlock_EXP1_EXP_PT_2_IN0 : X_BUF
    port map (
      I => a12_11_0_IBUF_19,
      O => NlwBufferSignal_EXP1_EXP_PT_2_IN0
    );
  NlwBufferBlock_EXP1_EXP_PT_2_IN1 : X_BUF
    port map (
      I => cas1_PIN_BUF_Q_43,
      O => NlwBufferSignal_EXP1_EXP_PT_2_IN1
    );
  NlwBufferBlock_EXP1_EXP_PT_3_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_EXP1_EXP_PT_3_IN0
    );
  NlwBufferBlock_EXP1_EXP_PT_3_IN1 : X_BUF
    port map (
      I => cas1_PIN_BUF_Q_43,
      O => NlwBufferSignal_EXP1_EXP_PT_3_IN1
    );
  NlwBufferBlock_EXP1_EXP_PT_4_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_EXP1_EXP_PT_4_IN0
    );
  NlwBufferBlock_EXP1_EXP_PT_4_IN1 : X_BUF
    port map (
      I => cas1_PIN_BUF_Q_43,
      O => NlwBufferSignal_EXP1_EXP_PT_4_IN1
    );
  NlwBufferBlock_EXP1_EXP_PT_5_IN0 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_37,
      O => NlwBufferSignal_EXP1_EXP_PT_5_IN0
    );
  NlwBufferBlock_EXP1_EXP_PT_5_IN1 : X_BUF
    port map (
      I => cas1_PIN_BUF_Q_43,
      O => NlwBufferSignal_EXP1_EXP_PT_5_IN1
    );
  NlwBufferBlock_EXP1_EXP_tsimrenamed_net_IN0 : X_BUF
    port map (
      I => EXP1_EXP_PT_0_391,
      O => NlwBufferSignal_EXP1_EXP_tsimrenamed_net_IN0
    );
  NlwBufferBlock_EXP1_EXP_tsimrenamed_net_IN1 : X_BUF
    port map (
      I => EXP1_EXP_PT_1_392,
      O => NlwBufferSignal_EXP1_EXP_tsimrenamed_net_IN1
    );
  NlwBufferBlock_EXP1_EXP_tsimrenamed_net_IN2 : X_BUF
    port map (
      I => EXP1_EXP_PT_2_393,
      O => NlwBufferSignal_EXP1_EXP_tsimrenamed_net_IN2
    );
  NlwBufferBlock_EXP1_EXP_tsimrenamed_net_IN3 : X_BUF
    port map (
      I => EXP1_EXP_PT_3_394,
      O => NlwBufferSignal_EXP1_EXP_tsimrenamed_net_IN3
    );
  NlwBufferBlock_EXP1_EXP_tsimrenamed_net_IN4 : X_BUF
    port map (
      I => EXP1_EXP_PT_4_395,
      O => NlwBufferSignal_EXP1_EXP_tsimrenamed_net_IN4
    );
  NlwBufferBlock_EXP1_EXP_tsimrenamed_net_IN5 : X_BUF
    port map (
      I => EXP1_EXP_PT_5_396,
      O => NlwBufferSignal_EXP1_EXP_tsimrenamed_net_IN5
    );
  NlwBufferBlock_EXP2_EXP_PT_0_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_EXP2_EXP_PT_0_IN0
    );
  NlwBufferBlock_EXP2_EXP_PT_0_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_EXP2_EXP_PT_0_IN1
    );
  NlwBufferBlock_EXP2_EXP_PT_0_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_EXP2_EXP_PT_0_IN2
    );
  NlwBufferBlock_EXP2_EXP_PT_0_IN3 : X_BUF
    port map (
      I => Q_OpTx_FX_DC_49_UIM_247,
      O => NlwBufferSignal_EXP2_EXP_PT_0_IN3
    );
  NlwBufferBlock_EXP2_EXP_PT_1_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_EXP2_EXP_PT_1_IN0
    );
  NlwBufferBlock_EXP2_EXP_PT_1_IN1 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_EXP2_EXP_PT_1_IN1
    );
  NlwBufferBlock_EXP2_EXP_PT_1_IN2 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_EXP2_EXP_PT_1_IN2
    );
  NlwBufferBlock_EXP2_EXP_PT_1_IN3 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_EXP2_EXP_PT_1_IN3
    );
  NlwBufferBlock_EXP2_EXP_PT_1_IN4 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_EXP2_EXP_PT_1_IN4
    );
  NlwBufferBlock_EXP2_EXP_PT_1_IN5 : X_BUF
    port map (
      I => refcnt(6),
      O => NlwBufferSignal_EXP2_EXP_PT_1_IN5
    );
  NlwBufferBlock_EXP2_EXP_PT_1_IN6 : X_BUF
    port map (
      I => refcnt(7),
      O => NlwBufferSignal_EXP2_EXP_PT_1_IN6
    );
  NlwBufferBlock_EXP2_EXP_PT_1_IN7 : X_BUF
    port map (
      I => refcnt(4),
      O => NlwBufferSignal_EXP2_EXP_PT_1_IN7
    );
  NlwBufferBlock_EXP2_EXP_PT_1_IN8 : X_BUF
    port map (
      I => refcnt(5),
      O => NlwBufferSignal_EXP2_EXP_PT_1_IN8
    );
  NlwBufferBlock_EXP2_EXP_PT_1_IN9 : X_BUF
    port map (
      I => ras_PIN_BUF_Q_67,
      O => NlwBufferSignal_EXP2_EXP_PT_1_IN9
    );
  NlwBufferBlock_EXP2_EXP_PT_1_IN10 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_EXP2_EXP_PT_1_IN10
    );
  NlwBufferBlock_EXP2_EXP_PT_1_IN11 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_EXP2_EXP_PT_1_IN11
    );
  NlwBufferBlock_EXP2_EXP_PT_1_IN12 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_EXP2_EXP_PT_1_IN12
    );
  NlwBufferBlock_EXP2_EXP_PT_1_IN13 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_EXP2_EXP_PT_1_IN13
    );
  NlwBufferBlock_EXP2_EXP_PT_1_IN14 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_EXP2_EXP_PT_1_IN14
    );
  NlwBufferBlock_EXP2_EXP_PT_1_IN15 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_EXP2_EXP_PT_1_IN15
    );
  NlwBufferBlock_EXP2_EXP_PT_2_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_EXP2_EXP_PT_2_IN0
    );
  NlwBufferBlock_EXP2_EXP_PT_2_IN1 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_EXP2_EXP_PT_2_IN1
    );
  NlwBufferBlock_EXP2_EXP_PT_2_IN2 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_EXP2_EXP_PT_2_IN2
    );
  NlwBufferBlock_EXP2_EXP_PT_2_IN3 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_EXP2_EXP_PT_2_IN3
    );
  NlwBufferBlock_EXP2_EXP_PT_2_IN4 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_EXP2_EXP_PT_2_IN4
    );
  NlwBufferBlock_EXP2_EXP_PT_2_IN5 : X_BUF
    port map (
      I => refcnt(6),
      O => NlwBufferSignal_EXP2_EXP_PT_2_IN5
    );
  NlwBufferBlock_EXP2_EXP_PT_2_IN6 : X_BUF
    port map (
      I => refcnt(7),
      O => NlwBufferSignal_EXP2_EXP_PT_2_IN6
    );
  NlwBufferBlock_EXP2_EXP_PT_2_IN7 : X_BUF
    port map (
      I => refcnt(4),
      O => NlwBufferSignal_EXP2_EXP_PT_2_IN7
    );
  NlwBufferBlock_EXP2_EXP_PT_2_IN8 : X_BUF
    port map (
      I => refcnt(5),
      O => NlwBufferSignal_EXP2_EXP_PT_2_IN8
    );
  NlwBufferBlock_EXP2_EXP_PT_2_IN9 : X_BUF
    port map (
      I => ras_PIN_BUF_Q_67,
      O => NlwBufferSignal_EXP2_EXP_PT_2_IN9
    );
  NlwBufferBlock_EXP2_EXP_PT_2_IN10 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_EXP2_EXP_PT_2_IN10
    );
  NlwBufferBlock_EXP2_EXP_PT_2_IN11 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_EXP2_EXP_PT_2_IN11
    );
  NlwBufferBlock_EXP2_EXP_PT_2_IN12 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_EXP2_EXP_PT_2_IN12
    );
  NlwBufferBlock_EXP2_EXP_PT_2_IN13 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_EXP2_EXP_PT_2_IN13
    );
  NlwBufferBlock_EXP2_EXP_PT_2_IN14 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_EXP2_EXP_PT_2_IN14
    );
  NlwBufferBlock_EXP2_EXP_PT_2_IN15 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_EXP2_EXP_PT_2_IN15
    );
  NlwBufferBlock_EXP2_EXP_PT_3_IN0 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_EXP2_EXP_PT_3_IN0
    );
  NlwBufferBlock_EXP2_EXP_PT_3_IN1 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_EXP2_EXP_PT_3_IN1
    );
  NlwBufferBlock_EXP2_EXP_PT_3_IN2 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_EXP2_EXP_PT_3_IN2
    );
  NlwBufferBlock_EXP2_EXP_PT_3_IN3 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_EXP2_EXP_PT_3_IN3
    );
  NlwBufferBlock_EXP2_EXP_PT_3_IN4 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_EXP2_EXP_PT_3_IN4
    );
  NlwBufferBlock_EXP2_EXP_PT_3_IN5 : X_BUF
    port map (
      I => refcnt(6),
      O => NlwBufferSignal_EXP2_EXP_PT_3_IN5
    );
  NlwBufferBlock_EXP2_EXP_PT_3_IN6 : X_BUF
    port map (
      I => refcnt(7),
      O => NlwBufferSignal_EXP2_EXP_PT_3_IN6
    );
  NlwBufferBlock_EXP2_EXP_PT_3_IN7 : X_BUF
    port map (
      I => refcnt(4),
      O => NlwBufferSignal_EXP2_EXP_PT_3_IN7
    );
  NlwBufferBlock_EXP2_EXP_PT_3_IN8 : X_BUF
    port map (
      I => refcnt(5),
      O => NlwBufferSignal_EXP2_EXP_PT_3_IN8
    );
  NlwBufferBlock_EXP2_EXP_PT_3_IN9 : X_BUF
    port map (
      I => ras_PIN_BUF_Q_67,
      O => NlwBufferSignal_EXP2_EXP_PT_3_IN9
    );
  NlwBufferBlock_EXP2_EXP_PT_3_IN10 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_EXP2_EXP_PT_3_IN10
    );
  NlwBufferBlock_EXP2_EXP_PT_3_IN11 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_EXP2_EXP_PT_3_IN11
    );
  NlwBufferBlock_EXP2_EXP_PT_3_IN12 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_EXP2_EXP_PT_3_IN12
    );
  NlwBufferBlock_EXP2_EXP_PT_3_IN13 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_EXP2_EXP_PT_3_IN13
    );
  NlwBufferBlock_EXP2_EXP_PT_3_IN14 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_EXP2_EXP_PT_3_IN14
    );
  NlwBufferBlock_EXP2_EXP_PT_3_IN15 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_EXP2_EXP_PT_3_IN15
    );
  NlwBufferBlock_EXP2_EXP_PT_4_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_EXP2_EXP_PT_4_IN0
    );
  NlwBufferBlock_EXP2_EXP_PT_4_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_EXP2_EXP_PT_4_IN1
    );
  NlwBufferBlock_EXP2_EXP_PT_4_IN2 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_EXP2_EXP_PT_4_IN2
    );
  NlwBufferBlock_EXP2_EXP_PT_4_IN3 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_EXP2_EXP_PT_4_IN3
    );
  NlwBufferBlock_EXP2_EXP_PT_4_IN4 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_EXP2_EXP_PT_4_IN4
    );
  NlwBufferBlock_EXP2_EXP_PT_4_IN5 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_EXP2_EXP_PT_4_IN5
    );
  NlwBufferBlock_EXP2_EXP_PT_4_IN6 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_EXP2_EXP_PT_4_IN6
    );
  NlwBufferBlock_EXP2_EXP_PT_4_IN7 : X_BUF
    port map (
      I => refcnt(6),
      O => NlwBufferSignal_EXP2_EXP_PT_4_IN7
    );
  NlwBufferBlock_EXP2_EXP_PT_4_IN8 : X_BUF
    port map (
      I => refcnt(7),
      O => NlwBufferSignal_EXP2_EXP_PT_4_IN8
    );
  NlwBufferBlock_EXP2_EXP_PT_4_IN9 : X_BUF
    port map (
      I => refcnt(4),
      O => NlwBufferSignal_EXP2_EXP_PT_4_IN9
    );
  NlwBufferBlock_EXP2_EXP_PT_4_IN10 : X_BUF
    port map (
      I => refcnt(5),
      O => NlwBufferSignal_EXP2_EXP_PT_4_IN10
    );
  NlwBufferBlock_EXP2_EXP_PT_4_IN11 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_EXP2_EXP_PT_4_IN11
    );
  NlwBufferBlock_EXP2_EXP_PT_4_IN12 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_EXP2_EXP_PT_4_IN12
    );
  NlwBufferBlock_EXP2_EXP_PT_4_IN13 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_EXP2_EXP_PT_4_IN13
    );
  NlwBufferBlock_EXP2_EXP_PT_4_IN14 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_EXP2_EXP_PT_4_IN14
    );
  NlwBufferBlock_EXP2_EXP_PT_4_IN15 : X_BUF
    port map (
      I => Vcc_88,
      O => NlwBufferSignal_EXP2_EXP_PT_4_IN15
    );
  NlwBufferBlock_EXP2_EXP_tsimrenamed_net_IN0 : X_BUF
    port map (
      I => EXP2_EXP_PT_0_398,
      O => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN0
    );
  NlwBufferBlock_EXP2_EXP_tsimrenamed_net_IN1 : X_BUF
    port map (
      I => EXP2_EXP_PT_1_399,
      O => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN1
    );
  NlwBufferBlock_EXP2_EXP_tsimrenamed_net_IN2 : X_BUF
    port map (
      I => EXP2_EXP_PT_2_400,
      O => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN2
    );
  NlwBufferBlock_EXP2_EXP_tsimrenamed_net_IN3 : X_BUF
    port map (
      I => EXP2_EXP_PT_3_401,
      O => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN3
    );
  NlwBufferBlock_EXP2_EXP_tsimrenamed_net_IN4 : X_BUF
    port map (
      I => EXP2_EXP_PT_4_402,
      O => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN4
    );
  NlwBufferBlock_EXP3_EXP_PT_0_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_EXP3_EXP_PT_0_IN0
    );
  NlwBufferBlock_EXP3_EXP_PT_0_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_EXP3_EXP_PT_0_IN1
    );
  NlwBufferBlock_EXP3_EXP_PT_0_IN2 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_EXP3_EXP_PT_0_IN2
    );
  NlwBufferBlock_EXP3_EXP_PT_1_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_EXP3_EXP_PT_1_IN0
    );
  NlwBufferBlock_EXP3_EXP_PT_1_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_EXP3_EXP_PT_1_IN1
    );
  NlwBufferBlock_EXP3_EXP_PT_1_IN2 : X_BUF
    port map (
      I => refcnt(6),
      O => NlwBufferSignal_EXP3_EXP_PT_1_IN2
    );
  NlwBufferBlock_EXP3_EXP_PT_2_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_EXP3_EXP_PT_2_IN0
    );
  NlwBufferBlock_EXP3_EXP_PT_2_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_EXP3_EXP_PT_2_IN1
    );
  NlwBufferBlock_EXP3_EXP_PT_2_IN2 : X_BUF
    port map (
      I => refcnt(7),
      O => NlwBufferSignal_EXP3_EXP_PT_2_IN2
    );
  NlwBufferBlock_EXP3_EXP_PT_3_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_EXP3_EXP_PT_3_IN0
    );
  NlwBufferBlock_EXP3_EXP_PT_3_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_EXP3_EXP_PT_3_IN1
    );
  NlwBufferBlock_EXP3_EXP_PT_3_IN2 : X_BUF
    port map (
      I => refcnt(4),
      O => NlwBufferSignal_EXP3_EXP_PT_3_IN2
    );
  NlwBufferBlock_EXP3_EXP_PT_4_IN0 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_EXP3_EXP_PT_4_IN0
    );
  NlwBufferBlock_EXP3_EXP_PT_4_IN1 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_EXP3_EXP_PT_4_IN1
    );
  NlwBufferBlock_EXP3_EXP_PT_4_IN2 : X_BUF
    port map (
      I => refcnt(5),
      O => NlwBufferSignal_EXP3_EXP_PT_4_IN2
    );
  NlwBufferBlock_EXP3_EXP_tsimrenamed_net_IN0 : X_BUF
    port map (
      I => EXP3_EXP_PT_0_404,
      O => NlwBufferSignal_EXP3_EXP_tsimrenamed_net_IN0
    );
  NlwBufferBlock_EXP3_EXP_tsimrenamed_net_IN1 : X_BUF
    port map (
      I => EXP3_EXP_PT_1_405,
      O => NlwBufferSignal_EXP3_EXP_tsimrenamed_net_IN1
    );
  NlwBufferBlock_EXP3_EXP_tsimrenamed_net_IN2 : X_BUF
    port map (
      I => EXP3_EXP_PT_2_406,
      O => NlwBufferSignal_EXP3_EXP_tsimrenamed_net_IN2
    );
  NlwBufferBlock_EXP3_EXP_tsimrenamed_net_IN3 : X_BUF
    port map (
      I => EXP3_EXP_PT_3_407,
      O => NlwBufferSignal_EXP3_EXP_tsimrenamed_net_IN3
    );
  NlwBufferBlock_EXP3_EXP_tsimrenamed_net_IN4 : X_BUF
    port map (
      I => EXP3_EXP_PT_4_408,
      O => NlwBufferSignal_EXP3_EXP_tsimrenamed_net_IN4
    );
  NlwBufferBlock_FC_0_IN0 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_FC_0_IN0
    );
  NlwBufferBlock_FC_0_IN1 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_FC_0_IN1
    );
  NlwBufferBlock_FC_0_IN2 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_FC_0_IN2
    );
  NlwBufferBlock_FC_0_IN3 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_FC_0_IN3
    );
  NlwBufferBlock_FC_0_IN4 : X_BUF
    port map (
      I => refcnt(4),
      O => NlwBufferSignal_FC_0_IN4
    );
  NlwBufferBlock_FC_0_IN5 : X_BUF
    port map (
      I => refcnt(5),
      O => NlwBufferSignal_FC_0_IN5
    );
  NlwBufferBlock_FC_1_IN0 : X_BUF
    port map (
      I => refcnt(6),
      O => NlwBufferSignal_FC_1_IN0
    );
  NlwBufferBlock_FC_1_IN1 : X_BUF
    port map (
      I => refcnt(7),
      O => NlwBufferSignal_FC_1_IN1
    );
  NlwInverterBlock_rom_OBUF_D2_PT_0_IN1 : X_INV
    port map (
      I => NlwBufferSignal_rom_OBUF_D2_PT_0_IN1,
      O => NlwInverterSignal_rom_OBUF_D2_PT_0_IN1
    );
  NlwInverterBlock_rom_OBUF_D2_PT_0_IN3 : X_INV
    port map (
      I => NlwBufferSignal_rom_OBUF_D2_PT_0_IN3,
      O => NlwInverterSignal_rom_OBUF_D2_PT_0_IN3
    );
  NlwInverterBlock_rom_OBUF_D2_PT_1_IN0 : X_INV
    port map (
      I => NlwBufferSignal_rom_OBUF_D2_PT_1_IN0,
      O => NlwInverterSignal_rom_OBUF_D2_PT_1_IN0
    );
  NlwInverterBlock_rom_OBUF_D2_PT_1_IN1 : X_INV
    port map (
      I => NlwBufferSignal_rom_OBUF_D2_PT_1_IN1,
      O => NlwInverterSignal_rom_OBUF_D2_PT_1_IN1
    );
  NlwInverterBlock_rom_OBUF_D2_PT_1_IN2 : X_INV
    port map (
      I => NlwBufferSignal_rom_OBUF_D2_PT_1_IN2,
      O => NlwInverterSignal_rom_OBUF_D2_PT_1_IN2
    );
  NlwInverterBlock_rom_OBUF_D2_PT_1_IN3 : X_INV
    port map (
      I => NlwBufferSignal_rom_OBUF_D2_PT_1_IN3,
      O => NlwInverterSignal_rom_OBUF_D2_PT_1_IN3
    );
  NlwInverterBlock_rom_OBUF_D2_PT_1_IN4 : X_INV
    port map (
      I => NlwBufferSignal_rom_OBUF_D2_PT_1_IN4,
      O => NlwInverterSignal_rom_OBUF_D2_PT_1_IN4
    );
  NlwInverterBlock_rom_OBUF_D2_PT_1_IN5 : X_INV
    port map (
      I => NlwBufferSignal_rom_OBUF_D2_PT_1_IN5,
      O => NlwInverterSignal_rom_OBUF_D2_PT_1_IN5
    );
  NlwInverterBlock_rom_OBUF_D2_PT_1_IN6 : X_INV
    port map (
      I => NlwBufferSignal_rom_OBUF_D2_PT_1_IN6,
      O => NlwInverterSignal_rom_OBUF_D2_PT_1_IN6
    );
  NlwInverterBlock_rom_OBUF_D2_PT_1_IN7 : X_INV
    port map (
      I => NlwBufferSignal_rom_OBUF_D2_PT_1_IN7,
      O => NlwInverterSignal_rom_OBUF_D2_PT_1_IN7
    );
  NlwInverterBlock_rom_OBUF_D2_PT_1_IN13 : X_INV
    port map (
      I => NlwBufferSignal_rom_OBUF_D2_PT_1_IN13,
      O => NlwInverterSignal_rom_OBUF_D2_PT_1_IN13
    );
  NlwInverterBlock_rom_OBUF_D2_PT_1_IN14 : X_INV
    port map (
      I => NlwBufferSignal_rom_OBUF_D2_PT_1_IN14,
      O => NlwInverterSignal_rom_OBUF_D2_PT_1_IN14
    );
  NlwInverterBlock_rom_OBUF_D2_PT_2_IN0 : X_INV
    port map (
      I => NlwBufferSignal_rom_OBUF_D2_PT_2_IN0,
      O => NlwInverterSignal_rom_OBUF_D2_PT_2_IN0
    );
  NlwInverterBlock_rom_OBUF_D2_PT_2_IN1 : X_INV
    port map (
      I => NlwBufferSignal_rom_OBUF_D2_PT_2_IN1,
      O => NlwInverterSignal_rom_OBUF_D2_PT_2_IN1
    );
  NlwInverterBlock_rom_OBUF_D2_PT_2_IN2 : X_INV
    port map (
      I => NlwBufferSignal_rom_OBUF_D2_PT_2_IN2,
      O => NlwInverterSignal_rom_OBUF_D2_PT_2_IN2
    );
  NlwInverterBlock_rom_OBUF_D2_PT_2_IN3 : X_INV
    port map (
      I => NlwBufferSignal_rom_OBUF_D2_PT_2_IN3,
      O => NlwInverterSignal_rom_OBUF_D2_PT_2_IN3
    );
  NlwInverterBlock_rom_OBUF_D2_PT_2_IN4 : X_INV
    port map (
      I => NlwBufferSignal_rom_OBUF_D2_PT_2_IN4,
      O => NlwInverterSignal_rom_OBUF_D2_PT_2_IN4
    );
  NlwInverterBlock_rom_OBUF_D2_PT_2_IN5 : X_INV
    port map (
      I => NlwBufferSignal_rom_OBUF_D2_PT_2_IN5,
      O => NlwInverterSignal_rom_OBUF_D2_PT_2_IN5
    );
  NlwInverterBlock_rom_OBUF_D2_PT_2_IN6 : X_INV
    port map (
      I => NlwBufferSignal_rom_OBUF_D2_PT_2_IN6,
      O => NlwInverterSignal_rom_OBUF_D2_PT_2_IN6
    );
  NlwInverterBlock_rom_OBUF_D2_PT_2_IN7 : X_INV
    port map (
      I => NlwBufferSignal_rom_OBUF_D2_PT_2_IN7,
      O => NlwInverterSignal_rom_OBUF_D2_PT_2_IN7
    );
  NlwInverterBlock_rom_OBUF_D2_PT_2_IN13 : X_INV
    port map (
      I => NlwBufferSignal_rom_OBUF_D2_PT_2_IN13,
      O => NlwInverterSignal_rom_OBUF_D2_PT_2_IN13
    );
  NlwInverterBlock_rom_OBUF_D2_PT_2_IN14 : X_INV
    port map (
      I => NlwBufferSignal_rom_OBUF_D2_PT_2_IN14,
      O => NlwInverterSignal_rom_OBUF_D2_PT_2_IN14
    );
  NlwInverterBlock_phi1_OBUF_D_IN0 : X_INV
    port map (
      I => NlwBufferSignal_phi1_OBUF_D_IN0,
      O => NlwInverterSignal_phi1_OBUF_D_IN0
    );
  NlwInverterBlock_phi1_OBUF_D2_PT_1_IN1 : X_INV
    port map (
      I => NlwBufferSignal_phi1_OBUF_D2_PT_1_IN1,
      O => NlwInverterSignal_phi1_OBUF_D2_PT_1_IN1
    );
  NlwInverterBlock_phi1_OBUF_D2_PT_2_IN0 : X_INV
    port map (
      I => NlwBufferSignal_phi1_OBUF_D2_PT_2_IN0,
      O => NlwInverterSignal_phi1_OBUF_D2_PT_2_IN0
    );
  NlwInverterBlock_phi1_OBUF_D2_PT_2_IN1 : X_INV
    port map (
      I => NlwBufferSignal_phi1_OBUF_D2_PT_2_IN1,
      O => NlwInverterSignal_phi1_OBUF_D2_PT_2_IN1
    );
  NlwInverterBlock_phi1_OBUF_D2_PT_3_IN1 : X_INV
    port map (
      I => NlwBufferSignal_phi1_OBUF_D2_PT_3_IN1,
      O => NlwInverterSignal_phi1_OBUF_D2_PT_3_IN1
    );
  NlwInverterBlock_phi1_OBUF_D2_PT_4_IN0 : X_INV
    port map (
      I => NlwBufferSignal_phi1_OBUF_D2_PT_4_IN0,
      O => NlwInverterSignal_phi1_OBUF_D2_PT_4_IN0
    );
  NlwInverterBlock_phi1_OBUF_D2_PT_4_IN1 : X_INV
    port map (
      I => NlwBufferSignal_phi1_OBUF_D2_PT_4_IN1,
      O => NlwInverterSignal_phi1_OBUF_D2_PT_4_IN1
    );
  NlwInverterBlock_phi1_OBUF_D2_PT_5_IN0 : X_INV
    port map (
      I => NlwBufferSignal_phi1_OBUF_D2_PT_5_IN0,
      O => NlwInverterSignal_phi1_OBUF_D2_PT_5_IN0
    );
  NlwInverterBlock_phi1_OBUF_D2_PT_5_IN2 : X_INV
    port map (
      I => NlwBufferSignal_phi1_OBUF_D2_PT_5_IN2,
      O => NlwInverterSignal_phi1_OBUF_D2_PT_5_IN2
    );
  NlwInverterBlock_cas0_OBUF_D2_PT_3_IN0 : X_INV
    port map (
      I => NlwBufferSignal_cas0_OBUF_D2_PT_3_IN0,
      O => NlwInverterSignal_cas0_OBUF_D2_PT_3_IN0
    );
  NlwInverterBlock_cas0_OBUF_D2_PT_4_IN0 : X_INV
    port map (
      I => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN0,
      O => NlwInverterSignal_cas0_OBUF_D2_PT_4_IN0
    );
  NlwInverterBlock_cas0_OBUF_D2_PT_4_IN1 : X_INV
    port map (
      I => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN1,
      O => NlwInverterSignal_cas0_OBUF_D2_PT_4_IN1
    );
  NlwInverterBlock_cas0_OBUF_D2_PT_5_IN0 : X_INV
    port map (
      I => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN0,
      O => NlwInverterSignal_cas0_OBUF_D2_PT_5_IN0
    );
  NlwInverterBlock_cas0_OBUF_D2_PT_5_IN1 : X_INV
    port map (
      I => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN1,
      O => NlwInverterSignal_cas0_OBUF_D2_PT_5_IN1
    );
  NlwInverterBlock_cas0_OBUF_D2_PT_6_IN0 : X_INV
    port map (
      I => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN0,
      O => NlwInverterSignal_cas0_OBUF_D2_PT_6_IN0
    );
  NlwInverterBlock_cas0_OBUF_D2_PT_6_IN1 : X_INV
    port map (
      I => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN1,
      O => NlwInverterSignal_cas0_OBUF_D2_PT_6_IN1
    );
  NlwInverterBlock_cas1_OBUF_EXP_PT_0_IN1 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_EXP_PT_0_IN1,
      O => NlwInverterSignal_cas1_OBUF_EXP_PT_0_IN1
    );
  NlwInverterBlock_cas1_OBUF_EXP_PT_0_IN3 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_EXP_PT_0_IN3,
      O => NlwInverterSignal_cas1_OBUF_EXP_PT_0_IN3
    );
  NlwInverterBlock_cas1_OBUF_EXP_PT_0_IN4 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_EXP_PT_0_IN4,
      O => NlwInverterSignal_cas1_OBUF_EXP_PT_0_IN4
    );
  NlwInverterBlock_cas1_OBUF_EXP_PT_0_IN5 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_EXP_PT_0_IN5,
      O => NlwInverterSignal_cas1_OBUF_EXP_PT_0_IN5
    );
  NlwInverterBlock_cas1_OBUF_EXP_PT_0_IN6 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_EXP_PT_0_IN6,
      O => NlwInverterSignal_cas1_OBUF_EXP_PT_0_IN6
    );
  NlwInverterBlock_cas1_OBUF_EXP_PT_1_IN1 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_EXP_PT_1_IN1,
      O => NlwInverterSignal_cas1_OBUF_EXP_PT_1_IN1
    );
  NlwInverterBlock_cas1_OBUF_EXP_PT_1_IN3 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_EXP_PT_1_IN3,
      O => NlwInverterSignal_cas1_OBUF_EXP_PT_1_IN3
    );
  NlwInverterBlock_cas1_OBUF_EXP_PT_1_IN4 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_EXP_PT_1_IN4,
      O => NlwInverterSignal_cas1_OBUF_EXP_PT_1_IN4
    );
  NlwInverterBlock_cas1_OBUF_EXP_PT_1_IN5 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_EXP_PT_1_IN5,
      O => NlwInverterSignal_cas1_OBUF_EXP_PT_1_IN5
    );
  NlwInverterBlock_cas1_OBUF_EXP_PT_1_IN6 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_EXP_PT_1_IN6,
      O => NlwInverterSignal_cas1_OBUF_EXP_PT_1_IN6
    );
  NlwInverterBlock_cas2_OBUF_D2_PT_2_IN0 : X_INV
    port map (
      I => NlwBufferSignal_cas2_OBUF_D2_PT_2_IN0,
      O => NlwInverterSignal_cas2_OBUF_D2_PT_2_IN0
    );
  NlwInverterBlock_cas2_OBUF_D2_PT_3_IN0 : X_INV
    port map (
      I => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN0,
      O => NlwInverterSignal_cas2_OBUF_D2_PT_3_IN0
    );
  NlwInverterBlock_cas3_OBUF_D2_PT_2_IN0 : X_INV
    port map (
      I => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN0,
      O => NlwInverterSignal_cas3_OBUF_D2_PT_2_IN0
    );
  NlwInverterBlock_cas3_OBUF_D2_PT_3_IN0 : X_INV
    port map (
      I => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN0,
      O => NlwInverterSignal_cas3_OBUF_D2_PT_3_IN0
    );
  NlwInverterBlock_io0_OBUF_D2_PT_0_IN1 : X_INV
    port map (
      I => NlwBufferSignal_io0_OBUF_D2_PT_0_IN1,
      O => NlwInverterSignal_io0_OBUF_D2_PT_0_IN1
    );
  NlwInverterBlock_io0_OBUF_D2_PT_0_IN3 : X_INV
    port map (
      I => NlwBufferSignal_io0_OBUF_D2_PT_0_IN3,
      O => NlwInverterSignal_io0_OBUF_D2_PT_0_IN3
    );
  NlwInverterBlock_io0_OBUF_D2_PT_0_IN6 : X_INV
    port map (
      I => NlwBufferSignal_io0_OBUF_D2_PT_0_IN6,
      O => NlwInverterSignal_io0_OBUF_D2_PT_0_IN6
    );
  NlwInverterBlock_io0_OBUF_D2_PT_1_IN0 : X_INV
    port map (
      I => NlwBufferSignal_io0_OBUF_D2_PT_1_IN0,
      O => NlwInverterSignal_io0_OBUF_D2_PT_1_IN0
    );
  NlwInverterBlock_io0_OBUF_D2_PT_1_IN1 : X_INV
    port map (
      I => NlwBufferSignal_io0_OBUF_D2_PT_1_IN1,
      O => NlwInverterSignal_io0_OBUF_D2_PT_1_IN1
    );
  NlwInverterBlock_io0_OBUF_D2_PT_1_IN2 : X_INV
    port map (
      I => NlwBufferSignal_io0_OBUF_D2_PT_1_IN2,
      O => NlwInverterSignal_io0_OBUF_D2_PT_1_IN2
    );
  NlwInverterBlock_io0_OBUF_D2_PT_1_IN4 : X_INV
    port map (
      I => NlwBufferSignal_io0_OBUF_D2_PT_1_IN4,
      O => NlwInverterSignal_io0_OBUF_D2_PT_1_IN4
    );
  NlwInverterBlock_io0_OBUF_D2_PT_1_IN6 : X_INV
    port map (
      I => NlwBufferSignal_io0_OBUF_D2_PT_1_IN6,
      O => NlwInverterSignal_io0_OBUF_D2_PT_1_IN6
    );
  NlwInverterBlock_io0_OBUF_D2_PT_1_IN7 : X_INV
    port map (
      I => NlwBufferSignal_io0_OBUF_D2_PT_1_IN7,
      O => NlwInverterSignal_io0_OBUF_D2_PT_1_IN7
    );
  NlwInverterBlock_io1_OBUF_D2_PT_0_IN1 : X_INV
    port map (
      I => NlwBufferSignal_io1_OBUF_D2_PT_0_IN1,
      O => NlwInverterSignal_io1_OBUF_D2_PT_0_IN1
    );
  NlwInverterBlock_io1_OBUF_D2_PT_0_IN3 : X_INV
    port map (
      I => NlwBufferSignal_io1_OBUF_D2_PT_0_IN3,
      O => NlwInverterSignal_io1_OBUF_D2_PT_0_IN3
    );
  NlwInverterBlock_io1_OBUF_D2_PT_0_IN6 : X_INV
    port map (
      I => NlwBufferSignal_io1_OBUF_D2_PT_0_IN6,
      O => NlwInverterSignal_io1_OBUF_D2_PT_0_IN6
    );
  NlwInverterBlock_io1_OBUF_D2_PT_1_IN0 : X_INV
    port map (
      I => NlwBufferSignal_io1_OBUF_D2_PT_1_IN0,
      O => NlwInverterSignal_io1_OBUF_D2_PT_1_IN0
    );
  NlwInverterBlock_io1_OBUF_D2_PT_1_IN1 : X_INV
    port map (
      I => NlwBufferSignal_io1_OBUF_D2_PT_1_IN1,
      O => NlwInverterSignal_io1_OBUF_D2_PT_1_IN1
    );
  NlwInverterBlock_io1_OBUF_D2_PT_1_IN4 : X_INV
    port map (
      I => NlwBufferSignal_io1_OBUF_D2_PT_1_IN4,
      O => NlwInverterSignal_io1_OBUF_D2_PT_1_IN4
    );
  NlwInverterBlock_io1_OBUF_D2_PT_1_IN6 : X_INV
    port map (
      I => NlwBufferSignal_io1_OBUF_D2_PT_1_IN6,
      O => NlwInverterSignal_io1_OBUF_D2_PT_1_IN6
    );
  NlwInverterBlock_io1_OBUF_D2_PT_1_IN7 : X_INV
    port map (
      I => NlwBufferSignal_io1_OBUF_D2_PT_1_IN7,
      O => NlwInverterSignal_io1_OBUF_D2_PT_1_IN7
    );
  NlwInverterBlock_io2_OBUF_D2_PT_0_IN1 : X_INV
    port map (
      I => NlwBufferSignal_io2_OBUF_D2_PT_0_IN1,
      O => NlwInverterSignal_io2_OBUF_D2_PT_0_IN1
    );
  NlwInverterBlock_io2_OBUF_D2_PT_0_IN3 : X_INV
    port map (
      I => NlwBufferSignal_io2_OBUF_D2_PT_0_IN3,
      O => NlwInverterSignal_io2_OBUF_D2_PT_0_IN3
    );
  NlwInverterBlock_io2_OBUF_D2_PT_0_IN6 : X_INV
    port map (
      I => NlwBufferSignal_io2_OBUF_D2_PT_0_IN6,
      O => NlwInverterSignal_io2_OBUF_D2_PT_0_IN6
    );
  NlwInverterBlock_io2_OBUF_D2_PT_1_IN0 : X_INV
    port map (
      I => NlwBufferSignal_io2_OBUF_D2_PT_1_IN0,
      O => NlwInverterSignal_io2_OBUF_D2_PT_1_IN0
    );
  NlwInverterBlock_io2_OBUF_D2_PT_1_IN2 : X_INV
    port map (
      I => NlwBufferSignal_io2_OBUF_D2_PT_1_IN2,
      O => NlwInverterSignal_io2_OBUF_D2_PT_1_IN2
    );
  NlwInverterBlock_io2_OBUF_D2_PT_1_IN4 : X_INV
    port map (
      I => NlwBufferSignal_io2_OBUF_D2_PT_1_IN4,
      O => NlwInverterSignal_io2_OBUF_D2_PT_1_IN4
    );
  NlwInverterBlock_io2_OBUF_D2_PT_1_IN6 : X_INV
    port map (
      I => NlwBufferSignal_io2_OBUF_D2_PT_1_IN6,
      O => NlwInverterSignal_io2_OBUF_D2_PT_1_IN6
    );
  NlwInverterBlock_io2_OBUF_D2_PT_1_IN7 : X_INV
    port map (
      I => NlwBufferSignal_io2_OBUF_D2_PT_1_IN7,
      O => NlwInverterSignal_io2_OBUF_D2_PT_1_IN7
    );
  NlwInverterBlock_io3_OBUF_D2_PT_0_IN1 : X_INV
    port map (
      I => NlwBufferSignal_io3_OBUF_D2_PT_0_IN1,
      O => NlwInverterSignal_io3_OBUF_D2_PT_0_IN1
    );
  NlwInverterBlock_io3_OBUF_D2_PT_0_IN3 : X_INV
    port map (
      I => NlwBufferSignal_io3_OBUF_D2_PT_0_IN3,
      O => NlwInverterSignal_io3_OBUF_D2_PT_0_IN3
    );
  NlwInverterBlock_io3_OBUF_D2_PT_0_IN6 : X_INV
    port map (
      I => NlwBufferSignal_io3_OBUF_D2_PT_0_IN6,
      O => NlwInverterSignal_io3_OBUF_D2_PT_0_IN6
    );
  NlwInverterBlock_io3_OBUF_D2_PT_1_IN0 : X_INV
    port map (
      I => NlwBufferSignal_io3_OBUF_D2_PT_1_IN0,
      O => NlwInverterSignal_io3_OBUF_D2_PT_1_IN0
    );
  NlwInverterBlock_io3_OBUF_D2_PT_1_IN4 : X_INV
    port map (
      I => NlwBufferSignal_io3_OBUF_D2_PT_1_IN4,
      O => NlwInverterSignal_io3_OBUF_D2_PT_1_IN4
    );
  NlwInverterBlock_io3_OBUF_D2_PT_1_IN6 : X_INV
    port map (
      I => NlwBufferSignal_io3_OBUF_D2_PT_1_IN6,
      O => NlwInverterSignal_io3_OBUF_D2_PT_1_IN6
    );
  NlwInverterBlock_io3_OBUF_D2_PT_1_IN7 : X_INV
    port map (
      I => NlwBufferSignal_io3_OBUF_D2_PT_1_IN7,
      O => NlwInverterSignal_io3_OBUF_D2_PT_1_IN7
    );
  NlwInverterBlock_io4_OBUF_D2_PT_0_IN1 : X_INV
    port map (
      I => NlwBufferSignal_io4_OBUF_D2_PT_0_IN1,
      O => NlwInverterSignal_io4_OBUF_D2_PT_0_IN1
    );
  NlwInverterBlock_io4_OBUF_D2_PT_0_IN3 : X_INV
    port map (
      I => NlwBufferSignal_io4_OBUF_D2_PT_0_IN3,
      O => NlwInverterSignal_io4_OBUF_D2_PT_0_IN3
    );
  NlwInverterBlock_io4_OBUF_D2_PT_0_IN6 : X_INV
    port map (
      I => NlwBufferSignal_io4_OBUF_D2_PT_0_IN6,
      O => NlwInverterSignal_io4_OBUF_D2_PT_0_IN6
    );
  NlwInverterBlock_io4_OBUF_D2_PT_1_IN1 : X_INV
    port map (
      I => NlwBufferSignal_io4_OBUF_D2_PT_1_IN1,
      O => NlwInverterSignal_io4_OBUF_D2_PT_1_IN1
    );
  NlwInverterBlock_io4_OBUF_D2_PT_1_IN2 : X_INV
    port map (
      I => NlwBufferSignal_io4_OBUF_D2_PT_1_IN2,
      O => NlwInverterSignal_io4_OBUF_D2_PT_1_IN2
    );
  NlwInverterBlock_io4_OBUF_D2_PT_1_IN4 : X_INV
    port map (
      I => NlwBufferSignal_io4_OBUF_D2_PT_1_IN4,
      O => NlwInverterSignal_io4_OBUF_D2_PT_1_IN4
    );
  NlwInverterBlock_io4_OBUF_D2_PT_1_IN6 : X_INV
    port map (
      I => NlwBufferSignal_io4_OBUF_D2_PT_1_IN6,
      O => NlwInverterSignal_io4_OBUF_D2_PT_1_IN6
    );
  NlwInverterBlock_io4_OBUF_D2_PT_1_IN7 : X_INV
    port map (
      I => NlwBufferSignal_io4_OBUF_D2_PT_1_IN7,
      O => NlwInverterSignal_io4_OBUF_D2_PT_1_IN7
    );
  NlwInverterBlock_io5_OBUF_D2_PT_0_IN1 : X_INV
    port map (
      I => NlwBufferSignal_io5_OBUF_D2_PT_0_IN1,
      O => NlwInverterSignal_io5_OBUF_D2_PT_0_IN1
    );
  NlwInverterBlock_io5_OBUF_D2_PT_0_IN3 : X_INV
    port map (
      I => NlwBufferSignal_io5_OBUF_D2_PT_0_IN3,
      O => NlwInverterSignal_io5_OBUF_D2_PT_0_IN3
    );
  NlwInverterBlock_io5_OBUF_D2_PT_0_IN6 : X_INV
    port map (
      I => NlwBufferSignal_io5_OBUF_D2_PT_0_IN6,
      O => NlwInverterSignal_io5_OBUF_D2_PT_0_IN6
    );
  NlwInverterBlock_io5_OBUF_D2_PT_1_IN1 : X_INV
    port map (
      I => NlwBufferSignal_io5_OBUF_D2_PT_1_IN1,
      O => NlwInverterSignal_io5_OBUF_D2_PT_1_IN1
    );
  NlwInverterBlock_io5_OBUF_D2_PT_1_IN4 : X_INV
    port map (
      I => NlwBufferSignal_io5_OBUF_D2_PT_1_IN4,
      O => NlwInverterSignal_io5_OBUF_D2_PT_1_IN4
    );
  NlwInverterBlock_io5_OBUF_D2_PT_1_IN6 : X_INV
    port map (
      I => NlwBufferSignal_io5_OBUF_D2_PT_1_IN6,
      O => NlwInverterSignal_io5_OBUF_D2_PT_1_IN6
    );
  NlwInverterBlock_io5_OBUF_D2_PT_1_IN7 : X_INV
    port map (
      I => NlwBufferSignal_io5_OBUF_D2_PT_1_IN7,
      O => NlwInverterSignal_io5_OBUF_D2_PT_1_IN7
    );
  NlwInverterBlock_io6_OBUF_D2_PT_0_IN1 : X_INV
    port map (
      I => NlwBufferSignal_io6_OBUF_D2_PT_0_IN1,
      O => NlwInverterSignal_io6_OBUF_D2_PT_0_IN1
    );
  NlwInverterBlock_io6_OBUF_D2_PT_0_IN3 : X_INV
    port map (
      I => NlwBufferSignal_io6_OBUF_D2_PT_0_IN3,
      O => NlwInverterSignal_io6_OBUF_D2_PT_0_IN3
    );
  NlwInverterBlock_io6_OBUF_D2_PT_0_IN6 : X_INV
    port map (
      I => NlwBufferSignal_io6_OBUF_D2_PT_0_IN6,
      O => NlwInverterSignal_io6_OBUF_D2_PT_0_IN6
    );
  NlwInverterBlock_io6_OBUF_D2_PT_1_IN2 : X_INV
    port map (
      I => NlwBufferSignal_io6_OBUF_D2_PT_1_IN2,
      O => NlwInverterSignal_io6_OBUF_D2_PT_1_IN2
    );
  NlwInverterBlock_io6_OBUF_D2_PT_1_IN4 : X_INV
    port map (
      I => NlwBufferSignal_io6_OBUF_D2_PT_1_IN4,
      O => NlwInverterSignal_io6_OBUF_D2_PT_1_IN4
    );
  NlwInverterBlock_io6_OBUF_D2_PT_1_IN6 : X_INV
    port map (
      I => NlwBufferSignal_io6_OBUF_D2_PT_1_IN6,
      O => NlwInverterSignal_io6_OBUF_D2_PT_1_IN6
    );
  NlwInverterBlock_io6_OBUF_D2_PT_1_IN7 : X_INV
    port map (
      I => NlwBufferSignal_io6_OBUF_D2_PT_1_IN7,
      O => NlwInverterSignal_io6_OBUF_D2_PT_1_IN7
    );
  NlwInverterBlock_io7_OBUF_D2_PT_0_IN1 : X_INV
    port map (
      I => NlwBufferSignal_io7_OBUF_D2_PT_0_IN1,
      O => NlwInverterSignal_io7_OBUF_D2_PT_0_IN1
    );
  NlwInverterBlock_io7_OBUF_D2_PT_0_IN3 : X_INV
    port map (
      I => NlwBufferSignal_io7_OBUF_D2_PT_0_IN3,
      O => NlwInverterSignal_io7_OBUF_D2_PT_0_IN3
    );
  NlwInverterBlock_io7_OBUF_D2_PT_0_IN6 : X_INV
    port map (
      I => NlwBufferSignal_io7_OBUF_D2_PT_0_IN6,
      O => NlwInverterSignal_io7_OBUF_D2_PT_0_IN6
    );
  NlwInverterBlock_io7_OBUF_D2_PT_1_IN4 : X_INV
    port map (
      I => NlwBufferSignal_io7_OBUF_D2_PT_1_IN4,
      O => NlwInverterSignal_io7_OBUF_D2_PT_1_IN4
    );
  NlwInverterBlock_io7_OBUF_D2_PT_1_IN6 : X_INV
    port map (
      I => NlwBufferSignal_io7_OBUF_D2_PT_1_IN6,
      O => NlwInverterSignal_io7_OBUF_D2_PT_1_IN6
    );
  NlwInverterBlock_io7_OBUF_D2_PT_1_IN7 : X_INV
    port map (
      I => NlwBufferSignal_io7_OBUF_D2_PT_1_IN7,
      O => NlwInverterSignal_io7_OBUF_D2_PT_1_IN7
    );
  NlwInverterBlock_phi0_OBUF_D2_PT_2_IN0 : X_INV
    port map (
      I => NlwBufferSignal_phi0_OBUF_D2_PT_2_IN0,
      O => NlwInverterSignal_phi0_OBUF_D2_PT_2_IN0
    );
  NlwInverterBlock_phi0_OBUF_EXP_PT_0_IN0 : X_INV
    port map (
      I => NlwBufferSignal_phi0_OBUF_EXP_PT_0_IN0,
      O => NlwInverterSignal_phi0_OBUF_EXP_PT_0_IN0
    );
  NlwInverterBlock_phi0_OBUF_EXP_PT_0_IN1 : X_INV
    port map (
      I => NlwBufferSignal_phi0_OBUF_EXP_PT_0_IN1,
      O => NlwInverterSignal_phi0_OBUF_EXP_PT_0_IN1
    );
  NlwInverterBlock_phi0_OBUF_EXP_PT_1_IN0 : X_INV
    port map (
      I => NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN0,
      O => NlwInverterSignal_phi0_OBUF_EXP_PT_1_IN0
    );
  NlwInverterBlock_phi0_OBUF_EXP_PT_1_IN1 : X_INV
    port map (
      I => NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN1,
      O => NlwInverterSignal_phi0_OBUF_EXP_PT_1_IN1
    );
  NlwInverterBlock_phi0_OBUF_EXP_PT_1_IN2 : X_INV
    port map (
      I => NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN2,
      O => NlwInverterSignal_phi0_OBUF_EXP_PT_1_IN2
    );
  NlwInverterBlock_phi0_OBUF_EXP_PT_1_IN3 : X_INV
    port map (
      I => NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN3,
      O => NlwInverterSignal_phi0_OBUF_EXP_PT_1_IN3
    );
  NlwInverterBlock_phi0_OBUF_EXP_PT_1_IN4 : X_INV
    port map (
      I => NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN4,
      O => NlwInverterSignal_phi0_OBUF_EXP_PT_1_IN4
    );
  NlwInverterBlock_phi0_OBUF_EXP_PT_1_IN5 : X_INV
    port map (
      I => NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN5,
      O => NlwInverterSignal_phi0_OBUF_EXP_PT_1_IN5
    );
  NlwInverterBlock_phi0_OBUF_EXP_PT_1_IN7 : X_INV
    port map (
      I => NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN7,
      O => NlwInverterSignal_phi0_OBUF_EXP_PT_1_IN7
    );
  NlwInverterBlock_phi0_OBUF_EXP_PT_1_IN8 : X_INV
    port map (
      I => NlwBufferSignal_phi0_OBUF_EXP_PT_1_IN8,
      O => NlwInverterSignal_phi0_OBUF_EXP_PT_1_IN8
    );
  NlwInverterBlock_ras_OBUF_D_IN0 : X_INV
    port map (
      I => NlwBufferSignal_ras_OBUF_D_IN0,
      O => NlwInverterSignal_ras_OBUF_D_IN0
    );
  NlwInverterBlock_ras_OBUF_D2_PT_1_IN0 : X_INV
    port map (
      I => NlwBufferSignal_ras_OBUF_D2_PT_1_IN0,
      O => NlwInverterSignal_ras_OBUF_D2_PT_1_IN0
    );
  NlwInverterBlock_ras_OBUF_D2_PT_1_IN1 : X_INV
    port map (
      I => NlwBufferSignal_ras_OBUF_D2_PT_1_IN1,
      O => NlwInverterSignal_ras_OBUF_D2_PT_1_IN1
    );
  NlwInverterBlock_ras_OBUF_D2_PT_1_IN2 : X_INV
    port map (
      I => NlwBufferSignal_ras_OBUF_D2_PT_1_IN2,
      O => NlwInverterSignal_ras_OBUF_D2_PT_1_IN2
    );
  NlwInverterBlock_ras_OBUF_D2_PT_2_IN0 : X_INV
    port map (
      I => NlwBufferSignal_ras_OBUF_D2_PT_2_IN0,
      O => NlwInverterSignal_ras_OBUF_D2_PT_2_IN0
    );
  NlwInverterBlock_ras_OBUF_D2_PT_2_IN1 : X_INV
    port map (
      I => NlwBufferSignal_ras_OBUF_D2_PT_2_IN1,
      O => NlwInverterSignal_ras_OBUF_D2_PT_2_IN1
    );
  NlwInverterBlock_ras_OBUF_D2_PT_2_IN2 : X_INV
    port map (
      I => NlwBufferSignal_ras_OBUF_D2_PT_2_IN2,
      O => NlwInverterSignal_ras_OBUF_D2_PT_2_IN2
    );
  NlwInverterBlock_ras_OBUF_D2_PT_3_IN1 : X_INV
    port map (
      I => NlwBufferSignal_ras_OBUF_D2_PT_3_IN1,
      O => NlwInverterSignal_ras_OBUF_D2_PT_3_IN1
    );
  NlwInverterBlock_ras_OBUF_D2_PT_3_IN2 : X_INV
    port map (
      I => NlwBufferSignal_ras_OBUF_D2_PT_3_IN2,
      O => NlwInverterSignal_ras_OBUF_D2_PT_3_IN2
    );
  NlwInverterBlock_ras_OBUF_EXP_PT_1_IN0 : X_INV
    port map (
      I => NlwBufferSignal_ras_OBUF_EXP_PT_1_IN0,
      O => NlwInverterSignal_ras_OBUF_EXP_PT_1_IN0
    );
  NlwInverterBlock_ras_OBUF_EXP_PT_1_IN1 : X_INV
    port map (
      I => NlwBufferSignal_ras_OBUF_EXP_PT_1_IN1,
      O => NlwInverterSignal_ras_OBUF_EXP_PT_1_IN1
    );
  NlwInverterBlock_ras_OBUF_EXP_PT_1_IN2 : X_INV
    port map (
      I => NlwBufferSignal_ras_OBUF_EXP_PT_1_IN2,
      O => NlwInverterSignal_ras_OBUF_EXP_PT_1_IN2
    );
  NlwInverterBlock_ras_OBUF_EXP_PT_1_IN3 : X_INV
    port map (
      I => NlwBufferSignal_ras_OBUF_EXP_PT_1_IN3,
      O => NlwInverterSignal_ras_OBUF_EXP_PT_1_IN3
    );
  NlwInverterBlock_ras_OBUF_EXP_PT_1_IN4 : X_INV
    port map (
      I => NlwBufferSignal_ras_OBUF_EXP_PT_1_IN4,
      O => NlwInverterSignal_ras_OBUF_EXP_PT_1_IN4
    );
  NlwInverterBlock_ras_OBUF_EXP_PT_1_IN5 : X_INV
    port map (
      I => NlwBufferSignal_ras_OBUF_EXP_PT_1_IN5,
      O => NlwInverterSignal_ras_OBUF_EXP_PT_1_IN5
    );
  NlwInverterBlock_ras_OBUF_EXP_PT_1_IN6 : X_INV
    port map (
      I => NlwBufferSignal_ras_OBUF_EXP_PT_1_IN6,
      O => NlwInverterSignal_ras_OBUF_EXP_PT_1_IN6
    );
  NlwInverterBlock_counter_2_D2_PT_0_IN1 : X_INV
    port map (
      I => NlwBufferSignal_counter_2_D2_PT_0_IN1,
      O => NlwInverterSignal_counter_2_D2_PT_0_IN1
    );
  NlwInverterBlock_counter_2_D2_PT_1_IN0 : X_INV
    port map (
      I => NlwBufferSignal_counter_2_D2_PT_1_IN0,
      O => NlwInverterSignal_counter_2_D2_PT_1_IN0
    );
  NlwInverterBlock_iocnt_2_D2_PT_0_IN1 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_2_D2_PT_0_IN1,
      O => NlwInverterSignal_iocnt_2_D2_PT_0_IN1
    );
  NlwInverterBlock_iocnt_2_D2_PT_1_IN1 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_2_D2_PT_1_IN1,
      O => NlwInverterSignal_iocnt_2_D2_PT_1_IN1
    );
  NlwInverterBlock_counter_0_D_IN0 : X_INV
    port map (
      I => NlwBufferSignal_counter_0_D_IN0,
      O => NlwInverterSignal_counter_0_D_IN0
    );
  NlwInverterBlock_counter_0_D2_IN1 : X_INV
    port map (
      I => NlwBufferSignal_counter_0_D2_IN1,
      O => NlwInverterSignal_counter_0_D2_IN1
    );
  NlwInverterBlock_counter_1_D2_PT_0_IN1 : X_INV
    port map (
      I => NlwBufferSignal_counter_1_D2_PT_0_IN1,
      O => NlwInverterSignal_counter_1_D2_PT_0_IN1
    );
  NlwInverterBlock_counter_1_D2_PT_1_IN0 : X_INV
    port map (
      I => NlwBufferSignal_counter_1_D2_PT_1_IN0,
      O => NlwInverterSignal_counter_1_D2_PT_1_IN0
    );
  NlwInverterBlock_counter_1_D2_PT_1_IN1 : X_INV
    port map (
      I => NlwBufferSignal_counter_1_D2_PT_1_IN1,
      O => NlwInverterSignal_counter_1_D2_PT_1_IN1
    );
  NlwInverterBlock_iocnt_0_D2_PT_0_IN1 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_0_D2_PT_0_IN1,
      O => NlwInverterSignal_iocnt_0_D2_PT_0_IN1
    );
  NlwInverterBlock_iocnt_0_D2_PT_1_IN1 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_0_D2_PT_1_IN1,
      O => NlwInverterSignal_iocnt_0_D2_PT_1_IN1
    );
  NlwInverterBlock_iocnt_0_D2_PT_2_IN1 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_0_D2_PT_2_IN1,
      O => NlwInverterSignal_iocnt_0_D2_PT_2_IN1
    );
  NlwInverterBlock_iocnt_0_D2_PT_3_IN12 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_0_D2_PT_3_IN12,
      O => NlwInverterSignal_iocnt_0_D2_PT_3_IN12
    );
  NlwInverterBlock_iocnt_0_D2_PT_3_IN13 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_0_D2_PT_3_IN13,
      O => NlwInverterSignal_iocnt_0_D2_PT_3_IN13
    );
  NlwInverterBlock_iocnt_0_D2_PT_3_IN14 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_0_D2_PT_3_IN14,
      O => NlwInverterSignal_iocnt_0_D2_PT_3_IN14
    );
  NlwInverterBlock_iocnt_0_D2_PT_3_IN16 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_0_D2_PT_3_IN16,
      O => NlwInverterSignal_iocnt_0_D2_PT_3_IN16
    );
  NlwInverterBlock_iocnt_0_D2_PT_3_IN17 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_0_D2_PT_3_IN17,
      O => NlwInverterSignal_iocnt_0_D2_PT_3_IN17
    );
  NlwInverterBlock_iocnt_0_D2_PT_3_IN18 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_0_D2_PT_3_IN18,
      O => NlwInverterSignal_iocnt_0_D2_PT_3_IN18
    );
  NlwInverterBlock_iocnt_1_D2_PT_0_IN1 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_1_D2_PT_0_IN1,
      O => NlwInverterSignal_iocnt_1_D2_PT_0_IN1
    );
  NlwInverterBlock_iocnt_1_D2_PT_1_IN1 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_1_D2_PT_1_IN1,
      O => NlwInverterSignal_iocnt_1_D2_PT_1_IN1
    );
  NlwInverterBlock_iocnt_1_D2_PT_1_IN3 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_1_D2_PT_1_IN3,
      O => NlwInverterSignal_iocnt_1_D2_PT_1_IN3
    );
  NlwInverterBlock_iocnt_1_EXP_PT_0_IN0 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_1_EXP_PT_0_IN0,
      O => NlwInverterSignal_iocnt_1_EXP_PT_0_IN0
    );
  NlwInverterBlock_iocnt_1_EXP_PT_0_IN1 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_1_EXP_PT_0_IN1,
      O => NlwInverterSignal_iocnt_1_EXP_PT_0_IN1
    );
  NlwInverterBlock_iocnt_1_EXP_PT_1_IN1 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_1_EXP_PT_1_IN1,
      O => NlwInverterSignal_iocnt_1_EXP_PT_1_IN1
    );
  NlwInverterBlock_iocnt_1_EXP_PT_2_IN0 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_1_EXP_PT_2_IN0,
      O => NlwInverterSignal_iocnt_1_EXP_PT_2_IN0
    );
  NlwInverterBlock_iocnt_1_EXP_PT_2_IN1 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_1_EXP_PT_2_IN1,
      O => NlwInverterSignal_iocnt_1_EXP_PT_2_IN1
    );
  NlwInverterBlock_iocnt_1_EXP_PT_2_IN2 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_1_EXP_PT_2_IN2,
      O => NlwInverterSignal_iocnt_1_EXP_PT_2_IN2
    );
  NlwInverterBlock_iocnt_1_EXP_PT_2_IN3 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_1_EXP_PT_2_IN3,
      O => NlwInverterSignal_iocnt_1_EXP_PT_2_IN3
    );
  NlwInverterBlock_iocnt_1_EXP_PT_2_IN4 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_1_EXP_PT_2_IN4,
      O => NlwInverterSignal_iocnt_1_EXP_PT_2_IN4
    );
  NlwInverterBlock_iocnt_1_EXP_PT_2_IN5 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_1_EXP_PT_2_IN5,
      O => NlwInverterSignal_iocnt_1_EXP_PT_2_IN5
    );
  NlwInverterBlock_iocnt_1_EXP_PT_2_IN7 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_1_EXP_PT_2_IN7,
      O => NlwInverterSignal_iocnt_1_EXP_PT_2_IN7
    );
  NlwInverterBlock_iocnt_1_EXP_PT_2_IN8 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_1_EXP_PT_2_IN8,
      O => NlwInverterSignal_iocnt_1_EXP_PT_2_IN8
    );
  NlwInverterBlock_refcnt_0_D2_IN1 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_0_D2_IN1,
      O => NlwInverterSignal_refcnt_0_D2_IN1
    );
  NlwInverterBlock_refcnt_1_D_IN0 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_1_D_IN0,
      O => NlwInverterSignal_refcnt_1_D_IN0
    );
  NlwInverterBlock_refcnt_1_D2_PT_0_IN0 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_1_D2_PT_0_IN0,
      O => NlwInverterSignal_refcnt_1_D2_PT_0_IN0
    );
  NlwInverterBlock_refcnt_1_D2_PT_0_IN1 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_1_D2_PT_0_IN1,
      O => NlwInverterSignal_refcnt_1_D2_PT_0_IN1
    );
  NlwInverterBlock_refcnt_1_D2_PT_1_IN0 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_1_D2_PT_1_IN0,
      O => NlwInverterSignal_refcnt_1_D2_PT_1_IN0
    );
  NlwInverterBlock_refcnt_1_D2_PT_1_IN1 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_1_D2_PT_1_IN1,
      O => NlwInverterSignal_refcnt_1_D2_PT_1_IN1
    );
  NlwInverterBlock_refcnt_1_EXP_PT_0_IN1 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_1_EXP_PT_0_IN1,
      O => NlwInverterSignal_refcnt_1_EXP_PT_0_IN1
    );
  NlwInverterBlock_refcnt_1_EXP_PT_0_IN2 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_1_EXP_PT_0_IN2,
      O => NlwInverterSignal_refcnt_1_EXP_PT_0_IN2
    );
  NlwInverterBlock_refcnt_1_EXP_PT_1_IN0 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_1_EXP_PT_1_IN0,
      O => NlwInverterSignal_refcnt_1_EXP_PT_1_IN0
    );
  NlwInverterBlock_refcnt_1_EXP_PT_1_IN3 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_1_EXP_PT_1_IN3,
      O => NlwInverterSignal_refcnt_1_EXP_PT_1_IN3
    );
  NlwInverterBlock_refcnt_1_EXP_PT_1_IN4 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_1_EXP_PT_1_IN4,
      O => NlwInverterSignal_refcnt_1_EXP_PT_1_IN4
    );
  NlwInverterBlock_refcnt_1_EXP_PT_1_IN5 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_1_EXP_PT_1_IN5,
      O => NlwInverterSignal_refcnt_1_EXP_PT_1_IN5
    );
  NlwInverterBlock_refcnt_1_EXP_PT_1_IN6 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_1_EXP_PT_1_IN6,
      O => NlwInverterSignal_refcnt_1_EXP_PT_1_IN6
    );
  NlwInverterBlock_refcnt_1_EXP_PT_1_IN7 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_1_EXP_PT_1_IN7,
      O => NlwInverterSignal_refcnt_1_EXP_PT_1_IN7
    );
  NlwInverterBlock_refcnt_1_EXP_PT_1_IN8 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_1_EXP_PT_1_IN8,
      O => NlwInverterSignal_refcnt_1_EXP_PT_1_IN8
    );
  NlwInverterBlock_refcnt_1_EXP_PT_1_IN9 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_1_EXP_PT_1_IN9,
      O => NlwInverterSignal_refcnt_1_EXP_PT_1_IN9
    );
  NlwInverterBlock_refcnt_1_EXP_PT_1_IN10 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_1_EXP_PT_1_IN10,
      O => NlwInverterSignal_refcnt_1_EXP_PT_1_IN10
    );
  NlwInverterBlock_refcnt_1_EXP_PT_1_IN11 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_1_EXP_PT_1_IN11,
      O => NlwInverterSignal_refcnt_1_EXP_PT_1_IN11
    );
  NlwInverterBlock_refcnt_1_EXP_PT_1_IN12 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_1_EXP_PT_1_IN12,
      O => NlwInverterSignal_refcnt_1_EXP_PT_1_IN12
    );
  NlwInverterBlock_refcnt_1_EXP_PT_1_IN13 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_1_EXP_PT_1_IN13,
      O => NlwInverterSignal_refcnt_1_EXP_PT_1_IN13
    );
  NlwInverterBlock_refcnt_2_D2_IN1 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_2_D2_IN1,
      O => NlwInverterSignal_refcnt_2_D2_IN1
    );
  NlwInverterBlock_refcnt_2_D2_IN3 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_2_D2_IN3,
      O => NlwInverterSignal_refcnt_2_D2_IN3
    );
  NlwInverterBlock_refcnt_2_D2_IN4 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_2_D2_IN4,
      O => NlwInverterSignal_refcnt_2_D2_IN4
    );
  NlwInverterBlock_refcnt_2_EXP_PT_1_IN0 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_2_EXP_PT_1_IN0,
      O => NlwInverterSignal_refcnt_2_EXP_PT_1_IN0
    );
  NlwInverterBlock_refcnt_2_EXP_PT_3_IN1 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_2_EXP_PT_3_IN1,
      O => NlwInverterSignal_refcnt_2_EXP_PT_3_IN1
    );
  NlwInverterBlock_refcnt_3_D2_IN1 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_3_D2_IN1,
      O => NlwInverterSignal_refcnt_3_D2_IN1
    );
  NlwInverterBlock_refcnt_3_D2_IN3 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_3_D2_IN3,
      O => NlwInverterSignal_refcnt_3_D2_IN3
    );
  NlwInverterBlock_refcnt_3_D2_IN4 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_3_D2_IN4,
      O => NlwInverterSignal_refcnt_3_D2_IN4
    );
  NlwInverterBlock_refcnt_3_D2_IN5 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_3_D2_IN5,
      O => NlwInverterSignal_refcnt_3_D2_IN5
    );
  NlwInverterBlock_refcnt_3_EXP_PT_0_IN0 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_3_EXP_PT_0_IN0,
      O => NlwInverterSignal_refcnt_3_EXP_PT_0_IN0
    );
  NlwInverterBlock_refcnt_3_EXP_PT_1_IN0 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_3_EXP_PT_1_IN0,
      O => NlwInverterSignal_refcnt_3_EXP_PT_1_IN0
    );
  NlwInverterBlock_refcnt_3_EXP_PT_3_IN1 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_3_EXP_PT_3_IN1,
      O => NlwInverterSignal_refcnt_3_EXP_PT_3_IN1
    );
  NlwInverterBlock_refcnt_4_D2_PT_1_IN1 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_D2_PT_1_IN1,
      O => NlwInverterSignal_refcnt_4_D2_PT_1_IN1
    );
  NlwInverterBlock_refcnt_4_D2_PT_1_IN3 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_D2_PT_1_IN3,
      O => NlwInverterSignal_refcnt_4_D2_PT_1_IN3
    );
  NlwInverterBlock_refcnt_4_D2_PT_1_IN4 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_D2_PT_1_IN4,
      O => NlwInverterSignal_refcnt_4_D2_PT_1_IN4
    );
  NlwInverterBlock_refcnt_4_D2_PT_1_IN5 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_D2_PT_1_IN5,
      O => NlwInverterSignal_refcnt_4_D2_PT_1_IN5
    );
  NlwInverterBlock_refcnt_4_D2_PT_1_IN6 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_D2_PT_1_IN6,
      O => NlwInverterSignal_refcnt_4_D2_PT_1_IN6
    );
  NlwInverterBlock_refcnt_4_D2_PT_2_IN1 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_D2_PT_2_IN1,
      O => NlwInverterSignal_refcnt_4_D2_PT_2_IN1
    );
  NlwInverterBlock_refcnt_4_D2_PT_2_IN3 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_D2_PT_2_IN3,
      O => NlwInverterSignal_refcnt_4_D2_PT_2_IN3
    );
  NlwInverterBlock_refcnt_4_D2_PT_2_IN4 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_D2_PT_2_IN4,
      O => NlwInverterSignal_refcnt_4_D2_PT_2_IN4
    );
  NlwInverterBlock_refcnt_4_D2_PT_2_IN5 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_D2_PT_2_IN5,
      O => NlwInverterSignal_refcnt_4_D2_PT_2_IN5
    );
  NlwInverterBlock_refcnt_4_D2_PT_2_IN6 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_D2_PT_2_IN6,
      O => NlwInverterSignal_refcnt_4_D2_PT_2_IN6
    );
  NlwInverterBlock_refcnt_4_EXP_PT_0_IN1 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_EXP_PT_0_IN1,
      O => NlwInverterSignal_refcnt_4_EXP_PT_0_IN1
    );
  NlwInverterBlock_refcnt_4_EXP_PT_1_IN0 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_EXP_PT_1_IN0,
      O => NlwInverterSignal_refcnt_4_EXP_PT_1_IN0
    );
  NlwInverterBlock_refcnt_4_EXP_PT_1_IN1 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_EXP_PT_1_IN1,
      O => NlwInverterSignal_refcnt_4_EXP_PT_1_IN1
    );
  NlwInverterBlock_refcnt_4_EXP_PT_2_IN1 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_EXP_PT_2_IN1,
      O => NlwInverterSignal_refcnt_4_EXP_PT_2_IN1
    );
  NlwInverterBlock_refcnt_4_EXP_PT_2_IN2 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_EXP_PT_2_IN2,
      O => NlwInverterSignal_refcnt_4_EXP_PT_2_IN2
    );
  NlwInverterBlock_refcnt_4_EXP_PT_2_IN3 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_EXP_PT_2_IN3,
      O => NlwInverterSignal_refcnt_4_EXP_PT_2_IN3
    );
  NlwInverterBlock_refcnt_4_EXP_PT_2_IN5 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_EXP_PT_2_IN5,
      O => NlwInverterSignal_refcnt_4_EXP_PT_2_IN5
    );
  NlwInverterBlock_refcnt_4_EXP_PT_2_IN6 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_EXP_PT_2_IN6,
      O => NlwInverterSignal_refcnt_4_EXP_PT_2_IN6
    );
  NlwInverterBlock_refcnt_4_EXP_PT_2_IN7 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_EXP_PT_2_IN7,
      O => NlwInverterSignal_refcnt_4_EXP_PT_2_IN7
    );
  NlwInverterBlock_refcnt_4_EXP_PT_2_IN8 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_EXP_PT_2_IN8,
      O => NlwInverterSignal_refcnt_4_EXP_PT_2_IN8
    );
  NlwInverterBlock_refcnt_4_EXP_PT_2_IN9 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_EXP_PT_2_IN9,
      O => NlwInverterSignal_refcnt_4_EXP_PT_2_IN9
    );
  NlwInverterBlock_refcnt_5_D2_PT_0_IN1 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_D2_PT_0_IN1,
      O => NlwInverterSignal_refcnt_5_D2_PT_0_IN1
    );
  NlwInverterBlock_refcnt_5_D2_PT_0_IN3 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_D2_PT_0_IN3,
      O => NlwInverterSignal_refcnt_5_D2_PT_0_IN3
    );
  NlwInverterBlock_refcnt_5_D2_PT_0_IN4 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_D2_PT_0_IN4,
      O => NlwInverterSignal_refcnt_5_D2_PT_0_IN4
    );
  NlwInverterBlock_refcnt_5_D2_PT_0_IN5 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_D2_PT_0_IN5,
      O => NlwInverterSignal_refcnt_5_D2_PT_0_IN5
    );
  NlwInverterBlock_refcnt_5_D2_PT_0_IN6 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_D2_PT_0_IN6,
      O => NlwInverterSignal_refcnt_5_D2_PT_0_IN6
    );
  NlwInverterBlock_refcnt_5_D2_PT_0_IN8 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_D2_PT_0_IN8,
      O => NlwInverterSignal_refcnt_5_D2_PT_0_IN8
    );
  NlwInverterBlock_refcnt_5_D2_PT_1_IN1 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_D2_PT_1_IN1,
      O => NlwInverterSignal_refcnt_5_D2_PT_1_IN1
    );
  NlwInverterBlock_refcnt_5_D2_PT_1_IN3 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_D2_PT_1_IN3,
      O => NlwInverterSignal_refcnt_5_D2_PT_1_IN3
    );
  NlwInverterBlock_refcnt_5_D2_PT_1_IN4 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_D2_PT_1_IN4,
      O => NlwInverterSignal_refcnt_5_D2_PT_1_IN4
    );
  NlwInverterBlock_refcnt_5_D2_PT_1_IN5 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_D2_PT_1_IN5,
      O => NlwInverterSignal_refcnt_5_D2_PT_1_IN5
    );
  NlwInverterBlock_refcnt_5_D2_PT_1_IN6 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_D2_PT_1_IN6,
      O => NlwInverterSignal_refcnt_5_D2_PT_1_IN6
    );
  NlwInverterBlock_refcnt_5_D2_PT_1_IN8 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_D2_PT_1_IN8,
      O => NlwInverterSignal_refcnt_5_D2_PT_1_IN8
    );
  NlwInverterBlock_refcnt_5_D2_PT_2_IN1 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_D2_PT_2_IN1,
      O => NlwInverterSignal_refcnt_5_D2_PT_2_IN1
    );
  NlwInverterBlock_refcnt_5_D2_PT_2_IN3 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_D2_PT_2_IN3,
      O => NlwInverterSignal_refcnt_5_D2_PT_2_IN3
    );
  NlwInverterBlock_refcnt_5_D2_PT_2_IN4 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_D2_PT_2_IN4,
      O => NlwInverterSignal_refcnt_5_D2_PT_2_IN4
    );
  NlwInverterBlock_refcnt_5_D2_PT_2_IN5 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_D2_PT_2_IN5,
      O => NlwInverterSignal_refcnt_5_D2_PT_2_IN5
    );
  NlwInverterBlock_refcnt_5_D2_PT_2_IN6 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_D2_PT_2_IN6,
      O => NlwInverterSignal_refcnt_5_D2_PT_2_IN6
    );
  NlwInverterBlock_refcnt_5_D2_PT_2_IN7 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_D2_PT_2_IN7,
      O => NlwInverterSignal_refcnt_5_D2_PT_2_IN7
    );
  NlwInverterBlock_refcnt_5_EXP_PT_0_IN0 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_EXP_PT_0_IN0,
      O => NlwInverterSignal_refcnt_5_EXP_PT_0_IN0
    );
  NlwInverterBlock_refcnt_5_EXP_PT_0_IN1 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_EXP_PT_0_IN1,
      O => NlwInverterSignal_refcnt_5_EXP_PT_0_IN1
    );
  NlwInverterBlock_refcnt_5_EXP_PT_1_IN0 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_EXP_PT_1_IN0,
      O => NlwInverterSignal_refcnt_5_EXP_PT_1_IN0
    );
  NlwInverterBlock_refcnt_5_EXP_PT_1_IN1 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_EXP_PT_1_IN1,
      O => NlwInverterSignal_refcnt_5_EXP_PT_1_IN1
    );
  NlwInverterBlock_refcnt_5_EXP_PT_1_IN2 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_EXP_PT_1_IN2,
      O => NlwInverterSignal_refcnt_5_EXP_PT_1_IN2
    );
  NlwInverterBlock_refcnt_5_EXP_PT_1_IN3 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_EXP_PT_1_IN3,
      O => NlwInverterSignal_refcnt_5_EXP_PT_1_IN3
    );
  NlwInverterBlock_refcnt_5_EXP_PT_1_IN4 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_EXP_PT_1_IN4,
      O => NlwInverterSignal_refcnt_5_EXP_PT_1_IN4
    );
  NlwInverterBlock_refcnt_5_EXP_PT_1_IN5 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_EXP_PT_1_IN5,
      O => NlwInverterSignal_refcnt_5_EXP_PT_1_IN5
    );
  NlwInverterBlock_refcnt_5_EXP_PT_1_IN7 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_EXP_PT_1_IN7,
      O => NlwInverterSignal_refcnt_5_EXP_PT_1_IN7
    );
  NlwInverterBlock_refcnt_5_EXP_PT_1_IN8 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_EXP_PT_1_IN8,
      O => NlwInverterSignal_refcnt_5_EXP_PT_1_IN8
    );
  NlwInverterBlock_refcnt_6_D2_IN1 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_6_D2_IN1,
      O => NlwInverterSignal_refcnt_6_D2_IN1
    );
  NlwInverterBlock_refcnt_6_D2_IN3 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_6_D2_IN3,
      O => NlwInverterSignal_refcnt_6_D2_IN3
    );
  NlwInverterBlock_refcnt_7_D2_IN1 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_D2_IN1,
      O => NlwInverterSignal_refcnt_7_D2_IN1
    );
  NlwInverterBlock_refcnt_7_D2_IN3 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_D2_IN3,
      O => NlwInverterSignal_refcnt_7_D2_IN3
    );
  NlwInverterBlock_refcnt_7_D2_IN4 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_D2_IN4,
      O => NlwInverterSignal_refcnt_7_D2_IN4
    );
  NlwInverterBlock_refcnt_7_D2_IN5 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_D2_IN5,
      O => NlwInverterSignal_refcnt_7_D2_IN5
    );
  NlwInverterBlock_refcnt_7_D2_IN6 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_D2_IN6,
      O => NlwInverterSignal_refcnt_7_D2_IN6
    );
  NlwInverterBlock_refcnt_7_D2_IN7 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_D2_IN7,
      O => NlwInverterSignal_refcnt_7_D2_IN7
    );
  NlwInverterBlock_refcnt_7_D2_IN8 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_D2_IN8,
      O => NlwInverterSignal_refcnt_7_D2_IN8
    );
  NlwInverterBlock_refcnt_7_D2_IN9 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_D2_IN9,
      O => NlwInverterSignal_refcnt_7_D2_IN9
    );
  NlwInverterBlock_refcnt_7_EXP_PT_0_IN0 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_EXP_PT_0_IN0,
      O => NlwInverterSignal_refcnt_7_EXP_PT_0_IN0
    );
  NlwInverterBlock_refcnt_7_EXP_PT_0_IN1 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_EXP_PT_0_IN1,
      O => NlwInverterSignal_refcnt_7_EXP_PT_0_IN1
    );
  NlwInverterBlock_refcnt_7_EXP_PT_1_IN1 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_EXP_PT_1_IN1,
      O => NlwInverterSignal_refcnt_7_EXP_PT_1_IN1
    );
  NlwInverterBlock_refcnt_7_EXP_PT_2_IN0 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_EXP_PT_2_IN0,
      O => NlwInverterSignal_refcnt_7_EXP_PT_2_IN0
    );
  NlwInverterBlock_refcnt_7_EXP_PT_3_IN0 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_EXP_PT_3_IN0,
      O => NlwInverterSignal_refcnt_7_EXP_PT_3_IN0
    );
  NlwInverterBlock_refcnt_7_EXP_PT_3_IN3 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_EXP_PT_3_IN3,
      O => NlwInverterSignal_refcnt_7_EXP_PT_3_IN3
    );
  NlwInverterBlock_refcnt_7_EXP_PT_3_IN4 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_EXP_PT_3_IN4,
      O => NlwInverterSignal_refcnt_7_EXP_PT_3_IN4
    );
  NlwInverterBlock_refcnt_7_EXP_PT_3_IN5 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_EXP_PT_3_IN5,
      O => NlwInverterSignal_refcnt_7_EXP_PT_3_IN5
    );
  NlwInverterBlock_refcnt_7_EXP_PT_3_IN6 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_EXP_PT_3_IN6,
      O => NlwInverterSignal_refcnt_7_EXP_PT_3_IN6
    );
  NlwInverterBlock_refcnt_7_EXP_PT_3_IN7 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_EXP_PT_3_IN7,
      O => NlwInverterSignal_refcnt_7_EXP_PT_3_IN7
    );
  NlwInverterBlock_refcnt_7_EXP_PT_3_IN8 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_EXP_PT_3_IN8,
      O => NlwInverterSignal_refcnt_7_EXP_PT_3_IN8
    );
  NlwInverterBlock_refcnt_7_EXP_PT_3_IN9 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_EXP_PT_3_IN9,
      O => NlwInverterSignal_refcnt_7_EXP_PT_3_IN9
    );
  NlwInverterBlock_refcnt_7_EXP_PT_3_IN10 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_EXP_PT_3_IN10,
      O => NlwInverterSignal_refcnt_7_EXP_PT_3_IN10
    );
  NlwInverterBlock_refcnt_7_EXP_PT_3_IN11 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_EXP_PT_3_IN11,
      O => NlwInverterSignal_refcnt_7_EXP_PT_3_IN11
    );
  NlwInverterBlock_refcnt_7_EXP_PT_3_IN12 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_EXP_PT_3_IN12,
      O => NlwInverterSignal_refcnt_7_EXP_PT_3_IN12
    );
  NlwInverterBlock_refcnt_7_EXP_PT_3_IN13 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_EXP_PT_3_IN13,
      O => NlwInverterSignal_refcnt_7_EXP_PT_3_IN13
    );
  NlwInverterBlock_OpTx_FX_DC_49_D2_PT_0_IN0 : X_INV
    port map (
      I => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_0_IN0,
      O => NlwInverterSignal_OpTx_FX_DC_49_D2_PT_0_IN0
    );
  NlwInverterBlock_OpTx_FX_DC_49_D2_PT_0_IN1 : X_INV
    port map (
      I => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_0_IN1,
      O => NlwInverterSignal_OpTx_FX_DC_49_D2_PT_0_IN1
    );
  NlwInverterBlock_OpTx_FX_DC_49_D2_PT_2_IN0 : X_INV
    port map (
      I => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN0,
      O => NlwInverterSignal_OpTx_FX_DC_49_D2_PT_2_IN0
    );
  NlwInverterBlock_OpTx_FX_DC_49_D2_PT_2_IN1 : X_INV
    port map (
      I => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN1,
      O => NlwInverterSignal_OpTx_FX_DC_49_D2_PT_2_IN1
    );
  NlwInverterBlock_OpTx_FX_DC_49_D2_PT_2_IN2 : X_INV
    port map (
      I => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN2,
      O => NlwInverterSignal_OpTx_FX_DC_49_D2_PT_2_IN2
    );
  NlwInverterBlock_OpTx_FX_DC_49_D2_PT_2_IN3 : X_INV
    port map (
      I => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN3,
      O => NlwInverterSignal_OpTx_FX_DC_49_D2_PT_2_IN3
    );
  NlwInverterBlock_OpTx_FX_DC_49_D2_PT_2_IN4 : X_INV
    port map (
      I => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN4,
      O => NlwInverterSignal_OpTx_FX_DC_49_D2_PT_2_IN4
    );
  NlwInverterBlock_OpTx_FX_DC_49_D2_PT_2_IN5 : X_INV
    port map (
      I => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN5,
      O => NlwInverterSignal_OpTx_FX_DC_49_D2_PT_2_IN5
    );
  NlwInverterBlock_OpTx_FX_DC_49_D2_PT_2_IN6 : X_INV
    port map (
      I => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN6,
      O => NlwInverterSignal_OpTx_FX_DC_49_D2_PT_2_IN6
    );
  NlwInverterBlock_OpTx_FX_DC_49_D2_PT_2_IN7 : X_INV
    port map (
      I => NlwBufferSignal_OpTx_FX_DC_49_D2_PT_2_IN7,
      O => NlwInverterSignal_OpTx_FX_DC_49_D2_PT_2_IN7
    );
  NlwInverterBlock_EXP1_EXP_PT_2_IN0 : X_INV
    port map (
      I => NlwBufferSignal_EXP1_EXP_PT_2_IN0,
      O => NlwInverterSignal_EXP1_EXP_PT_2_IN0
    );
  NlwInverterBlock_EXP1_EXP_PT_3_IN0 : X_INV
    port map (
      I => NlwBufferSignal_EXP1_EXP_PT_3_IN0,
      O => NlwInverterSignal_EXP1_EXP_PT_3_IN0
    );
  NlwInverterBlock_EXP1_EXP_PT_5_IN0 : X_INV
    port map (
      I => NlwBufferSignal_EXP1_EXP_PT_5_IN0,
      O => NlwInverterSignal_EXP1_EXP_PT_5_IN0
    );
  NlwInverterBlock_EXP2_EXP_PT_0_IN0 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_0_IN0,
      O => NlwInverterSignal_EXP2_EXP_PT_0_IN0
    );
  NlwInverterBlock_EXP2_EXP_PT_0_IN1 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_0_IN1,
      O => NlwInverterSignal_EXP2_EXP_PT_0_IN1
    );
  NlwInverterBlock_EXP2_EXP_PT_0_IN3 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_0_IN3,
      O => NlwInverterSignal_EXP2_EXP_PT_0_IN3
    );
  NlwInverterBlock_EXP2_EXP_PT_1_IN0 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_1_IN0,
      O => NlwInverterSignal_EXP2_EXP_PT_1_IN0
    );
  NlwInverterBlock_EXP2_EXP_PT_1_IN1 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_1_IN1,
      O => NlwInverterSignal_EXP2_EXP_PT_1_IN1
    );
  NlwInverterBlock_EXP2_EXP_PT_1_IN2 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_1_IN2,
      O => NlwInverterSignal_EXP2_EXP_PT_1_IN2
    );
  NlwInverterBlock_EXP2_EXP_PT_1_IN3 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_1_IN3,
      O => NlwInverterSignal_EXP2_EXP_PT_1_IN3
    );
  NlwInverterBlock_EXP2_EXP_PT_1_IN4 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_1_IN4,
      O => NlwInverterSignal_EXP2_EXP_PT_1_IN4
    );
  NlwInverterBlock_EXP2_EXP_PT_1_IN5 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_1_IN5,
      O => NlwInverterSignal_EXP2_EXP_PT_1_IN5
    );
  NlwInverterBlock_EXP2_EXP_PT_1_IN6 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_1_IN6,
      O => NlwInverterSignal_EXP2_EXP_PT_1_IN6
    );
  NlwInverterBlock_EXP2_EXP_PT_1_IN7 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_1_IN7,
      O => NlwInverterSignal_EXP2_EXP_PT_1_IN7
    );
  NlwInverterBlock_EXP2_EXP_PT_1_IN8 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_1_IN8,
      O => NlwInverterSignal_EXP2_EXP_PT_1_IN8
    );
  NlwInverterBlock_EXP2_EXP_PT_1_IN9 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_1_IN9,
      O => NlwInverterSignal_EXP2_EXP_PT_1_IN9
    );
  NlwInverterBlock_EXP2_EXP_PT_2_IN0 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_2_IN0,
      O => NlwInverterSignal_EXP2_EXP_PT_2_IN0
    );
  NlwInverterBlock_EXP2_EXP_PT_2_IN1 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_2_IN1,
      O => NlwInverterSignal_EXP2_EXP_PT_2_IN1
    );
  NlwInverterBlock_EXP2_EXP_PT_2_IN2 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_2_IN2,
      O => NlwInverterSignal_EXP2_EXP_PT_2_IN2
    );
  NlwInverterBlock_EXP2_EXP_PT_2_IN3 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_2_IN3,
      O => NlwInverterSignal_EXP2_EXP_PT_2_IN3
    );
  NlwInverterBlock_EXP2_EXP_PT_2_IN4 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_2_IN4,
      O => NlwInverterSignal_EXP2_EXP_PT_2_IN4
    );
  NlwInverterBlock_EXP2_EXP_PT_2_IN5 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_2_IN5,
      O => NlwInverterSignal_EXP2_EXP_PT_2_IN5
    );
  NlwInverterBlock_EXP2_EXP_PT_2_IN6 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_2_IN6,
      O => NlwInverterSignal_EXP2_EXP_PT_2_IN6
    );
  NlwInverterBlock_EXP2_EXP_PT_2_IN7 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_2_IN7,
      O => NlwInverterSignal_EXP2_EXP_PT_2_IN7
    );
  NlwInverterBlock_EXP2_EXP_PT_2_IN8 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_2_IN8,
      O => NlwInverterSignal_EXP2_EXP_PT_2_IN8
    );
  NlwInverterBlock_EXP2_EXP_PT_2_IN9 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_2_IN9,
      O => NlwInverterSignal_EXP2_EXP_PT_2_IN9
    );
  NlwInverterBlock_EXP2_EXP_PT_3_IN1 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_3_IN1,
      O => NlwInverterSignal_EXP2_EXP_PT_3_IN1
    );
  NlwInverterBlock_EXP2_EXP_PT_3_IN2 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_3_IN2,
      O => NlwInverterSignal_EXP2_EXP_PT_3_IN2
    );
  NlwInverterBlock_EXP2_EXP_PT_3_IN3 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_3_IN3,
      O => NlwInverterSignal_EXP2_EXP_PT_3_IN3
    );
  NlwInverterBlock_EXP2_EXP_PT_3_IN4 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_3_IN4,
      O => NlwInverterSignal_EXP2_EXP_PT_3_IN4
    );
  NlwInverterBlock_EXP2_EXP_PT_3_IN5 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_3_IN5,
      O => NlwInverterSignal_EXP2_EXP_PT_3_IN5
    );
  NlwInverterBlock_EXP2_EXP_PT_3_IN6 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_3_IN6,
      O => NlwInverterSignal_EXP2_EXP_PT_3_IN6
    );
  NlwInverterBlock_EXP2_EXP_PT_3_IN7 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_3_IN7,
      O => NlwInverterSignal_EXP2_EXP_PT_3_IN7
    );
  NlwInverterBlock_EXP2_EXP_PT_3_IN8 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_3_IN8,
      O => NlwInverterSignal_EXP2_EXP_PT_3_IN8
    );
  NlwInverterBlock_EXP2_EXP_PT_3_IN9 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_3_IN9,
      O => NlwInverterSignal_EXP2_EXP_PT_3_IN9
    );
  NlwInverterBlock_EXP2_EXP_PT_4_IN0 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_4_IN0,
      O => NlwInverterSignal_EXP2_EXP_PT_4_IN0
    );
  NlwInverterBlock_EXP2_EXP_PT_4_IN1 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_4_IN1,
      O => NlwInverterSignal_EXP2_EXP_PT_4_IN1
    );
  NlwInverterBlock_EXP2_EXP_PT_4_IN3 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_4_IN3,
      O => NlwInverterSignal_EXP2_EXP_PT_4_IN3
    );
  NlwInverterBlock_EXP2_EXP_PT_4_IN4 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_4_IN4,
      O => NlwInverterSignal_EXP2_EXP_PT_4_IN4
    );
  NlwInverterBlock_EXP2_EXP_PT_4_IN5 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_4_IN5,
      O => NlwInverterSignal_EXP2_EXP_PT_4_IN5
    );
  NlwInverterBlock_EXP2_EXP_PT_4_IN6 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_4_IN6,
      O => NlwInverterSignal_EXP2_EXP_PT_4_IN6
    );
  NlwInverterBlock_EXP2_EXP_PT_4_IN7 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_4_IN7,
      O => NlwInverterSignal_EXP2_EXP_PT_4_IN7
    );
  NlwInverterBlock_EXP2_EXP_PT_4_IN8 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_4_IN8,
      O => NlwInverterSignal_EXP2_EXP_PT_4_IN8
    );
  NlwInverterBlock_EXP2_EXP_PT_4_IN9 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_4_IN9,
      O => NlwInverterSignal_EXP2_EXP_PT_4_IN9
    );
  NlwInverterBlock_EXP2_EXP_PT_4_IN10 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_PT_4_IN10,
      O => NlwInverterSignal_EXP2_EXP_PT_4_IN10
    );
  NlwInverterBlock_EXP3_EXP_PT_0_IN0 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_0_IN0,
      O => NlwInverterSignal_EXP3_EXP_PT_0_IN0
    );
  NlwInverterBlock_EXP3_EXP_PT_0_IN1 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_0_IN1,
      O => NlwInverterSignal_EXP3_EXP_PT_0_IN1
    );
  NlwInverterBlock_EXP3_EXP_PT_1_IN0 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_1_IN0,
      O => NlwInverterSignal_EXP3_EXP_PT_1_IN0
    );
  NlwInverterBlock_EXP3_EXP_PT_1_IN1 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_1_IN1,
      O => NlwInverterSignal_EXP3_EXP_PT_1_IN1
    );
  NlwInverterBlock_EXP3_EXP_PT_2_IN0 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_2_IN0,
      O => NlwInverterSignal_EXP3_EXP_PT_2_IN0
    );
  NlwInverterBlock_EXP3_EXP_PT_2_IN1 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_2_IN1,
      O => NlwInverterSignal_EXP3_EXP_PT_2_IN1
    );
  NlwInverterBlock_EXP3_EXP_PT_3_IN0 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_3_IN0,
      O => NlwInverterSignal_EXP3_EXP_PT_3_IN0
    );
  NlwInverterBlock_EXP3_EXP_PT_3_IN1 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_3_IN1,
      O => NlwInverterSignal_EXP3_EXP_PT_3_IN1
    );
  NlwInverterBlock_EXP3_EXP_PT_4_IN0 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_4_IN0,
      O => NlwInverterSignal_EXP3_EXP_PT_4_IN0
    );
  NlwInverterBlock_EXP3_EXP_PT_4_IN1 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_4_IN1,
      O => NlwInverterSignal_EXP3_EXP_PT_4_IN1
    );
  NlwInverterBlock_FC_0_IN0 : X_INV
    port map (
      I => NlwBufferSignal_FC_0_IN0,
      O => NlwInverterSignal_FC_0_IN0
    );
  NlwInverterBlock_FC_0_IN1 : X_INV
    port map (
      I => NlwBufferSignal_FC_0_IN1,
      O => NlwInverterSignal_FC_0_IN1
    );
  NlwInverterBlock_FC_0_IN2 : X_INV
    port map (
      I => NlwBufferSignal_FC_0_IN2,
      O => NlwInverterSignal_FC_0_IN2
    );
  NlwInverterBlock_FC_0_IN3 : X_INV
    port map (
      I => NlwBufferSignal_FC_0_IN3,
      O => NlwInverterSignal_FC_0_IN3
    );
  NlwInverterBlock_FC_0_IN4 : X_INV
    port map (
      I => NlwBufferSignal_FC_0_IN4,
      O => NlwInverterSignal_FC_0_IN4
    );
  NlwInverterBlock_FC_0_IN5 : X_INV
    port map (
      I => NlwBufferSignal_FC_0_IN5,
      O => NlwInverterSignal_FC_0_IN5
    );
  NlwInverterBlock_FC_1_IN0 : X_INV
    port map (
      I => NlwBufferSignal_FC_1_IN0,
      O => NlwInverterSignal_FC_1_IN0
    );
  NlwInverterBlock_FC_1_IN1 : X_INV
    port map (
      I => NlwBufferSignal_FC_1_IN1,
      O => NlwInverterSignal_FC_1_IN1
    );
  NlwBlockROC : X_ROC
    generic map (ROC_WIDTH => 100 ns)
    port map (O => PRLD);

end Structure;

