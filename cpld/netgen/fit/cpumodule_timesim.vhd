--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: P.20131013
--  \   \         Application: netgen
--  /   /         Filename: cpumodule_timesim.vhd
-- /___/   /\     Timestamp: Wed Sep 30 16:58:27 2026
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
    rw : in STD_LOGIC := 'X'; 
    a10 : in STD_LOGIC := 'X'; 
    clk : in STD_LOGIC := 'X'; 
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
    a15_13 : in STD_LOGIC_VECTOR ( 2 downto 0 ); 
    a12_11 : in STD_LOGIC_VECTOR ( 1 downto 0 ) 
  );
end cpumodule;

architecture Structure of cpumodule is
  signal bank_4_IBUF_1 : STD_LOGIC; 
  signal bank_3_IBUF_3 : STD_LOGIC; 
  signal bank_2_IBUF_5 : STD_LOGIC; 
  signal bank_1_IBUF_7 : STD_LOGIC; 
  signal bank_0_IBUF_9 : STD_LOGIC; 
  signal a15_13_2_IBUF_11 : STD_LOGIC; 
  signal a15_13_1_IBUF_13 : STD_LOGIC; 
  signal a15_13_0_IBUF_15 : STD_LOGIC; 
  signal rw_IBUF_17 : STD_LOGIC; 
  signal bank_6_IBUF_19 : STD_LOGIC; 
  signal bank_5_IBUF_21 : STD_LOGIC; 
  signal bank_7_IBUF_23 : STD_LOGIC; 
  signal a12_11_1_IBUF_25 : STD_LOGIC; 
  signal a12_11_0_IBUF_27 : STD_LOGIC; 
  signal a10_IBUF_29 : STD_LOGIC; 
  signal FCLK_IO_0_31 : STD_LOGIC; 
  signal rom_PIN_BUF_Q_33 : STD_LOGIC; 
  signal phi1_PIN_BUF_Q_35 : STD_LOGIC; 
  signal cas0_PIN_BUF_Q_37 : STD_LOGIC; 
  signal cas1_PIN_BUF_Q_39 : STD_LOGIC; 
  signal cas2_PIN_BUF_Q_41 : STD_LOGIC; 
  signal cas3_PIN_BUF_Q_43 : STD_LOGIC; 
  signal io0_PIN_BUF_Q_45 : STD_LOGIC; 
  signal io1_PIN_BUF_Q_47 : STD_LOGIC; 
  signal io2_PIN_BUF_Q_49 : STD_LOGIC; 
  signal io3_PIN_BUF_Q_51 : STD_LOGIC; 
  signal io4_PIN_BUF_Q_53 : STD_LOGIC; 
  signal io5_PIN_BUF_Q_55 : STD_LOGIC; 
  signal io6_PIN_BUF_Q_57 : STD_LOGIC; 
  signal io7_PIN_BUF_Q_59 : STD_LOGIC; 
  signal phi0_PIN_BUF_Q_61 : STD_LOGIC; 
  signal ras_PIN_BUF_Q_63 : STD_LOGIC; 
  signal rom_OBUF_Q_64 : STD_LOGIC; 
  signal phi1_OBUF_Q_65 : STD_LOGIC; 
  signal cas0_OBUF_Q_66 : STD_LOGIC; 
  signal cas1_OBUF_Q_67 : STD_LOGIC; 
  signal cas2_OBUF_Q_68 : STD_LOGIC; 
  signal cas3_OBUF_Q_69 : STD_LOGIC; 
  signal io0_OBUF_Q_70 : STD_LOGIC; 
  signal io1_OBUF_Q_71 : STD_LOGIC; 
  signal io2_OBUF_Q_72 : STD_LOGIC; 
  signal io3_OBUF_Q_73 : STD_LOGIC; 
  signal io4_OBUF_Q_74 : STD_LOGIC; 
  signal io5_OBUF_Q_75 : STD_LOGIC; 
  signal io6_OBUF_Q_76 : STD_LOGIC; 
  signal io7_OBUF_Q_77 : STD_LOGIC; 
  signal phi0_OBUF_Q_78 : STD_LOGIC; 
  signal ras_OBUF_Q_79 : STD_LOGIC; 
  signal rom_OBUF_Q_80 : STD_LOGIC; 
  signal rom_OBUF_D_81 : STD_LOGIC; 
  signal rom_OBUF_tsimcreated_xor_Q_82 : STD_LOGIC; 
  signal Gnd_83 : STD_LOGIC; 
  signal Vcc_84 : STD_LOGIC; 
  signal rom_OBUF_D1_85 : STD_LOGIC; 
  signal rom_OBUF_D2_86 : STD_LOGIC; 
  signal rom_OBUF_D2_PT_0_90 : STD_LOGIC; 
  signal rom_OBUF_D2_PT_1_91 : STD_LOGIC; 
  signal phi1_OBUF_Q_92 : STD_LOGIC; 
  signal phi1_OBUF_D_93 : STD_LOGIC; 
  signal phi1_OBUF_D1_94 : STD_LOGIC; 
  signal phi1_OBUF_D2_95 : STD_LOGIC; 
  signal EXP1_EXP_96 : STD_LOGIC; 
  signal phi1_OBUF_D2_PT_0_97 : STD_LOGIC; 
  signal phi1_OBUF_D2_PT_1_98 : STD_LOGIC; 
  signal phi1_OBUF_D2_PT_2_99 : STD_LOGIC; 
  signal phi1_OBUF_D2_PT_3_101 : STD_LOGIC; 
  signal phi1_OBUF_D2_PT_4_102 : STD_LOGIC; 
  signal phi1_OBUF_D2_PT_5_105 : STD_LOGIC; 
  signal cas0_OBUF_Q_106 : STD_LOGIC; 
  signal cas0_OBUF_D_107 : STD_LOGIC; 
  signal cas0_OBUF_D1_108 : STD_LOGIC; 
  signal cas0_OBUF_D2_109 : STD_LOGIC; 
  signal refcnt_1_EXP_110 : STD_LOGIC; 
  signal cas0_OBUF_D2_PT_0_111 : STD_LOGIC; 
  signal EXP3_EXP_112 : STD_LOGIC; 
  signal cas0_OBUF_D2_PT_1_113 : STD_LOGIC; 
  signal cas0_OBUF_D2_PT_2_114 : STD_LOGIC; 
  signal cas0_OBUF_D2_PT_3_115 : STD_LOGIC; 
  signal cas0_OBUF_D2_PT_4_117 : STD_LOGIC; 
  signal cas0_OBUF_D2_PT_5_119 : STD_LOGIC; 
  signal cas0_OBUF_D2_PT_6_121 : STD_LOGIC; 
  signal cas1_OBUF_Q_122 : STD_LOGIC; 
  signal cas1_OBUF_D_123 : STD_LOGIC; 
  signal cas1_OBUF_tsimcreated_xor_Q_124 : STD_LOGIC; 
  signal cas1_OBUF_D1_125 : STD_LOGIC; 
  signal cas1_OBUF_D2_126 : STD_LOGIC; 
  signal refcnt_5_EXP_127 : STD_LOGIC; 
  signal cas1_OBUF_D2_PT_0_128 : STD_LOGIC; 
  signal cas1_OBUF_D2_PT_1_129 : STD_LOGIC; 
  signal cas1_OBUF_D2_PT_2_130 : STD_LOGIC; 
  signal cas1_OBUF_D2_PT_3_131 : STD_LOGIC; 
  signal cas1_OBUF_D2_PT_4_132 : STD_LOGIC; 
  signal cas1_OBUF_D2_PT_5_134 : STD_LOGIC; 
  signal cas2_OBUF_Q_135 : STD_LOGIC; 
  signal cas2_OBUF_D_136 : STD_LOGIC; 
  signal cas2_OBUF_tsimcreated_xor_Q_137 : STD_LOGIC; 
  signal cas2_OBUF_D1_138 : STD_LOGIC; 
  signal cas2_OBUF_D2_139 : STD_LOGIC; 
  signal refcnt_2_EXP_140 : STD_LOGIC; 
  signal cas2_OBUF_D2_PT_0_141 : STD_LOGIC; 
  signal refcnt_3_EXP_142 : STD_LOGIC; 
  signal cas2_OBUF_D2_PT_1_143 : STD_LOGIC; 
  signal cas2_OBUF_D2_PT_2_144 : STD_LOGIC; 
  signal cas2_OBUF_D2_PT_3_145 : STD_LOGIC; 
  signal cas2_OBUF_D2_PT_4_146 : STD_LOGIC; 
  signal cas2_OBUF_D2_PT_5_147 : STD_LOGIC; 
  signal cas2_OBUF_D2_PT_6_148 : STD_LOGIC; 
  signal cas3_OBUF_Q_149 : STD_LOGIC; 
  signal cas3_OBUF_D_150 : STD_LOGIC; 
  signal cas3_OBUF_tsimcreated_xor_Q_151 : STD_LOGIC; 
  signal cas3_OBUF_D1_152 : STD_LOGIC; 
  signal cas3_OBUF_D2_153 : STD_LOGIC; 
  signal refcnt_7_EXP_154 : STD_LOGIC; 
  signal cas3_OBUF_D2_PT_0_155 : STD_LOGIC; 
  signal cas3_OBUF_D2_PT_1_156 : STD_LOGIC; 
  signal cas3_OBUF_D2_PT_2_157 : STD_LOGIC; 
  signal cas3_OBUF_D2_PT_3_158 : STD_LOGIC; 
  signal cas3_OBUF_D2_PT_4_159 : STD_LOGIC; 
  signal cas3_OBUF_D2_PT_5_160 : STD_LOGIC; 
  signal io0_OBUF_Q_161 : STD_LOGIC; 
  signal io0_OBUF_D_162 : STD_LOGIC; 
  signal io0_OBUF_tsimcreated_xor_Q_163 : STD_LOGIC; 
  signal io0_OBUF_D1_164 : STD_LOGIC; 
  signal io0_OBUF_D2_165 : STD_LOGIC; 
  signal io0_OBUF_D2_PT_0_166 : STD_LOGIC; 
  signal io0_OBUF_D2_PT_1_167 : STD_LOGIC; 
  signal io1_OBUF_Q_168 : STD_LOGIC; 
  signal io1_OBUF_D_169 : STD_LOGIC; 
  signal io1_OBUF_tsimcreated_xor_Q_170 : STD_LOGIC; 
  signal io1_OBUF_D1_171 : STD_LOGIC; 
  signal io1_OBUF_D2_172 : STD_LOGIC; 
  signal io1_OBUF_D2_PT_0_173 : STD_LOGIC; 
  signal io1_OBUF_D2_PT_1_174 : STD_LOGIC; 
  signal io2_OBUF_Q_175 : STD_LOGIC; 
  signal io2_OBUF_D_176 : STD_LOGIC; 
  signal io2_OBUF_tsimcreated_xor_Q_177 : STD_LOGIC; 
  signal io2_OBUF_D1_178 : STD_LOGIC; 
  signal io2_OBUF_D2_179 : STD_LOGIC; 
  signal io2_OBUF_D2_PT_0_180 : STD_LOGIC; 
  signal io2_OBUF_D2_PT_1_181 : STD_LOGIC; 
  signal io3_OBUF_Q_182 : STD_LOGIC; 
  signal io3_OBUF_D_183 : STD_LOGIC; 
  signal io3_OBUF_tsimcreated_xor_Q_184 : STD_LOGIC; 
  signal io3_OBUF_D1_185 : STD_LOGIC; 
  signal io3_OBUF_D2_186 : STD_LOGIC; 
  signal io3_OBUF_D2_PT_0_187 : STD_LOGIC; 
  signal io3_OBUF_D2_PT_1_188 : STD_LOGIC; 
  signal io4_OBUF_Q_189 : STD_LOGIC; 
  signal io4_OBUF_D_190 : STD_LOGIC; 
  signal io4_OBUF_tsimcreated_xor_Q_191 : STD_LOGIC; 
  signal io4_OBUF_D1_192 : STD_LOGIC; 
  signal io4_OBUF_D2_193 : STD_LOGIC; 
  signal io4_OBUF_D2_PT_0_194 : STD_LOGIC; 
  signal io4_OBUF_D2_PT_1_195 : STD_LOGIC; 
  signal io5_OBUF_Q_196 : STD_LOGIC; 
  signal io5_OBUF_D_197 : STD_LOGIC; 
  signal io5_OBUF_tsimcreated_xor_Q_198 : STD_LOGIC; 
  signal io5_OBUF_D1_199 : STD_LOGIC; 
  signal io5_OBUF_D2_200 : STD_LOGIC; 
  signal io5_OBUF_D2_PT_0_201 : STD_LOGIC; 
  signal io5_OBUF_D2_PT_1_202 : STD_LOGIC; 
  signal io6_OBUF_Q_203 : STD_LOGIC; 
  signal io6_OBUF_D_204 : STD_LOGIC; 
  signal io6_OBUF_tsimcreated_xor_Q_205 : STD_LOGIC; 
  signal io6_OBUF_D1_206 : STD_LOGIC; 
  signal io6_OBUF_D2_207 : STD_LOGIC; 
  signal io6_OBUF_D2_PT_0_208 : STD_LOGIC; 
  signal io6_OBUF_D2_PT_1_209 : STD_LOGIC; 
  signal io7_OBUF_Q_210 : STD_LOGIC; 
  signal io7_OBUF_D_211 : STD_LOGIC; 
  signal io7_OBUF_tsimcreated_xor_Q_212 : STD_LOGIC; 
  signal io7_OBUF_D1_213 : STD_LOGIC; 
  signal io7_OBUF_D2_214 : STD_LOGIC; 
  signal io7_OBUF_D2_PT_0_215 : STD_LOGIC; 
  signal io7_OBUF_D2_PT_1_216 : STD_LOGIC; 
  signal phi0_OBUF_Q_217 : STD_LOGIC; 
  signal phi0_OBUF_D_218 : STD_LOGIC; 
  signal phi0_OBUF_D1_219 : STD_LOGIC; 
  signal phi0_OBUF_D2_220 : STD_LOGIC; 
  signal EXP0_EXP_221 : STD_LOGIC; 
  signal phi0_OBUF_D2_PT_0_222 : STD_LOGIC; 
  signal phi0_OBUF_D2_PT_1_223 : STD_LOGIC; 
  signal phi0_OBUF_D2_PT_2_224 : STD_LOGIC; 
  signal phi0_OBUF_D2_PT_3_225 : STD_LOGIC; 
  signal phi0_OBUF_D2_PT_4_226 : STD_LOGIC; 
  signal phi0_OBUF_D2_PT_5_227 : STD_LOGIC; 
  signal ras_OBUF_Q_228 : STD_LOGIC; 
  signal ras_OBUF_D_229 : STD_LOGIC; 
  signal ras_OBUF_D1_230 : STD_LOGIC; 
  signal ras_OBUF_D2_231 : STD_LOGIC; 
  signal EXP2_EXP_232 : STD_LOGIC; 
  signal ras_OBUF_D2_PT_0_233 : STD_LOGIC; 
  signal ras_OBUF_D2_PT_1_234 : STD_LOGIC; 
  signal ras_OBUF_D2_PT_2_235 : STD_LOGIC; 
  signal ras_OBUF_D2_PT_3_236 : STD_LOGIC; 
  signal ras_OBUF_D2_PT_4_241 : STD_LOGIC; 
  signal ras_OBUF_D2_PT_5_242 : STD_LOGIC; 
  signal iocnt_0_Q_243 : STD_LOGIC; 
  signal iocnt_0_D_244 : STD_LOGIC; 
  signal iocnt_0_tsimcreated_xor_Q_245 : STD_LOGIC; 
  signal iocnt_0_D1_246 : STD_LOGIC; 
  signal iocnt_0_D2_247 : STD_LOGIC; 
  signal iocnt_0_D2_PT_0_248 : STD_LOGIC; 
  signal iocnt_0_D2_PT_1_249 : STD_LOGIC; 
  signal iocnt_0_D2_PT_2_250 : STD_LOGIC; 
  signal iocnt_0_D2_PT_3_251 : STD_LOGIC; 
  signal iocnt_1_Q_252 : STD_LOGIC; 
  signal iocnt_1_D_253 : STD_LOGIC; 
  signal iocnt_1_tsimcreated_xor_Q_254 : STD_LOGIC; 
  signal iocnt_1_D1_255 : STD_LOGIC; 
  signal iocnt_1_D2_256 : STD_LOGIC; 
  signal iocnt_1_D2_PT_0_257 : STD_LOGIC; 
  signal iocnt_1_D2_PT_1_258 : STD_LOGIC; 
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
  signal counter_2_Q_277 : STD_LOGIC; 
  signal counter_2_D_278 : STD_LOGIC; 
  signal counter_2_D1_279 : STD_LOGIC; 
  signal counter_2_D2_280 : STD_LOGIC; 
  signal counter_2_D2_PT_0_281 : STD_LOGIC; 
  signal counter_2_D2_PT_1_282 : STD_LOGIC; 
  signal refcnt_0_Q_283 : STD_LOGIC; 
  signal refcnt_0_D_284 : STD_LOGIC; 
  signal refcnt_0_tsimcreated_xor_Q_285 : STD_LOGIC; 
  signal refcnt_0_D1_286 : STD_LOGIC; 
  signal refcnt_0_D2_287 : STD_LOGIC; 
  signal refcnt_1_Q_288 : STD_LOGIC; 
  signal refcnt_1_EXP_tsimrenamed_net_Q_289 : STD_LOGIC; 
  signal refcnt_1_D_290 : STD_LOGIC; 
  signal refcnt_1_tsimcreated_xor_Q_291 : STD_LOGIC; 
  signal refcnt_1_D1_292 : STD_LOGIC; 
  signal refcnt_1_D2_293 : STD_LOGIC; 
  signal refcnt_1_D2_PT_0_294 : STD_LOGIC; 
  signal refcnt_1_D2_PT_1_295 : STD_LOGIC; 
  signal refcnt_1_D2_PT_2_296 : STD_LOGIC; 
  signal refcnt_1_D2_PT_3_297 : STD_LOGIC; 
  signal refcnt_4_EXP_298 : STD_LOGIC; 
  signal refcnt_1_D2_PT_4_299 : STD_LOGIC; 
  signal refcnt_2_Q_300 : STD_LOGIC; 
  signal refcnt_2_EXP_tsimrenamed_net_Q_301 : STD_LOGIC; 
  signal refcnt_2_D_302 : STD_LOGIC; 
  signal refcnt_2_tsimcreated_xor_Q_303 : STD_LOGIC; 
  signal refcnt_2_D1_304 : STD_LOGIC; 
  signal refcnt_2_D2_305 : STD_LOGIC; 
  signal refcnt_2_EXP_PT_0_306 : STD_LOGIC; 
  signal refcnt_2_EXP_PT_1_307 : STD_LOGIC; 
  signal refcnt_3_Q_308 : STD_LOGIC; 
  signal refcnt_3_EXP_tsimrenamed_net_Q_309 : STD_LOGIC; 
  signal refcnt_3_D_310 : STD_LOGIC; 
  signal refcnt_3_tsimcreated_xor_Q_311 : STD_LOGIC; 
  signal refcnt_3_D1_312 : STD_LOGIC; 
  signal refcnt_3_D2_313 : STD_LOGIC; 
  signal refcnt_3_EXP_PT_0_314 : STD_LOGIC; 
  signal refcnt_3_EXP_PT_1_315 : STD_LOGIC; 
  signal refcnt_4_Q_316 : STD_LOGIC; 
  signal refcnt_4_EXP_tsimrenamed_net_Q_317 : STD_LOGIC; 
  signal refcnt_4_D_318 : STD_LOGIC; 
  signal refcnt_4_tsimcreated_xor_Q_319 : STD_LOGIC; 
  signal refcnt_4_D1_320 : STD_LOGIC; 
  signal refcnt_4_D2_321 : STD_LOGIC; 
  signal refcnt_4_D2_PT_0_322 : STD_LOGIC; 
  signal refcnt_4_D2_PT_1_323 : STD_LOGIC; 
  signal refcnt_4_D2_PT_2_324 : STD_LOGIC; 
  signal refcnt_4_D2_PT_3_325 : STD_LOGIC; 
  signal refcnt_5_Q_326 : STD_LOGIC; 
  signal refcnt_5_EXP_tsimrenamed_net_Q_327 : STD_LOGIC; 
  signal refcnt_5_D_328 : STD_LOGIC; 
  signal refcnt_5_tsimcreated_xor_Q_329 : STD_LOGIC; 
  signal refcnt_5_D1_330 : STD_LOGIC; 
  signal refcnt_5_D2_331 : STD_LOGIC; 
  signal refcnt_6_EXP_332 : STD_LOGIC; 
  signal refcnt_5_D2_PT_0_333 : STD_LOGIC; 
  signal refcnt_5_D2_PT_1_334 : STD_LOGIC; 
  signal refcnt_5_EXP_PT_0_335 : STD_LOGIC; 
  signal refcnt_5_EXP_PT_1_336 : STD_LOGIC; 
  signal refcnt_5_EXP_PT_2_337 : STD_LOGIC; 
  signal refcnt_5_EXP_PT_3_338 : STD_LOGIC; 
  signal refcnt_6_Q_339 : STD_LOGIC; 
  signal refcnt_6_EXP_tsimrenamed_net_Q_340 : STD_LOGIC; 
  signal refcnt_6_D_341 : STD_LOGIC; 
  signal refcnt_6_tsimcreated_xor_Q_342 : STD_LOGIC; 
  signal refcnt_6_D1_343 : STD_LOGIC; 
  signal refcnt_6_D2_344 : STD_LOGIC; 
  signal refcnt_6_D2_PT_0_345 : STD_LOGIC; 
  signal refcnt_6_D2_PT_1_346 : STD_LOGIC; 
  signal refcnt_6_EXP_PT_0_347 : STD_LOGIC; 
  signal refcnt_6_EXP_PT_1_348 : STD_LOGIC; 
  signal refcnt_7_Q_349 : STD_LOGIC; 
  signal refcnt_7_EXP_tsimrenamed_net_Q_350 : STD_LOGIC; 
  signal refcnt_7_D_351 : STD_LOGIC; 
  signal refcnt_7_tsimcreated_xor_Q_352 : STD_LOGIC; 
  signal refcnt_7_D1_353 : STD_LOGIC; 
  signal refcnt_7_D2_354 : STD_LOGIC; 
  signal refcnt_7_EXP_PT_0_355 : STD_LOGIC; 
  signal refcnt_7_EXP_PT_1_356 : STD_LOGIC; 
  signal refcnt_7_EXP_PT_2_357 : STD_LOGIC; 
  signal refcnt_7_EXP_PT_3_358 : STD_LOGIC; 
  signal EXP0_EXP_tsimrenamed_net_Q_359 : STD_LOGIC; 
  signal EXP0_EXP_PT_0_360 : STD_LOGIC; 
  signal EXP0_EXP_PT_1_361 : STD_LOGIC; 
  signal EXP1_EXP_tsimrenamed_net_Q_362 : STD_LOGIC; 
  signal EXP1_EXP_PT_0_363 : STD_LOGIC; 
  signal EXP1_EXP_PT_1_364 : STD_LOGIC; 
  signal EXP2_EXP_tsimrenamed_net_Q_365 : STD_LOGIC; 
  signal EXP3_EXP_tsimrenamed_net_Q_366 : STD_LOGIC; 
  signal EXP3_EXP_PT_0_367 : STD_LOGIC; 
  signal EXP3_EXP_PT_1_368 : STD_LOGIC; 
  signal EXP3_EXP_PT_2_369 : STD_LOGIC; 
  signal EXP3_EXP_PT_3_370 : STD_LOGIC; 
  signal EXP3_EXP_PT_4_371 : STD_LOGIC; 
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
  signal NlwBufferSignal_rom_OBUF_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_rom_OBUF_D2_IN1 : STD_LOGIC; 
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
  signal NlwBufferSignal_cas0_OBUF_D2_PT_3_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_4_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_4_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_4_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_4_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_4_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_4_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_4_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_4_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_4_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_4_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_4_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_4_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_4_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_4_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_4_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_4_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_5_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_5_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_5_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_5_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_5_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_5_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_5_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_5_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_5_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_5_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_5_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_5_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_5_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_5_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_5_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_5_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_6_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_6_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_6_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_6_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_6_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_6_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_6_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_6_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_6_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_6_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_6_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_6_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_6_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_6_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_6_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_PT_6_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_cas0_OBUF_D2_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_tsimcreated_xor_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_tsimcreated_xor_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_2_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_2_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_2_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_2_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_2_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_2_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_2_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_2_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_2_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_2_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_2_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_2_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_3_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_3_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_3_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_3_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_3_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_3_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_3_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_3_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_3_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_3_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_3_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_3_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_3_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_3_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_3_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_3_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_4_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_4_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_4_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_4_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_4_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_4_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_4_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_4_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_4_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_4_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_4_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_4_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_4_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_4_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_4_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_4_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_5_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_5_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_5_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_5_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_5_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_5_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_5_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_5_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_5_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_5_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_5_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_5_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_5_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_5_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_5_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_PT_5_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_cas1_OBUF_D2_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_tsimcreated_xor_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_tsimcreated_xor_IN1 : STD_LOGIC; 
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
  signal NlwBufferSignal_cas2_OBUF_D2_PT_2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_3_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_3_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_3_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_3_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_3_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_3_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_3_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_3_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_3_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_3_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_3_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_3_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_3_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_3_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_3_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_3_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_4_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_4_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_4_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_4_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_4_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_4_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_4_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_4_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_4_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_4_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_4_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_4_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_4_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_4_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_4_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_4_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_5_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_5_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_5_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_5_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_5_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_5_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_5_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_5_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_5_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_5_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_5_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_5_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_5_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_5_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_5_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_5_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_6_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_6_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_6_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_6_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_6_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_6_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_6_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_6_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_6_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_6_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_6_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_6_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_6_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_6_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_6_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_PT_6_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_cas2_OBUF_D2_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_tsimcreated_xor_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_tsimcreated_xor_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_2_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_2_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_2_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_2_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_2_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_2_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_2_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_2_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_2_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_2_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_2_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_2_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_3_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_3_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_3_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_3_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_3_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_3_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_3_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_3_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_3_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_3_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_3_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_3_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_3_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_3_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_3_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_3_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_4_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_4_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_4_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_4_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_4_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_4_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_4_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_4_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_4_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_4_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_4_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_4_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_4_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_4_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_4_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_4_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_5_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_5_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_5_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_5_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_5_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_5_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_5_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_5_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_5_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_5_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_5_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_5_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_5_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_5_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_5_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_PT_5_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_cas3_OBUF_D2_IN5 : STD_LOGIC; 
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
  signal NlwBufferSignal_phi0_OBUF_D2_PT_4_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_D2_PT_4_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_D2_PT_4_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_D2_PT_5_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_D2_PT_5_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_D2_PT_5_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_D2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_D2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_D2_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_phi0_OBUF_D2_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_3_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_3_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_3_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_4_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_4_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_4_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_4_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_4_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_4_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_4_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_4_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_4_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_4_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_4_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_4_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_4_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_4_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_4_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_4_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_5_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_5_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_5_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_5_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_5_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_5_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_5_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_5_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_5_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_5_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_5_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_5_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_5_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_5_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_5_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_PT_5_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_ras_OBUF_D2_IN5 : STD_LOGIC; 
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
  signal NlwBufferSignal_refcnt_1_D2_PT_4_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_D2_PT_4_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_D2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_D2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_D2_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN15 : STD_LOGIC; 
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
  signal NlwBufferSignal_refcnt_2_EXP_PT_0_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_0_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_0_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_0_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_0_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_0_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_0_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_0_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_0_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_0_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_0_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_0_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_0_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_0_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_1_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_1_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_1_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_1_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_1_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_1_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_1_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_1_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_1_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_1_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_1_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_1_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_PT_1_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_tsimrenamed_net_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_2_EXP_tsimrenamed_net_IN1 : STD_LOGIC; 
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
  signal NlwBufferSignal_refcnt_3_EXP_PT_0_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_0_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_0_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_0_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_0_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_0_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_0_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_0_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_0_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_0_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_0_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_0_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_0_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_0_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_1_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_1_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_1_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_1_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_1_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_1_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_1_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_1_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_1_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_1_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_1_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_1_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_PT_1_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_tsimrenamed_net_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_3_EXP_tsimrenamed_net_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_tsimcreated_xor_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_tsimcreated_xor_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_PT_0_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_PT_0_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_PT_0_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_PT_0_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_PT_0_IN7 : STD_LOGIC; 
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
  signal NlwBufferSignal_refcnt_4_D2_PT_3_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_PT_3_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_PT_3_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_PT_3_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_PT_3_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_PT_3_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_PT_3_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_PT_3_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_D2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_EXP_tsimrenamed_net_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_EXP_tsimrenamed_net_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_EXP_tsimrenamed_net_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_EXP_tsimrenamed_net_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_EXP_tsimrenamed_net_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_EXP_tsimrenamed_net_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_4_EXP_tsimrenamed_net_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_tsimcreated_xor_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_tsimcreated_xor_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_PT_0_IN1 : STD_LOGIC; 
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
  signal NlwBufferSignal_refcnt_5_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_0_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_0_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_0_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_0_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_0_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_0_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_0_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_0_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_0_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_0_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_0_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_0_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_0_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_0_IN15 : STD_LOGIC; 
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
  signal NlwBufferSignal_refcnt_5_EXP_PT_2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_2_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_2_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_2_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_2_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_2_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_2_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_2_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_2_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_2_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_2_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_2_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_2_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_3_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_3_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_3_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_3_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_3_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_3_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_3_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_3_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_3_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_3_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_3_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_3_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_3_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_3_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_3_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_PT_3_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_tsimrenamed_net_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_tsimrenamed_net_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_tsimrenamed_net_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_5_EXP_tsimrenamed_net_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_tsimcreated_xor_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_tsimcreated_xor_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_REG_IN : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_REG_CLK : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_PT_0_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_PT_0_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_PT_0_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_PT_0_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_PT_0_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_PT_0_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_PT_0_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_PT_0_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_PT_0_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_PT_0_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_PT_0_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_PT_0_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_PT_0_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_PT_1_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_PT_1_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_PT_1_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_PT_1_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_PT_1_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_PT_1_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_PT_1_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_PT_1_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_PT_1_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_PT_1_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_PT_1_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_D2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_EXP_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_EXP_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_EXP_PT_0_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_EXP_PT_0_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_EXP_PT_0_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_EXP_PT_0_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_EXP_PT_0_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_EXP_PT_0_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_EXP_PT_0_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_EXP_PT_0_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_EXP_PT_0_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_EXP_PT_0_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_EXP_PT_0_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_EXP_PT_0_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_EXP_PT_0_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_EXP_PT_0_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_EXP_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_EXP_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_EXP_PT_1_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_EXP_PT_1_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_EXP_PT_1_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_EXP_PT_1_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_EXP_PT_1_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_EXP_PT_1_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_EXP_PT_1_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_EXP_PT_1_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_EXP_PT_1_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_EXP_PT_1_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_EXP_PT_1_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_EXP_PT_1_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_EXP_PT_1_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_EXP_tsimrenamed_net_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_6_EXP_tsimrenamed_net_IN1 : STD_LOGIC; 
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
  signal NlwBufferSignal_refcnt_7_EXP_PT_0_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_0_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_0_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_0_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_0_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_0_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_0_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_0_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_0_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_0_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_0_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_0_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_0_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_1_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_1_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_1_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_1_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_1_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_1_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_1_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_1_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_1_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_1_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_1_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_1_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_1_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_2_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_2_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_2_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_2_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_2_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_2_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_2_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_2_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_2_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_2_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_2_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_refcnt_7_EXP_PT_2_IN15 : STD_LOGIC; 
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
  signal NlwBufferSignal_EXP0_EXP_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_0_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_1_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_1_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_1_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_1_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_1_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_1_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_1_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_1_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_1_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_1_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_1_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_1_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_PT_1_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_tsimrenamed_net_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP0_EXP_tsimrenamed_net_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_PT_0_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_PT_1_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_PT_1_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_PT_1_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_PT_1_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_PT_1_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_PT_1_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_PT_1_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_PT_1_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_PT_1_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_PT_1_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_PT_1_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_PT_1_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_PT_1_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_tsimrenamed_net_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP1_EXP_tsimrenamed_net_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_0_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_0_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_0_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_0_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_0_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_0_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_0_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_0_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_0_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_0_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_0_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_0_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_0_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_0_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_0_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_0_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_1_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_1_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_1_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_1_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_1_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_1_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_1_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_1_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_1_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_1_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_1_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_1_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_1_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_1_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_1_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_2_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_2_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_2_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_2_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_2_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_2_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_2_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_2_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_2_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_2_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_2_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_2_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_2_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_2_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_2_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_2_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_3_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_3_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_3_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_3_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_3_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_3_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_3_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_3_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_3_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_3_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_3_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_3_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_3_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_3_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_3_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_3_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_4_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_4_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_4_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_4_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_4_IN4 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_4_IN5 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_4_IN6 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_4_IN7 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_4_IN8 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_4_IN9 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_4_IN10 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_4_IN11 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_4_IN12 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_4_IN13 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_4_IN14 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_PT_4_IN15 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_tsimrenamed_net_IN0 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_tsimrenamed_net_IN1 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_tsimrenamed_net_IN2 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_tsimrenamed_net_IN3 : STD_LOGIC; 
  signal NlwBufferSignal_EXP3_EXP_tsimrenamed_net_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_rom_OBUF_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_rom_OBUF_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_rom_OBUF_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_rom_OBUF_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_rom_OBUF_D2_PT_1_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_rom_OBUF_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_rom_OBUF_D2_PT_1_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_rom_OBUF_D2_PT_1_IN9 : STD_LOGIC; 
  signal NlwInverterSignal_rom_OBUF_D2_PT_1_IN10 : STD_LOGIC; 
  signal NlwInverterSignal_rom_OBUF_D2_PT_1_IN11 : STD_LOGIC; 
  signal NlwInverterSignal_rom_OBUF_D2_PT_1_IN13 : STD_LOGIC; 
  signal NlwInverterSignal_rom_OBUF_D2_PT_1_IN14 : STD_LOGIC; 
  signal NlwInverterSignal_phi1_OBUF_D_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_phi1_OBUF_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_phi1_OBUF_D2_PT_2_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_phi1_OBUF_D2_PT_2_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_phi1_OBUF_D2_PT_3_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_phi1_OBUF_D2_PT_4_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_phi1_OBUF_D2_PT_4_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_phi1_OBUF_D2_PT_5_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_phi1_OBUF_D2_PT_5_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_cas0_OBUF_D_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_cas0_OBUF_D2_PT_2_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_cas0_OBUF_D2_PT_3_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_cas0_OBUF_D2_PT_3_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_cas0_OBUF_D2_PT_4_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_cas0_OBUF_D2_PT_4_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_cas0_OBUF_D2_PT_4_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_cas0_OBUF_D2_PT_4_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_cas0_OBUF_D2_PT_4_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_cas0_OBUF_D2_PT_4_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_cas0_OBUF_D2_PT_4_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_cas0_OBUF_D2_PT_5_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_cas0_OBUF_D2_PT_5_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_cas0_OBUF_D2_PT_5_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_cas0_OBUF_D2_PT_5_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_cas0_OBUF_D2_PT_5_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_cas0_OBUF_D2_PT_5_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_cas0_OBUF_D2_PT_5_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_cas0_OBUF_D2_PT_6_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_cas0_OBUF_D2_PT_6_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_cas0_OBUF_D2_PT_6_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_cas0_OBUF_D2_PT_6_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_cas0_OBUF_D2_PT_6_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_cas0_OBUF_D2_PT_6_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_cas0_OBUF_D2_PT_6_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_D2_PT_2_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_D2_PT_2_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_D2_PT_2_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_D2_PT_2_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_D2_PT_2_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_D2_PT_2_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_D2_PT_3_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_D2_PT_3_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_D2_PT_3_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_D2_PT_3_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_D2_PT_3_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_D2_PT_3_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_D2_PT_4_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_D2_PT_4_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_D2_PT_4_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_D2_PT_4_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_D2_PT_4_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_D2_PT_4_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_D2_PT_5_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_D2_PT_5_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_D2_PT_5_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_D2_PT_5_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_D2_PT_5_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_cas1_OBUF_D2_PT_5_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_cas2_OBUF_D2_PT_2_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_cas2_OBUF_D2_PT_2_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_cas2_OBUF_D2_PT_3_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_cas2_OBUF_D2_PT_3_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_cas2_OBUF_D2_PT_3_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_cas2_OBUF_D2_PT_3_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_cas2_OBUF_D2_PT_3_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_cas2_OBUF_D2_PT_3_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_cas2_OBUF_D2_PT_4_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_cas2_OBUF_D2_PT_4_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_cas2_OBUF_D2_PT_4_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_cas2_OBUF_D2_PT_4_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_cas2_OBUF_D2_PT_4_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_cas2_OBUF_D2_PT_4_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_cas2_OBUF_D2_PT_5_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_cas2_OBUF_D2_PT_5_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_cas2_OBUF_D2_PT_5_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_cas2_OBUF_D2_PT_5_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_cas2_OBUF_D2_PT_5_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_cas2_OBUF_D2_PT_5_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_cas2_OBUF_D2_PT_6_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_cas2_OBUF_D2_PT_6_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_cas2_OBUF_D2_PT_6_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_cas2_OBUF_D2_PT_6_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_cas2_OBUF_D2_PT_6_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_cas2_OBUF_D2_PT_6_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_cas3_OBUF_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_cas3_OBUF_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_cas3_OBUF_D2_PT_2_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_cas3_OBUF_D2_PT_2_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_cas3_OBUF_D2_PT_2_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_cas3_OBUF_D2_PT_2_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_cas3_OBUF_D2_PT_2_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_cas3_OBUF_D2_PT_3_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_cas3_OBUF_D2_PT_3_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_cas3_OBUF_D2_PT_3_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_cas3_OBUF_D2_PT_3_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_cas3_OBUF_D2_PT_3_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_cas3_OBUF_D2_PT_4_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_cas3_OBUF_D2_PT_4_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_cas3_OBUF_D2_PT_4_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_cas3_OBUF_D2_PT_4_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_cas3_OBUF_D2_PT_4_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_cas3_OBUF_D2_PT_5_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_cas3_OBUF_D2_PT_5_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_cas3_OBUF_D2_PT_5_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_cas3_OBUF_D2_PT_5_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_cas3_OBUF_D2_PT_5_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_io0_OBUF_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_io0_OBUF_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_io0_OBUF_D2_PT_0_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_io0_OBUF_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_io0_OBUF_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_io0_OBUF_D2_PT_1_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_io0_OBUF_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_io0_OBUF_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_io0_OBUF_D2_PT_1_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_io1_OBUF_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_io1_OBUF_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_io1_OBUF_D2_PT_0_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_io1_OBUF_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_io1_OBUF_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_io1_OBUF_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_io1_OBUF_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_io1_OBUF_D2_PT_1_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_io2_OBUF_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_io2_OBUF_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_io2_OBUF_D2_PT_0_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_io2_OBUF_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_io2_OBUF_D2_PT_1_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_io2_OBUF_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_io2_OBUF_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_io2_OBUF_D2_PT_1_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_io3_OBUF_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_io3_OBUF_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_io3_OBUF_D2_PT_0_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_io3_OBUF_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_io3_OBUF_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_io3_OBUF_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_io3_OBUF_D2_PT_1_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_io4_OBUF_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_io4_OBUF_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_io4_OBUF_D2_PT_0_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_io4_OBUF_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_io4_OBUF_D2_PT_1_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_io4_OBUF_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_io4_OBUF_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_io4_OBUF_D2_PT_1_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_io5_OBUF_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_io5_OBUF_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_io5_OBUF_D2_PT_0_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_io5_OBUF_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_io5_OBUF_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_io5_OBUF_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_io5_OBUF_D2_PT_1_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_io6_OBUF_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_io6_OBUF_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_io6_OBUF_D2_PT_0_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_io6_OBUF_D2_PT_1_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_io6_OBUF_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_io6_OBUF_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_io6_OBUF_D2_PT_1_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_io7_OBUF_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_io7_OBUF_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_io7_OBUF_D2_PT_0_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_io7_OBUF_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_io7_OBUF_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_io7_OBUF_D2_PT_1_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_phi0_OBUF_D2_PT_2_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_phi0_OBUF_D2_PT_4_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_phi0_OBUF_D2_PT_4_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_phi0_OBUF_D2_PT_5_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_ras_OBUF_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_ras_OBUF_D2_PT_3_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_ras_OBUF_D2_PT_4_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_ras_OBUF_D2_PT_4_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_ras_OBUF_D2_PT_4_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_ras_OBUF_D2_PT_4_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_ras_OBUF_D2_PT_4_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_ras_OBUF_D2_PT_4_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_ras_OBUF_D2_PT_4_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_ras_OBUF_D2_PT_4_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_0_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_0_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_0_D2_PT_2_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_0_D2_PT_3_IN12 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_0_D2_PT_3_IN13 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_0_D2_PT_3_IN14 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_0_D2_PT_3_IN15 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_0_D2_PT_3_IN16 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_1_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_1_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_1_D2_PT_1_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_2_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_iocnt_2_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_counter_0_D_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_counter_0_D2_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_counter_1_D2_PT_0_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_counter_1_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_counter_1_D2_PT_1_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_counter_2_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_counter_2_D2_PT_1_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_0_D2_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_D_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_D2_PT_1_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_D2_PT_2_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_D2_PT_2_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_EXP_tsimrenamed_net_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_EXP_tsimrenamed_net_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_EXP_tsimrenamed_net_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_EXP_tsimrenamed_net_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_EXP_tsimrenamed_net_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_EXP_tsimrenamed_net_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_EXP_tsimrenamed_net_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_EXP_tsimrenamed_net_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_EXP_tsimrenamed_net_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_EXP_tsimrenamed_net_IN9 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_1_EXP_tsimrenamed_net_IN10 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_2_D2_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_2_D2_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_2_D2_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_2_EXP_PT_0_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_2_EXP_PT_0_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_2_EXP_PT_0_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_2_EXP_PT_0_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_2_EXP_PT_0_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_2_EXP_PT_0_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_2_EXP_PT_1_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_2_EXP_PT_1_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_2_EXP_PT_1_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_2_EXP_PT_1_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_2_EXP_PT_1_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_2_EXP_PT_1_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_3_D2_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_3_D2_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_3_D2_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_3_D2_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_3_EXP_PT_0_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_3_EXP_PT_0_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_3_EXP_PT_0_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_3_EXP_PT_0_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_3_EXP_PT_0_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_3_EXP_PT_0_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_3_EXP_PT_1_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_3_EXP_PT_1_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_3_EXP_PT_1_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_3_EXP_PT_1_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_3_EXP_PT_1_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_3_EXP_PT_1_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_D2_PT_0_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_D2_PT_0_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_D2_PT_0_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_D2_PT_1_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_D2_PT_1_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_D2_PT_2_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_D2_PT_2_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_D2_PT_2_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_D2_PT_2_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_D2_PT_2_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_D2_PT_3_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_D2_PT_3_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_D2_PT_3_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_D2_PT_3_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_D2_PT_3_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_EXP_tsimrenamed_net_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_EXP_tsimrenamed_net_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_EXP_tsimrenamed_net_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_EXP_tsimrenamed_net_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_EXP_tsimrenamed_net_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_EXP_tsimrenamed_net_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_4_EXP_tsimrenamed_net_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_D2_PT_1_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_D2_PT_1_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_D2_PT_1_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_EXP_PT_0_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_EXP_PT_0_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_EXP_PT_0_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_EXP_PT_0_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_EXP_PT_0_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_EXP_PT_0_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_EXP_PT_1_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_EXP_PT_1_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_EXP_PT_1_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_EXP_PT_1_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_EXP_PT_1_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_EXP_PT_2_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_EXP_PT_2_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_EXP_PT_2_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_EXP_PT_2_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_EXP_PT_2_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_EXP_PT_2_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_EXP_PT_3_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_EXP_PT_3_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_EXP_PT_3_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_EXP_PT_3_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_EXP_PT_3_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_5_EXP_PT_3_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_6_D2_PT_0_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_6_D2_PT_0_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_6_D2_PT_0_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_6_D2_PT_0_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_6_D2_PT_0_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_6_D2_PT_0_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_6_D2_PT_0_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_6_D2_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_6_D2_PT_1_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_6_D2_PT_1_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_6_D2_PT_1_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_6_D2_PT_1_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_6_D2_PT_1_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_6_D2_PT_1_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_6_EXP_PT_0_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_6_EXP_PT_0_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_6_EXP_PT_0_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_6_EXP_PT_0_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_6_EXP_PT_0_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_6_EXP_PT_0_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_6_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_6_EXP_PT_1_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_6_EXP_PT_1_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_6_EXP_PT_1_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_6_EXP_PT_1_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_6_EXP_PT_1_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_D2_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_D2_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_D2_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_D2_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_D2_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_D2_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_D2_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_D2_IN9 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_0_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_0_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_0_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_0_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_0_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_1_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_1_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_1_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_1_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_1_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_2_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_2_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_2_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_2_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_2_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_3_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_3_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_3_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_3_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_refcnt_7_EXP_PT_3_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_EXP0_EXP_PT_0_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_EXP0_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_EXP0_EXP_PT_1_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_EXP0_EXP_PT_1_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_EXP0_EXP_PT_1_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_EXP0_EXP_PT_1_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_EXP0_EXP_PT_1_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_EXP0_EXP_PT_1_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_EXP0_EXP_PT_1_IN9 : STD_LOGIC; 
  signal NlwInverterSignal_EXP0_EXP_PT_1_IN10 : STD_LOGIC; 
  signal NlwInverterSignal_EXP0_EXP_PT_1_IN11 : STD_LOGIC; 
  signal NlwInverterSignal_EXP0_EXP_PT_1_IN12 : STD_LOGIC; 
  signal NlwInverterSignal_EXP0_EXP_PT_1_IN13 : STD_LOGIC; 
  signal NlwInverterSignal_EXP1_EXP_PT_0_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_EXP1_EXP_PT_0_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_EXP1_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_EXP1_EXP_PT_1_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_EXP1_EXP_PT_1_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_EXP1_EXP_PT_1_IN5 : STD_LOGIC; 
  signal NlwInverterSignal_EXP1_EXP_PT_1_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_EXP1_EXP_PT_1_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_EXP1_EXP_PT_1_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_EXP1_EXP_PT_1_IN9 : STD_LOGIC; 
  signal NlwInverterSignal_EXP1_EXP_PT_1_IN10 : STD_LOGIC; 
  signal NlwInverterSignal_EXP1_EXP_PT_1_IN11 : STD_LOGIC; 
  signal NlwInverterSignal_EXP1_EXP_PT_1_IN12 : STD_LOGIC; 
  signal NlwInverterSignal_EXP1_EXP_PT_1_IN13 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_tsimrenamed_net_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_tsimrenamed_net_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_tsimrenamed_net_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_tsimrenamed_net_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_tsimrenamed_net_IN4 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_tsimrenamed_net_IN9 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_tsimrenamed_net_IN10 : STD_LOGIC; 
  signal NlwInverterSignal_EXP2_EXP_tsimrenamed_net_IN11 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_0_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_0_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_0_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_0_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_0_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_0_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_0_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_1_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_1_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_1_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_1_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_1_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_1_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_1_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_2_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_2_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_2_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_2_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_2_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_2_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_2_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_3_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_3_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_3_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_3_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_3_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_3_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_3_IN8 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_4_IN0 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_4_IN1 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_4_IN2 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_4_IN3 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_4_IN6 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_4_IN7 : STD_LOGIC; 
  signal NlwInverterSignal_EXP3_EXP_PT_4_IN8 : STD_LOGIC; 
  signal counter : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal iocnt : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal refcnt : STD_LOGIC_VECTOR ( 7 downto 0 ); 
begin
  bank_4_IBUF : X_BUF
    port map (
      I => bank(4),
      O => bank_4_IBUF_1
    );
  bank_3_IBUF : X_BUF
    port map (
      I => bank(3),
      O => bank_3_IBUF_3
    );
  bank_2_IBUF : X_BUF
    port map (
      I => bank(2),
      O => bank_2_IBUF_5
    );
  bank_1_IBUF : X_BUF
    port map (
      I => bank(1),
      O => bank_1_IBUF_7
    );
  bank_0_IBUF : X_BUF
    port map (
      I => bank(0),
      O => bank_0_IBUF_9
    );
  a15_13_2_IBUF : X_BUF
    port map (
      I => a15_13(2),
      O => a15_13_2_IBUF_11
    );
  a15_13_1_IBUF : X_BUF
    port map (
      I => a15_13(1),
      O => a15_13_1_IBUF_13
    );
  a15_13_0_IBUF : X_BUF
    port map (
      I => a15_13(0),
      O => a15_13_0_IBUF_15
    );
  rw_IBUF : X_BUF
    port map (
      I => rw,
      O => rw_IBUF_17
    );
  bank_6_IBUF : X_BUF
    port map (
      I => bank(6),
      O => bank_6_IBUF_19
    );
  bank_5_IBUF : X_BUF
    port map (
      I => bank(5),
      O => bank_5_IBUF_21
    );
  bank_7_IBUF : X_BUF
    port map (
      I => bank(7),
      O => bank_7_IBUF_23
    );
  a12_11_1_IBUF : X_BUF
    port map (
      I => a12_11(1),
      O => a12_11_1_IBUF_25
    );
  a12_11_0_IBUF : X_BUF
    port map (
      I => a12_11(0),
      O => a12_11_0_IBUF_27
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
  rom_PIN_BUF_Q : X_BUF
    port map (
      I => rom,
      O => rom_PIN_BUF_Q_33
    );
  phi1_PIN_BUF_Q : X_BUF
    port map (
      I => phi1,
      O => phi1_PIN_BUF_Q_35
    );
  cas0_PIN_BUF_Q : X_BUF
    port map (
      I => cas0,
      O => cas0_PIN_BUF_Q_37
    );
  cas1_PIN_BUF_Q : X_BUF
    port map (
      I => cas1,
      O => cas1_PIN_BUF_Q_39
    );
  cas2_PIN_BUF_Q : X_BUF
    port map (
      I => cas2,
      O => cas2_PIN_BUF_Q_41
    );
  cas3_PIN_BUF_Q : X_BUF
    port map (
      I => cas3,
      O => cas3_PIN_BUF_Q_43
    );
  io0_PIN_BUF_Q : X_BUF
    port map (
      I => io0,
      O => io0_PIN_BUF_Q_45
    );
  io1_PIN_BUF_Q : X_BUF
    port map (
      I => io1,
      O => io1_PIN_BUF_Q_47
    );
  io2_PIN_BUF_Q : X_BUF
    port map (
      I => io2,
      O => io2_PIN_BUF_Q_49
    );
  io3_PIN_BUF_Q : X_BUF
    port map (
      I => io3,
      O => io3_PIN_BUF_Q_51
    );
  io4_PIN_BUF_Q : X_BUF
    port map (
      I => io4,
      O => io4_PIN_BUF_Q_53
    );
  io5_PIN_BUF_Q : X_BUF
    port map (
      I => io5,
      O => io5_PIN_BUF_Q_55
    );
  io6_PIN_BUF_Q : X_BUF
    port map (
      I => io6,
      O => io6_PIN_BUF_Q_57
    );
  io7_PIN_BUF_Q : X_BUF
    port map (
      I => io7,
      O => io7_PIN_BUF_Q_59
    );
  phi0_PIN_BUF_Q : X_BUF
    port map (
      I => phi0,
      O => phi0_PIN_BUF_Q_61
    );
  ras_PIN_BUF_Q : X_BUF
    port map (
      I => ras,
      O => ras_PIN_BUF_Q_63
    );
  rom_50 : X_BUF
    port map (
      I => rom_OBUF_Q_64,
      O => rom
    );
  phi1_52 : X_BUF
    port map (
      I => phi1_OBUF_Q_65,
      O => phi1
    );
  cas0_54 : X_BUF
    port map (
      I => cas0_OBUF_Q_66,
      O => cas0
    );
  cas1_56 : X_BUF
    port map (
      I => cas1_OBUF_Q_67,
      O => cas1
    );
  cas2_58 : X_BUF
    port map (
      I => cas2_OBUF_Q_68,
      O => cas2
    );
  cas3_60 : X_BUF
    port map (
      I => cas3_OBUF_Q_69,
      O => cas3
    );
  io0_62 : X_BUF
    port map (
      I => io0_OBUF_Q_70,
      O => io0
    );
  io1_64 : X_BUF
    port map (
      I => io1_OBUF_Q_71,
      O => io1
    );
  io2_66 : X_BUF
    port map (
      I => io2_OBUF_Q_72,
      O => io2
    );
  io3_68 : X_BUF
    port map (
      I => io3_OBUF_Q_73,
      O => io3
    );
  io4_70 : X_BUF
    port map (
      I => io4_OBUF_Q_74,
      O => io4
    );
  io5_72 : X_BUF
    port map (
      I => io5_OBUF_Q_75,
      O => io5
    );
  io6_74 : X_BUF
    port map (
      I => io6_OBUF_Q_76,
      O => io6
    );
  io7_76 : X_BUF
    port map (
      I => io7_OBUF_Q_77,
      O => io7
    );
  phi0_78 : X_BUF
    port map (
      I => phi0_OBUF_Q_78,
      O => phi0
    );
  ras_80 : X_BUF
    port map (
      I => ras_OBUF_Q_79,
      O => ras
    );
  rom_OBUF_Q : X_BUF
    port map (
      I => rom_OBUF_Q_80,
      O => rom_OBUF_Q_64
    );
  rom_OBUF_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_rom_OBUF_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_rom_OBUF_tsimcreated_xor_IN1,
      O => rom_OBUF_tsimcreated_xor_Q_82
    );
  rom_OBUF_REG : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NlwBufferSignal_rom_OBUF_REG_IN,
      CE => Vcc_84,
      CLK => NlwBufferSignal_rom_OBUF_REG_CLK,
      SET => Gnd_83,
      RST => Gnd_83,
      O => rom_OBUF_Q_80
    );
  Gnd : X_ZERO
    port map (
      O => Gnd_83
    );
  Vcc : X_ONE
    port map (
      O => Vcc_84
    );
  rom_OBUF_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_rom_OBUF_D_IN0,
      I1 => NlwBufferSignal_rom_OBUF_D_IN1,
      O => rom_OBUF_D_81
    );
  rom_OBUF_D1 : X_ZERO
    port map (
      O => rom_OBUF_D1_85
    );
  rom_OBUF_D2_PT_0 : X_AND4
    port map (
      I0 => NlwInverterSignal_rom_OBUF_D2_PT_0_IN0,
      I1 => NlwBufferSignal_rom_OBUF_D2_PT_0_IN1,
      I2 => NlwBufferSignal_rom_OBUF_D2_PT_0_IN2,
      I3 => NlwInverterSignal_rom_OBUF_D2_PT_0_IN3,
      O => rom_OBUF_D2_PT_0_90
    );
  rom_OBUF_D2_PT_1 : X_AND16
    port map (
      I0 => NlwInverterSignal_rom_OBUF_D2_PT_1_IN0,
      I1 => NlwInverterSignal_rom_OBUF_D2_PT_1_IN1,
      I2 => NlwInverterSignal_rom_OBUF_D2_PT_1_IN2,
      I3 => NlwInverterSignal_rom_OBUF_D2_PT_1_IN3,
      I4 => NlwInverterSignal_rom_OBUF_D2_PT_1_IN4,
      I5 => NlwBufferSignal_rom_OBUF_D2_PT_1_IN5,
      I6 => NlwBufferSignal_rom_OBUF_D2_PT_1_IN6,
      I7 => NlwBufferSignal_rom_OBUF_D2_PT_1_IN7,
      I8 => NlwBufferSignal_rom_OBUF_D2_PT_1_IN8,
      I9 => NlwInverterSignal_rom_OBUF_D2_PT_1_IN9,
      I10 => NlwInverterSignal_rom_OBUF_D2_PT_1_IN10,
      I11 => NlwInverterSignal_rom_OBUF_D2_PT_1_IN11,
      I12 => NlwBufferSignal_rom_OBUF_D2_PT_1_IN12,
      I13 => NlwInverterSignal_rom_OBUF_D2_PT_1_IN13,
      I14 => NlwInverterSignal_rom_OBUF_D2_PT_1_IN14,
      I15 => NlwBufferSignal_rom_OBUF_D2_PT_1_IN15,
      O => rom_OBUF_D2_PT_1_91
    );
  rom_OBUF_D2 : X_OR2
    port map (
      I0 => NlwBufferSignal_rom_OBUF_D2_IN0,
      I1 => NlwBufferSignal_rom_OBUF_D2_IN1,
      O => rom_OBUF_D2_86
    );
  phi1_OBUF_Q : X_BUF
    port map (
      I => phi1_OBUF_Q_92,
      O => phi1_OBUF_Q_65
    );
  phi1_OBUF_REG : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => NlwBufferSignal_phi1_OBUF_REG_IN,
      CE => Vcc_84,
      CLK => NlwBufferSignal_phi1_OBUF_REG_CLK,
      SET => Gnd_83,
      RST => Gnd_83,
      O => phi1_OBUF_Q_92
    );
  phi1_OBUF_D : X_XOR2
    port map (
      I0 => NlwInverterSignal_phi1_OBUF_D_IN0,
      I1 => NlwBufferSignal_phi1_OBUF_D_IN1,
      O => phi1_OBUF_D_93
    );
  phi1_OBUF_D1 : X_ZERO
    port map (
      O => phi1_OBUF_D1_94
    );
  phi1_OBUF_D2_PT_0 : X_AND2
    port map (
      I0 => NlwBufferSignal_phi1_OBUF_D2_PT_0_IN0,
      I1 => NlwBufferSignal_phi1_OBUF_D2_PT_0_IN1,
      O => phi1_OBUF_D2_PT_0_97
    );
  phi1_OBUF_D2_PT_1 : X_AND2
    port map (
      I0 => NlwBufferSignal_phi1_OBUF_D2_PT_1_IN0,
      I1 => NlwInverterSignal_phi1_OBUF_D2_PT_1_IN1,
      O => phi1_OBUF_D2_PT_1_98
    );
  phi1_OBUF_D2_PT_2 : X_AND2
    port map (
      I0 => NlwInverterSignal_phi1_OBUF_D2_PT_2_IN0,
      I1 => NlwInverterSignal_phi1_OBUF_D2_PT_2_IN1,
      O => phi1_OBUF_D2_PT_2_99
    );
  phi1_OBUF_D2_PT_3 : X_AND2
    port map (
      I0 => NlwBufferSignal_phi1_OBUF_D2_PT_3_IN0,
      I1 => NlwInverterSignal_phi1_OBUF_D2_PT_3_IN1,
      O => phi1_OBUF_D2_PT_3_101
    );
  phi1_OBUF_D2_PT_4 : X_AND3
    port map (
      I0 => NlwInverterSignal_phi1_OBUF_D2_PT_4_IN0,
      I1 => NlwBufferSignal_phi1_OBUF_D2_PT_4_IN1,
      I2 => NlwInverterSignal_phi1_OBUF_D2_PT_4_IN2,
      O => phi1_OBUF_D2_PT_4_102
    );
  phi1_OBUF_D2_PT_5 : X_AND3
    port map (
      I0 => NlwInverterSignal_phi1_OBUF_D2_PT_5_IN0,
      I1 => NlwBufferSignal_phi1_OBUF_D2_PT_5_IN1,
      I2 => NlwInverterSignal_phi1_OBUF_D2_PT_5_IN2,
      O => phi1_OBUF_D2_PT_5_105
    );
  phi1_OBUF_D2 : X_OR6
    port map (
      I0 => NlwBufferSignal_phi1_OBUF_D2_IN0,
      I1 => NlwBufferSignal_phi1_OBUF_D2_IN1,
      I2 => NlwBufferSignal_phi1_OBUF_D2_IN2,
      I3 => NlwBufferSignal_phi1_OBUF_D2_IN3,
      I4 => NlwBufferSignal_phi1_OBUF_D2_IN4,
      I5 => NlwBufferSignal_phi1_OBUF_D2_IN5,
      O => phi1_OBUF_D2_95
    );
  cas0_OBUF_Q : X_BUF
    port map (
      I => cas0_OBUF_Q_106,
      O => cas0_OBUF_Q_66
    );
  cas0_OBUF_REG : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NlwBufferSignal_cas0_OBUF_REG_IN,
      CE => Vcc_84,
      CLK => NlwBufferSignal_cas0_OBUF_REG_CLK,
      SET => Gnd_83,
      RST => Gnd_83,
      O => cas0_OBUF_Q_106
    );
  cas0_OBUF_D : X_XOR2
    port map (
      I0 => NlwInverterSignal_cas0_OBUF_D_IN0,
      I1 => NlwBufferSignal_cas0_OBUF_D_IN1,
      O => cas0_OBUF_D_107
    );
  cas0_OBUF_D1 : X_ZERO
    port map (
      O => cas0_OBUF_D1_108
    );
  cas0_OBUF_D2_PT_0 : X_AND2
    port map (
      I0 => NlwBufferSignal_cas0_OBUF_D2_PT_0_IN0,
      I1 => NlwBufferSignal_cas0_OBUF_D2_PT_0_IN1,
      O => cas0_OBUF_D2_PT_0_111
    );
  cas0_OBUF_D2_PT_1 : X_AND2
    port map (
      I0 => NlwBufferSignal_cas0_OBUF_D2_PT_1_IN0,
      I1 => NlwBufferSignal_cas0_OBUF_D2_PT_1_IN1,
      O => cas0_OBUF_D2_PT_1_113
    );
  cas0_OBUF_D2_PT_2 : X_AND2
    port map (
      I0 => NlwBufferSignal_cas0_OBUF_D2_PT_2_IN0,
      I1 => NlwInverterSignal_cas0_OBUF_D2_PT_2_IN1,
      O => cas0_OBUF_D2_PT_2_114
    );
  cas0_OBUF_D2_PT_3 : X_AND3
    port map (
      I0 => NlwInverterSignal_cas0_OBUF_D2_PT_3_IN0,
      I1 => NlwBufferSignal_cas0_OBUF_D2_PT_3_IN1,
      I2 => NlwInverterSignal_cas0_OBUF_D2_PT_3_IN2,
      O => cas0_OBUF_D2_PT_3_115
    );
  cas0_OBUF_D2_PT_4 : X_AND16
    port map (
      I0 => NlwInverterSignal_cas0_OBUF_D2_PT_4_IN0,
      I1 => NlwInverterSignal_cas0_OBUF_D2_PT_4_IN1,
      I2 => NlwInverterSignal_cas0_OBUF_D2_PT_4_IN2,
      I3 => NlwInverterSignal_cas0_OBUF_D2_PT_4_IN3,
      I4 => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN4,
      I5 => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN5,
      I6 => NlwInverterSignal_cas0_OBUF_D2_PT_4_IN6,
      I7 => NlwInverterSignal_cas0_OBUF_D2_PT_4_IN7,
      I8 => NlwInverterSignal_cas0_OBUF_D2_PT_4_IN8,
      I9 => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN9,
      I10 => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN10,
      I11 => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN11,
      I12 => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN12,
      I13 => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN13,
      I14 => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN14,
      I15 => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN15,
      O => cas0_OBUF_D2_PT_4_117
    );
  cas0_OBUF_D2_PT_5 : X_AND16
    port map (
      I0 => NlwInverterSignal_cas0_OBUF_D2_PT_5_IN0,
      I1 => NlwInverterSignal_cas0_OBUF_D2_PT_5_IN1,
      I2 => NlwInverterSignal_cas0_OBUF_D2_PT_5_IN2,
      I3 => NlwInverterSignal_cas0_OBUF_D2_PT_5_IN3,
      I4 => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN4,
      I5 => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN5,
      I6 => NlwInverterSignal_cas0_OBUF_D2_PT_5_IN6,
      I7 => NlwInverterSignal_cas0_OBUF_D2_PT_5_IN7,
      I8 => NlwInverterSignal_cas0_OBUF_D2_PT_5_IN8,
      I9 => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN9,
      I10 => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN10,
      I11 => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN11,
      I12 => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN12,
      I13 => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN13,
      I14 => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN14,
      I15 => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN15,
      O => cas0_OBUF_D2_PT_5_119
    );
  cas0_OBUF_D2_PT_6 : X_AND16
    port map (
      I0 => NlwInverterSignal_cas0_OBUF_D2_PT_6_IN0,
      I1 => NlwInverterSignal_cas0_OBUF_D2_PT_6_IN1,
      I2 => NlwInverterSignal_cas0_OBUF_D2_PT_6_IN2,
      I3 => NlwInverterSignal_cas0_OBUF_D2_PT_6_IN3,
      I4 => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN4,
      I5 => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN5,
      I6 => NlwInverterSignal_cas0_OBUF_D2_PT_6_IN6,
      I7 => NlwInverterSignal_cas0_OBUF_D2_PT_6_IN7,
      I8 => NlwInverterSignal_cas0_OBUF_D2_PT_6_IN8,
      I9 => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN9,
      I10 => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN10,
      I11 => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN11,
      I12 => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN12,
      I13 => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN13,
      I14 => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN14,
      I15 => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN15,
      O => cas0_OBUF_D2_PT_6_121
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
      O => cas0_OBUF_D2_109
    );
  cas1_OBUF_Q : X_BUF
    port map (
      I => cas1_OBUF_Q_122,
      O => cas1_OBUF_Q_67
    );
  cas1_OBUF_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_cas1_OBUF_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_cas1_OBUF_tsimcreated_xor_IN1,
      O => cas1_OBUF_tsimcreated_xor_Q_124
    );
  cas1_OBUF_REG : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NlwBufferSignal_cas1_OBUF_REG_IN,
      CE => Vcc_84,
      CLK => NlwBufferSignal_cas1_OBUF_REG_CLK,
      SET => Gnd_83,
      RST => Gnd_83,
      O => cas1_OBUF_Q_122
    );
  cas1_OBUF_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_cas1_OBUF_D_IN0,
      I1 => NlwBufferSignal_cas1_OBUF_D_IN1,
      O => cas1_OBUF_D_123
    );
  cas1_OBUF_D1 : X_ZERO
    port map (
      O => cas1_OBUF_D1_125
    );
  cas1_OBUF_D2_PT_0 : X_AND2
    port map (
      I0 => NlwBufferSignal_cas1_OBUF_D2_PT_0_IN0,
      I1 => NlwBufferSignal_cas1_OBUF_D2_PT_0_IN1,
      O => cas1_OBUF_D2_PT_0_128
    );
  cas1_OBUF_D2_PT_1 : X_AND4
    port map (
      I0 => NlwInverterSignal_cas1_OBUF_D2_PT_1_IN0,
      I1 => NlwBufferSignal_cas1_OBUF_D2_PT_1_IN1,
      I2 => NlwBufferSignal_cas1_OBUF_D2_PT_1_IN2,
      I3 => NlwInverterSignal_cas1_OBUF_D2_PT_1_IN3,
      O => cas1_OBUF_D2_PT_1_129
    );
  cas1_OBUF_D2_PT_2 : X_AND16
    port map (
      I0 => NlwInverterSignal_cas1_OBUF_D2_PT_2_IN0,
      I1 => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN1,
      I2 => NlwInverterSignal_cas1_OBUF_D2_PT_2_IN2,
      I3 => NlwInverterSignal_cas1_OBUF_D2_PT_2_IN3,
      I4 => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN4,
      I5 => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN5,
      I6 => NlwInverterSignal_cas1_OBUF_D2_PT_2_IN6,
      I7 => NlwInverterSignal_cas1_OBUF_D2_PT_2_IN7,
      I8 => NlwInverterSignal_cas1_OBUF_D2_PT_2_IN8,
      I9 => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN9,
      I10 => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN10,
      I11 => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN11,
      I12 => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN12,
      I13 => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN13,
      I14 => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN14,
      I15 => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN15,
      O => cas1_OBUF_D2_PT_2_130
    );
  cas1_OBUF_D2_PT_3 : X_AND16
    port map (
      I0 => NlwInverterSignal_cas1_OBUF_D2_PT_3_IN0,
      I1 => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN1,
      I2 => NlwInverterSignal_cas1_OBUF_D2_PT_3_IN2,
      I3 => NlwInverterSignal_cas1_OBUF_D2_PT_3_IN3,
      I4 => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN4,
      I5 => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN5,
      I6 => NlwInverterSignal_cas1_OBUF_D2_PT_3_IN6,
      I7 => NlwInverterSignal_cas1_OBUF_D2_PT_3_IN7,
      I8 => NlwInverterSignal_cas1_OBUF_D2_PT_3_IN8,
      I9 => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN9,
      I10 => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN10,
      I11 => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN11,
      I12 => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN12,
      I13 => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN13,
      I14 => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN14,
      I15 => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN15,
      O => cas1_OBUF_D2_PT_3_131
    );
  cas1_OBUF_D2_PT_4 : X_AND16
    port map (
      I0 => NlwInverterSignal_cas1_OBUF_D2_PT_4_IN0,
      I1 => NlwBufferSignal_cas1_OBUF_D2_PT_4_IN1,
      I2 => NlwInverterSignal_cas1_OBUF_D2_PT_4_IN2,
      I3 => NlwInverterSignal_cas1_OBUF_D2_PT_4_IN3,
      I4 => NlwBufferSignal_cas1_OBUF_D2_PT_4_IN4,
      I5 => NlwBufferSignal_cas1_OBUF_D2_PT_4_IN5,
      I6 => NlwInverterSignal_cas1_OBUF_D2_PT_4_IN6,
      I7 => NlwInverterSignal_cas1_OBUF_D2_PT_4_IN7,
      I8 => NlwInverterSignal_cas1_OBUF_D2_PT_4_IN8,
      I9 => NlwBufferSignal_cas1_OBUF_D2_PT_4_IN9,
      I10 => NlwBufferSignal_cas1_OBUF_D2_PT_4_IN10,
      I11 => NlwBufferSignal_cas1_OBUF_D2_PT_4_IN11,
      I12 => NlwBufferSignal_cas1_OBUF_D2_PT_4_IN12,
      I13 => NlwBufferSignal_cas1_OBUF_D2_PT_4_IN13,
      I14 => NlwBufferSignal_cas1_OBUF_D2_PT_4_IN14,
      I15 => NlwBufferSignal_cas1_OBUF_D2_PT_4_IN15,
      O => cas1_OBUF_D2_PT_4_132
    );
  cas1_OBUF_D2_PT_5 : X_AND16
    port map (
      I0 => NlwInverterSignal_cas1_OBUF_D2_PT_5_IN0,
      I1 => NlwBufferSignal_cas1_OBUF_D2_PT_5_IN1,
      I2 => NlwInverterSignal_cas1_OBUF_D2_PT_5_IN2,
      I3 => NlwInverterSignal_cas1_OBUF_D2_PT_5_IN3,
      I4 => NlwBufferSignal_cas1_OBUF_D2_PT_5_IN4,
      I5 => NlwBufferSignal_cas1_OBUF_D2_PT_5_IN5,
      I6 => NlwInverterSignal_cas1_OBUF_D2_PT_5_IN6,
      I7 => NlwInverterSignal_cas1_OBUF_D2_PT_5_IN7,
      I8 => NlwInverterSignal_cas1_OBUF_D2_PT_5_IN8,
      I9 => NlwBufferSignal_cas1_OBUF_D2_PT_5_IN9,
      I10 => NlwBufferSignal_cas1_OBUF_D2_PT_5_IN10,
      I11 => NlwBufferSignal_cas1_OBUF_D2_PT_5_IN11,
      I12 => NlwBufferSignal_cas1_OBUF_D2_PT_5_IN12,
      I13 => NlwBufferSignal_cas1_OBUF_D2_PT_5_IN13,
      I14 => NlwBufferSignal_cas1_OBUF_D2_PT_5_IN14,
      I15 => NlwBufferSignal_cas1_OBUF_D2_PT_5_IN15,
      O => cas1_OBUF_D2_PT_5_134
    );
  cas1_OBUF_D2 : X_OR6
    port map (
      I0 => NlwBufferSignal_cas1_OBUF_D2_IN0,
      I1 => NlwBufferSignal_cas1_OBUF_D2_IN1,
      I2 => NlwBufferSignal_cas1_OBUF_D2_IN2,
      I3 => NlwBufferSignal_cas1_OBUF_D2_IN3,
      I4 => NlwBufferSignal_cas1_OBUF_D2_IN4,
      I5 => NlwBufferSignal_cas1_OBUF_D2_IN5,
      O => cas1_OBUF_D2_126
    );
  cas2_OBUF_Q : X_BUF
    port map (
      I => cas2_OBUF_Q_135,
      O => cas2_OBUF_Q_68
    );
  cas2_OBUF_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_cas2_OBUF_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_cas2_OBUF_tsimcreated_xor_IN1,
      O => cas2_OBUF_tsimcreated_xor_Q_137
    );
  cas2_OBUF_REG : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NlwBufferSignal_cas2_OBUF_REG_IN,
      CE => Vcc_84,
      CLK => NlwBufferSignal_cas2_OBUF_REG_CLK,
      SET => Gnd_83,
      RST => Gnd_83,
      O => cas2_OBUF_Q_135
    );
  cas2_OBUF_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_cas2_OBUF_D_IN0,
      I1 => NlwBufferSignal_cas2_OBUF_D_IN1,
      O => cas2_OBUF_D_136
    );
  cas2_OBUF_D1 : X_ZERO
    port map (
      O => cas2_OBUF_D1_138
    );
  cas2_OBUF_D2_PT_0 : X_AND2
    port map (
      I0 => NlwBufferSignal_cas2_OBUF_D2_PT_0_IN0,
      I1 => NlwBufferSignal_cas2_OBUF_D2_PT_0_IN1,
      O => cas2_OBUF_D2_PT_0_141
    );
  cas2_OBUF_D2_PT_1 : X_AND2
    port map (
      I0 => NlwBufferSignal_cas2_OBUF_D2_PT_1_IN0,
      I1 => NlwBufferSignal_cas2_OBUF_D2_PT_1_IN1,
      O => cas2_OBUF_D2_PT_1_143
    );
  cas2_OBUF_D2_PT_2 : X_AND4
    port map (
      I0 => NlwInverterSignal_cas2_OBUF_D2_PT_2_IN0,
      I1 => NlwBufferSignal_cas2_OBUF_D2_PT_2_IN1,
      I2 => NlwBufferSignal_cas2_OBUF_D2_PT_2_IN2,
      I3 => NlwInverterSignal_cas2_OBUF_D2_PT_2_IN3,
      O => cas2_OBUF_D2_PT_2_144
    );
  cas2_OBUF_D2_PT_3 : X_AND16
    port map (
      I0 => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN0,
      I1 => NlwInverterSignal_cas2_OBUF_D2_PT_3_IN1,
      I2 => NlwInverterSignal_cas2_OBUF_D2_PT_3_IN2,
      I3 => NlwInverterSignal_cas2_OBUF_D2_PT_3_IN3,
      I4 => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN4,
      I5 => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN5,
      I6 => NlwInverterSignal_cas2_OBUF_D2_PT_3_IN6,
      I7 => NlwInverterSignal_cas2_OBUF_D2_PT_3_IN7,
      I8 => NlwInverterSignal_cas2_OBUF_D2_PT_3_IN8,
      I9 => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN9,
      I10 => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN10,
      I11 => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN11,
      I12 => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN12,
      I13 => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN13,
      I14 => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN14,
      I15 => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN15,
      O => cas2_OBUF_D2_PT_3_145
    );
  cas2_OBUF_D2_PT_4 : X_AND16
    port map (
      I0 => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN0,
      I1 => NlwInverterSignal_cas2_OBUF_D2_PT_4_IN1,
      I2 => NlwInverterSignal_cas2_OBUF_D2_PT_4_IN2,
      I3 => NlwInverterSignal_cas2_OBUF_D2_PT_4_IN3,
      I4 => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN4,
      I5 => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN5,
      I6 => NlwInverterSignal_cas2_OBUF_D2_PT_4_IN6,
      I7 => NlwInverterSignal_cas2_OBUF_D2_PT_4_IN7,
      I8 => NlwInverterSignal_cas2_OBUF_D2_PT_4_IN8,
      I9 => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN9,
      I10 => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN10,
      I11 => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN11,
      I12 => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN12,
      I13 => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN13,
      I14 => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN14,
      I15 => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN15,
      O => cas2_OBUF_D2_PT_4_146
    );
  cas2_OBUF_D2_PT_5 : X_AND16
    port map (
      I0 => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN0,
      I1 => NlwInverterSignal_cas2_OBUF_D2_PT_5_IN1,
      I2 => NlwInverterSignal_cas2_OBUF_D2_PT_5_IN2,
      I3 => NlwInverterSignal_cas2_OBUF_D2_PT_5_IN3,
      I4 => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN4,
      I5 => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN5,
      I6 => NlwInverterSignal_cas2_OBUF_D2_PT_5_IN6,
      I7 => NlwInverterSignal_cas2_OBUF_D2_PT_5_IN7,
      I8 => NlwInverterSignal_cas2_OBUF_D2_PT_5_IN8,
      I9 => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN9,
      I10 => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN10,
      I11 => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN11,
      I12 => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN12,
      I13 => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN13,
      I14 => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN14,
      I15 => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN15,
      O => cas2_OBUF_D2_PT_5_147
    );
  cas2_OBUF_D2_PT_6 : X_AND16
    port map (
      I0 => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN0,
      I1 => NlwInverterSignal_cas2_OBUF_D2_PT_6_IN1,
      I2 => NlwInverterSignal_cas2_OBUF_D2_PT_6_IN2,
      I3 => NlwInverterSignal_cas2_OBUF_D2_PT_6_IN3,
      I4 => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN4,
      I5 => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN5,
      I6 => NlwInverterSignal_cas2_OBUF_D2_PT_6_IN6,
      I7 => NlwInverterSignal_cas2_OBUF_D2_PT_6_IN7,
      I8 => NlwInverterSignal_cas2_OBUF_D2_PT_6_IN8,
      I9 => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN9,
      I10 => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN10,
      I11 => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN11,
      I12 => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN12,
      I13 => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN13,
      I14 => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN14,
      I15 => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN15,
      O => cas2_OBUF_D2_PT_6_148
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
      O => cas2_OBUF_D2_139
    );
  cas3_OBUF_Q : X_BUF
    port map (
      I => cas3_OBUF_Q_149,
      O => cas3_OBUF_Q_69
    );
  cas3_OBUF_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_cas3_OBUF_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_cas3_OBUF_tsimcreated_xor_IN1,
      O => cas3_OBUF_tsimcreated_xor_Q_151
    );
  cas3_OBUF_REG : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NlwBufferSignal_cas3_OBUF_REG_IN,
      CE => Vcc_84,
      CLK => NlwBufferSignal_cas3_OBUF_REG_CLK,
      SET => Gnd_83,
      RST => Gnd_83,
      O => cas3_OBUF_Q_149
    );
  cas3_OBUF_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_cas3_OBUF_D_IN0,
      I1 => NlwBufferSignal_cas3_OBUF_D_IN1,
      O => cas3_OBUF_D_150
    );
  cas3_OBUF_D1 : X_ZERO
    port map (
      O => cas3_OBUF_D1_152
    );
  cas3_OBUF_D2_PT_0 : X_AND2
    port map (
      I0 => NlwBufferSignal_cas3_OBUF_D2_PT_0_IN0,
      I1 => NlwBufferSignal_cas3_OBUF_D2_PT_0_IN1,
      O => cas3_OBUF_D2_PT_0_155
    );
  cas3_OBUF_D2_PT_1 : X_AND4
    port map (
      I0 => NlwInverterSignal_cas3_OBUF_D2_PT_1_IN0,
      I1 => NlwBufferSignal_cas3_OBUF_D2_PT_1_IN1,
      I2 => NlwBufferSignal_cas3_OBUF_D2_PT_1_IN2,
      I3 => NlwInverterSignal_cas3_OBUF_D2_PT_1_IN3,
      O => cas3_OBUF_D2_PT_1_156
    );
  cas3_OBUF_D2_PT_2 : X_AND16
    port map (
      I0 => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN0,
      I1 => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN1,
      I2 => NlwInverterSignal_cas3_OBUF_D2_PT_2_IN2,
      I3 => NlwInverterSignal_cas3_OBUF_D2_PT_2_IN3,
      I4 => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN4,
      I5 => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN5,
      I6 => NlwInverterSignal_cas3_OBUF_D2_PT_2_IN6,
      I7 => NlwInverterSignal_cas3_OBUF_D2_PT_2_IN7,
      I8 => NlwInverterSignal_cas3_OBUF_D2_PT_2_IN8,
      I9 => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN9,
      I10 => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN10,
      I11 => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN11,
      I12 => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN12,
      I13 => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN13,
      I14 => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN14,
      I15 => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN15,
      O => cas3_OBUF_D2_PT_2_157
    );
  cas3_OBUF_D2_PT_3 : X_AND16
    port map (
      I0 => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN0,
      I1 => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN1,
      I2 => NlwInverterSignal_cas3_OBUF_D2_PT_3_IN2,
      I3 => NlwInverterSignal_cas3_OBUF_D2_PT_3_IN3,
      I4 => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN4,
      I5 => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN5,
      I6 => NlwInverterSignal_cas3_OBUF_D2_PT_3_IN6,
      I7 => NlwInverterSignal_cas3_OBUF_D2_PT_3_IN7,
      I8 => NlwInverterSignal_cas3_OBUF_D2_PT_3_IN8,
      I9 => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN9,
      I10 => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN10,
      I11 => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN11,
      I12 => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN12,
      I13 => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN13,
      I14 => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN14,
      I15 => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN15,
      O => cas3_OBUF_D2_PT_3_158
    );
  cas3_OBUF_D2_PT_4 : X_AND16
    port map (
      I0 => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN0,
      I1 => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN1,
      I2 => NlwInverterSignal_cas3_OBUF_D2_PT_4_IN2,
      I3 => NlwInverterSignal_cas3_OBUF_D2_PT_4_IN3,
      I4 => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN4,
      I5 => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN5,
      I6 => NlwInverterSignal_cas3_OBUF_D2_PT_4_IN6,
      I7 => NlwInverterSignal_cas3_OBUF_D2_PT_4_IN7,
      I8 => NlwInverterSignal_cas3_OBUF_D2_PT_4_IN8,
      I9 => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN9,
      I10 => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN10,
      I11 => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN11,
      I12 => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN12,
      I13 => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN13,
      I14 => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN14,
      I15 => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN15,
      O => cas3_OBUF_D2_PT_4_159
    );
  cas3_OBUF_D2_PT_5 : X_AND16
    port map (
      I0 => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN0,
      I1 => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN1,
      I2 => NlwInverterSignal_cas3_OBUF_D2_PT_5_IN2,
      I3 => NlwInverterSignal_cas3_OBUF_D2_PT_5_IN3,
      I4 => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN4,
      I5 => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN5,
      I6 => NlwInverterSignal_cas3_OBUF_D2_PT_5_IN6,
      I7 => NlwInverterSignal_cas3_OBUF_D2_PT_5_IN7,
      I8 => NlwInverterSignal_cas3_OBUF_D2_PT_5_IN8,
      I9 => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN9,
      I10 => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN10,
      I11 => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN11,
      I12 => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN12,
      I13 => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN13,
      I14 => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN14,
      I15 => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN15,
      O => cas3_OBUF_D2_PT_5_160
    );
  cas3_OBUF_D2 : X_OR6
    port map (
      I0 => NlwBufferSignal_cas3_OBUF_D2_IN0,
      I1 => NlwBufferSignal_cas3_OBUF_D2_IN1,
      I2 => NlwBufferSignal_cas3_OBUF_D2_IN2,
      I3 => NlwBufferSignal_cas3_OBUF_D2_IN3,
      I4 => NlwBufferSignal_cas3_OBUF_D2_IN4,
      I5 => NlwBufferSignal_cas3_OBUF_D2_IN5,
      O => cas3_OBUF_D2_153
    );
  io0_OBUF_Q : X_BUF
    port map (
      I => io0_OBUF_Q_161,
      O => io0_OBUF_Q_70
    );
  io0_OBUF_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_io0_OBUF_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_io0_OBUF_tsimcreated_xor_IN1,
      O => io0_OBUF_tsimcreated_xor_Q_163
    );
  io0_OBUF_REG : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NlwBufferSignal_io0_OBUF_REG_IN,
      CE => Vcc_84,
      CLK => NlwBufferSignal_io0_OBUF_REG_CLK,
      SET => Gnd_83,
      RST => Gnd_83,
      O => io0_OBUF_Q_161
    );
  io0_OBUF_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_io0_OBUF_D_IN0,
      I1 => NlwBufferSignal_io0_OBUF_D_IN1,
      O => io0_OBUF_D_162
    );
  io0_OBUF_D1 : X_ZERO
    port map (
      O => io0_OBUF_D1_164
    );
  io0_OBUF_D2_PT_0 : X_AND7
    port map (
      I0 => NlwInverterSignal_io0_OBUF_D2_PT_0_IN0,
      I1 => NlwBufferSignal_io0_OBUF_D2_PT_0_IN1,
      I2 => NlwBufferSignal_io0_OBUF_D2_PT_0_IN2,
      I3 => NlwInverterSignal_io0_OBUF_D2_PT_0_IN3,
      I4 => NlwBufferSignal_io0_OBUF_D2_PT_0_IN4,
      I5 => NlwBufferSignal_io0_OBUF_D2_PT_0_IN5,
      I6 => NlwInverterSignal_io0_OBUF_D2_PT_0_IN6,
      O => io0_OBUF_D2_PT_0_166
    );
  io0_OBUF_D2_PT_1 : X_AND16
    port map (
      I0 => NlwInverterSignal_io0_OBUF_D2_PT_1_IN0,
      I1 => NlwInverterSignal_io0_OBUF_D2_PT_1_IN1,
      I2 => NlwInverterSignal_io0_OBUF_D2_PT_1_IN2,
      I3 => NlwInverterSignal_io0_OBUF_D2_PT_1_IN3,
      I4 => NlwBufferSignal_io0_OBUF_D2_PT_1_IN4,
      I5 => NlwBufferSignal_io0_OBUF_D2_PT_1_IN5,
      I6 => NlwInverterSignal_io0_OBUF_D2_PT_1_IN6,
      I7 => NlwBufferSignal_io0_OBUF_D2_PT_1_IN7,
      I8 => NlwInverterSignal_io0_OBUF_D2_PT_1_IN8,
      I9 => NlwBufferSignal_io0_OBUF_D2_PT_1_IN9,
      I10 => NlwBufferSignal_io0_OBUF_D2_PT_1_IN10,
      I11 => NlwBufferSignal_io0_OBUF_D2_PT_1_IN11,
      I12 => NlwBufferSignal_io0_OBUF_D2_PT_1_IN12,
      I13 => NlwBufferSignal_io0_OBUF_D2_PT_1_IN13,
      I14 => NlwBufferSignal_io0_OBUF_D2_PT_1_IN14,
      I15 => NlwBufferSignal_io0_OBUF_D2_PT_1_IN15,
      O => io0_OBUF_D2_PT_1_167
    );
  io0_OBUF_D2 : X_OR2
    port map (
      I0 => NlwBufferSignal_io0_OBUF_D2_IN0,
      I1 => NlwBufferSignal_io0_OBUF_D2_IN1,
      O => io0_OBUF_D2_165
    );
  io1_OBUF_Q : X_BUF
    port map (
      I => io1_OBUF_Q_168,
      O => io1_OBUF_Q_71
    );
  io1_OBUF_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_io1_OBUF_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_io1_OBUF_tsimcreated_xor_IN1,
      O => io1_OBUF_tsimcreated_xor_Q_170
    );
  io1_OBUF_REG : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NlwBufferSignal_io1_OBUF_REG_IN,
      CE => Vcc_84,
      CLK => NlwBufferSignal_io1_OBUF_REG_CLK,
      SET => Gnd_83,
      RST => Gnd_83,
      O => io1_OBUF_Q_168
    );
  io1_OBUF_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_io1_OBUF_D_IN0,
      I1 => NlwBufferSignal_io1_OBUF_D_IN1,
      O => io1_OBUF_D_169
    );
  io1_OBUF_D1 : X_ZERO
    port map (
      O => io1_OBUF_D1_171
    );
  io1_OBUF_D2_PT_0 : X_AND7
    port map (
      I0 => NlwInverterSignal_io1_OBUF_D2_PT_0_IN0,
      I1 => NlwBufferSignal_io1_OBUF_D2_PT_0_IN1,
      I2 => NlwBufferSignal_io1_OBUF_D2_PT_0_IN2,
      I3 => NlwInverterSignal_io1_OBUF_D2_PT_0_IN3,
      I4 => NlwBufferSignal_io1_OBUF_D2_PT_0_IN4,
      I5 => NlwBufferSignal_io1_OBUF_D2_PT_0_IN5,
      I6 => NlwInverterSignal_io1_OBUF_D2_PT_0_IN6,
      O => io1_OBUF_D2_PT_0_173
    );
  io1_OBUF_D2_PT_1 : X_AND16
    port map (
      I0 => NlwInverterSignal_io1_OBUF_D2_PT_1_IN0,
      I1 => NlwInverterSignal_io1_OBUF_D2_PT_1_IN1,
      I2 => NlwBufferSignal_io1_OBUF_D2_PT_1_IN2,
      I3 => NlwInverterSignal_io1_OBUF_D2_PT_1_IN3,
      I4 => NlwBufferSignal_io1_OBUF_D2_PT_1_IN4,
      I5 => NlwBufferSignal_io1_OBUF_D2_PT_1_IN5,
      I6 => NlwInverterSignal_io1_OBUF_D2_PT_1_IN6,
      I7 => NlwBufferSignal_io1_OBUF_D2_PT_1_IN7,
      I8 => NlwInverterSignal_io1_OBUF_D2_PT_1_IN8,
      I9 => NlwBufferSignal_io1_OBUF_D2_PT_1_IN9,
      I10 => NlwBufferSignal_io1_OBUF_D2_PT_1_IN10,
      I11 => NlwBufferSignal_io1_OBUF_D2_PT_1_IN11,
      I12 => NlwBufferSignal_io1_OBUF_D2_PT_1_IN12,
      I13 => NlwBufferSignal_io1_OBUF_D2_PT_1_IN13,
      I14 => NlwBufferSignal_io1_OBUF_D2_PT_1_IN14,
      I15 => NlwBufferSignal_io1_OBUF_D2_PT_1_IN15,
      O => io1_OBUF_D2_PT_1_174
    );
  io1_OBUF_D2 : X_OR2
    port map (
      I0 => NlwBufferSignal_io1_OBUF_D2_IN0,
      I1 => NlwBufferSignal_io1_OBUF_D2_IN1,
      O => io1_OBUF_D2_172
    );
  io2_OBUF_Q : X_BUF
    port map (
      I => io2_OBUF_Q_175,
      O => io2_OBUF_Q_72
    );
  io2_OBUF_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_io2_OBUF_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_io2_OBUF_tsimcreated_xor_IN1,
      O => io2_OBUF_tsimcreated_xor_Q_177
    );
  io2_OBUF_REG : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NlwBufferSignal_io2_OBUF_REG_IN,
      CE => Vcc_84,
      CLK => NlwBufferSignal_io2_OBUF_REG_CLK,
      SET => Gnd_83,
      RST => Gnd_83,
      O => io2_OBUF_Q_175
    );
  io2_OBUF_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_io2_OBUF_D_IN0,
      I1 => NlwBufferSignal_io2_OBUF_D_IN1,
      O => io2_OBUF_D_176
    );
  io2_OBUF_D1 : X_ZERO
    port map (
      O => io2_OBUF_D1_178
    );
  io2_OBUF_D2_PT_0 : X_AND7
    port map (
      I0 => NlwInverterSignal_io2_OBUF_D2_PT_0_IN0,
      I1 => NlwBufferSignal_io2_OBUF_D2_PT_0_IN1,
      I2 => NlwBufferSignal_io2_OBUF_D2_PT_0_IN2,
      I3 => NlwInverterSignal_io2_OBUF_D2_PT_0_IN3,
      I4 => NlwBufferSignal_io2_OBUF_D2_PT_0_IN4,
      I5 => NlwBufferSignal_io2_OBUF_D2_PT_0_IN5,
      I6 => NlwInverterSignal_io2_OBUF_D2_PT_0_IN6,
      O => io2_OBUF_D2_PT_0_180
    );
  io2_OBUF_D2_PT_1 : X_AND16
    port map (
      I0 => NlwInverterSignal_io2_OBUF_D2_PT_1_IN0,
      I1 => NlwBufferSignal_io2_OBUF_D2_PT_1_IN1,
      I2 => NlwInverterSignal_io2_OBUF_D2_PT_1_IN2,
      I3 => NlwInverterSignal_io2_OBUF_D2_PT_1_IN3,
      I4 => NlwBufferSignal_io2_OBUF_D2_PT_1_IN4,
      I5 => NlwBufferSignal_io2_OBUF_D2_PT_1_IN5,
      I6 => NlwInverterSignal_io2_OBUF_D2_PT_1_IN6,
      I7 => NlwBufferSignal_io2_OBUF_D2_PT_1_IN7,
      I8 => NlwInverterSignal_io2_OBUF_D2_PT_1_IN8,
      I9 => NlwBufferSignal_io2_OBUF_D2_PT_1_IN9,
      I10 => NlwBufferSignal_io2_OBUF_D2_PT_1_IN10,
      I11 => NlwBufferSignal_io2_OBUF_D2_PT_1_IN11,
      I12 => NlwBufferSignal_io2_OBUF_D2_PT_1_IN12,
      I13 => NlwBufferSignal_io2_OBUF_D2_PT_1_IN13,
      I14 => NlwBufferSignal_io2_OBUF_D2_PT_1_IN14,
      I15 => NlwBufferSignal_io2_OBUF_D2_PT_1_IN15,
      O => io2_OBUF_D2_PT_1_181
    );
  io2_OBUF_D2 : X_OR2
    port map (
      I0 => NlwBufferSignal_io2_OBUF_D2_IN0,
      I1 => NlwBufferSignal_io2_OBUF_D2_IN1,
      O => io2_OBUF_D2_179
    );
  io3_OBUF_Q : X_BUF
    port map (
      I => io3_OBUF_Q_182,
      O => io3_OBUF_Q_73
    );
  io3_OBUF_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_io3_OBUF_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_io3_OBUF_tsimcreated_xor_IN1,
      O => io3_OBUF_tsimcreated_xor_Q_184
    );
  io3_OBUF_REG : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NlwBufferSignal_io3_OBUF_REG_IN,
      CE => Vcc_84,
      CLK => NlwBufferSignal_io3_OBUF_REG_CLK,
      SET => Gnd_83,
      RST => Gnd_83,
      O => io3_OBUF_Q_182
    );
  io3_OBUF_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_io3_OBUF_D_IN0,
      I1 => NlwBufferSignal_io3_OBUF_D_IN1,
      O => io3_OBUF_D_183
    );
  io3_OBUF_D1 : X_ZERO
    port map (
      O => io3_OBUF_D1_185
    );
  io3_OBUF_D2_PT_0 : X_AND7
    port map (
      I0 => NlwInverterSignal_io3_OBUF_D2_PT_0_IN0,
      I1 => NlwBufferSignal_io3_OBUF_D2_PT_0_IN1,
      I2 => NlwBufferSignal_io3_OBUF_D2_PT_0_IN2,
      I3 => NlwInverterSignal_io3_OBUF_D2_PT_0_IN3,
      I4 => NlwBufferSignal_io3_OBUF_D2_PT_0_IN4,
      I5 => NlwBufferSignal_io3_OBUF_D2_PT_0_IN5,
      I6 => NlwInverterSignal_io3_OBUF_D2_PT_0_IN6,
      O => io3_OBUF_D2_PT_0_187
    );
  io3_OBUF_D2_PT_1 : X_AND16
    port map (
      I0 => NlwInverterSignal_io3_OBUF_D2_PT_1_IN0,
      I1 => NlwBufferSignal_io3_OBUF_D2_PT_1_IN1,
      I2 => NlwBufferSignal_io3_OBUF_D2_PT_1_IN2,
      I3 => NlwInverterSignal_io3_OBUF_D2_PT_1_IN3,
      I4 => NlwBufferSignal_io3_OBUF_D2_PT_1_IN4,
      I5 => NlwBufferSignal_io3_OBUF_D2_PT_1_IN5,
      I6 => NlwInverterSignal_io3_OBUF_D2_PT_1_IN6,
      I7 => NlwBufferSignal_io3_OBUF_D2_PT_1_IN7,
      I8 => NlwInverterSignal_io3_OBUF_D2_PT_1_IN8,
      I9 => NlwBufferSignal_io3_OBUF_D2_PT_1_IN9,
      I10 => NlwBufferSignal_io3_OBUF_D2_PT_1_IN10,
      I11 => NlwBufferSignal_io3_OBUF_D2_PT_1_IN11,
      I12 => NlwBufferSignal_io3_OBUF_D2_PT_1_IN12,
      I13 => NlwBufferSignal_io3_OBUF_D2_PT_1_IN13,
      I14 => NlwBufferSignal_io3_OBUF_D2_PT_1_IN14,
      I15 => NlwBufferSignal_io3_OBUF_D2_PT_1_IN15,
      O => io3_OBUF_D2_PT_1_188
    );
  io3_OBUF_D2 : X_OR2
    port map (
      I0 => NlwBufferSignal_io3_OBUF_D2_IN0,
      I1 => NlwBufferSignal_io3_OBUF_D2_IN1,
      O => io3_OBUF_D2_186
    );
  io4_OBUF_Q : X_BUF
    port map (
      I => io4_OBUF_Q_189,
      O => io4_OBUF_Q_74
    );
  io4_OBUF_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_io4_OBUF_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_io4_OBUF_tsimcreated_xor_IN1,
      O => io4_OBUF_tsimcreated_xor_Q_191
    );
  io4_OBUF_REG : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NlwBufferSignal_io4_OBUF_REG_IN,
      CE => Vcc_84,
      CLK => NlwBufferSignal_io4_OBUF_REG_CLK,
      SET => Gnd_83,
      RST => Gnd_83,
      O => io4_OBUF_Q_189
    );
  io4_OBUF_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_io4_OBUF_D_IN0,
      I1 => NlwBufferSignal_io4_OBUF_D_IN1,
      O => io4_OBUF_D_190
    );
  io4_OBUF_D1 : X_ZERO
    port map (
      O => io4_OBUF_D1_192
    );
  io4_OBUF_D2_PT_0 : X_AND7
    port map (
      I0 => NlwInverterSignal_io4_OBUF_D2_PT_0_IN0,
      I1 => NlwBufferSignal_io4_OBUF_D2_PT_0_IN1,
      I2 => NlwBufferSignal_io4_OBUF_D2_PT_0_IN2,
      I3 => NlwInverterSignal_io4_OBUF_D2_PT_0_IN3,
      I4 => NlwBufferSignal_io4_OBUF_D2_PT_0_IN4,
      I5 => NlwBufferSignal_io4_OBUF_D2_PT_0_IN5,
      I6 => NlwInverterSignal_io4_OBUF_D2_PT_0_IN6,
      O => io4_OBUF_D2_PT_0_194
    );
  io4_OBUF_D2_PT_1 : X_AND16
    port map (
      I0 => NlwBufferSignal_io4_OBUF_D2_PT_1_IN0,
      I1 => NlwInverterSignal_io4_OBUF_D2_PT_1_IN1,
      I2 => NlwInverterSignal_io4_OBUF_D2_PT_1_IN2,
      I3 => NlwInverterSignal_io4_OBUF_D2_PT_1_IN3,
      I4 => NlwBufferSignal_io4_OBUF_D2_PT_1_IN4,
      I5 => NlwBufferSignal_io4_OBUF_D2_PT_1_IN5,
      I6 => NlwInverterSignal_io4_OBUF_D2_PT_1_IN6,
      I7 => NlwBufferSignal_io4_OBUF_D2_PT_1_IN7,
      I8 => NlwInverterSignal_io4_OBUF_D2_PT_1_IN8,
      I9 => NlwBufferSignal_io4_OBUF_D2_PT_1_IN9,
      I10 => NlwBufferSignal_io4_OBUF_D2_PT_1_IN10,
      I11 => NlwBufferSignal_io4_OBUF_D2_PT_1_IN11,
      I12 => NlwBufferSignal_io4_OBUF_D2_PT_1_IN12,
      I13 => NlwBufferSignal_io4_OBUF_D2_PT_1_IN13,
      I14 => NlwBufferSignal_io4_OBUF_D2_PT_1_IN14,
      I15 => NlwBufferSignal_io4_OBUF_D2_PT_1_IN15,
      O => io4_OBUF_D2_PT_1_195
    );
  io4_OBUF_D2 : X_OR2
    port map (
      I0 => NlwBufferSignal_io4_OBUF_D2_IN0,
      I1 => NlwBufferSignal_io4_OBUF_D2_IN1,
      O => io4_OBUF_D2_193
    );
  io5_OBUF_Q : X_BUF
    port map (
      I => io5_OBUF_Q_196,
      O => io5_OBUF_Q_75
    );
  io5_OBUF_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_io5_OBUF_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_io5_OBUF_tsimcreated_xor_IN1,
      O => io5_OBUF_tsimcreated_xor_Q_198
    );
  io5_OBUF_REG : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NlwBufferSignal_io5_OBUF_REG_IN,
      CE => Vcc_84,
      CLK => NlwBufferSignal_io5_OBUF_REG_CLK,
      SET => Gnd_83,
      RST => Gnd_83,
      O => io5_OBUF_Q_196
    );
  io5_OBUF_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_io5_OBUF_D_IN0,
      I1 => NlwBufferSignal_io5_OBUF_D_IN1,
      O => io5_OBUF_D_197
    );
  io5_OBUF_D1 : X_ZERO
    port map (
      O => io5_OBUF_D1_199
    );
  io5_OBUF_D2_PT_0 : X_AND7
    port map (
      I0 => NlwInverterSignal_io5_OBUF_D2_PT_0_IN0,
      I1 => NlwBufferSignal_io5_OBUF_D2_PT_0_IN1,
      I2 => NlwBufferSignal_io5_OBUF_D2_PT_0_IN2,
      I3 => NlwInverterSignal_io5_OBUF_D2_PT_0_IN3,
      I4 => NlwBufferSignal_io5_OBUF_D2_PT_0_IN4,
      I5 => NlwBufferSignal_io5_OBUF_D2_PT_0_IN5,
      I6 => NlwInverterSignal_io5_OBUF_D2_PT_0_IN6,
      O => io5_OBUF_D2_PT_0_201
    );
  io5_OBUF_D2_PT_1 : X_AND16
    port map (
      I0 => NlwBufferSignal_io5_OBUF_D2_PT_1_IN0,
      I1 => NlwInverterSignal_io5_OBUF_D2_PT_1_IN1,
      I2 => NlwBufferSignal_io5_OBUF_D2_PT_1_IN2,
      I3 => NlwInverterSignal_io5_OBUF_D2_PT_1_IN3,
      I4 => NlwBufferSignal_io5_OBUF_D2_PT_1_IN4,
      I5 => NlwBufferSignal_io5_OBUF_D2_PT_1_IN5,
      I6 => NlwInverterSignal_io5_OBUF_D2_PT_1_IN6,
      I7 => NlwBufferSignal_io5_OBUF_D2_PT_1_IN7,
      I8 => NlwInverterSignal_io5_OBUF_D2_PT_1_IN8,
      I9 => NlwBufferSignal_io5_OBUF_D2_PT_1_IN9,
      I10 => NlwBufferSignal_io5_OBUF_D2_PT_1_IN10,
      I11 => NlwBufferSignal_io5_OBUF_D2_PT_1_IN11,
      I12 => NlwBufferSignal_io5_OBUF_D2_PT_1_IN12,
      I13 => NlwBufferSignal_io5_OBUF_D2_PT_1_IN13,
      I14 => NlwBufferSignal_io5_OBUF_D2_PT_1_IN14,
      I15 => NlwBufferSignal_io5_OBUF_D2_PT_1_IN15,
      O => io5_OBUF_D2_PT_1_202
    );
  io5_OBUF_D2 : X_OR2
    port map (
      I0 => NlwBufferSignal_io5_OBUF_D2_IN0,
      I1 => NlwBufferSignal_io5_OBUF_D2_IN1,
      O => io5_OBUF_D2_200
    );
  io6_OBUF_Q : X_BUF
    port map (
      I => io6_OBUF_Q_203,
      O => io6_OBUF_Q_76
    );
  io6_OBUF_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_io6_OBUF_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_io6_OBUF_tsimcreated_xor_IN1,
      O => io6_OBUF_tsimcreated_xor_Q_205
    );
  io6_OBUF_REG : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NlwBufferSignal_io6_OBUF_REG_IN,
      CE => Vcc_84,
      CLK => NlwBufferSignal_io6_OBUF_REG_CLK,
      SET => Gnd_83,
      RST => Gnd_83,
      O => io6_OBUF_Q_203
    );
  io6_OBUF_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_io6_OBUF_D_IN0,
      I1 => NlwBufferSignal_io6_OBUF_D_IN1,
      O => io6_OBUF_D_204
    );
  io6_OBUF_D1 : X_ZERO
    port map (
      O => io6_OBUF_D1_206
    );
  io6_OBUF_D2_PT_0 : X_AND7
    port map (
      I0 => NlwInverterSignal_io6_OBUF_D2_PT_0_IN0,
      I1 => NlwBufferSignal_io6_OBUF_D2_PT_0_IN1,
      I2 => NlwBufferSignal_io6_OBUF_D2_PT_0_IN2,
      I3 => NlwInverterSignal_io6_OBUF_D2_PT_0_IN3,
      I4 => NlwBufferSignal_io6_OBUF_D2_PT_0_IN4,
      I5 => NlwBufferSignal_io6_OBUF_D2_PT_0_IN5,
      I6 => NlwInverterSignal_io6_OBUF_D2_PT_0_IN6,
      O => io6_OBUF_D2_PT_0_208
    );
  io6_OBUF_D2_PT_1 : X_AND16
    port map (
      I0 => NlwBufferSignal_io6_OBUF_D2_PT_1_IN0,
      I1 => NlwBufferSignal_io6_OBUF_D2_PT_1_IN1,
      I2 => NlwInverterSignal_io6_OBUF_D2_PT_1_IN2,
      I3 => NlwInverterSignal_io6_OBUF_D2_PT_1_IN3,
      I4 => NlwBufferSignal_io6_OBUF_D2_PT_1_IN4,
      I5 => NlwBufferSignal_io6_OBUF_D2_PT_1_IN5,
      I6 => NlwInverterSignal_io6_OBUF_D2_PT_1_IN6,
      I7 => NlwBufferSignal_io6_OBUF_D2_PT_1_IN7,
      I8 => NlwInverterSignal_io6_OBUF_D2_PT_1_IN8,
      I9 => NlwBufferSignal_io6_OBUF_D2_PT_1_IN9,
      I10 => NlwBufferSignal_io6_OBUF_D2_PT_1_IN10,
      I11 => NlwBufferSignal_io6_OBUF_D2_PT_1_IN11,
      I12 => NlwBufferSignal_io6_OBUF_D2_PT_1_IN12,
      I13 => NlwBufferSignal_io6_OBUF_D2_PT_1_IN13,
      I14 => NlwBufferSignal_io6_OBUF_D2_PT_1_IN14,
      I15 => NlwBufferSignal_io6_OBUF_D2_PT_1_IN15,
      O => io6_OBUF_D2_PT_1_209
    );
  io6_OBUF_D2 : X_OR2
    port map (
      I0 => NlwBufferSignal_io6_OBUF_D2_IN0,
      I1 => NlwBufferSignal_io6_OBUF_D2_IN1,
      O => io6_OBUF_D2_207
    );
  io7_OBUF_Q : X_BUF
    port map (
      I => io7_OBUF_Q_210,
      O => io7_OBUF_Q_77
    );
  io7_OBUF_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_io7_OBUF_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_io7_OBUF_tsimcreated_xor_IN1,
      O => io7_OBUF_tsimcreated_xor_Q_212
    );
  io7_OBUF_REG : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NlwBufferSignal_io7_OBUF_REG_IN,
      CE => Vcc_84,
      CLK => NlwBufferSignal_io7_OBUF_REG_CLK,
      SET => Gnd_83,
      RST => Gnd_83,
      O => io7_OBUF_Q_210
    );
  io7_OBUF_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_io7_OBUF_D_IN0,
      I1 => NlwBufferSignal_io7_OBUF_D_IN1,
      O => io7_OBUF_D_211
    );
  io7_OBUF_D1 : X_ZERO
    port map (
      O => io7_OBUF_D1_213
    );
  io7_OBUF_D2_PT_0 : X_AND7
    port map (
      I0 => NlwInverterSignal_io7_OBUF_D2_PT_0_IN0,
      I1 => NlwBufferSignal_io7_OBUF_D2_PT_0_IN1,
      I2 => NlwBufferSignal_io7_OBUF_D2_PT_0_IN2,
      I3 => NlwInverterSignal_io7_OBUF_D2_PT_0_IN3,
      I4 => NlwBufferSignal_io7_OBUF_D2_PT_0_IN4,
      I5 => NlwBufferSignal_io7_OBUF_D2_PT_0_IN5,
      I6 => NlwInverterSignal_io7_OBUF_D2_PT_0_IN6,
      O => io7_OBUF_D2_PT_0_215
    );
  io7_OBUF_D2_PT_1 : X_AND16
    port map (
      I0 => NlwBufferSignal_io7_OBUF_D2_PT_1_IN0,
      I1 => NlwBufferSignal_io7_OBUF_D2_PT_1_IN1,
      I2 => NlwBufferSignal_io7_OBUF_D2_PT_1_IN2,
      I3 => NlwInverterSignal_io7_OBUF_D2_PT_1_IN3,
      I4 => NlwBufferSignal_io7_OBUF_D2_PT_1_IN4,
      I5 => NlwBufferSignal_io7_OBUF_D2_PT_1_IN5,
      I6 => NlwInverterSignal_io7_OBUF_D2_PT_1_IN6,
      I7 => NlwBufferSignal_io7_OBUF_D2_PT_1_IN7,
      I8 => NlwInverterSignal_io7_OBUF_D2_PT_1_IN8,
      I9 => NlwBufferSignal_io7_OBUF_D2_PT_1_IN9,
      I10 => NlwBufferSignal_io7_OBUF_D2_PT_1_IN10,
      I11 => NlwBufferSignal_io7_OBUF_D2_PT_1_IN11,
      I12 => NlwBufferSignal_io7_OBUF_D2_PT_1_IN12,
      I13 => NlwBufferSignal_io7_OBUF_D2_PT_1_IN13,
      I14 => NlwBufferSignal_io7_OBUF_D2_PT_1_IN14,
      I15 => NlwBufferSignal_io7_OBUF_D2_PT_1_IN15,
      O => io7_OBUF_D2_PT_1_216
    );
  io7_OBUF_D2 : X_OR2
    port map (
      I0 => NlwBufferSignal_io7_OBUF_D2_IN0,
      I1 => NlwBufferSignal_io7_OBUF_D2_IN1,
      O => io7_OBUF_D2_214
    );
  phi0_OBUF_Q : X_BUF
    port map (
      I => phi0_OBUF_Q_217,
      O => phi0_OBUF_Q_78
    );
  phi0_OBUF_REG : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NlwBufferSignal_phi0_OBUF_REG_IN,
      CE => Vcc_84,
      CLK => NlwBufferSignal_phi0_OBUF_REG_CLK,
      SET => Gnd_83,
      RST => Gnd_83,
      O => phi0_OBUF_Q_217
    );
  phi0_OBUF_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_phi0_OBUF_D_IN0,
      I1 => NlwBufferSignal_phi0_OBUF_D_IN1,
      O => phi0_OBUF_D_218
    );
  phi0_OBUF_D1 : X_ZERO
    port map (
      O => phi0_OBUF_D1_219
    );
  phi0_OBUF_D2_PT_0 : X_AND2
    port map (
      I0 => NlwBufferSignal_phi0_OBUF_D2_PT_0_IN0,
      I1 => NlwBufferSignal_phi0_OBUF_D2_PT_0_IN1,
      O => phi0_OBUF_D2_PT_0_222
    );
  phi0_OBUF_D2_PT_1 : X_AND2
    port map (
      I0 => NlwBufferSignal_phi0_OBUF_D2_PT_1_IN0,
      I1 => NlwBufferSignal_phi0_OBUF_D2_PT_1_IN1,
      O => phi0_OBUF_D2_PT_1_223
    );
  phi0_OBUF_D2_PT_2 : X_AND2
    port map (
      I0 => NlwInverterSignal_phi0_OBUF_D2_PT_2_IN0,
      I1 => NlwBufferSignal_phi0_OBUF_D2_PT_2_IN1,
      O => phi0_OBUF_D2_PT_2_224
    );
  phi0_OBUF_D2_PT_3 : X_AND2
    port map (
      I0 => NlwBufferSignal_phi0_OBUF_D2_PT_3_IN0,
      I1 => NlwBufferSignal_phi0_OBUF_D2_PT_3_IN1,
      O => phi0_OBUF_D2_PT_3_225
    );
  phi0_OBUF_D2_PT_4 : X_AND3
    port map (
      I0 => NlwInverterSignal_phi0_OBUF_D2_PT_4_IN0,
      I1 => NlwBufferSignal_phi0_OBUF_D2_PT_4_IN1,
      I2 => NlwInverterSignal_phi0_OBUF_D2_PT_4_IN2,
      O => phi0_OBUF_D2_PT_4_226
    );
  phi0_OBUF_D2_PT_5 : X_AND3
    port map (
      I0 => NlwInverterSignal_phi0_OBUF_D2_PT_5_IN0,
      I1 => NlwBufferSignal_phi0_OBUF_D2_PT_5_IN1,
      I2 => NlwBufferSignal_phi0_OBUF_D2_PT_5_IN2,
      O => phi0_OBUF_D2_PT_5_227
    );
  phi0_OBUF_D2 : X_OR6
    port map (
      I0 => NlwBufferSignal_phi0_OBUF_D2_IN0,
      I1 => NlwBufferSignal_phi0_OBUF_D2_IN1,
      I2 => NlwBufferSignal_phi0_OBUF_D2_IN2,
      I3 => NlwBufferSignal_phi0_OBUF_D2_IN3,
      I4 => NlwBufferSignal_phi0_OBUF_D2_IN4,
      I5 => NlwBufferSignal_phi0_OBUF_D2_IN5,
      O => phi0_OBUF_D2_220
    );
  ras_OBUF_Q : X_BUF
    port map (
      I => ras_OBUF_Q_228,
      O => ras_OBUF_Q_79
    );
  ras_OBUF_REG : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NlwBufferSignal_ras_OBUF_REG_IN,
      CE => Vcc_84,
      CLK => NlwBufferSignal_ras_OBUF_REG_CLK,
      SET => Gnd_83,
      RST => Gnd_83,
      O => ras_OBUF_Q_228
    );
  ras_OBUF_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_ras_OBUF_D_IN0,
      I1 => NlwBufferSignal_ras_OBUF_D_IN1,
      O => ras_OBUF_D_229
    );
  ras_OBUF_D1 : X_ZERO
    port map (
      O => ras_OBUF_D1_230
    );
  ras_OBUF_D2_PT_0 : X_AND2
    port map (
      I0 => NlwBufferSignal_ras_OBUF_D2_PT_0_IN0,
      I1 => NlwBufferSignal_ras_OBUF_D2_PT_0_IN1,
      O => ras_OBUF_D2_PT_0_233
    );
  ras_OBUF_D2_PT_1 : X_AND2
    port map (
      I0 => NlwInverterSignal_ras_OBUF_D2_PT_1_IN0,
      I1 => NlwBufferSignal_ras_OBUF_D2_PT_1_IN1,
      O => ras_OBUF_D2_PT_1_234
    );
  ras_OBUF_D2_PT_2 : X_AND2
    port map (
      I0 => NlwBufferSignal_ras_OBUF_D2_PT_2_IN0,
      I1 => NlwBufferSignal_ras_OBUF_D2_PT_2_IN1,
      O => ras_OBUF_D2_PT_2_235
    );
  ras_OBUF_D2_PT_3 : X_AND3
    port map (
      I0 => NlwBufferSignal_ras_OBUF_D2_PT_3_IN0,
      I1 => NlwInverterSignal_ras_OBUF_D2_PT_3_IN1,
      I2 => NlwBufferSignal_ras_OBUF_D2_PT_3_IN2,
      O => ras_OBUF_D2_PT_3_236
    );
  ras_OBUF_D2_PT_4 : X_AND16
    port map (
      I0 => NlwInverterSignal_ras_OBUF_D2_PT_4_IN0,
      I1 => NlwInverterSignal_ras_OBUF_D2_PT_4_IN1,
      I2 => NlwInverterSignal_ras_OBUF_D2_PT_4_IN2,
      I3 => NlwInverterSignal_ras_OBUF_D2_PT_4_IN3,
      I4 => NlwInverterSignal_ras_OBUF_D2_PT_4_IN4,
      I5 => NlwInverterSignal_ras_OBUF_D2_PT_4_IN5,
      I6 => NlwInverterSignal_ras_OBUF_D2_PT_4_IN6,
      I7 => NlwInverterSignal_ras_OBUF_D2_PT_4_IN7,
      I8 => NlwBufferSignal_ras_OBUF_D2_PT_4_IN8,
      I9 => NlwBufferSignal_ras_OBUF_D2_PT_4_IN9,
      I10 => NlwBufferSignal_ras_OBUF_D2_PT_4_IN10,
      I11 => NlwBufferSignal_ras_OBUF_D2_PT_4_IN11,
      I12 => NlwBufferSignal_ras_OBUF_D2_PT_4_IN12,
      I13 => NlwBufferSignal_ras_OBUF_D2_PT_4_IN13,
      I14 => NlwBufferSignal_ras_OBUF_D2_PT_4_IN14,
      I15 => NlwBufferSignal_ras_OBUF_D2_PT_4_IN15,
      O => ras_OBUF_D2_PT_4_241
    );
  ras_OBUF_D2_PT_5 : X_AND16
    port map (
      I0 => NlwBufferSignal_ras_OBUF_D2_PT_5_IN0,
      I1 => NlwBufferSignal_ras_OBUF_D2_PT_5_IN1,
      I2 => NlwBufferSignal_ras_OBUF_D2_PT_5_IN2,
      I3 => NlwBufferSignal_ras_OBUF_D2_PT_5_IN3,
      I4 => NlwBufferSignal_ras_OBUF_D2_PT_5_IN4,
      I5 => NlwBufferSignal_ras_OBUF_D2_PT_5_IN5,
      I6 => NlwBufferSignal_ras_OBUF_D2_PT_5_IN6,
      I7 => NlwBufferSignal_ras_OBUF_D2_PT_5_IN7,
      I8 => NlwBufferSignal_ras_OBUF_D2_PT_5_IN8,
      I9 => NlwBufferSignal_ras_OBUF_D2_PT_5_IN9,
      I10 => NlwBufferSignal_ras_OBUF_D2_PT_5_IN10,
      I11 => NlwBufferSignal_ras_OBUF_D2_PT_5_IN11,
      I12 => NlwBufferSignal_ras_OBUF_D2_PT_5_IN12,
      I13 => NlwBufferSignal_ras_OBUF_D2_PT_5_IN13,
      I14 => NlwBufferSignal_ras_OBUF_D2_PT_5_IN14,
      I15 => NlwBufferSignal_ras_OBUF_D2_PT_5_IN15,
      O => ras_OBUF_D2_PT_5_242
    );
  ras_OBUF_D2 : X_OR6
    port map (
      I0 => NlwBufferSignal_ras_OBUF_D2_IN0,
      I1 => NlwBufferSignal_ras_OBUF_D2_IN1,
      I2 => NlwBufferSignal_ras_OBUF_D2_IN2,
      I3 => NlwBufferSignal_ras_OBUF_D2_IN3,
      I4 => NlwBufferSignal_ras_OBUF_D2_IN4,
      I5 => NlwBufferSignal_ras_OBUF_D2_IN5,
      O => ras_OBUF_D2_231
    );
  iocnt_0_Q : X_BUF
    port map (
      I => iocnt_0_Q_243,
      O => iocnt(0)
    );
  iocnt_0_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_iocnt_0_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_iocnt_0_tsimcreated_xor_IN1,
      O => iocnt_0_tsimcreated_xor_Q_245
    );
  iocnt_0_REG : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => NlwBufferSignal_iocnt_0_REG_IN,
      CE => Vcc_84,
      CLK => NlwBufferSignal_iocnt_0_REG_CLK,
      SET => Gnd_83,
      RST => Gnd_83,
      O => iocnt_0_Q_243
    );
  iocnt_0_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_iocnt_0_D_IN0,
      I1 => NlwBufferSignal_iocnt_0_D_IN1,
      O => iocnt_0_D_244
    );
  iocnt_0_D1 : X_ZERO
    port map (
      O => iocnt_0_D1_246
    );
  iocnt_0_D2_PT_0 : X_AND4
    port map (
      I0 => NlwInverterSignal_iocnt_0_D2_PT_0_IN0,
      I1 => NlwBufferSignal_iocnt_0_D2_PT_0_IN1,
      I2 => NlwBufferSignal_iocnt_0_D2_PT_0_IN2,
      I3 => NlwBufferSignal_iocnt_0_D2_PT_0_IN3,
      O => iocnt_0_D2_PT_0_248
    );
  iocnt_0_D2_PT_1 : X_AND4
    port map (
      I0 => NlwInverterSignal_iocnt_0_D2_PT_1_IN0,
      I1 => NlwBufferSignal_iocnt_0_D2_PT_1_IN1,
      I2 => NlwBufferSignal_iocnt_0_D2_PT_1_IN2,
      I3 => NlwBufferSignal_iocnt_0_D2_PT_1_IN3,
      O => iocnt_0_D2_PT_1_249
    );
  iocnt_0_D2_PT_2 : X_AND4
    port map (
      I0 => NlwInverterSignal_iocnt_0_D2_PT_2_IN0,
      I1 => NlwBufferSignal_iocnt_0_D2_PT_2_IN1,
      I2 => NlwBufferSignal_iocnt_0_D2_PT_2_IN2,
      I3 => NlwBufferSignal_iocnt_0_D2_PT_2_IN3,
      O => iocnt_0_D2_PT_2_250
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
      I15 => NlwInverterSignal_iocnt_0_D2_PT_3_IN15,
      I16 => NlwInverterSignal_iocnt_0_D2_PT_3_IN16,
      I17 => NlwBufferSignal_iocnt_0_D2_PT_3_IN17,
      I18 => NlwBufferSignal_iocnt_0_D2_PT_3_IN18,
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
      O => iocnt_0_D2_PT_3_251
    );
  iocnt_0_D2 : X_OR4
    port map (
      I0 => NlwBufferSignal_iocnt_0_D2_IN0,
      I1 => NlwBufferSignal_iocnt_0_D2_IN1,
      I2 => NlwBufferSignal_iocnt_0_D2_IN2,
      I3 => NlwBufferSignal_iocnt_0_D2_IN3,
      O => iocnt_0_D2_247
    );
  iocnt_1_Q : X_BUF
    port map (
      I => iocnt_1_Q_252,
      O => iocnt(1)
    );
  iocnt_1_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_iocnt_1_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_iocnt_1_tsimcreated_xor_IN1,
      O => iocnt_1_tsimcreated_xor_Q_254
    );
  iocnt_1_REG : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => NlwBufferSignal_iocnt_1_REG_IN,
      CE => Vcc_84,
      CLK => NlwBufferSignal_iocnt_1_REG_CLK,
      SET => Gnd_83,
      RST => Gnd_83,
      O => iocnt_1_Q_252
    );
  iocnt_1_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_iocnt_1_D_IN0,
      I1 => NlwBufferSignal_iocnt_1_D_IN1,
      O => iocnt_1_D_253
    );
  iocnt_1_D1 : X_ZERO
    port map (
      O => iocnt_1_D1_255
    );
  iocnt_1_D2_PT_0 : X_AND5
    port map (
      I0 => NlwInverterSignal_iocnt_1_D2_PT_0_IN0,
      I1 => NlwBufferSignal_iocnt_1_D2_PT_0_IN1,
      I2 => NlwBufferSignal_iocnt_1_D2_PT_0_IN2,
      I3 => NlwBufferSignal_iocnt_1_D2_PT_0_IN3,
      I4 => NlwBufferSignal_iocnt_1_D2_PT_0_IN4,
      O => iocnt_1_D2_PT_0_257
    );
  iocnt_1_D2_PT_1 : X_AND5
    port map (
      I0 => NlwInverterSignal_iocnt_1_D2_PT_1_IN0,
      I1 => NlwBufferSignal_iocnt_1_D2_PT_1_IN1,
      I2 => NlwBufferSignal_iocnt_1_D2_PT_1_IN2,
      I3 => NlwBufferSignal_iocnt_1_D2_PT_1_IN3,
      I4 => NlwInverterSignal_iocnt_1_D2_PT_1_IN4,
      O => iocnt_1_D2_PT_1_258
    );
  iocnt_1_D2 : X_OR2
    port map (
      I0 => NlwBufferSignal_iocnt_1_D2_IN0,
      I1 => NlwBufferSignal_iocnt_1_D2_IN1,
      O => iocnt_1_D2_256
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
      CE => Vcc_84,
      CLK => NlwBufferSignal_iocnt_2_REG_CLK,
      SET => Gnd_83,
      RST => Gnd_83,
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
      I0 => NlwInverterSignal_iocnt_2_D2_PT_0_IN0,
      I1 => NlwBufferSignal_iocnt_2_D2_PT_0_IN1,
      I2 => NlwBufferSignal_iocnt_2_D2_PT_0_IN2,
      I3 => NlwBufferSignal_iocnt_2_D2_PT_0_IN3,
      I4 => NlwBufferSignal_iocnt_2_D2_PT_0_IN4,
      O => iocnt_2_D2_PT_0_264
    );
  iocnt_2_D2_PT_1 : X_AND5
    port map (
      I0 => NlwInverterSignal_iocnt_2_D2_PT_1_IN0,
      I1 => NlwBufferSignal_iocnt_2_D2_PT_1_IN1,
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
      CE => Vcc_84,
      CLK => NlwBufferSignal_counter_0_REG_CLK,
      SET => Gnd_83,
      RST => Gnd_83,
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
      I0 => NlwInverterSignal_counter_0_D2_IN0,
      I1 => NlwBufferSignal_counter_0_D2_IN1,
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
      CE => Vcc_84,
      CLK => NlwBufferSignal_counter_1_REG_CLK,
      SET => Gnd_83,
      RST => Gnd_83,
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
      I1 => NlwBufferSignal_counter_1_D2_PT_1_IN1,
      I2 => NlwInverterSignal_counter_1_D2_PT_1_IN2,
      O => counter_1_D2_PT_1_276
    );
  counter_1_D2 : X_OR2
    port map (
      I0 => NlwBufferSignal_counter_1_D2_IN0,
      I1 => NlwBufferSignal_counter_1_D2_IN1,
      O => counter_1_D2_274
    );
  counter_2_Q : X_BUF
    port map (
      I => counter_2_Q_277,
      O => counter(2)
    );
  counter_2_REG : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => NlwBufferSignal_counter_2_REG_IN,
      CE => Vcc_84,
      CLK => NlwBufferSignal_counter_2_REG_CLK,
      SET => Gnd_83,
      RST => Gnd_83,
      O => counter_2_Q_277
    );
  counter_2_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_counter_2_D_IN0,
      I1 => NlwBufferSignal_counter_2_D_IN1,
      O => counter_2_D_278
    );
  counter_2_D1 : X_ZERO
    port map (
      O => counter_2_D1_279
    );
  counter_2_D2_PT_0 : X_AND2
    port map (
      I0 => NlwInverterSignal_counter_2_D2_PT_0_IN0,
      I1 => NlwBufferSignal_counter_2_D2_PT_0_IN1,
      O => counter_2_D2_PT_0_281
    );
  counter_2_D2_PT_1 : X_AND3
    port map (
      I0 => NlwBufferSignal_counter_2_D2_PT_1_IN0,
      I1 => NlwBufferSignal_counter_2_D2_PT_1_IN1,
      I2 => NlwInverterSignal_counter_2_D2_PT_1_IN2,
      O => counter_2_D2_PT_1_282
    );
  counter_2_D2 : X_OR2
    port map (
      I0 => NlwBufferSignal_counter_2_D2_IN0,
      I1 => NlwBufferSignal_counter_2_D2_IN1,
      O => counter_2_D2_280
    );
  refcnt_0_Q : X_BUF
    port map (
      I => refcnt_0_Q_283,
      O => refcnt(0)
    );
  refcnt_0_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_refcnt_0_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_refcnt_0_tsimcreated_xor_IN1,
      O => refcnt_0_tsimcreated_xor_Q_285
    );
  refcnt_0_REG : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => NlwBufferSignal_refcnt_0_REG_IN,
      CE => Vcc_84,
      CLK => NlwBufferSignal_refcnt_0_REG_CLK,
      SET => Gnd_83,
      RST => Gnd_83,
      O => refcnt_0_Q_283
    );
  refcnt_0_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_refcnt_0_D_IN0,
      I1 => NlwBufferSignal_refcnt_0_D_IN1,
      O => refcnt_0_D_284
    );
  refcnt_0_D1 : X_ZERO
    port map (
      O => refcnt_0_D1_286
    );
  refcnt_0_D2 : X_AND3
    port map (
      I0 => NlwInverterSignal_refcnt_0_D2_IN0,
      I1 => NlwBufferSignal_refcnt_0_D2_IN1,
      I2 => NlwBufferSignal_refcnt_0_D2_IN2,
      O => refcnt_0_D2_287
    );
  refcnt_1_Q : X_BUF
    port map (
      I => refcnt_1_Q_288,
      O => refcnt(1)
    );
  refcnt_1_EXP : X_BUF
    port map (
      I => refcnt_1_EXP_tsimrenamed_net_Q_289,
      O => refcnt_1_EXP_110
    );
  refcnt_1_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_refcnt_1_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_refcnt_1_tsimcreated_xor_IN1,
      O => refcnt_1_tsimcreated_xor_Q_291
    );
  refcnt_1_REG : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => NlwBufferSignal_refcnt_1_REG_IN,
      CE => Vcc_84,
      CLK => NlwBufferSignal_refcnt_1_REG_CLK,
      SET => Gnd_83,
      RST => Gnd_83,
      O => refcnt_1_Q_288
    );
  refcnt_1_D : X_XOR2
    port map (
      I0 => NlwInverterSignal_refcnt_1_D_IN0,
      I1 => NlwBufferSignal_refcnt_1_D_IN1,
      O => refcnt_1_D_290
    );
  refcnt_1_D1 : X_ZERO
    port map (
      O => refcnt_1_D1_292
    );
  refcnt_1_D2_PT_0 : X_AND2
    port map (
      I0 => NlwBufferSignal_refcnt_1_D2_PT_0_IN0,
      I1 => NlwBufferSignal_refcnt_1_D2_PT_0_IN1,
      O => refcnt_1_D2_PT_0_294
    );
  refcnt_1_D2_PT_1 : X_AND2
    port map (
      I0 => NlwInverterSignal_refcnt_1_D2_PT_1_IN0,
      I1 => NlwInverterSignal_refcnt_1_D2_PT_1_IN1,
      O => refcnt_1_D2_PT_1_295
    );
  refcnt_1_D2_PT_2 : X_AND2
    port map (
      I0 => NlwInverterSignal_refcnt_1_D2_PT_2_IN0,
      I1 => NlwInverterSignal_refcnt_1_D2_PT_2_IN1,
      O => refcnt_1_D2_PT_2_296
    );
  refcnt_1_D2_PT_3 : X_AND2
    port map (
      I0 => NlwBufferSignal_refcnt_1_D2_PT_3_IN0,
      I1 => NlwBufferSignal_refcnt_1_D2_PT_3_IN1,
      O => refcnt_1_D2_PT_3_297
    );
  refcnt_1_D2_PT_4 : X_AND2
    port map (
      I0 => NlwBufferSignal_refcnt_1_D2_PT_4_IN0,
      I1 => NlwBufferSignal_refcnt_1_D2_PT_4_IN1,
      O => refcnt_1_D2_PT_4_299
    );
  refcnt_1_D2 : X_OR5
    port map (
      I0 => NlwBufferSignal_refcnt_1_D2_IN0,
      I1 => NlwBufferSignal_refcnt_1_D2_IN1,
      I2 => NlwBufferSignal_refcnt_1_D2_IN2,
      I3 => NlwBufferSignal_refcnt_1_D2_IN3,
      I4 => NlwBufferSignal_refcnt_1_D2_IN4,
      O => refcnt_1_D2_293
    );
  refcnt_1_EXP_tsimrenamed_net_Q : X_AND16
    port map (
      I0 => NlwInverterSignal_refcnt_1_EXP_tsimrenamed_net_IN0,
      I1 => NlwInverterSignal_refcnt_1_EXP_tsimrenamed_net_IN1,
      I2 => NlwInverterSignal_refcnt_1_EXP_tsimrenamed_net_IN2,
      I3 => NlwInverterSignal_refcnt_1_EXP_tsimrenamed_net_IN3,
      I4 => NlwInverterSignal_refcnt_1_EXP_tsimrenamed_net_IN4,
      I5 => NlwInverterSignal_refcnt_1_EXP_tsimrenamed_net_IN5,
      I6 => NlwInverterSignal_refcnt_1_EXP_tsimrenamed_net_IN6,
      I7 => NlwInverterSignal_refcnt_1_EXP_tsimrenamed_net_IN7,
      I8 => NlwInverterSignal_refcnt_1_EXP_tsimrenamed_net_IN8,
      I9 => NlwInverterSignal_refcnt_1_EXP_tsimrenamed_net_IN9,
      I10 => NlwInverterSignal_refcnt_1_EXP_tsimrenamed_net_IN10,
      I11 => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN11,
      I12 => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN12,
      I13 => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN13,
      I14 => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN14,
      I15 => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN15,
      O => refcnt_1_EXP_tsimrenamed_net_Q_289
    );
  refcnt_2_Q : X_BUF
    port map (
      I => refcnt_2_Q_300,
      O => refcnt(2)
    );
  refcnt_2_EXP : X_BUF
    port map (
      I => refcnt_2_EXP_tsimrenamed_net_Q_301,
      O => refcnt_2_EXP_140
    );
  refcnt_2_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_refcnt_2_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_refcnt_2_tsimcreated_xor_IN1,
      O => refcnt_2_tsimcreated_xor_Q_303
    );
  refcnt_2_REG : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NlwBufferSignal_refcnt_2_REG_IN,
      CE => Vcc_84,
      CLK => NlwBufferSignal_refcnt_2_REG_CLK,
      SET => Gnd_83,
      RST => Gnd_83,
      O => refcnt_2_Q_300
    );
  refcnt_2_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_refcnt_2_D_IN0,
      I1 => NlwBufferSignal_refcnt_2_D_IN1,
      O => refcnt_2_D_302
    );
  refcnt_2_D1 : X_ZERO
    port map (
      O => refcnt_2_D1_304
    );
  refcnt_2_D2 : X_AND5
    port map (
      I0 => NlwInverterSignal_refcnt_2_D2_IN0,
      I1 => NlwBufferSignal_refcnt_2_D2_IN1,
      I2 => NlwBufferSignal_refcnt_2_D2_IN2,
      I3 => NlwInverterSignal_refcnt_2_D2_IN3,
      I4 => NlwInverterSignal_refcnt_2_D2_IN4,
      O => refcnt_2_D2_305
    );
  refcnt_2_EXP_PT_0 : X_AND16
    port map (
      I0 => NlwBufferSignal_refcnt_2_EXP_PT_0_IN0,
      I1 => NlwInverterSignal_refcnt_2_EXP_PT_0_IN1,
      I2 => NlwInverterSignal_refcnt_2_EXP_PT_0_IN2,
      I3 => NlwInverterSignal_refcnt_2_EXP_PT_0_IN3,
      I4 => NlwBufferSignal_refcnt_2_EXP_PT_0_IN4,
      I5 => NlwBufferSignal_refcnt_2_EXP_PT_0_IN5,
      I6 => NlwInverterSignal_refcnt_2_EXP_PT_0_IN6,
      I7 => NlwInverterSignal_refcnt_2_EXP_PT_0_IN7,
      I8 => NlwInverterSignal_refcnt_2_EXP_PT_0_IN8,
      I9 => NlwBufferSignal_refcnt_2_EXP_PT_0_IN9,
      I10 => NlwBufferSignal_refcnt_2_EXP_PT_0_IN10,
      I11 => NlwBufferSignal_refcnt_2_EXP_PT_0_IN11,
      I12 => NlwBufferSignal_refcnt_2_EXP_PT_0_IN12,
      I13 => NlwBufferSignal_refcnt_2_EXP_PT_0_IN13,
      I14 => NlwBufferSignal_refcnt_2_EXP_PT_0_IN14,
      I15 => NlwBufferSignal_refcnt_2_EXP_PT_0_IN15,
      O => refcnt_2_EXP_PT_0_306
    );
  refcnt_2_EXP_PT_1 : X_AND16
    port map (
      I0 => NlwBufferSignal_refcnt_2_EXP_PT_1_IN0,
      I1 => NlwInverterSignal_refcnt_2_EXP_PT_1_IN1,
      I2 => NlwInverterSignal_refcnt_2_EXP_PT_1_IN2,
      I3 => NlwInverterSignal_refcnt_2_EXP_PT_1_IN3,
      I4 => NlwBufferSignal_refcnt_2_EXP_PT_1_IN4,
      I5 => NlwBufferSignal_refcnt_2_EXP_PT_1_IN5,
      I6 => NlwInverterSignal_refcnt_2_EXP_PT_1_IN6,
      I7 => NlwInverterSignal_refcnt_2_EXP_PT_1_IN7,
      I8 => NlwInverterSignal_refcnt_2_EXP_PT_1_IN8,
      I9 => NlwBufferSignal_refcnt_2_EXP_PT_1_IN9,
      I10 => NlwBufferSignal_refcnt_2_EXP_PT_1_IN10,
      I11 => NlwBufferSignal_refcnt_2_EXP_PT_1_IN11,
      I12 => NlwBufferSignal_refcnt_2_EXP_PT_1_IN12,
      I13 => NlwBufferSignal_refcnt_2_EXP_PT_1_IN13,
      I14 => NlwBufferSignal_refcnt_2_EXP_PT_1_IN14,
      I15 => NlwBufferSignal_refcnt_2_EXP_PT_1_IN15,
      O => refcnt_2_EXP_PT_1_307
    );
  refcnt_2_EXP_tsimrenamed_net_Q : X_OR2
    port map (
      I0 => NlwBufferSignal_refcnt_2_EXP_tsimrenamed_net_IN0,
      I1 => NlwBufferSignal_refcnt_2_EXP_tsimrenamed_net_IN1,
      O => refcnt_2_EXP_tsimrenamed_net_Q_301
    );
  refcnt_3_Q : X_BUF
    port map (
      I => refcnt_3_Q_308,
      O => refcnt(3)
    );
  refcnt_3_EXP : X_BUF
    port map (
      I => refcnt_3_EXP_tsimrenamed_net_Q_309,
      O => refcnt_3_EXP_142
    );
  refcnt_3_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_refcnt_3_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_refcnt_3_tsimcreated_xor_IN1,
      O => refcnt_3_tsimcreated_xor_Q_311
    );
  refcnt_3_REG : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => NlwBufferSignal_refcnt_3_REG_IN,
      CE => Vcc_84,
      CLK => NlwBufferSignal_refcnt_3_REG_CLK,
      SET => Gnd_83,
      RST => Gnd_83,
      O => refcnt_3_Q_308
    );
  refcnt_3_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_refcnt_3_D_IN0,
      I1 => NlwBufferSignal_refcnt_3_D_IN1,
      O => refcnt_3_D_310
    );
  refcnt_3_D1 : X_ZERO
    port map (
      O => refcnt_3_D1_312
    );
  refcnt_3_D2 : X_AND6
    port map (
      I0 => NlwInverterSignal_refcnt_3_D2_IN0,
      I1 => NlwBufferSignal_refcnt_3_D2_IN1,
      I2 => NlwBufferSignal_refcnt_3_D2_IN2,
      I3 => NlwInverterSignal_refcnt_3_D2_IN3,
      I4 => NlwInverterSignal_refcnt_3_D2_IN4,
      I5 => NlwInverterSignal_refcnt_3_D2_IN5,
      O => refcnt_3_D2_313
    );
  refcnt_3_EXP_PT_0 : X_AND16
    port map (
      I0 => NlwBufferSignal_refcnt_3_EXP_PT_0_IN0,
      I1 => NlwInverterSignal_refcnt_3_EXP_PT_0_IN1,
      I2 => NlwInverterSignal_refcnt_3_EXP_PT_0_IN2,
      I3 => NlwInverterSignal_refcnt_3_EXP_PT_0_IN3,
      I4 => NlwBufferSignal_refcnt_3_EXP_PT_0_IN4,
      I5 => NlwBufferSignal_refcnt_3_EXP_PT_0_IN5,
      I6 => NlwInverterSignal_refcnt_3_EXP_PT_0_IN6,
      I7 => NlwInverterSignal_refcnt_3_EXP_PT_0_IN7,
      I8 => NlwInverterSignal_refcnt_3_EXP_PT_0_IN8,
      I9 => NlwBufferSignal_refcnt_3_EXP_PT_0_IN9,
      I10 => NlwBufferSignal_refcnt_3_EXP_PT_0_IN10,
      I11 => NlwBufferSignal_refcnt_3_EXP_PT_0_IN11,
      I12 => NlwBufferSignal_refcnt_3_EXP_PT_0_IN12,
      I13 => NlwBufferSignal_refcnt_3_EXP_PT_0_IN13,
      I14 => NlwBufferSignal_refcnt_3_EXP_PT_0_IN14,
      I15 => NlwBufferSignal_refcnt_3_EXP_PT_0_IN15,
      O => refcnt_3_EXP_PT_0_314
    );
  refcnt_3_EXP_PT_1 : X_AND16
    port map (
      I0 => NlwBufferSignal_refcnt_3_EXP_PT_1_IN0,
      I1 => NlwInverterSignal_refcnt_3_EXP_PT_1_IN1,
      I2 => NlwInverterSignal_refcnt_3_EXP_PT_1_IN2,
      I3 => NlwInverterSignal_refcnt_3_EXP_PT_1_IN3,
      I4 => NlwBufferSignal_refcnt_3_EXP_PT_1_IN4,
      I5 => NlwBufferSignal_refcnt_3_EXP_PT_1_IN5,
      I6 => NlwInverterSignal_refcnt_3_EXP_PT_1_IN6,
      I7 => NlwInverterSignal_refcnt_3_EXP_PT_1_IN7,
      I8 => NlwInverterSignal_refcnt_3_EXP_PT_1_IN8,
      I9 => NlwBufferSignal_refcnt_3_EXP_PT_1_IN9,
      I10 => NlwBufferSignal_refcnt_3_EXP_PT_1_IN10,
      I11 => NlwBufferSignal_refcnt_3_EXP_PT_1_IN11,
      I12 => NlwBufferSignal_refcnt_3_EXP_PT_1_IN12,
      I13 => NlwBufferSignal_refcnt_3_EXP_PT_1_IN13,
      I14 => NlwBufferSignal_refcnt_3_EXP_PT_1_IN14,
      I15 => NlwBufferSignal_refcnt_3_EXP_PT_1_IN15,
      O => refcnt_3_EXP_PT_1_315
    );
  refcnt_3_EXP_tsimrenamed_net_Q : X_OR2
    port map (
      I0 => NlwBufferSignal_refcnt_3_EXP_tsimrenamed_net_IN0,
      I1 => NlwBufferSignal_refcnt_3_EXP_tsimrenamed_net_IN1,
      O => refcnt_3_EXP_tsimrenamed_net_Q_309
    );
  refcnt_4_Q : X_BUF
    port map (
      I => refcnt_4_Q_316,
      O => refcnt(4)
    );
  refcnt_4_EXP : X_BUF
    port map (
      I => refcnt_4_EXP_tsimrenamed_net_Q_317,
      O => refcnt_4_EXP_298
    );
  refcnt_4_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_refcnt_4_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_refcnt_4_tsimcreated_xor_IN1,
      O => refcnt_4_tsimcreated_xor_Q_319
    );
  refcnt_4_REG : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => NlwBufferSignal_refcnt_4_REG_IN,
      CE => Vcc_84,
      CLK => NlwBufferSignal_refcnt_4_REG_CLK,
      SET => Gnd_83,
      RST => Gnd_83,
      O => refcnt_4_Q_316
    );
  refcnt_4_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_refcnt_4_D_IN0,
      I1 => NlwBufferSignal_refcnt_4_D_IN1,
      O => refcnt_4_D_318
    );
  refcnt_4_D1 : X_ZERO
    port map (
      O => refcnt_4_D1_320
    );
  refcnt_4_D2_PT_0 : X_AND8
    port map (
      I0 => NlwInverterSignal_refcnt_4_D2_PT_0_IN0,
      I1 => NlwBufferSignal_refcnt_4_D2_PT_0_IN1,
      I2 => NlwBufferSignal_refcnt_4_D2_PT_0_IN2,
      I3 => NlwInverterSignal_refcnt_4_D2_PT_0_IN3,
      I4 => NlwInverterSignal_refcnt_4_D2_PT_0_IN4,
      I5 => NlwInverterSignal_refcnt_4_D2_PT_0_IN5,
      I6 => NlwInverterSignal_refcnt_4_D2_PT_0_IN6,
      I7 => NlwBufferSignal_refcnt_4_D2_PT_0_IN7,
      O => refcnt_4_D2_PT_0_322
    );
  refcnt_4_D2_PT_1 : X_AND8
    port map (
      I0 => NlwInverterSignal_refcnt_4_D2_PT_1_IN0,
      I1 => NlwBufferSignal_refcnt_4_D2_PT_1_IN1,
      I2 => NlwBufferSignal_refcnt_4_D2_PT_1_IN2,
      I3 => NlwInverterSignal_refcnt_4_D2_PT_1_IN3,
      I4 => NlwInverterSignal_refcnt_4_D2_PT_1_IN4,
      I5 => NlwInverterSignal_refcnt_4_D2_PT_1_IN5,
      I6 => NlwInverterSignal_refcnt_4_D2_PT_1_IN6,
      I7 => NlwBufferSignal_refcnt_4_D2_PT_1_IN7,
      O => refcnt_4_D2_PT_1_323
    );
  refcnt_4_D2_PT_2 : X_AND8
    port map (
      I0 => NlwInverterSignal_refcnt_4_D2_PT_2_IN0,
      I1 => NlwBufferSignal_refcnt_4_D2_PT_2_IN1,
      I2 => NlwBufferSignal_refcnt_4_D2_PT_2_IN2,
      I3 => NlwInverterSignal_refcnt_4_D2_PT_2_IN3,
      I4 => NlwInverterSignal_refcnt_4_D2_PT_2_IN4,
      I5 => NlwInverterSignal_refcnt_4_D2_PT_2_IN5,
      I6 => NlwInverterSignal_refcnt_4_D2_PT_2_IN6,
      I7 => NlwBufferSignal_refcnt_4_D2_PT_2_IN7,
      O => refcnt_4_D2_PT_2_324
    );
  refcnt_4_D2_PT_3 : X_AND8
    port map (
      I0 => NlwInverterSignal_refcnt_4_D2_PT_3_IN0,
      I1 => NlwBufferSignal_refcnt_4_D2_PT_3_IN1,
      I2 => NlwBufferSignal_refcnt_4_D2_PT_3_IN2,
      I3 => NlwInverterSignal_refcnt_4_D2_PT_3_IN3,
      I4 => NlwInverterSignal_refcnt_4_D2_PT_3_IN4,
      I5 => NlwInverterSignal_refcnt_4_D2_PT_3_IN5,
      I6 => NlwInverterSignal_refcnt_4_D2_PT_3_IN6,
      I7 => NlwBufferSignal_refcnt_4_D2_PT_3_IN7,
      O => refcnt_4_D2_PT_3_325
    );
  refcnt_4_D2 : X_OR4
    port map (
      I0 => NlwBufferSignal_refcnt_4_D2_IN0,
      I1 => NlwBufferSignal_refcnt_4_D2_IN1,
      I2 => NlwBufferSignal_refcnt_4_D2_IN2,
      I3 => NlwBufferSignal_refcnt_4_D2_IN3,
      O => refcnt_4_D2_321
    );
  refcnt_4_EXP_tsimrenamed_net_Q : X_AND7
    port map (
      I0 => NlwInverterSignal_refcnt_4_EXP_tsimrenamed_net_IN0,
      I1 => NlwInverterSignal_refcnt_4_EXP_tsimrenamed_net_IN1,
      I2 => NlwInverterSignal_refcnt_4_EXP_tsimrenamed_net_IN2,
      I3 => NlwInverterSignal_refcnt_4_EXP_tsimrenamed_net_IN3,
      I4 => NlwInverterSignal_refcnt_4_EXP_tsimrenamed_net_IN4,
      I5 => NlwInverterSignal_refcnt_4_EXP_tsimrenamed_net_IN5,
      I6 => NlwInverterSignal_refcnt_4_EXP_tsimrenamed_net_IN6,
      O => refcnt_4_EXP_tsimrenamed_net_Q_317
    );
  refcnt_5_Q : X_BUF
    port map (
      I => refcnt_5_Q_326,
      O => refcnt(5)
    );
  refcnt_5_EXP : X_BUF
    port map (
      I => refcnt_5_EXP_tsimrenamed_net_Q_327,
      O => refcnt_5_EXP_127
    );
  refcnt_5_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_refcnt_5_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_refcnt_5_tsimcreated_xor_IN1,
      O => refcnt_5_tsimcreated_xor_Q_329
    );
  refcnt_5_REG : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => NlwBufferSignal_refcnt_5_REG_IN,
      CE => Vcc_84,
      CLK => NlwBufferSignal_refcnt_5_REG_CLK,
      SET => Gnd_83,
      RST => Gnd_83,
      O => refcnt_5_Q_326
    );
  refcnt_5_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_refcnt_5_D_IN0,
      I1 => NlwBufferSignal_refcnt_5_D_IN1,
      O => refcnt_5_D_328
    );
  refcnt_5_D1 : X_ZERO
    port map (
      O => refcnt_5_D1_330
    );
  refcnt_5_D2_PT_0 : X_AND2
    port map (
      I0 => NlwBufferSignal_refcnt_5_D2_PT_0_IN0,
      I1 => NlwBufferSignal_refcnt_5_D2_PT_0_IN1,
      O => refcnt_5_D2_PT_0_333
    );
  refcnt_5_D2_PT_1 : X_AND16
    port map (
      I0 => NlwInverterSignal_refcnt_5_D2_PT_1_IN0,
      I1 => NlwBufferSignal_refcnt_5_D2_PT_1_IN1,
      I2 => NlwBufferSignal_refcnt_5_D2_PT_1_IN2,
      I3 => NlwInverterSignal_refcnt_5_D2_PT_1_IN3,
      I4 => NlwInverterSignal_refcnt_5_D2_PT_1_IN4,
      I5 => NlwInverterSignal_refcnt_5_D2_PT_1_IN5,
      I6 => NlwInverterSignal_refcnt_5_D2_PT_1_IN6,
      I7 => NlwInverterSignal_refcnt_5_D2_PT_1_IN7,
      I8 => NlwBufferSignal_refcnt_5_D2_PT_1_IN8,
      I9 => NlwBufferSignal_refcnt_5_D2_PT_1_IN9,
      I10 => NlwBufferSignal_refcnt_5_D2_PT_1_IN10,
      I11 => NlwBufferSignal_refcnt_5_D2_PT_1_IN11,
      I12 => NlwBufferSignal_refcnt_5_D2_PT_1_IN12,
      I13 => NlwBufferSignal_refcnt_5_D2_PT_1_IN13,
      I14 => NlwBufferSignal_refcnt_5_D2_PT_1_IN14,
      I15 => NlwBufferSignal_refcnt_5_D2_PT_1_IN15,
      O => refcnt_5_D2_PT_1_334
    );
  refcnt_5_D2 : X_OR2
    port map (
      I0 => NlwBufferSignal_refcnt_5_D2_IN0,
      I1 => NlwBufferSignal_refcnt_5_D2_IN1,
      O => refcnt_5_D2_331
    );
  refcnt_5_EXP_PT_0 : X_AND16
    port map (
      I0 => NlwInverterSignal_refcnt_5_EXP_PT_0_IN0,
      I1 => NlwBufferSignal_refcnt_5_EXP_PT_0_IN1,
      I2 => NlwInverterSignal_refcnt_5_EXP_PT_0_IN2,
      I3 => NlwInverterSignal_refcnt_5_EXP_PT_0_IN3,
      I4 => NlwBufferSignal_refcnt_5_EXP_PT_0_IN4,
      I5 => NlwBufferSignal_refcnt_5_EXP_PT_0_IN5,
      I6 => NlwInverterSignal_refcnt_5_EXP_PT_0_IN6,
      I7 => NlwInverterSignal_refcnt_5_EXP_PT_0_IN7,
      I8 => NlwInverterSignal_refcnt_5_EXP_PT_0_IN8,
      I9 => NlwBufferSignal_refcnt_5_EXP_PT_0_IN9,
      I10 => NlwBufferSignal_refcnt_5_EXP_PT_0_IN10,
      I11 => NlwBufferSignal_refcnt_5_EXP_PT_0_IN11,
      I12 => NlwBufferSignal_refcnt_5_EXP_PT_0_IN12,
      I13 => NlwBufferSignal_refcnt_5_EXP_PT_0_IN13,
      I14 => NlwBufferSignal_refcnt_5_EXP_PT_0_IN14,
      I15 => NlwBufferSignal_refcnt_5_EXP_PT_0_IN15,
      O => refcnt_5_EXP_PT_0_335
    );
  refcnt_5_EXP_PT_1 : X_AND16
    port map (
      I0 => NlwInverterSignal_refcnt_5_EXP_PT_1_IN0,
      I1 => NlwBufferSignal_refcnt_5_EXP_PT_1_IN1,
      I2 => NlwInverterSignal_refcnt_5_EXP_PT_1_IN2,
      I3 => NlwInverterSignal_refcnt_5_EXP_PT_1_IN3,
      I4 => NlwBufferSignal_refcnt_5_EXP_PT_1_IN4,
      I5 => NlwBufferSignal_refcnt_5_EXP_PT_1_IN5,
      I6 => NlwInverterSignal_refcnt_5_EXP_PT_1_IN6,
      I7 => NlwInverterSignal_refcnt_5_EXP_PT_1_IN7,
      I8 => NlwInverterSignal_refcnt_5_EXP_PT_1_IN8,
      I9 => NlwBufferSignal_refcnt_5_EXP_PT_1_IN9,
      I10 => NlwBufferSignal_refcnt_5_EXP_PT_1_IN10,
      I11 => NlwBufferSignal_refcnt_5_EXP_PT_1_IN11,
      I12 => NlwBufferSignal_refcnt_5_EXP_PT_1_IN12,
      I13 => NlwBufferSignal_refcnt_5_EXP_PT_1_IN13,
      I14 => NlwBufferSignal_refcnt_5_EXP_PT_1_IN14,
      I15 => NlwBufferSignal_refcnt_5_EXP_PT_1_IN15,
      O => refcnt_5_EXP_PT_1_336
    );
  refcnt_5_EXP_PT_2 : X_AND16
    port map (
      I0 => NlwInverterSignal_refcnt_5_EXP_PT_2_IN0,
      I1 => NlwBufferSignal_refcnt_5_EXP_PT_2_IN1,
      I2 => NlwInverterSignal_refcnt_5_EXP_PT_2_IN2,
      I3 => NlwInverterSignal_refcnt_5_EXP_PT_2_IN3,
      I4 => NlwBufferSignal_refcnt_5_EXP_PT_2_IN4,
      I5 => NlwBufferSignal_refcnt_5_EXP_PT_2_IN5,
      I6 => NlwInverterSignal_refcnt_5_EXP_PT_2_IN6,
      I7 => NlwInverterSignal_refcnt_5_EXP_PT_2_IN7,
      I8 => NlwInverterSignal_refcnt_5_EXP_PT_2_IN8,
      I9 => NlwBufferSignal_refcnt_5_EXP_PT_2_IN9,
      I10 => NlwBufferSignal_refcnt_5_EXP_PT_2_IN10,
      I11 => NlwBufferSignal_refcnt_5_EXP_PT_2_IN11,
      I12 => NlwBufferSignal_refcnt_5_EXP_PT_2_IN12,
      I13 => NlwBufferSignal_refcnt_5_EXP_PT_2_IN13,
      I14 => NlwBufferSignal_refcnt_5_EXP_PT_2_IN14,
      I15 => NlwBufferSignal_refcnt_5_EXP_PT_2_IN15,
      O => refcnt_5_EXP_PT_2_337
    );
  refcnt_5_EXP_PT_3 : X_AND16
    port map (
      I0 => NlwInverterSignal_refcnt_5_EXP_PT_3_IN0,
      I1 => NlwBufferSignal_refcnt_5_EXP_PT_3_IN1,
      I2 => NlwInverterSignal_refcnt_5_EXP_PT_3_IN2,
      I3 => NlwInverterSignal_refcnt_5_EXP_PT_3_IN3,
      I4 => NlwBufferSignal_refcnt_5_EXP_PT_3_IN4,
      I5 => NlwBufferSignal_refcnt_5_EXP_PT_3_IN5,
      I6 => NlwInverterSignal_refcnt_5_EXP_PT_3_IN6,
      I7 => NlwInverterSignal_refcnt_5_EXP_PT_3_IN7,
      I8 => NlwInverterSignal_refcnt_5_EXP_PT_3_IN8,
      I9 => NlwBufferSignal_refcnt_5_EXP_PT_3_IN9,
      I10 => NlwBufferSignal_refcnt_5_EXP_PT_3_IN10,
      I11 => NlwBufferSignal_refcnt_5_EXP_PT_3_IN11,
      I12 => NlwBufferSignal_refcnt_5_EXP_PT_3_IN12,
      I13 => NlwBufferSignal_refcnt_5_EXP_PT_3_IN13,
      I14 => NlwBufferSignal_refcnt_5_EXP_PT_3_IN14,
      I15 => NlwBufferSignal_refcnt_5_EXP_PT_3_IN15,
      O => refcnt_5_EXP_PT_3_338
    );
  refcnt_5_EXP_tsimrenamed_net_Q : X_OR4
    port map (
      I0 => NlwBufferSignal_refcnt_5_EXP_tsimrenamed_net_IN0,
      I1 => NlwBufferSignal_refcnt_5_EXP_tsimrenamed_net_IN1,
      I2 => NlwBufferSignal_refcnt_5_EXP_tsimrenamed_net_IN2,
      I3 => NlwBufferSignal_refcnt_5_EXP_tsimrenamed_net_IN3,
      O => refcnt_5_EXP_tsimrenamed_net_Q_327
    );
  refcnt_6_Q : X_BUF
    port map (
      I => refcnt_6_Q_339,
      O => refcnt(6)
    );
  refcnt_6_EXP : X_BUF
    port map (
      I => refcnt_6_EXP_tsimrenamed_net_Q_340,
      O => refcnt_6_EXP_332
    );
  refcnt_6_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_refcnt_6_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_refcnt_6_tsimcreated_xor_IN1,
      O => refcnt_6_tsimcreated_xor_Q_342
    );
  refcnt_6_REG : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => NlwBufferSignal_refcnt_6_REG_IN,
      CE => Vcc_84,
      CLK => NlwBufferSignal_refcnt_6_REG_CLK,
      SET => Gnd_83,
      RST => Gnd_83,
      O => refcnt_6_Q_339
    );
  refcnt_6_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_refcnt_6_D_IN0,
      I1 => NlwBufferSignal_refcnt_6_D_IN1,
      O => refcnt_6_D_341
    );
  refcnt_6_D1 : X_ZERO
    port map (
      O => refcnt_6_D1_343
    );
  refcnt_6_D2_PT_0 : X_AND16
    port map (
      I0 => NlwInverterSignal_refcnt_6_D2_PT_0_IN0,
      I1 => NlwBufferSignal_refcnt_6_D2_PT_0_IN1,
      I2 => NlwBufferSignal_refcnt_6_D2_PT_0_IN2,
      I3 => NlwInverterSignal_refcnt_6_D2_PT_0_IN3,
      I4 => NlwInverterSignal_refcnt_6_D2_PT_0_IN4,
      I5 => NlwInverterSignal_refcnt_6_D2_PT_0_IN5,
      I6 => NlwInverterSignal_refcnt_6_D2_PT_0_IN6,
      I7 => NlwInverterSignal_refcnt_6_D2_PT_0_IN7,
      I8 => NlwInverterSignal_refcnt_6_D2_PT_0_IN8,
      I9 => NlwBufferSignal_refcnt_6_D2_PT_0_IN9,
      I10 => NlwBufferSignal_refcnt_6_D2_PT_0_IN10,
      I11 => NlwBufferSignal_refcnt_6_D2_PT_0_IN11,
      I12 => NlwBufferSignal_refcnt_6_D2_PT_0_IN12,
      I13 => NlwBufferSignal_refcnt_6_D2_PT_0_IN13,
      I14 => NlwBufferSignal_refcnt_6_D2_PT_0_IN14,
      I15 => NlwBufferSignal_refcnt_6_D2_PT_0_IN15,
      O => refcnt_6_D2_PT_0_345
    );
  refcnt_6_D2_PT_1 : X_AND16
    port map (
      I0 => NlwInverterSignal_refcnt_6_D2_PT_1_IN0,
      I1 => NlwBufferSignal_refcnt_6_D2_PT_1_IN1,
      I2 => NlwBufferSignal_refcnt_6_D2_PT_1_IN2,
      I3 => NlwInverterSignal_refcnt_6_D2_PT_1_IN3,
      I4 => NlwInverterSignal_refcnt_6_D2_PT_1_IN4,
      I5 => NlwInverterSignal_refcnt_6_D2_PT_1_IN5,
      I6 => NlwInverterSignal_refcnt_6_D2_PT_1_IN6,
      I7 => NlwInverterSignal_refcnt_6_D2_PT_1_IN7,
      I8 => NlwInverterSignal_refcnt_6_D2_PT_1_IN8,
      I9 => NlwBufferSignal_refcnt_6_D2_PT_1_IN9,
      I10 => NlwBufferSignal_refcnt_6_D2_PT_1_IN10,
      I11 => NlwBufferSignal_refcnt_6_D2_PT_1_IN11,
      I12 => NlwBufferSignal_refcnt_6_D2_PT_1_IN12,
      I13 => NlwBufferSignal_refcnt_6_D2_PT_1_IN13,
      I14 => NlwBufferSignal_refcnt_6_D2_PT_1_IN14,
      I15 => NlwBufferSignal_refcnt_6_D2_PT_1_IN15,
      O => refcnt_6_D2_PT_1_346
    );
  refcnt_6_D2 : X_OR2
    port map (
      I0 => NlwBufferSignal_refcnt_6_D2_IN0,
      I1 => NlwBufferSignal_refcnt_6_D2_IN1,
      O => refcnt_6_D2_344
    );
  refcnt_6_EXP_PT_0 : X_AND16
    port map (
      I0 => NlwInverterSignal_refcnt_6_EXP_PT_0_IN0,
      I1 => NlwBufferSignal_refcnt_6_EXP_PT_0_IN1,
      I2 => NlwBufferSignal_refcnt_6_EXP_PT_0_IN2,
      I3 => NlwInverterSignal_refcnt_6_EXP_PT_0_IN3,
      I4 => NlwInverterSignal_refcnt_6_EXP_PT_0_IN4,
      I5 => NlwInverterSignal_refcnt_6_EXP_PT_0_IN5,
      I6 => NlwInverterSignal_refcnt_6_EXP_PT_0_IN6,
      I7 => NlwInverterSignal_refcnt_6_EXP_PT_0_IN7,
      I8 => NlwBufferSignal_refcnt_6_EXP_PT_0_IN8,
      I9 => NlwBufferSignal_refcnt_6_EXP_PT_0_IN9,
      I10 => NlwBufferSignal_refcnt_6_EXP_PT_0_IN10,
      I11 => NlwBufferSignal_refcnt_6_EXP_PT_0_IN11,
      I12 => NlwBufferSignal_refcnt_6_EXP_PT_0_IN12,
      I13 => NlwBufferSignal_refcnt_6_EXP_PT_0_IN13,
      I14 => NlwBufferSignal_refcnt_6_EXP_PT_0_IN14,
      I15 => NlwBufferSignal_refcnt_6_EXP_PT_0_IN15,
      O => refcnt_6_EXP_PT_0_347
    );
  refcnt_6_EXP_PT_1 : X_AND16
    port map (
      I0 => NlwInverterSignal_refcnt_6_EXP_PT_1_IN0,
      I1 => NlwBufferSignal_refcnt_6_EXP_PT_1_IN1,
      I2 => NlwBufferSignal_refcnt_6_EXP_PT_1_IN2,
      I3 => NlwInverterSignal_refcnt_6_EXP_PT_1_IN3,
      I4 => NlwInverterSignal_refcnt_6_EXP_PT_1_IN4,
      I5 => NlwInverterSignal_refcnt_6_EXP_PT_1_IN5,
      I6 => NlwInverterSignal_refcnt_6_EXP_PT_1_IN6,
      I7 => NlwInverterSignal_refcnt_6_EXP_PT_1_IN7,
      I8 => NlwBufferSignal_refcnt_6_EXP_PT_1_IN8,
      I9 => NlwBufferSignal_refcnt_6_EXP_PT_1_IN9,
      I10 => NlwBufferSignal_refcnt_6_EXP_PT_1_IN10,
      I11 => NlwBufferSignal_refcnt_6_EXP_PT_1_IN11,
      I12 => NlwBufferSignal_refcnt_6_EXP_PT_1_IN12,
      I13 => NlwBufferSignal_refcnt_6_EXP_PT_1_IN13,
      I14 => NlwBufferSignal_refcnt_6_EXP_PT_1_IN14,
      I15 => NlwBufferSignal_refcnt_6_EXP_PT_1_IN15,
      O => refcnt_6_EXP_PT_1_348
    );
  refcnt_6_EXP_tsimrenamed_net_Q : X_OR2
    port map (
      I0 => NlwBufferSignal_refcnt_6_EXP_tsimrenamed_net_IN0,
      I1 => NlwBufferSignal_refcnt_6_EXP_tsimrenamed_net_IN1,
      O => refcnt_6_EXP_tsimrenamed_net_Q_340
    );
  refcnt_7_Q : X_BUF
    port map (
      I => refcnt_7_Q_349,
      O => refcnt(7)
    );
  refcnt_7_EXP : X_BUF
    port map (
      I => refcnt_7_EXP_tsimrenamed_net_Q_350,
      O => refcnt_7_EXP_154
    );
  refcnt_7_tsimcreated_xor_Q : X_XOR2
    port map (
      I0 => NlwBufferSignal_refcnt_7_tsimcreated_xor_IN0,
      I1 => NlwBufferSignal_refcnt_7_tsimcreated_xor_IN1,
      O => refcnt_7_tsimcreated_xor_Q_352
    );
  refcnt_7_REG : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NlwBufferSignal_refcnt_7_REG_IN,
      CE => Vcc_84,
      CLK => NlwBufferSignal_refcnt_7_REG_CLK,
      SET => Gnd_83,
      RST => Gnd_83,
      O => refcnt_7_Q_349
    );
  refcnt_7_D : X_XOR2
    port map (
      I0 => NlwBufferSignal_refcnt_7_D_IN0,
      I1 => NlwBufferSignal_refcnt_7_D_IN1,
      O => refcnt_7_D_351
    );
  refcnt_7_D1 : X_ZERO
    port map (
      O => refcnt_7_D1_353
    );
  refcnt_7_D2 : X_AND16
    port map (
      I0 => NlwInverterSignal_refcnt_7_D2_IN0,
      I1 => NlwBufferSignal_refcnt_7_D2_IN1,
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
      O => refcnt_7_D2_354
    );
  refcnt_7_EXP_PT_0 : X_AND16
    port map (
      I0 => NlwBufferSignal_refcnt_7_EXP_PT_0_IN0,
      I1 => NlwBufferSignal_refcnt_7_EXP_PT_0_IN1,
      I2 => NlwInverterSignal_refcnt_7_EXP_PT_0_IN2,
      I3 => NlwInverterSignal_refcnt_7_EXP_PT_0_IN3,
      I4 => NlwBufferSignal_refcnt_7_EXP_PT_0_IN4,
      I5 => NlwBufferSignal_refcnt_7_EXP_PT_0_IN5,
      I6 => NlwInverterSignal_refcnt_7_EXP_PT_0_IN6,
      I7 => NlwInverterSignal_refcnt_7_EXP_PT_0_IN7,
      I8 => NlwInverterSignal_refcnt_7_EXP_PT_0_IN8,
      I9 => NlwBufferSignal_refcnt_7_EXP_PT_0_IN9,
      I10 => NlwBufferSignal_refcnt_7_EXP_PT_0_IN10,
      I11 => NlwBufferSignal_refcnt_7_EXP_PT_0_IN11,
      I12 => NlwBufferSignal_refcnt_7_EXP_PT_0_IN12,
      I13 => NlwBufferSignal_refcnt_7_EXP_PT_0_IN13,
      I14 => NlwBufferSignal_refcnt_7_EXP_PT_0_IN14,
      I15 => NlwBufferSignal_refcnt_7_EXP_PT_0_IN15,
      O => refcnt_7_EXP_PT_0_355
    );
  refcnt_7_EXP_PT_1 : X_AND16
    port map (
      I0 => NlwBufferSignal_refcnt_7_EXP_PT_1_IN0,
      I1 => NlwBufferSignal_refcnt_7_EXP_PT_1_IN1,
      I2 => NlwInverterSignal_refcnt_7_EXP_PT_1_IN2,
      I3 => NlwInverterSignal_refcnt_7_EXP_PT_1_IN3,
      I4 => NlwBufferSignal_refcnt_7_EXP_PT_1_IN4,
      I5 => NlwBufferSignal_refcnt_7_EXP_PT_1_IN5,
      I6 => NlwInverterSignal_refcnt_7_EXP_PT_1_IN6,
      I7 => NlwInverterSignal_refcnt_7_EXP_PT_1_IN7,
      I8 => NlwInverterSignal_refcnt_7_EXP_PT_1_IN8,
      I9 => NlwBufferSignal_refcnt_7_EXP_PT_1_IN9,
      I10 => NlwBufferSignal_refcnt_7_EXP_PT_1_IN10,
      I11 => NlwBufferSignal_refcnt_7_EXP_PT_1_IN11,
      I12 => NlwBufferSignal_refcnt_7_EXP_PT_1_IN12,
      I13 => NlwBufferSignal_refcnt_7_EXP_PT_1_IN13,
      I14 => NlwBufferSignal_refcnt_7_EXP_PT_1_IN14,
      I15 => NlwBufferSignal_refcnt_7_EXP_PT_1_IN15,
      O => refcnt_7_EXP_PT_1_356
    );
  refcnt_7_EXP_PT_2 : X_AND16
    port map (
      I0 => NlwBufferSignal_refcnt_7_EXP_PT_2_IN0,
      I1 => NlwBufferSignal_refcnt_7_EXP_PT_2_IN1,
      I2 => NlwInverterSignal_refcnt_7_EXP_PT_2_IN2,
      I3 => NlwInverterSignal_refcnt_7_EXP_PT_2_IN3,
      I4 => NlwBufferSignal_refcnt_7_EXP_PT_2_IN4,
      I5 => NlwBufferSignal_refcnt_7_EXP_PT_2_IN5,
      I6 => NlwInverterSignal_refcnt_7_EXP_PT_2_IN6,
      I7 => NlwInverterSignal_refcnt_7_EXP_PT_2_IN7,
      I8 => NlwInverterSignal_refcnt_7_EXP_PT_2_IN8,
      I9 => NlwBufferSignal_refcnt_7_EXP_PT_2_IN9,
      I10 => NlwBufferSignal_refcnt_7_EXP_PT_2_IN10,
      I11 => NlwBufferSignal_refcnt_7_EXP_PT_2_IN11,
      I12 => NlwBufferSignal_refcnt_7_EXP_PT_2_IN12,
      I13 => NlwBufferSignal_refcnt_7_EXP_PT_2_IN13,
      I14 => NlwBufferSignal_refcnt_7_EXP_PT_2_IN14,
      I15 => NlwBufferSignal_refcnt_7_EXP_PT_2_IN15,
      O => refcnt_7_EXP_PT_2_357
    );
  refcnt_7_EXP_PT_3 : X_AND16
    port map (
      I0 => NlwBufferSignal_refcnt_7_EXP_PT_3_IN0,
      I1 => NlwBufferSignal_refcnt_7_EXP_PT_3_IN1,
      I2 => NlwInverterSignal_refcnt_7_EXP_PT_3_IN2,
      I3 => NlwInverterSignal_refcnt_7_EXP_PT_3_IN3,
      I4 => NlwBufferSignal_refcnt_7_EXP_PT_3_IN4,
      I5 => NlwBufferSignal_refcnt_7_EXP_PT_3_IN5,
      I6 => NlwInverterSignal_refcnt_7_EXP_PT_3_IN6,
      I7 => NlwInverterSignal_refcnt_7_EXP_PT_3_IN7,
      I8 => NlwInverterSignal_refcnt_7_EXP_PT_3_IN8,
      I9 => NlwBufferSignal_refcnt_7_EXP_PT_3_IN9,
      I10 => NlwBufferSignal_refcnt_7_EXP_PT_3_IN10,
      I11 => NlwBufferSignal_refcnt_7_EXP_PT_3_IN11,
      I12 => NlwBufferSignal_refcnt_7_EXP_PT_3_IN12,
      I13 => NlwBufferSignal_refcnt_7_EXP_PT_3_IN13,
      I14 => NlwBufferSignal_refcnt_7_EXP_PT_3_IN14,
      I15 => NlwBufferSignal_refcnt_7_EXP_PT_3_IN15,
      O => refcnt_7_EXP_PT_3_358
    );
  refcnt_7_EXP_tsimrenamed_net_Q : X_OR4
    port map (
      I0 => NlwBufferSignal_refcnt_7_EXP_tsimrenamed_net_IN0,
      I1 => NlwBufferSignal_refcnt_7_EXP_tsimrenamed_net_IN1,
      I2 => NlwBufferSignal_refcnt_7_EXP_tsimrenamed_net_IN2,
      I3 => NlwBufferSignal_refcnt_7_EXP_tsimrenamed_net_IN3,
      O => refcnt_7_EXP_tsimrenamed_net_Q_350
    );
  EXP0_EXP : X_BUF
    port map (
      I => EXP0_EXP_tsimrenamed_net_Q_359,
      O => EXP0_EXP_221
    );
  EXP0_EXP_PT_0 : X_AND3
    port map (
      I0 => NlwBufferSignal_EXP0_EXP_PT_0_IN0,
      I1 => NlwInverterSignal_EXP0_EXP_PT_0_IN1,
      I2 => NlwBufferSignal_EXP0_EXP_PT_0_IN2,
      O => EXP0_EXP_PT_0_360
    );
  EXP0_EXP_PT_1 : X_AND16
    port map (
      I0 => NlwInverterSignal_EXP0_EXP_PT_1_IN0,
      I1 => NlwBufferSignal_EXP0_EXP_PT_1_IN1,
      I2 => NlwBufferSignal_EXP0_EXP_PT_1_IN2,
      I3 => NlwInverterSignal_EXP0_EXP_PT_1_IN3,
      I4 => NlwInverterSignal_EXP0_EXP_PT_1_IN4,
      I5 => NlwInverterSignal_EXP0_EXP_PT_1_IN5,
      I6 => NlwInverterSignal_EXP0_EXP_PT_1_IN6,
      I7 => NlwInverterSignal_EXP0_EXP_PT_1_IN7,
      I8 => NlwInverterSignal_EXP0_EXP_PT_1_IN8,
      I9 => NlwInverterSignal_EXP0_EXP_PT_1_IN9,
      I10 => NlwInverterSignal_EXP0_EXP_PT_1_IN10,
      I11 => NlwInverterSignal_EXP0_EXP_PT_1_IN11,
      I12 => NlwInverterSignal_EXP0_EXP_PT_1_IN12,
      I13 => NlwInverterSignal_EXP0_EXP_PT_1_IN13,
      I14 => NlwBufferSignal_EXP0_EXP_PT_1_IN14,
      I15 => NlwBufferSignal_EXP0_EXP_PT_1_IN15,
      O => EXP0_EXP_PT_1_361
    );
  EXP0_EXP_tsimrenamed_net_Q : X_OR2
    port map (
      I0 => NlwBufferSignal_EXP0_EXP_tsimrenamed_net_IN0,
      I1 => NlwBufferSignal_EXP0_EXP_tsimrenamed_net_IN1,
      O => EXP0_EXP_tsimrenamed_net_Q_359
    );
  EXP1_EXP : X_BUF
    port map (
      I => EXP1_EXP_tsimrenamed_net_Q_362,
      O => EXP1_EXP_96
    );
  EXP1_EXP_PT_0 : X_AND3
    port map (
      I0 => NlwBufferSignal_EXP1_EXP_PT_0_IN0,
      I1 => NlwInverterSignal_EXP1_EXP_PT_0_IN1,
      I2 => NlwInverterSignal_EXP1_EXP_PT_0_IN2,
      O => EXP1_EXP_PT_0_363
    );
  EXP1_EXP_PT_1 : X_AND16
    port map (
      I0 => NlwInverterSignal_EXP1_EXP_PT_1_IN0,
      I1 => NlwBufferSignal_EXP1_EXP_PT_1_IN1,
      I2 => NlwBufferSignal_EXP1_EXP_PT_1_IN2,
      I3 => NlwInverterSignal_EXP1_EXP_PT_1_IN3,
      I4 => NlwInverterSignal_EXP1_EXP_PT_1_IN4,
      I5 => NlwInverterSignal_EXP1_EXP_PT_1_IN5,
      I6 => NlwInverterSignal_EXP1_EXP_PT_1_IN6,
      I7 => NlwInverterSignal_EXP1_EXP_PT_1_IN7,
      I8 => NlwInverterSignal_EXP1_EXP_PT_1_IN8,
      I9 => NlwInverterSignal_EXP1_EXP_PT_1_IN9,
      I10 => NlwInverterSignal_EXP1_EXP_PT_1_IN10,
      I11 => NlwInverterSignal_EXP1_EXP_PT_1_IN11,
      I12 => NlwInverterSignal_EXP1_EXP_PT_1_IN12,
      I13 => NlwInverterSignal_EXP1_EXP_PT_1_IN13,
      I14 => NlwBufferSignal_EXP1_EXP_PT_1_IN14,
      I15 => NlwBufferSignal_EXP1_EXP_PT_1_IN15,
      O => EXP1_EXP_PT_1_364
    );
  EXP1_EXP_tsimrenamed_net_Q : X_OR2
    port map (
      I0 => NlwBufferSignal_EXP1_EXP_tsimrenamed_net_IN0,
      I1 => NlwBufferSignal_EXP1_EXP_tsimrenamed_net_IN1,
      O => EXP1_EXP_tsimrenamed_net_Q_362
    );
  EXP2_EXP : X_BUF
    port map (
      I => EXP2_EXP_tsimrenamed_net_Q_365,
      O => EXP2_EXP_232
    );
  EXP2_EXP_tsimrenamed_net_Q : X_AND16
    port map (
      I0 => NlwInverterSignal_EXP2_EXP_tsimrenamed_net_IN0,
      I1 => NlwInverterSignal_EXP2_EXP_tsimrenamed_net_IN1,
      I2 => NlwInverterSignal_EXP2_EXP_tsimrenamed_net_IN2,
      I3 => NlwInverterSignal_EXP2_EXP_tsimrenamed_net_IN3,
      I4 => NlwInverterSignal_EXP2_EXP_tsimrenamed_net_IN4,
      I5 => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN5,
      I6 => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN6,
      I7 => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN7,
      I8 => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN8,
      I9 => NlwInverterSignal_EXP2_EXP_tsimrenamed_net_IN9,
      I10 => NlwInverterSignal_EXP2_EXP_tsimrenamed_net_IN10,
      I11 => NlwInverterSignal_EXP2_EXP_tsimrenamed_net_IN11,
      I12 => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN12,
      I13 => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN13,
      I14 => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN14,
      I15 => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN15,
      O => EXP2_EXP_tsimrenamed_net_Q_365
    );
  EXP3_EXP : X_BUF
    port map (
      I => EXP3_EXP_tsimrenamed_net_Q_366,
      O => EXP3_EXP_112
    );
  EXP3_EXP_PT_0 : X_AND16
    port map (
      I0 => NlwInverterSignal_EXP3_EXP_PT_0_IN0,
      I1 => NlwInverterSignal_EXP3_EXP_PT_0_IN1,
      I2 => NlwInverterSignal_EXP3_EXP_PT_0_IN2,
      I3 => NlwInverterSignal_EXP3_EXP_PT_0_IN3,
      I4 => NlwBufferSignal_EXP3_EXP_PT_0_IN4,
      I5 => NlwBufferSignal_EXP3_EXP_PT_0_IN5,
      I6 => NlwInverterSignal_EXP3_EXP_PT_0_IN6,
      I7 => NlwInverterSignal_EXP3_EXP_PT_0_IN7,
      I8 => NlwInverterSignal_EXP3_EXP_PT_0_IN8,
      I9 => NlwBufferSignal_EXP3_EXP_PT_0_IN9,
      I10 => NlwBufferSignal_EXP3_EXP_PT_0_IN10,
      I11 => NlwBufferSignal_EXP3_EXP_PT_0_IN11,
      I12 => NlwBufferSignal_EXP3_EXP_PT_0_IN12,
      I13 => NlwBufferSignal_EXP3_EXP_PT_0_IN13,
      I14 => NlwBufferSignal_EXP3_EXP_PT_0_IN14,
      I15 => NlwBufferSignal_EXP3_EXP_PT_0_IN15,
      O => EXP3_EXP_PT_0_367
    );
  EXP3_EXP_PT_1 : X_AND16
    port map (
      I0 => NlwInverterSignal_EXP3_EXP_PT_1_IN0,
      I1 => NlwInverterSignal_EXP3_EXP_PT_1_IN1,
      I2 => NlwInverterSignal_EXP3_EXP_PT_1_IN2,
      I3 => NlwInverterSignal_EXP3_EXP_PT_1_IN3,
      I4 => NlwBufferSignal_EXP3_EXP_PT_1_IN4,
      I5 => NlwBufferSignal_EXP3_EXP_PT_1_IN5,
      I6 => NlwInverterSignal_EXP3_EXP_PT_1_IN6,
      I7 => NlwInverterSignal_EXP3_EXP_PT_1_IN7,
      I8 => NlwInverterSignal_EXP3_EXP_PT_1_IN8,
      I9 => NlwBufferSignal_EXP3_EXP_PT_1_IN9,
      I10 => NlwBufferSignal_EXP3_EXP_PT_1_IN10,
      I11 => NlwBufferSignal_EXP3_EXP_PT_1_IN11,
      I12 => NlwBufferSignal_EXP3_EXP_PT_1_IN12,
      I13 => NlwBufferSignal_EXP3_EXP_PT_1_IN13,
      I14 => NlwBufferSignal_EXP3_EXP_PT_1_IN14,
      I15 => NlwBufferSignal_EXP3_EXP_PT_1_IN15,
      O => EXP3_EXP_PT_1_368
    );
  EXP3_EXP_PT_2 : X_AND16
    port map (
      I0 => NlwInverterSignal_EXP3_EXP_PT_2_IN0,
      I1 => NlwInverterSignal_EXP3_EXP_PT_2_IN1,
      I2 => NlwInverterSignal_EXP3_EXP_PT_2_IN2,
      I3 => NlwInverterSignal_EXP3_EXP_PT_2_IN3,
      I4 => NlwBufferSignal_EXP3_EXP_PT_2_IN4,
      I5 => NlwBufferSignal_EXP3_EXP_PT_2_IN5,
      I6 => NlwInverterSignal_EXP3_EXP_PT_2_IN6,
      I7 => NlwInverterSignal_EXP3_EXP_PT_2_IN7,
      I8 => NlwInverterSignal_EXP3_EXP_PT_2_IN8,
      I9 => NlwBufferSignal_EXP3_EXP_PT_2_IN9,
      I10 => NlwBufferSignal_EXP3_EXP_PT_2_IN10,
      I11 => NlwBufferSignal_EXP3_EXP_PT_2_IN11,
      I12 => NlwBufferSignal_EXP3_EXP_PT_2_IN12,
      I13 => NlwBufferSignal_EXP3_EXP_PT_2_IN13,
      I14 => NlwBufferSignal_EXP3_EXP_PT_2_IN14,
      I15 => NlwBufferSignal_EXP3_EXP_PT_2_IN15,
      O => EXP3_EXP_PT_2_369
    );
  EXP3_EXP_PT_3 : X_AND16
    port map (
      I0 => NlwInverterSignal_EXP3_EXP_PT_3_IN0,
      I1 => NlwInverterSignal_EXP3_EXP_PT_3_IN1,
      I2 => NlwInverterSignal_EXP3_EXP_PT_3_IN2,
      I3 => NlwInverterSignal_EXP3_EXP_PT_3_IN3,
      I4 => NlwBufferSignal_EXP3_EXP_PT_3_IN4,
      I5 => NlwBufferSignal_EXP3_EXP_PT_3_IN5,
      I6 => NlwInverterSignal_EXP3_EXP_PT_3_IN6,
      I7 => NlwInverterSignal_EXP3_EXP_PT_3_IN7,
      I8 => NlwInverterSignal_EXP3_EXP_PT_3_IN8,
      I9 => NlwBufferSignal_EXP3_EXP_PT_3_IN9,
      I10 => NlwBufferSignal_EXP3_EXP_PT_3_IN10,
      I11 => NlwBufferSignal_EXP3_EXP_PT_3_IN11,
      I12 => NlwBufferSignal_EXP3_EXP_PT_3_IN12,
      I13 => NlwBufferSignal_EXP3_EXP_PT_3_IN13,
      I14 => NlwBufferSignal_EXP3_EXP_PT_3_IN14,
      I15 => NlwBufferSignal_EXP3_EXP_PT_3_IN15,
      O => EXP3_EXP_PT_3_370
    );
  EXP3_EXP_PT_4 : X_AND16
    port map (
      I0 => NlwInverterSignal_EXP3_EXP_PT_4_IN0,
      I1 => NlwInverterSignal_EXP3_EXP_PT_4_IN1,
      I2 => NlwInverterSignal_EXP3_EXP_PT_4_IN2,
      I3 => NlwInverterSignal_EXP3_EXP_PT_4_IN3,
      I4 => NlwBufferSignal_EXP3_EXP_PT_4_IN4,
      I5 => NlwBufferSignal_EXP3_EXP_PT_4_IN5,
      I6 => NlwInverterSignal_EXP3_EXP_PT_4_IN6,
      I7 => NlwInverterSignal_EXP3_EXP_PT_4_IN7,
      I8 => NlwInverterSignal_EXP3_EXP_PT_4_IN8,
      I9 => NlwBufferSignal_EXP3_EXP_PT_4_IN9,
      I10 => NlwBufferSignal_EXP3_EXP_PT_4_IN10,
      I11 => NlwBufferSignal_EXP3_EXP_PT_4_IN11,
      I12 => NlwBufferSignal_EXP3_EXP_PT_4_IN12,
      I13 => NlwBufferSignal_EXP3_EXP_PT_4_IN13,
      I14 => NlwBufferSignal_EXP3_EXP_PT_4_IN14,
      I15 => NlwBufferSignal_EXP3_EXP_PT_4_IN15,
      O => EXP3_EXP_PT_4_371
    );
  EXP3_EXP_tsimrenamed_net_Q : X_OR5
    port map (
      I0 => NlwBufferSignal_EXP3_EXP_tsimrenamed_net_IN0,
      I1 => NlwBufferSignal_EXP3_EXP_tsimrenamed_net_IN1,
      I2 => NlwBufferSignal_EXP3_EXP_tsimrenamed_net_IN2,
      I3 => NlwBufferSignal_EXP3_EXP_tsimrenamed_net_IN3,
      I4 => NlwBufferSignal_EXP3_EXP_tsimrenamed_net_IN4,
      O => EXP3_EXP_tsimrenamed_net_Q_366
    );
  NlwBufferBlock_rom_OBUF_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => rom_OBUF_D_81,
      O => NlwBufferSignal_rom_OBUF_tsimcreated_xor_IN0
    );
  NlwBufferBlock_rom_OBUF_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => rom_OBUF_Q_80,
      O => NlwBufferSignal_rom_OBUF_tsimcreated_xor_IN1
    );
  NlwBufferBlock_rom_OBUF_REG_IN : X_BUF
    port map (
      I => rom_OBUF_tsimcreated_xor_Q_82,
      O => NlwBufferSignal_rom_OBUF_REG_IN
    );
  NlwBufferBlock_rom_OBUF_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_rom_OBUF_REG_CLK
    );
  NlwBufferBlock_rom_OBUF_D_IN0 : X_BUF
    port map (
      I => rom_OBUF_D1_85,
      O => NlwBufferSignal_rom_OBUF_D_IN0
    );
  NlwBufferBlock_rom_OBUF_D_IN1 : X_BUF
    port map (
      I => rom_OBUF_D2_86,
      O => NlwBufferSignal_rom_OBUF_D_IN1
    );
  NlwBufferBlock_rom_OBUF_D2_PT_0_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_rom_OBUF_D2_PT_0_IN0
    );
  NlwBufferBlock_rom_OBUF_D2_PT_0_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_rom_OBUF_D2_PT_0_IN1
    );
  NlwBufferBlock_rom_OBUF_D2_PT_0_IN2 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_rom_OBUF_D2_PT_0_IN2
    );
  NlwBufferBlock_rom_OBUF_D2_PT_0_IN3 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_rom_OBUF_D2_PT_0_IN3
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN0 : X_BUF
    port map (
      I => bank_4_IBUF_1,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN0
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN1 : X_BUF
    port map (
      I => bank_3_IBUF_3,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN1
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN2 : X_BUF
    port map (
      I => bank_2_IBUF_5,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN2
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN3 : X_BUF
    port map (
      I => bank_1_IBUF_7,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN3
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN4 : X_BUF
    port map (
      I => bank_0_IBUF_9,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN4
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN5 : X_BUF
    port map (
      I => a15_13_2_IBUF_11,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN5
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN6 : X_BUF
    port map (
      I => a15_13_1_IBUF_13,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN6
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN7 : X_BUF
    port map (
      I => a15_13_0_IBUF_15,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN7
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN8 : X_BUF
    port map (
      I => rw_IBUF_17,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN8
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN9 : X_BUF
    port map (
      I => bank_6_IBUF_19,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN9
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN10 : X_BUF
    port map (
      I => bank_5_IBUF_21,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN10
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN11 : X_BUF
    port map (
      I => bank_7_IBUF_23,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN11
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN12 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN12
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN13 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN13
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN14 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN14
    );
  NlwBufferBlock_rom_OBUF_D2_PT_1_IN15 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_rom_OBUF_D2_PT_1_IN15
    );
  NlwBufferBlock_rom_OBUF_D2_IN0 : X_BUF
    port map (
      I => rom_OBUF_D2_PT_0_90,
      O => NlwBufferSignal_rom_OBUF_D2_IN0
    );
  NlwBufferBlock_rom_OBUF_D2_IN1 : X_BUF
    port map (
      I => rom_OBUF_D2_PT_1_91,
      O => NlwBufferSignal_rom_OBUF_D2_IN1
    );
  NlwBufferBlock_phi1_OBUF_REG_IN : X_BUF
    port map (
      I => phi1_OBUF_D_93,
      O => NlwBufferSignal_phi1_OBUF_REG_IN
    );
  NlwBufferBlock_phi1_OBUF_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_phi1_OBUF_REG_CLK
    );
  NlwBufferBlock_phi1_OBUF_D_IN0 : X_BUF
    port map (
      I => phi1_OBUF_D1_94,
      O => NlwBufferSignal_phi1_OBUF_D_IN0
    );
  NlwBufferBlock_phi1_OBUF_D_IN1 : X_BUF
    port map (
      I => phi1_OBUF_D2_95,
      O => NlwBufferSignal_phi1_OBUF_D_IN1
    );
  NlwBufferBlock_phi1_OBUF_D2_PT_0_IN0 : X_BUF
    port map (
      I => EXP1_EXP_96,
      O => NlwBufferSignal_phi1_OBUF_D2_PT_0_IN0
    );
  NlwBufferBlock_phi1_OBUF_D2_PT_0_IN1 : X_BUF
    port map (
      I => EXP1_EXP_96,
      O => NlwBufferSignal_phi1_OBUF_D2_PT_0_IN1
    );
  NlwBufferBlock_phi1_OBUF_D2_PT_1_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_phi1_OBUF_D2_PT_1_IN0
    );
  NlwBufferBlock_phi1_OBUF_D2_PT_1_IN1 : X_BUF
    port map (
      I => phi1_PIN_BUF_Q_35,
      O => NlwBufferSignal_phi1_OBUF_D2_PT_1_IN1
    );
  NlwBufferBlock_phi1_OBUF_D2_PT_2_IN0 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_phi1_OBUF_D2_PT_2_IN0
    );
  NlwBufferBlock_phi1_OBUF_D2_PT_2_IN1 : X_BUF
    port map (
      I => phi1_PIN_BUF_Q_35,
      O => NlwBufferSignal_phi1_OBUF_D2_PT_2_IN1
    );
  NlwBufferBlock_phi1_OBUF_D2_PT_3_IN0 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_phi1_OBUF_D2_PT_3_IN0
    );
  NlwBufferBlock_phi1_OBUF_D2_PT_3_IN1 : X_BUF
    port map (
      I => phi1_PIN_BUF_Q_35,
      O => NlwBufferSignal_phi1_OBUF_D2_PT_3_IN1
    );
  NlwBufferBlock_phi1_OBUF_D2_PT_4_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_phi1_OBUF_D2_PT_4_IN0
    );
  NlwBufferBlock_phi1_OBUF_D2_PT_4_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_phi1_OBUF_D2_PT_4_IN1
    );
  NlwBufferBlock_phi1_OBUF_D2_PT_4_IN2 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_phi1_OBUF_D2_PT_4_IN2
    );
  NlwBufferBlock_phi1_OBUF_D2_PT_5_IN0 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_phi1_OBUF_D2_PT_5_IN0
    );
  NlwBufferBlock_phi1_OBUF_D2_PT_5_IN1 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_phi1_OBUF_D2_PT_5_IN1
    );
  NlwBufferBlock_phi1_OBUF_D2_PT_5_IN2 : X_BUF
    port map (
      I => phi1_PIN_BUF_Q_35,
      O => NlwBufferSignal_phi1_OBUF_D2_PT_5_IN2
    );
  NlwBufferBlock_phi1_OBUF_D2_IN0 : X_BUF
    port map (
      I => phi1_OBUF_D2_PT_0_97,
      O => NlwBufferSignal_phi1_OBUF_D2_IN0
    );
  NlwBufferBlock_phi1_OBUF_D2_IN1 : X_BUF
    port map (
      I => phi1_OBUF_D2_PT_1_98,
      O => NlwBufferSignal_phi1_OBUF_D2_IN1
    );
  NlwBufferBlock_phi1_OBUF_D2_IN2 : X_BUF
    port map (
      I => phi1_OBUF_D2_PT_2_99,
      O => NlwBufferSignal_phi1_OBUF_D2_IN2
    );
  NlwBufferBlock_phi1_OBUF_D2_IN3 : X_BUF
    port map (
      I => phi1_OBUF_D2_PT_3_101,
      O => NlwBufferSignal_phi1_OBUF_D2_IN3
    );
  NlwBufferBlock_phi1_OBUF_D2_IN4 : X_BUF
    port map (
      I => phi1_OBUF_D2_PT_4_102,
      O => NlwBufferSignal_phi1_OBUF_D2_IN4
    );
  NlwBufferBlock_phi1_OBUF_D2_IN5 : X_BUF
    port map (
      I => phi1_OBUF_D2_PT_5_105,
      O => NlwBufferSignal_phi1_OBUF_D2_IN5
    );
  NlwBufferBlock_cas0_OBUF_REG_IN : X_BUF
    port map (
      I => cas0_OBUF_D_107,
      O => NlwBufferSignal_cas0_OBUF_REG_IN
    );
  NlwBufferBlock_cas0_OBUF_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_cas0_OBUF_REG_CLK
    );
  NlwBufferBlock_cas0_OBUF_D_IN0 : X_BUF
    port map (
      I => cas0_OBUF_D1_108,
      O => NlwBufferSignal_cas0_OBUF_D_IN0
    );
  NlwBufferBlock_cas0_OBUF_D_IN1 : X_BUF
    port map (
      I => cas0_OBUF_D2_109,
      O => NlwBufferSignal_cas0_OBUF_D_IN1
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_0_IN0 : X_BUF
    port map (
      I => refcnt_1_EXP_110,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_0_IN0
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_0_IN1 : X_BUF
    port map (
      I => refcnt_1_EXP_110,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_0_IN1
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_1_IN0 : X_BUF
    port map (
      I => EXP3_EXP_112,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_1_IN0
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_1_IN1 : X_BUF
    port map (
      I => EXP3_EXP_112,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_1_IN1
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_2_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_2_IN0
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_2_IN1 : X_BUF
    port map (
      I => cas0_PIN_BUF_Q_37,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_2_IN1
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_3_IN0 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_3_IN0
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_3_IN1 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_3_IN1
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_3_IN2 : X_BUF
    port map (
      I => cas0_PIN_BUF_Q_37,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_3_IN2
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_4_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN0
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_4_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN1
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_4_IN2 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN2
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_4_IN3 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN3
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_4_IN4 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN4
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_4_IN5 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN5
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_4_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN6
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_4_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN7
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_4_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN8
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_4_IN9 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN9
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_4_IN10 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN10
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_4_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN11
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_4_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN12
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_4_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN13
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_4_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN14
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_4_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN15
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_5_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN0
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_5_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN1
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_5_IN2 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN2
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_5_IN3 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN3
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_5_IN4 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN4
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_5_IN5 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN5
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_5_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN6
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_5_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN7
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_5_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN8
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_5_IN9 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN9
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_5_IN10 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN10
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_5_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN11
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_5_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN12
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_5_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN13
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_5_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN14
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_5_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN15
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_6_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN0
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_6_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN1
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_6_IN2 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN2
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_6_IN3 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN3
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_6_IN4 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN4
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_6_IN5 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN5
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_6_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN6
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_6_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN7
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_6_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN8
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_6_IN9 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN9
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_6_IN10 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN10
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_6_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN11
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_6_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN12
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_6_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN13
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_6_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN14
    );
  NlwBufferBlock_cas0_OBUF_D2_PT_6_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN15
    );
  NlwBufferBlock_cas0_OBUF_D2_IN0 : X_BUF
    port map (
      I => cas0_OBUF_D2_PT_0_111,
      O => NlwBufferSignal_cas0_OBUF_D2_IN0
    );
  NlwBufferBlock_cas0_OBUF_D2_IN1 : X_BUF
    port map (
      I => cas0_OBUF_D2_PT_1_113,
      O => NlwBufferSignal_cas0_OBUF_D2_IN1
    );
  NlwBufferBlock_cas0_OBUF_D2_IN2 : X_BUF
    port map (
      I => cas0_OBUF_D2_PT_2_114,
      O => NlwBufferSignal_cas0_OBUF_D2_IN2
    );
  NlwBufferBlock_cas0_OBUF_D2_IN3 : X_BUF
    port map (
      I => cas0_OBUF_D2_PT_3_115,
      O => NlwBufferSignal_cas0_OBUF_D2_IN3
    );
  NlwBufferBlock_cas0_OBUF_D2_IN4 : X_BUF
    port map (
      I => cas0_OBUF_D2_PT_4_117,
      O => NlwBufferSignal_cas0_OBUF_D2_IN4
    );
  NlwBufferBlock_cas0_OBUF_D2_IN5 : X_BUF
    port map (
      I => cas0_OBUF_D2_PT_5_119,
      O => NlwBufferSignal_cas0_OBUF_D2_IN5
    );
  NlwBufferBlock_cas0_OBUF_D2_IN6 : X_BUF
    port map (
      I => cas0_OBUF_D2_PT_6_121,
      O => NlwBufferSignal_cas0_OBUF_D2_IN6
    );
  NlwBufferBlock_cas1_OBUF_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => cas1_OBUF_D_123,
      O => NlwBufferSignal_cas1_OBUF_tsimcreated_xor_IN0
    );
  NlwBufferBlock_cas1_OBUF_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => cas1_OBUF_Q_122,
      O => NlwBufferSignal_cas1_OBUF_tsimcreated_xor_IN1
    );
  NlwBufferBlock_cas1_OBUF_REG_IN : X_BUF
    port map (
      I => cas1_OBUF_tsimcreated_xor_Q_124,
      O => NlwBufferSignal_cas1_OBUF_REG_IN
    );
  NlwBufferBlock_cas1_OBUF_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_cas1_OBUF_REG_CLK
    );
  NlwBufferBlock_cas1_OBUF_D_IN0 : X_BUF
    port map (
      I => cas1_OBUF_D1_125,
      O => NlwBufferSignal_cas1_OBUF_D_IN0
    );
  NlwBufferBlock_cas1_OBUF_D_IN1 : X_BUF
    port map (
      I => cas1_OBUF_D2_126,
      O => NlwBufferSignal_cas1_OBUF_D_IN1
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_0_IN0 : X_BUF
    port map (
      I => refcnt_5_EXP_127,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_0_IN0
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_0_IN1 : X_BUF
    port map (
      I => refcnt_5_EXP_127,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_0_IN1
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_1_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_cas1_OBUF_D2_PT_1_IN0
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_1_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_cas1_OBUF_D2_PT_1_IN1
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_1_IN2 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_cas1_OBUF_D2_PT_1_IN2
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_1_IN3 : X_BUF
    port map (
      I => cas1_PIN_BUF_Q_39,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_1_IN3
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_2_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN0
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_2_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN1
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_2_IN2 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN2
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_2_IN3 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN3
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_2_IN4 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN4
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_2_IN5 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN5
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_2_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN6
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_2_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN7
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_2_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN8
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_2_IN9 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN9
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_2_IN10 : X_BUF
    port map (
      I => cas1_PIN_BUF_Q_39,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN10
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_2_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN11
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_2_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN12
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_2_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN13
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_2_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN14
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_2_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN15
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_3_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN0
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_3_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN1
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_3_IN2 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN2
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_3_IN3 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN3
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_3_IN4 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN4
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_3_IN5 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN5
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_3_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN6
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_3_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN7
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_3_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN8
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_3_IN9 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN9
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_3_IN10 : X_BUF
    port map (
      I => cas1_PIN_BUF_Q_39,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN10
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_3_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN11
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_3_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN12
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_3_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN13
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_3_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN14
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_3_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN15
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_4_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_4_IN0
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_4_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_4_IN1
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_4_IN2 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_cas1_OBUF_D2_PT_4_IN2
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_4_IN3 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_cas1_OBUF_D2_PT_4_IN3
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_4_IN4 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_cas1_OBUF_D2_PT_4_IN4
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_4_IN5 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_4_IN5
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_4_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_cas1_OBUF_D2_PT_4_IN6
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_4_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_cas1_OBUF_D2_PT_4_IN7
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_4_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_cas1_OBUF_D2_PT_4_IN8
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_4_IN9 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_cas1_OBUF_D2_PT_4_IN9
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_4_IN10 : X_BUF
    port map (
      I => cas1_PIN_BUF_Q_39,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_4_IN10
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_4_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_4_IN11
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_4_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_4_IN12
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_4_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_4_IN13
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_4_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_4_IN14
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_4_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_4_IN15
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_5_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_5_IN0
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_5_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_5_IN1
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_5_IN2 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_cas1_OBUF_D2_PT_5_IN2
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_5_IN3 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_cas1_OBUF_D2_PT_5_IN3
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_5_IN4 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_cas1_OBUF_D2_PT_5_IN4
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_5_IN5 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_5_IN5
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_5_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_cas1_OBUF_D2_PT_5_IN6
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_5_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_cas1_OBUF_D2_PT_5_IN7
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_5_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_cas1_OBUF_D2_PT_5_IN8
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_5_IN9 : X_BUF
    port map (
      I => cas1_PIN_BUF_Q_39,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_5_IN9
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_5_IN10 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_cas1_OBUF_D2_PT_5_IN10
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_5_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_5_IN11
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_5_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_5_IN12
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_5_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_5_IN13
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_5_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_5_IN14
    );
  NlwBufferBlock_cas1_OBUF_D2_PT_5_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas1_OBUF_D2_PT_5_IN15
    );
  NlwBufferBlock_cas1_OBUF_D2_IN0 : X_BUF
    port map (
      I => cas1_OBUF_D2_PT_0_128,
      O => NlwBufferSignal_cas1_OBUF_D2_IN0
    );
  NlwBufferBlock_cas1_OBUF_D2_IN1 : X_BUF
    port map (
      I => cas1_OBUF_D2_PT_1_129,
      O => NlwBufferSignal_cas1_OBUF_D2_IN1
    );
  NlwBufferBlock_cas1_OBUF_D2_IN2 : X_BUF
    port map (
      I => cas1_OBUF_D2_PT_2_130,
      O => NlwBufferSignal_cas1_OBUF_D2_IN2
    );
  NlwBufferBlock_cas1_OBUF_D2_IN3 : X_BUF
    port map (
      I => cas1_OBUF_D2_PT_3_131,
      O => NlwBufferSignal_cas1_OBUF_D2_IN3
    );
  NlwBufferBlock_cas1_OBUF_D2_IN4 : X_BUF
    port map (
      I => cas1_OBUF_D2_PT_4_132,
      O => NlwBufferSignal_cas1_OBUF_D2_IN4
    );
  NlwBufferBlock_cas1_OBUF_D2_IN5 : X_BUF
    port map (
      I => cas1_OBUF_D2_PT_5_134,
      O => NlwBufferSignal_cas1_OBUF_D2_IN5
    );
  NlwBufferBlock_cas2_OBUF_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => cas2_OBUF_D_136,
      O => NlwBufferSignal_cas2_OBUF_tsimcreated_xor_IN0
    );
  NlwBufferBlock_cas2_OBUF_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => cas2_OBUF_Q_135,
      O => NlwBufferSignal_cas2_OBUF_tsimcreated_xor_IN1
    );
  NlwBufferBlock_cas2_OBUF_REG_IN : X_BUF
    port map (
      I => cas2_OBUF_tsimcreated_xor_Q_137,
      O => NlwBufferSignal_cas2_OBUF_REG_IN
    );
  NlwBufferBlock_cas2_OBUF_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_cas2_OBUF_REG_CLK
    );
  NlwBufferBlock_cas2_OBUF_D_IN0 : X_BUF
    port map (
      I => cas2_OBUF_D1_138,
      O => NlwBufferSignal_cas2_OBUF_D_IN0
    );
  NlwBufferBlock_cas2_OBUF_D_IN1 : X_BUF
    port map (
      I => cas2_OBUF_D2_139,
      O => NlwBufferSignal_cas2_OBUF_D_IN1
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_0_IN0 : X_BUF
    port map (
      I => refcnt_2_EXP_140,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_0_IN0
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_0_IN1 : X_BUF
    port map (
      I => refcnt_2_EXP_140,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_0_IN1
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_1_IN0 : X_BUF
    port map (
      I => refcnt_3_EXP_142,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_1_IN0
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_1_IN1 : X_BUF
    port map (
      I => refcnt_3_EXP_142,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_1_IN1
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_2_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_cas2_OBUF_D2_PT_2_IN0
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_2_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_cas2_OBUF_D2_PT_2_IN1
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_2_IN2 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_cas2_OBUF_D2_PT_2_IN2
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_2_IN3 : X_BUF
    port map (
      I => cas2_PIN_BUF_Q_41,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_2_IN3
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_3_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN0
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_3_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN1
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_3_IN2 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN2
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_3_IN3 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN3
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_3_IN4 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN4
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_3_IN5 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN5
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_3_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN6
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_3_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN7
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_3_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN8
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_3_IN9 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN9
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_3_IN10 : X_BUF
    port map (
      I => cas2_PIN_BUF_Q_41,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN10
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_3_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN11
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_3_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN12
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_3_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN13
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_3_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN14
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_3_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN15
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_4_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN0
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_4_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN1
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_4_IN2 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN2
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_4_IN3 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN3
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_4_IN4 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN4
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_4_IN5 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN5
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_4_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN6
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_4_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN7
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_4_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN8
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_4_IN9 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN9
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_4_IN10 : X_BUF
    port map (
      I => cas2_PIN_BUF_Q_41,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN10
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_4_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN11
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_4_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN12
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_4_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN13
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_4_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN14
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_4_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN15
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_5_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN0
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_5_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN1
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_5_IN2 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN2
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_5_IN3 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN3
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_5_IN4 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN4
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_5_IN5 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN5
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_5_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN6
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_5_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN7
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_5_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN8
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_5_IN9 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN9
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_5_IN10 : X_BUF
    port map (
      I => cas2_PIN_BUF_Q_41,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN10
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_5_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN11
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_5_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN12
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_5_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN13
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_5_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN14
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_5_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN15
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_6_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN0
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_6_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN1
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_6_IN2 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN2
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_6_IN3 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN3
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_6_IN4 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN4
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_6_IN5 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN5
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_6_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN6
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_6_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN7
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_6_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN8
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_6_IN9 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN9
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_6_IN10 : X_BUF
    port map (
      I => cas2_PIN_BUF_Q_41,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN10
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_6_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN11
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_6_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN12
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_6_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN13
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_6_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN14
    );
  NlwBufferBlock_cas2_OBUF_D2_PT_6_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN15
    );
  NlwBufferBlock_cas2_OBUF_D2_IN0 : X_BUF
    port map (
      I => cas2_OBUF_D2_PT_0_141,
      O => NlwBufferSignal_cas2_OBUF_D2_IN0
    );
  NlwBufferBlock_cas2_OBUF_D2_IN1 : X_BUF
    port map (
      I => cas2_OBUF_D2_PT_1_143,
      O => NlwBufferSignal_cas2_OBUF_D2_IN1
    );
  NlwBufferBlock_cas2_OBUF_D2_IN2 : X_BUF
    port map (
      I => cas2_OBUF_D2_PT_2_144,
      O => NlwBufferSignal_cas2_OBUF_D2_IN2
    );
  NlwBufferBlock_cas2_OBUF_D2_IN3 : X_BUF
    port map (
      I => cas2_OBUF_D2_PT_3_145,
      O => NlwBufferSignal_cas2_OBUF_D2_IN3
    );
  NlwBufferBlock_cas2_OBUF_D2_IN4 : X_BUF
    port map (
      I => cas2_OBUF_D2_PT_4_146,
      O => NlwBufferSignal_cas2_OBUF_D2_IN4
    );
  NlwBufferBlock_cas2_OBUF_D2_IN5 : X_BUF
    port map (
      I => cas2_OBUF_D2_PT_5_147,
      O => NlwBufferSignal_cas2_OBUF_D2_IN5
    );
  NlwBufferBlock_cas2_OBUF_D2_IN6 : X_BUF
    port map (
      I => cas2_OBUF_D2_PT_6_148,
      O => NlwBufferSignal_cas2_OBUF_D2_IN6
    );
  NlwBufferBlock_cas3_OBUF_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => cas3_OBUF_D_150,
      O => NlwBufferSignal_cas3_OBUF_tsimcreated_xor_IN0
    );
  NlwBufferBlock_cas3_OBUF_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => cas3_OBUF_Q_149,
      O => NlwBufferSignal_cas3_OBUF_tsimcreated_xor_IN1
    );
  NlwBufferBlock_cas3_OBUF_REG_IN : X_BUF
    port map (
      I => cas3_OBUF_tsimcreated_xor_Q_151,
      O => NlwBufferSignal_cas3_OBUF_REG_IN
    );
  NlwBufferBlock_cas3_OBUF_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_cas3_OBUF_REG_CLK
    );
  NlwBufferBlock_cas3_OBUF_D_IN0 : X_BUF
    port map (
      I => cas3_OBUF_D1_152,
      O => NlwBufferSignal_cas3_OBUF_D_IN0
    );
  NlwBufferBlock_cas3_OBUF_D_IN1 : X_BUF
    port map (
      I => cas3_OBUF_D2_153,
      O => NlwBufferSignal_cas3_OBUF_D_IN1
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_0_IN0 : X_BUF
    port map (
      I => refcnt_7_EXP_154,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_0_IN0
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_0_IN1 : X_BUF
    port map (
      I => refcnt_7_EXP_154,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_0_IN1
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_1_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_cas3_OBUF_D2_PT_1_IN0
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_1_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_cas3_OBUF_D2_PT_1_IN1
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_1_IN2 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_cas3_OBUF_D2_PT_1_IN2
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_1_IN3 : X_BUF
    port map (
      I => cas3_PIN_BUF_Q_43,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_1_IN3
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_2_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN0
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_2_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN1
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_2_IN2 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN2
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_2_IN3 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN3
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_2_IN4 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN4
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_2_IN5 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN5
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_2_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN6
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_2_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN7
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_2_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN8
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_2_IN9 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN9
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_2_IN10 : X_BUF
    port map (
      I => cas3_PIN_BUF_Q_43,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN10
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_2_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN11
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_2_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN12
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_2_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN13
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_2_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN14
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_2_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN15
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_3_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN0
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_3_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN1
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_3_IN2 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN2
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_3_IN3 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN3
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_3_IN4 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN4
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_3_IN5 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN5
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_3_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN6
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_3_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN7
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_3_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN8
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_3_IN9 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN9
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_3_IN10 : X_BUF
    port map (
      I => cas3_PIN_BUF_Q_43,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN10
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_3_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN11
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_3_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN12
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_3_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN13
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_3_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN14
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_3_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN15
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_4_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN0
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_4_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN1
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_4_IN2 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN2
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_4_IN3 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN3
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_4_IN4 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN4
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_4_IN5 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN5
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_4_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN6
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_4_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN7
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_4_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN8
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_4_IN9 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN9
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_4_IN10 : X_BUF
    port map (
      I => cas3_PIN_BUF_Q_43,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN10
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_4_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN11
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_4_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN12
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_4_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN13
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_4_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN14
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_4_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN15
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_5_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN0
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_5_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN1
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_5_IN2 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN2
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_5_IN3 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN3
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_5_IN4 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN4
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_5_IN5 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN5
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_5_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN6
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_5_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN7
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_5_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN8
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_5_IN9 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN9
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_5_IN10 : X_BUF
    port map (
      I => cas3_PIN_BUF_Q_43,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN10
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_5_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN11
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_5_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN12
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_5_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN13
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_5_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN14
    );
  NlwBufferBlock_cas3_OBUF_D2_PT_5_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN15
    );
  NlwBufferBlock_cas3_OBUF_D2_IN0 : X_BUF
    port map (
      I => cas3_OBUF_D2_PT_0_155,
      O => NlwBufferSignal_cas3_OBUF_D2_IN0
    );
  NlwBufferBlock_cas3_OBUF_D2_IN1 : X_BUF
    port map (
      I => cas3_OBUF_D2_PT_1_156,
      O => NlwBufferSignal_cas3_OBUF_D2_IN1
    );
  NlwBufferBlock_cas3_OBUF_D2_IN2 : X_BUF
    port map (
      I => cas3_OBUF_D2_PT_2_157,
      O => NlwBufferSignal_cas3_OBUF_D2_IN2
    );
  NlwBufferBlock_cas3_OBUF_D2_IN3 : X_BUF
    port map (
      I => cas3_OBUF_D2_PT_3_158,
      O => NlwBufferSignal_cas3_OBUF_D2_IN3
    );
  NlwBufferBlock_cas3_OBUF_D2_IN4 : X_BUF
    port map (
      I => cas3_OBUF_D2_PT_4_159,
      O => NlwBufferSignal_cas3_OBUF_D2_IN4
    );
  NlwBufferBlock_cas3_OBUF_D2_IN5 : X_BUF
    port map (
      I => cas3_OBUF_D2_PT_5_160,
      O => NlwBufferSignal_cas3_OBUF_D2_IN5
    );
  NlwBufferBlock_io0_OBUF_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => io0_OBUF_D_162,
      O => NlwBufferSignal_io0_OBUF_tsimcreated_xor_IN0
    );
  NlwBufferBlock_io0_OBUF_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => io0_OBUF_Q_161,
      O => NlwBufferSignal_io0_OBUF_tsimcreated_xor_IN1
    );
  NlwBufferBlock_io0_OBUF_REG_IN : X_BUF
    port map (
      I => io0_OBUF_tsimcreated_xor_Q_163,
      O => NlwBufferSignal_io0_OBUF_REG_IN
    );
  NlwBufferBlock_io0_OBUF_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_io0_OBUF_REG_CLK
    );
  NlwBufferBlock_io0_OBUF_D_IN0 : X_BUF
    port map (
      I => io0_OBUF_D1_164,
      O => NlwBufferSignal_io0_OBUF_D_IN0
    );
  NlwBufferBlock_io0_OBUF_D_IN1 : X_BUF
    port map (
      I => io0_OBUF_D2_165,
      O => NlwBufferSignal_io0_OBUF_D_IN1
    );
  NlwBufferBlock_io0_OBUF_D2_PT_0_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_io0_OBUF_D2_PT_0_IN0
    );
  NlwBufferBlock_io0_OBUF_D2_PT_0_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_io0_OBUF_D2_PT_0_IN1
    );
  NlwBufferBlock_io0_OBUF_D2_PT_0_IN2 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_io0_OBUF_D2_PT_0_IN2
    );
  NlwBufferBlock_io0_OBUF_D2_PT_0_IN3 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_io0_OBUF_D2_PT_0_IN3
    );
  NlwBufferBlock_io0_OBUF_D2_PT_0_IN4 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_io0_OBUF_D2_PT_0_IN4
    );
  NlwBufferBlock_io0_OBUF_D2_PT_0_IN5 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_io0_OBUF_D2_PT_0_IN5
    );
  NlwBufferBlock_io0_OBUF_D2_PT_0_IN6 : X_BUF
    port map (
      I => io0_PIN_BUF_Q_45,
      O => NlwBufferSignal_io0_OBUF_D2_PT_0_IN6
    );
  NlwBufferBlock_io0_OBUF_D2_PT_1_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_io0_OBUF_D2_PT_1_IN0
    );
  NlwBufferBlock_io0_OBUF_D2_PT_1_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_io0_OBUF_D2_PT_1_IN1
    );
  NlwBufferBlock_io0_OBUF_D2_PT_1_IN2 : X_BUF
    port map (
      I => a10_IBUF_29,
      O => NlwBufferSignal_io0_OBUF_D2_PT_1_IN2
    );
  NlwBufferBlock_io0_OBUF_D2_PT_1_IN3 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_io0_OBUF_D2_PT_1_IN3
    );
  NlwBufferBlock_io0_OBUF_D2_PT_1_IN4 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_io0_OBUF_D2_PT_1_IN4
    );
  NlwBufferBlock_io0_OBUF_D2_PT_1_IN5 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_io0_OBUF_D2_PT_1_IN5
    );
  NlwBufferBlock_io0_OBUF_D2_PT_1_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_io0_OBUF_D2_PT_1_IN6
    );
  NlwBufferBlock_io0_OBUF_D2_PT_1_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_io0_OBUF_D2_PT_1_IN7
    );
  NlwBufferBlock_io0_OBUF_D2_PT_1_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_io0_OBUF_D2_PT_1_IN8
    );
  NlwBufferBlock_io0_OBUF_D2_PT_1_IN9 : X_BUF
    port map (
      I => io0_PIN_BUF_Q_45,
      O => NlwBufferSignal_io0_OBUF_D2_PT_1_IN9
    );
  NlwBufferBlock_io0_OBUF_D2_PT_1_IN10 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io0_OBUF_D2_PT_1_IN10
    );
  NlwBufferBlock_io0_OBUF_D2_PT_1_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io0_OBUF_D2_PT_1_IN11
    );
  NlwBufferBlock_io0_OBUF_D2_PT_1_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io0_OBUF_D2_PT_1_IN12
    );
  NlwBufferBlock_io0_OBUF_D2_PT_1_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io0_OBUF_D2_PT_1_IN13
    );
  NlwBufferBlock_io0_OBUF_D2_PT_1_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io0_OBUF_D2_PT_1_IN14
    );
  NlwBufferBlock_io0_OBUF_D2_PT_1_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io0_OBUF_D2_PT_1_IN15
    );
  NlwBufferBlock_io0_OBUF_D2_IN0 : X_BUF
    port map (
      I => io0_OBUF_D2_PT_0_166,
      O => NlwBufferSignal_io0_OBUF_D2_IN0
    );
  NlwBufferBlock_io0_OBUF_D2_IN1 : X_BUF
    port map (
      I => io0_OBUF_D2_PT_1_167,
      O => NlwBufferSignal_io0_OBUF_D2_IN1
    );
  NlwBufferBlock_io1_OBUF_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => io1_OBUF_D_169,
      O => NlwBufferSignal_io1_OBUF_tsimcreated_xor_IN0
    );
  NlwBufferBlock_io1_OBUF_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => io1_OBUF_Q_168,
      O => NlwBufferSignal_io1_OBUF_tsimcreated_xor_IN1
    );
  NlwBufferBlock_io1_OBUF_REG_IN : X_BUF
    port map (
      I => io1_OBUF_tsimcreated_xor_Q_170,
      O => NlwBufferSignal_io1_OBUF_REG_IN
    );
  NlwBufferBlock_io1_OBUF_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_io1_OBUF_REG_CLK
    );
  NlwBufferBlock_io1_OBUF_D_IN0 : X_BUF
    port map (
      I => io1_OBUF_D1_171,
      O => NlwBufferSignal_io1_OBUF_D_IN0
    );
  NlwBufferBlock_io1_OBUF_D_IN1 : X_BUF
    port map (
      I => io1_OBUF_D2_172,
      O => NlwBufferSignal_io1_OBUF_D_IN1
    );
  NlwBufferBlock_io1_OBUF_D2_PT_0_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_io1_OBUF_D2_PT_0_IN0
    );
  NlwBufferBlock_io1_OBUF_D2_PT_0_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_io1_OBUF_D2_PT_0_IN1
    );
  NlwBufferBlock_io1_OBUF_D2_PT_0_IN2 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_io1_OBUF_D2_PT_0_IN2
    );
  NlwBufferBlock_io1_OBUF_D2_PT_0_IN3 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_io1_OBUF_D2_PT_0_IN3
    );
  NlwBufferBlock_io1_OBUF_D2_PT_0_IN4 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_io1_OBUF_D2_PT_0_IN4
    );
  NlwBufferBlock_io1_OBUF_D2_PT_0_IN5 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_io1_OBUF_D2_PT_0_IN5
    );
  NlwBufferBlock_io1_OBUF_D2_PT_0_IN6 : X_BUF
    port map (
      I => io1_PIN_BUF_Q_47,
      O => NlwBufferSignal_io1_OBUF_D2_PT_0_IN6
    );
  NlwBufferBlock_io1_OBUF_D2_PT_1_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_io1_OBUF_D2_PT_1_IN0
    );
  NlwBufferBlock_io1_OBUF_D2_PT_1_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_io1_OBUF_D2_PT_1_IN1
    );
  NlwBufferBlock_io1_OBUF_D2_PT_1_IN2 : X_BUF
    port map (
      I => a10_IBUF_29,
      O => NlwBufferSignal_io1_OBUF_D2_PT_1_IN2
    );
  NlwBufferBlock_io1_OBUF_D2_PT_1_IN3 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_io1_OBUF_D2_PT_1_IN3
    );
  NlwBufferBlock_io1_OBUF_D2_PT_1_IN4 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_io1_OBUF_D2_PT_1_IN4
    );
  NlwBufferBlock_io1_OBUF_D2_PT_1_IN5 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_io1_OBUF_D2_PT_1_IN5
    );
  NlwBufferBlock_io1_OBUF_D2_PT_1_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_io1_OBUF_D2_PT_1_IN6
    );
  NlwBufferBlock_io1_OBUF_D2_PT_1_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_io1_OBUF_D2_PT_1_IN7
    );
  NlwBufferBlock_io1_OBUF_D2_PT_1_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_io1_OBUF_D2_PT_1_IN8
    );
  NlwBufferBlock_io1_OBUF_D2_PT_1_IN9 : X_BUF
    port map (
      I => io1_PIN_BUF_Q_47,
      O => NlwBufferSignal_io1_OBUF_D2_PT_1_IN9
    );
  NlwBufferBlock_io1_OBUF_D2_PT_1_IN10 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io1_OBUF_D2_PT_1_IN10
    );
  NlwBufferBlock_io1_OBUF_D2_PT_1_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io1_OBUF_D2_PT_1_IN11
    );
  NlwBufferBlock_io1_OBUF_D2_PT_1_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io1_OBUF_D2_PT_1_IN12
    );
  NlwBufferBlock_io1_OBUF_D2_PT_1_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io1_OBUF_D2_PT_1_IN13
    );
  NlwBufferBlock_io1_OBUF_D2_PT_1_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io1_OBUF_D2_PT_1_IN14
    );
  NlwBufferBlock_io1_OBUF_D2_PT_1_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io1_OBUF_D2_PT_1_IN15
    );
  NlwBufferBlock_io1_OBUF_D2_IN0 : X_BUF
    port map (
      I => io1_OBUF_D2_PT_0_173,
      O => NlwBufferSignal_io1_OBUF_D2_IN0
    );
  NlwBufferBlock_io1_OBUF_D2_IN1 : X_BUF
    port map (
      I => io1_OBUF_D2_PT_1_174,
      O => NlwBufferSignal_io1_OBUF_D2_IN1
    );
  NlwBufferBlock_io2_OBUF_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => io2_OBUF_D_176,
      O => NlwBufferSignal_io2_OBUF_tsimcreated_xor_IN0
    );
  NlwBufferBlock_io2_OBUF_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => io2_OBUF_Q_175,
      O => NlwBufferSignal_io2_OBUF_tsimcreated_xor_IN1
    );
  NlwBufferBlock_io2_OBUF_REG_IN : X_BUF
    port map (
      I => io2_OBUF_tsimcreated_xor_Q_177,
      O => NlwBufferSignal_io2_OBUF_REG_IN
    );
  NlwBufferBlock_io2_OBUF_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_io2_OBUF_REG_CLK
    );
  NlwBufferBlock_io2_OBUF_D_IN0 : X_BUF
    port map (
      I => io2_OBUF_D1_178,
      O => NlwBufferSignal_io2_OBUF_D_IN0
    );
  NlwBufferBlock_io2_OBUF_D_IN1 : X_BUF
    port map (
      I => io2_OBUF_D2_179,
      O => NlwBufferSignal_io2_OBUF_D_IN1
    );
  NlwBufferBlock_io2_OBUF_D2_PT_0_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_io2_OBUF_D2_PT_0_IN0
    );
  NlwBufferBlock_io2_OBUF_D2_PT_0_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_io2_OBUF_D2_PT_0_IN1
    );
  NlwBufferBlock_io2_OBUF_D2_PT_0_IN2 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_io2_OBUF_D2_PT_0_IN2
    );
  NlwBufferBlock_io2_OBUF_D2_PT_0_IN3 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_io2_OBUF_D2_PT_0_IN3
    );
  NlwBufferBlock_io2_OBUF_D2_PT_0_IN4 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_io2_OBUF_D2_PT_0_IN4
    );
  NlwBufferBlock_io2_OBUF_D2_PT_0_IN5 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_io2_OBUF_D2_PT_0_IN5
    );
  NlwBufferBlock_io2_OBUF_D2_PT_0_IN6 : X_BUF
    port map (
      I => io2_PIN_BUF_Q_49,
      O => NlwBufferSignal_io2_OBUF_D2_PT_0_IN6
    );
  NlwBufferBlock_io2_OBUF_D2_PT_1_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_io2_OBUF_D2_PT_1_IN0
    );
  NlwBufferBlock_io2_OBUF_D2_PT_1_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_io2_OBUF_D2_PT_1_IN1
    );
  NlwBufferBlock_io2_OBUF_D2_PT_1_IN2 : X_BUF
    port map (
      I => a10_IBUF_29,
      O => NlwBufferSignal_io2_OBUF_D2_PT_1_IN2
    );
  NlwBufferBlock_io2_OBUF_D2_PT_1_IN3 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_io2_OBUF_D2_PT_1_IN3
    );
  NlwBufferBlock_io2_OBUF_D2_PT_1_IN4 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_io2_OBUF_D2_PT_1_IN4
    );
  NlwBufferBlock_io2_OBUF_D2_PT_1_IN5 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_io2_OBUF_D2_PT_1_IN5
    );
  NlwBufferBlock_io2_OBUF_D2_PT_1_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_io2_OBUF_D2_PT_1_IN6
    );
  NlwBufferBlock_io2_OBUF_D2_PT_1_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_io2_OBUF_D2_PT_1_IN7
    );
  NlwBufferBlock_io2_OBUF_D2_PT_1_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_io2_OBUF_D2_PT_1_IN8
    );
  NlwBufferBlock_io2_OBUF_D2_PT_1_IN9 : X_BUF
    port map (
      I => io2_PIN_BUF_Q_49,
      O => NlwBufferSignal_io2_OBUF_D2_PT_1_IN9
    );
  NlwBufferBlock_io2_OBUF_D2_PT_1_IN10 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io2_OBUF_D2_PT_1_IN10
    );
  NlwBufferBlock_io2_OBUF_D2_PT_1_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io2_OBUF_D2_PT_1_IN11
    );
  NlwBufferBlock_io2_OBUF_D2_PT_1_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io2_OBUF_D2_PT_1_IN12
    );
  NlwBufferBlock_io2_OBUF_D2_PT_1_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io2_OBUF_D2_PT_1_IN13
    );
  NlwBufferBlock_io2_OBUF_D2_PT_1_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io2_OBUF_D2_PT_1_IN14
    );
  NlwBufferBlock_io2_OBUF_D2_PT_1_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io2_OBUF_D2_PT_1_IN15
    );
  NlwBufferBlock_io2_OBUF_D2_IN0 : X_BUF
    port map (
      I => io2_OBUF_D2_PT_0_180,
      O => NlwBufferSignal_io2_OBUF_D2_IN0
    );
  NlwBufferBlock_io2_OBUF_D2_IN1 : X_BUF
    port map (
      I => io2_OBUF_D2_PT_1_181,
      O => NlwBufferSignal_io2_OBUF_D2_IN1
    );
  NlwBufferBlock_io3_OBUF_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => io3_OBUF_D_183,
      O => NlwBufferSignal_io3_OBUF_tsimcreated_xor_IN0
    );
  NlwBufferBlock_io3_OBUF_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => io3_OBUF_Q_182,
      O => NlwBufferSignal_io3_OBUF_tsimcreated_xor_IN1
    );
  NlwBufferBlock_io3_OBUF_REG_IN : X_BUF
    port map (
      I => io3_OBUF_tsimcreated_xor_Q_184,
      O => NlwBufferSignal_io3_OBUF_REG_IN
    );
  NlwBufferBlock_io3_OBUF_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_io3_OBUF_REG_CLK
    );
  NlwBufferBlock_io3_OBUF_D_IN0 : X_BUF
    port map (
      I => io3_OBUF_D1_185,
      O => NlwBufferSignal_io3_OBUF_D_IN0
    );
  NlwBufferBlock_io3_OBUF_D_IN1 : X_BUF
    port map (
      I => io3_OBUF_D2_186,
      O => NlwBufferSignal_io3_OBUF_D_IN1
    );
  NlwBufferBlock_io3_OBUF_D2_PT_0_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_io3_OBUF_D2_PT_0_IN0
    );
  NlwBufferBlock_io3_OBUF_D2_PT_0_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_io3_OBUF_D2_PT_0_IN1
    );
  NlwBufferBlock_io3_OBUF_D2_PT_0_IN2 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_io3_OBUF_D2_PT_0_IN2
    );
  NlwBufferBlock_io3_OBUF_D2_PT_0_IN3 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_io3_OBUF_D2_PT_0_IN3
    );
  NlwBufferBlock_io3_OBUF_D2_PT_0_IN4 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_io3_OBUF_D2_PT_0_IN4
    );
  NlwBufferBlock_io3_OBUF_D2_PT_0_IN5 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_io3_OBUF_D2_PT_0_IN5
    );
  NlwBufferBlock_io3_OBUF_D2_PT_0_IN6 : X_BUF
    port map (
      I => io3_PIN_BUF_Q_51,
      O => NlwBufferSignal_io3_OBUF_D2_PT_0_IN6
    );
  NlwBufferBlock_io3_OBUF_D2_PT_1_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_io3_OBUF_D2_PT_1_IN0
    );
  NlwBufferBlock_io3_OBUF_D2_PT_1_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_io3_OBUF_D2_PT_1_IN1
    );
  NlwBufferBlock_io3_OBUF_D2_PT_1_IN2 : X_BUF
    port map (
      I => a10_IBUF_29,
      O => NlwBufferSignal_io3_OBUF_D2_PT_1_IN2
    );
  NlwBufferBlock_io3_OBUF_D2_PT_1_IN3 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_io3_OBUF_D2_PT_1_IN3
    );
  NlwBufferBlock_io3_OBUF_D2_PT_1_IN4 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_io3_OBUF_D2_PT_1_IN4
    );
  NlwBufferBlock_io3_OBUF_D2_PT_1_IN5 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_io3_OBUF_D2_PT_1_IN5
    );
  NlwBufferBlock_io3_OBUF_D2_PT_1_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_io3_OBUF_D2_PT_1_IN6
    );
  NlwBufferBlock_io3_OBUF_D2_PT_1_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_io3_OBUF_D2_PT_1_IN7
    );
  NlwBufferBlock_io3_OBUF_D2_PT_1_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_io3_OBUF_D2_PT_1_IN8
    );
  NlwBufferBlock_io3_OBUF_D2_PT_1_IN9 : X_BUF
    port map (
      I => io3_PIN_BUF_Q_51,
      O => NlwBufferSignal_io3_OBUF_D2_PT_1_IN9
    );
  NlwBufferBlock_io3_OBUF_D2_PT_1_IN10 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io3_OBUF_D2_PT_1_IN10
    );
  NlwBufferBlock_io3_OBUF_D2_PT_1_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io3_OBUF_D2_PT_1_IN11
    );
  NlwBufferBlock_io3_OBUF_D2_PT_1_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io3_OBUF_D2_PT_1_IN12
    );
  NlwBufferBlock_io3_OBUF_D2_PT_1_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io3_OBUF_D2_PT_1_IN13
    );
  NlwBufferBlock_io3_OBUF_D2_PT_1_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io3_OBUF_D2_PT_1_IN14
    );
  NlwBufferBlock_io3_OBUF_D2_PT_1_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io3_OBUF_D2_PT_1_IN15
    );
  NlwBufferBlock_io3_OBUF_D2_IN0 : X_BUF
    port map (
      I => io3_OBUF_D2_PT_0_187,
      O => NlwBufferSignal_io3_OBUF_D2_IN0
    );
  NlwBufferBlock_io3_OBUF_D2_IN1 : X_BUF
    port map (
      I => io3_OBUF_D2_PT_1_188,
      O => NlwBufferSignal_io3_OBUF_D2_IN1
    );
  NlwBufferBlock_io4_OBUF_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => io4_OBUF_D_190,
      O => NlwBufferSignal_io4_OBUF_tsimcreated_xor_IN0
    );
  NlwBufferBlock_io4_OBUF_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => io4_OBUF_Q_189,
      O => NlwBufferSignal_io4_OBUF_tsimcreated_xor_IN1
    );
  NlwBufferBlock_io4_OBUF_REG_IN : X_BUF
    port map (
      I => io4_OBUF_tsimcreated_xor_Q_191,
      O => NlwBufferSignal_io4_OBUF_REG_IN
    );
  NlwBufferBlock_io4_OBUF_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_io4_OBUF_REG_CLK
    );
  NlwBufferBlock_io4_OBUF_D_IN0 : X_BUF
    port map (
      I => io4_OBUF_D1_192,
      O => NlwBufferSignal_io4_OBUF_D_IN0
    );
  NlwBufferBlock_io4_OBUF_D_IN1 : X_BUF
    port map (
      I => io4_OBUF_D2_193,
      O => NlwBufferSignal_io4_OBUF_D_IN1
    );
  NlwBufferBlock_io4_OBUF_D2_PT_0_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_io4_OBUF_D2_PT_0_IN0
    );
  NlwBufferBlock_io4_OBUF_D2_PT_0_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_io4_OBUF_D2_PT_0_IN1
    );
  NlwBufferBlock_io4_OBUF_D2_PT_0_IN2 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_io4_OBUF_D2_PT_0_IN2
    );
  NlwBufferBlock_io4_OBUF_D2_PT_0_IN3 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_io4_OBUF_D2_PT_0_IN3
    );
  NlwBufferBlock_io4_OBUF_D2_PT_0_IN4 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_io4_OBUF_D2_PT_0_IN4
    );
  NlwBufferBlock_io4_OBUF_D2_PT_0_IN5 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_io4_OBUF_D2_PT_0_IN5
    );
  NlwBufferBlock_io4_OBUF_D2_PT_0_IN6 : X_BUF
    port map (
      I => io4_PIN_BUF_Q_53,
      O => NlwBufferSignal_io4_OBUF_D2_PT_0_IN6
    );
  NlwBufferBlock_io4_OBUF_D2_PT_1_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_io4_OBUF_D2_PT_1_IN0
    );
  NlwBufferBlock_io4_OBUF_D2_PT_1_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_io4_OBUF_D2_PT_1_IN1
    );
  NlwBufferBlock_io4_OBUF_D2_PT_1_IN2 : X_BUF
    port map (
      I => a10_IBUF_29,
      O => NlwBufferSignal_io4_OBUF_D2_PT_1_IN2
    );
  NlwBufferBlock_io4_OBUF_D2_PT_1_IN3 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_io4_OBUF_D2_PT_1_IN3
    );
  NlwBufferBlock_io4_OBUF_D2_PT_1_IN4 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_io4_OBUF_D2_PT_1_IN4
    );
  NlwBufferBlock_io4_OBUF_D2_PT_1_IN5 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_io4_OBUF_D2_PT_1_IN5
    );
  NlwBufferBlock_io4_OBUF_D2_PT_1_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_io4_OBUF_D2_PT_1_IN6
    );
  NlwBufferBlock_io4_OBUF_D2_PT_1_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_io4_OBUF_D2_PT_1_IN7
    );
  NlwBufferBlock_io4_OBUF_D2_PT_1_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_io4_OBUF_D2_PT_1_IN8
    );
  NlwBufferBlock_io4_OBUF_D2_PT_1_IN9 : X_BUF
    port map (
      I => io4_PIN_BUF_Q_53,
      O => NlwBufferSignal_io4_OBUF_D2_PT_1_IN9
    );
  NlwBufferBlock_io4_OBUF_D2_PT_1_IN10 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io4_OBUF_D2_PT_1_IN10
    );
  NlwBufferBlock_io4_OBUF_D2_PT_1_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io4_OBUF_D2_PT_1_IN11
    );
  NlwBufferBlock_io4_OBUF_D2_PT_1_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io4_OBUF_D2_PT_1_IN12
    );
  NlwBufferBlock_io4_OBUF_D2_PT_1_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io4_OBUF_D2_PT_1_IN13
    );
  NlwBufferBlock_io4_OBUF_D2_PT_1_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io4_OBUF_D2_PT_1_IN14
    );
  NlwBufferBlock_io4_OBUF_D2_PT_1_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io4_OBUF_D2_PT_1_IN15
    );
  NlwBufferBlock_io4_OBUF_D2_IN0 : X_BUF
    port map (
      I => io4_OBUF_D2_PT_0_194,
      O => NlwBufferSignal_io4_OBUF_D2_IN0
    );
  NlwBufferBlock_io4_OBUF_D2_IN1 : X_BUF
    port map (
      I => io4_OBUF_D2_PT_1_195,
      O => NlwBufferSignal_io4_OBUF_D2_IN1
    );
  NlwBufferBlock_io5_OBUF_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => io5_OBUF_D_197,
      O => NlwBufferSignal_io5_OBUF_tsimcreated_xor_IN0
    );
  NlwBufferBlock_io5_OBUF_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => io5_OBUF_Q_196,
      O => NlwBufferSignal_io5_OBUF_tsimcreated_xor_IN1
    );
  NlwBufferBlock_io5_OBUF_REG_IN : X_BUF
    port map (
      I => io5_OBUF_tsimcreated_xor_Q_198,
      O => NlwBufferSignal_io5_OBUF_REG_IN
    );
  NlwBufferBlock_io5_OBUF_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_io5_OBUF_REG_CLK
    );
  NlwBufferBlock_io5_OBUF_D_IN0 : X_BUF
    port map (
      I => io5_OBUF_D1_199,
      O => NlwBufferSignal_io5_OBUF_D_IN0
    );
  NlwBufferBlock_io5_OBUF_D_IN1 : X_BUF
    port map (
      I => io5_OBUF_D2_200,
      O => NlwBufferSignal_io5_OBUF_D_IN1
    );
  NlwBufferBlock_io5_OBUF_D2_PT_0_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_io5_OBUF_D2_PT_0_IN0
    );
  NlwBufferBlock_io5_OBUF_D2_PT_0_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_io5_OBUF_D2_PT_0_IN1
    );
  NlwBufferBlock_io5_OBUF_D2_PT_0_IN2 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_io5_OBUF_D2_PT_0_IN2
    );
  NlwBufferBlock_io5_OBUF_D2_PT_0_IN3 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_io5_OBUF_D2_PT_0_IN3
    );
  NlwBufferBlock_io5_OBUF_D2_PT_0_IN4 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_io5_OBUF_D2_PT_0_IN4
    );
  NlwBufferBlock_io5_OBUF_D2_PT_0_IN5 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_io5_OBUF_D2_PT_0_IN5
    );
  NlwBufferBlock_io5_OBUF_D2_PT_0_IN6 : X_BUF
    port map (
      I => io5_PIN_BUF_Q_55,
      O => NlwBufferSignal_io5_OBUF_D2_PT_0_IN6
    );
  NlwBufferBlock_io5_OBUF_D2_PT_1_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_io5_OBUF_D2_PT_1_IN0
    );
  NlwBufferBlock_io5_OBUF_D2_PT_1_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_io5_OBUF_D2_PT_1_IN1
    );
  NlwBufferBlock_io5_OBUF_D2_PT_1_IN2 : X_BUF
    port map (
      I => a10_IBUF_29,
      O => NlwBufferSignal_io5_OBUF_D2_PT_1_IN2
    );
  NlwBufferBlock_io5_OBUF_D2_PT_1_IN3 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_io5_OBUF_D2_PT_1_IN3
    );
  NlwBufferBlock_io5_OBUF_D2_PT_1_IN4 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_io5_OBUF_D2_PT_1_IN4
    );
  NlwBufferBlock_io5_OBUF_D2_PT_1_IN5 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_io5_OBUF_D2_PT_1_IN5
    );
  NlwBufferBlock_io5_OBUF_D2_PT_1_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_io5_OBUF_D2_PT_1_IN6
    );
  NlwBufferBlock_io5_OBUF_D2_PT_1_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_io5_OBUF_D2_PT_1_IN7
    );
  NlwBufferBlock_io5_OBUF_D2_PT_1_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_io5_OBUF_D2_PT_1_IN8
    );
  NlwBufferBlock_io5_OBUF_D2_PT_1_IN9 : X_BUF
    port map (
      I => io5_PIN_BUF_Q_55,
      O => NlwBufferSignal_io5_OBUF_D2_PT_1_IN9
    );
  NlwBufferBlock_io5_OBUF_D2_PT_1_IN10 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io5_OBUF_D2_PT_1_IN10
    );
  NlwBufferBlock_io5_OBUF_D2_PT_1_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io5_OBUF_D2_PT_1_IN11
    );
  NlwBufferBlock_io5_OBUF_D2_PT_1_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io5_OBUF_D2_PT_1_IN12
    );
  NlwBufferBlock_io5_OBUF_D2_PT_1_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io5_OBUF_D2_PT_1_IN13
    );
  NlwBufferBlock_io5_OBUF_D2_PT_1_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io5_OBUF_D2_PT_1_IN14
    );
  NlwBufferBlock_io5_OBUF_D2_PT_1_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io5_OBUF_D2_PT_1_IN15
    );
  NlwBufferBlock_io5_OBUF_D2_IN0 : X_BUF
    port map (
      I => io5_OBUF_D2_PT_0_201,
      O => NlwBufferSignal_io5_OBUF_D2_IN0
    );
  NlwBufferBlock_io5_OBUF_D2_IN1 : X_BUF
    port map (
      I => io5_OBUF_D2_PT_1_202,
      O => NlwBufferSignal_io5_OBUF_D2_IN1
    );
  NlwBufferBlock_io6_OBUF_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => io6_OBUF_D_204,
      O => NlwBufferSignal_io6_OBUF_tsimcreated_xor_IN0
    );
  NlwBufferBlock_io6_OBUF_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => io6_OBUF_Q_203,
      O => NlwBufferSignal_io6_OBUF_tsimcreated_xor_IN1
    );
  NlwBufferBlock_io6_OBUF_REG_IN : X_BUF
    port map (
      I => io6_OBUF_tsimcreated_xor_Q_205,
      O => NlwBufferSignal_io6_OBUF_REG_IN
    );
  NlwBufferBlock_io6_OBUF_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_io6_OBUF_REG_CLK
    );
  NlwBufferBlock_io6_OBUF_D_IN0 : X_BUF
    port map (
      I => io6_OBUF_D1_206,
      O => NlwBufferSignal_io6_OBUF_D_IN0
    );
  NlwBufferBlock_io6_OBUF_D_IN1 : X_BUF
    port map (
      I => io6_OBUF_D2_207,
      O => NlwBufferSignal_io6_OBUF_D_IN1
    );
  NlwBufferBlock_io6_OBUF_D2_PT_0_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_io6_OBUF_D2_PT_0_IN0
    );
  NlwBufferBlock_io6_OBUF_D2_PT_0_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_io6_OBUF_D2_PT_0_IN1
    );
  NlwBufferBlock_io6_OBUF_D2_PT_0_IN2 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_io6_OBUF_D2_PT_0_IN2
    );
  NlwBufferBlock_io6_OBUF_D2_PT_0_IN3 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_io6_OBUF_D2_PT_0_IN3
    );
  NlwBufferBlock_io6_OBUF_D2_PT_0_IN4 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_io6_OBUF_D2_PT_0_IN4
    );
  NlwBufferBlock_io6_OBUF_D2_PT_0_IN5 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_io6_OBUF_D2_PT_0_IN5
    );
  NlwBufferBlock_io6_OBUF_D2_PT_0_IN6 : X_BUF
    port map (
      I => io6_PIN_BUF_Q_57,
      O => NlwBufferSignal_io6_OBUF_D2_PT_0_IN6
    );
  NlwBufferBlock_io6_OBUF_D2_PT_1_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_io6_OBUF_D2_PT_1_IN0
    );
  NlwBufferBlock_io6_OBUF_D2_PT_1_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_io6_OBUF_D2_PT_1_IN1
    );
  NlwBufferBlock_io6_OBUF_D2_PT_1_IN2 : X_BUF
    port map (
      I => a10_IBUF_29,
      O => NlwBufferSignal_io6_OBUF_D2_PT_1_IN2
    );
  NlwBufferBlock_io6_OBUF_D2_PT_1_IN3 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_io6_OBUF_D2_PT_1_IN3
    );
  NlwBufferBlock_io6_OBUF_D2_PT_1_IN4 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_io6_OBUF_D2_PT_1_IN4
    );
  NlwBufferBlock_io6_OBUF_D2_PT_1_IN5 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_io6_OBUF_D2_PT_1_IN5
    );
  NlwBufferBlock_io6_OBUF_D2_PT_1_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_io6_OBUF_D2_PT_1_IN6
    );
  NlwBufferBlock_io6_OBUF_D2_PT_1_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_io6_OBUF_D2_PT_1_IN7
    );
  NlwBufferBlock_io6_OBUF_D2_PT_1_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_io6_OBUF_D2_PT_1_IN8
    );
  NlwBufferBlock_io6_OBUF_D2_PT_1_IN9 : X_BUF
    port map (
      I => io6_PIN_BUF_Q_57,
      O => NlwBufferSignal_io6_OBUF_D2_PT_1_IN9
    );
  NlwBufferBlock_io6_OBUF_D2_PT_1_IN10 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io6_OBUF_D2_PT_1_IN10
    );
  NlwBufferBlock_io6_OBUF_D2_PT_1_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io6_OBUF_D2_PT_1_IN11
    );
  NlwBufferBlock_io6_OBUF_D2_PT_1_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io6_OBUF_D2_PT_1_IN12
    );
  NlwBufferBlock_io6_OBUF_D2_PT_1_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io6_OBUF_D2_PT_1_IN13
    );
  NlwBufferBlock_io6_OBUF_D2_PT_1_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io6_OBUF_D2_PT_1_IN14
    );
  NlwBufferBlock_io6_OBUF_D2_PT_1_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io6_OBUF_D2_PT_1_IN15
    );
  NlwBufferBlock_io6_OBUF_D2_IN0 : X_BUF
    port map (
      I => io6_OBUF_D2_PT_0_208,
      O => NlwBufferSignal_io6_OBUF_D2_IN0
    );
  NlwBufferBlock_io6_OBUF_D2_IN1 : X_BUF
    port map (
      I => io6_OBUF_D2_PT_1_209,
      O => NlwBufferSignal_io6_OBUF_D2_IN1
    );
  NlwBufferBlock_io7_OBUF_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => io7_OBUF_D_211,
      O => NlwBufferSignal_io7_OBUF_tsimcreated_xor_IN0
    );
  NlwBufferBlock_io7_OBUF_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => io7_OBUF_Q_210,
      O => NlwBufferSignal_io7_OBUF_tsimcreated_xor_IN1
    );
  NlwBufferBlock_io7_OBUF_REG_IN : X_BUF
    port map (
      I => io7_OBUF_tsimcreated_xor_Q_212,
      O => NlwBufferSignal_io7_OBUF_REG_IN
    );
  NlwBufferBlock_io7_OBUF_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_io7_OBUF_REG_CLK
    );
  NlwBufferBlock_io7_OBUF_D_IN0 : X_BUF
    port map (
      I => io7_OBUF_D1_213,
      O => NlwBufferSignal_io7_OBUF_D_IN0
    );
  NlwBufferBlock_io7_OBUF_D_IN1 : X_BUF
    port map (
      I => io7_OBUF_D2_214,
      O => NlwBufferSignal_io7_OBUF_D_IN1
    );
  NlwBufferBlock_io7_OBUF_D2_PT_0_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_io7_OBUF_D2_PT_0_IN0
    );
  NlwBufferBlock_io7_OBUF_D2_PT_0_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_io7_OBUF_D2_PT_0_IN1
    );
  NlwBufferBlock_io7_OBUF_D2_PT_0_IN2 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_io7_OBUF_D2_PT_0_IN2
    );
  NlwBufferBlock_io7_OBUF_D2_PT_0_IN3 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_io7_OBUF_D2_PT_0_IN3
    );
  NlwBufferBlock_io7_OBUF_D2_PT_0_IN4 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_io7_OBUF_D2_PT_0_IN4
    );
  NlwBufferBlock_io7_OBUF_D2_PT_0_IN5 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_io7_OBUF_D2_PT_0_IN5
    );
  NlwBufferBlock_io7_OBUF_D2_PT_0_IN6 : X_BUF
    port map (
      I => io7_PIN_BUF_Q_59,
      O => NlwBufferSignal_io7_OBUF_D2_PT_0_IN6
    );
  NlwBufferBlock_io7_OBUF_D2_PT_1_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_io7_OBUF_D2_PT_1_IN0
    );
  NlwBufferBlock_io7_OBUF_D2_PT_1_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_io7_OBUF_D2_PT_1_IN1
    );
  NlwBufferBlock_io7_OBUF_D2_PT_1_IN2 : X_BUF
    port map (
      I => a10_IBUF_29,
      O => NlwBufferSignal_io7_OBUF_D2_PT_1_IN2
    );
  NlwBufferBlock_io7_OBUF_D2_PT_1_IN3 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_io7_OBUF_D2_PT_1_IN3
    );
  NlwBufferBlock_io7_OBUF_D2_PT_1_IN4 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_io7_OBUF_D2_PT_1_IN4
    );
  NlwBufferBlock_io7_OBUF_D2_PT_1_IN5 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_io7_OBUF_D2_PT_1_IN5
    );
  NlwBufferBlock_io7_OBUF_D2_PT_1_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_io7_OBUF_D2_PT_1_IN6
    );
  NlwBufferBlock_io7_OBUF_D2_PT_1_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_io7_OBUF_D2_PT_1_IN7
    );
  NlwBufferBlock_io7_OBUF_D2_PT_1_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_io7_OBUF_D2_PT_1_IN8
    );
  NlwBufferBlock_io7_OBUF_D2_PT_1_IN9 : X_BUF
    port map (
      I => io7_PIN_BUF_Q_59,
      O => NlwBufferSignal_io7_OBUF_D2_PT_1_IN9
    );
  NlwBufferBlock_io7_OBUF_D2_PT_1_IN10 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io7_OBUF_D2_PT_1_IN10
    );
  NlwBufferBlock_io7_OBUF_D2_PT_1_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io7_OBUF_D2_PT_1_IN11
    );
  NlwBufferBlock_io7_OBUF_D2_PT_1_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io7_OBUF_D2_PT_1_IN12
    );
  NlwBufferBlock_io7_OBUF_D2_PT_1_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io7_OBUF_D2_PT_1_IN13
    );
  NlwBufferBlock_io7_OBUF_D2_PT_1_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io7_OBUF_D2_PT_1_IN14
    );
  NlwBufferBlock_io7_OBUF_D2_PT_1_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_io7_OBUF_D2_PT_1_IN15
    );
  NlwBufferBlock_io7_OBUF_D2_IN0 : X_BUF
    port map (
      I => io7_OBUF_D2_PT_0_215,
      O => NlwBufferSignal_io7_OBUF_D2_IN0
    );
  NlwBufferBlock_io7_OBUF_D2_IN1 : X_BUF
    port map (
      I => io7_OBUF_D2_PT_1_216,
      O => NlwBufferSignal_io7_OBUF_D2_IN1
    );
  NlwBufferBlock_phi0_OBUF_REG_IN : X_BUF
    port map (
      I => phi0_OBUF_D_218,
      O => NlwBufferSignal_phi0_OBUF_REG_IN
    );
  NlwBufferBlock_phi0_OBUF_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_phi0_OBUF_REG_CLK
    );
  NlwBufferBlock_phi0_OBUF_D_IN0 : X_BUF
    port map (
      I => phi0_OBUF_D1_219,
      O => NlwBufferSignal_phi0_OBUF_D_IN0
    );
  NlwBufferBlock_phi0_OBUF_D_IN1 : X_BUF
    port map (
      I => phi0_OBUF_D2_220,
      O => NlwBufferSignal_phi0_OBUF_D_IN1
    );
  NlwBufferBlock_phi0_OBUF_D2_PT_0_IN0 : X_BUF
    port map (
      I => EXP0_EXP_221,
      O => NlwBufferSignal_phi0_OBUF_D2_PT_0_IN0
    );
  NlwBufferBlock_phi0_OBUF_D2_PT_0_IN1 : X_BUF
    port map (
      I => EXP0_EXP_221,
      O => NlwBufferSignal_phi0_OBUF_D2_PT_0_IN1
    );
  NlwBufferBlock_phi0_OBUF_D2_PT_1_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_phi0_OBUF_D2_PT_1_IN0
    );
  NlwBufferBlock_phi0_OBUF_D2_PT_1_IN1 : X_BUF
    port map (
      I => phi0_PIN_BUF_Q_61,
      O => NlwBufferSignal_phi0_OBUF_D2_PT_1_IN1
    );
  NlwBufferBlock_phi0_OBUF_D2_PT_2_IN0 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_phi0_OBUF_D2_PT_2_IN0
    );
  NlwBufferBlock_phi0_OBUF_D2_PT_2_IN1 : X_BUF
    port map (
      I => phi0_PIN_BUF_Q_61,
      O => NlwBufferSignal_phi0_OBUF_D2_PT_2_IN1
    );
  NlwBufferBlock_phi0_OBUF_D2_PT_3_IN0 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_phi0_OBUF_D2_PT_3_IN0
    );
  NlwBufferBlock_phi0_OBUF_D2_PT_3_IN1 : X_BUF
    port map (
      I => phi0_PIN_BUF_Q_61,
      O => NlwBufferSignal_phi0_OBUF_D2_PT_3_IN1
    );
  NlwBufferBlock_phi0_OBUF_D2_PT_4_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_phi0_OBUF_D2_PT_4_IN0
    );
  NlwBufferBlock_phi0_OBUF_D2_PT_4_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_phi0_OBUF_D2_PT_4_IN1
    );
  NlwBufferBlock_phi0_OBUF_D2_PT_4_IN2 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_phi0_OBUF_D2_PT_4_IN2
    );
  NlwBufferBlock_phi0_OBUF_D2_PT_5_IN0 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_phi0_OBUF_D2_PT_5_IN0
    );
  NlwBufferBlock_phi0_OBUF_D2_PT_5_IN1 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_phi0_OBUF_D2_PT_5_IN1
    );
  NlwBufferBlock_phi0_OBUF_D2_PT_5_IN2 : X_BUF
    port map (
      I => phi0_PIN_BUF_Q_61,
      O => NlwBufferSignal_phi0_OBUF_D2_PT_5_IN2
    );
  NlwBufferBlock_phi0_OBUF_D2_IN0 : X_BUF
    port map (
      I => phi0_OBUF_D2_PT_0_222,
      O => NlwBufferSignal_phi0_OBUF_D2_IN0
    );
  NlwBufferBlock_phi0_OBUF_D2_IN1 : X_BUF
    port map (
      I => phi0_OBUF_D2_PT_1_223,
      O => NlwBufferSignal_phi0_OBUF_D2_IN1
    );
  NlwBufferBlock_phi0_OBUF_D2_IN2 : X_BUF
    port map (
      I => phi0_OBUF_D2_PT_2_224,
      O => NlwBufferSignal_phi0_OBUF_D2_IN2
    );
  NlwBufferBlock_phi0_OBUF_D2_IN3 : X_BUF
    port map (
      I => phi0_OBUF_D2_PT_3_225,
      O => NlwBufferSignal_phi0_OBUF_D2_IN3
    );
  NlwBufferBlock_phi0_OBUF_D2_IN4 : X_BUF
    port map (
      I => phi0_OBUF_D2_PT_4_226,
      O => NlwBufferSignal_phi0_OBUF_D2_IN4
    );
  NlwBufferBlock_phi0_OBUF_D2_IN5 : X_BUF
    port map (
      I => phi0_OBUF_D2_PT_5_227,
      O => NlwBufferSignal_phi0_OBUF_D2_IN5
    );
  NlwBufferBlock_ras_OBUF_REG_IN : X_BUF
    port map (
      I => ras_OBUF_D_229,
      O => NlwBufferSignal_ras_OBUF_REG_IN
    );
  NlwBufferBlock_ras_OBUF_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_ras_OBUF_REG_CLK
    );
  NlwBufferBlock_ras_OBUF_D_IN0 : X_BUF
    port map (
      I => ras_OBUF_D1_230,
      O => NlwBufferSignal_ras_OBUF_D_IN0
    );
  NlwBufferBlock_ras_OBUF_D_IN1 : X_BUF
    port map (
      I => ras_OBUF_D2_231,
      O => NlwBufferSignal_ras_OBUF_D_IN1
    );
  NlwBufferBlock_ras_OBUF_D2_PT_0_IN0 : X_BUF
    port map (
      I => EXP2_EXP_232,
      O => NlwBufferSignal_ras_OBUF_D2_PT_0_IN0
    );
  NlwBufferBlock_ras_OBUF_D2_PT_0_IN1 : X_BUF
    port map (
      I => EXP2_EXP_232,
      O => NlwBufferSignal_ras_OBUF_D2_PT_0_IN1
    );
  NlwBufferBlock_ras_OBUF_D2_PT_1_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_ras_OBUF_D2_PT_1_IN0
    );
  NlwBufferBlock_ras_OBUF_D2_PT_1_IN1 : X_BUF
    port map (
      I => ras_PIN_BUF_Q_63,
      O => NlwBufferSignal_ras_OBUF_D2_PT_1_IN1
    );
  NlwBufferBlock_ras_OBUF_D2_PT_2_IN0 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_ras_OBUF_D2_PT_2_IN0
    );
  NlwBufferBlock_ras_OBUF_D2_PT_2_IN1 : X_BUF
    port map (
      I => ras_PIN_BUF_Q_63,
      O => NlwBufferSignal_ras_OBUF_D2_PT_2_IN1
    );
  NlwBufferBlock_ras_OBUF_D2_PT_3_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_ras_OBUF_D2_PT_3_IN0
    );
  NlwBufferBlock_ras_OBUF_D2_PT_3_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_ras_OBUF_D2_PT_3_IN1
    );
  NlwBufferBlock_ras_OBUF_D2_PT_3_IN2 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_ras_OBUF_D2_PT_3_IN2
    );
  NlwBufferBlock_ras_OBUF_D2_PT_4_IN0 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_ras_OBUF_D2_PT_4_IN0
    );
  NlwBufferBlock_ras_OBUF_D2_PT_4_IN1 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_ras_OBUF_D2_PT_4_IN1
    );
  NlwBufferBlock_ras_OBUF_D2_PT_4_IN2 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_ras_OBUF_D2_PT_4_IN2
    );
  NlwBufferBlock_ras_OBUF_D2_PT_4_IN3 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_ras_OBUF_D2_PT_4_IN3
    );
  NlwBufferBlock_ras_OBUF_D2_PT_4_IN4 : X_BUF
    port map (
      I => refcnt(4),
      O => NlwBufferSignal_ras_OBUF_D2_PT_4_IN4
    );
  NlwBufferBlock_ras_OBUF_D2_PT_4_IN5 : X_BUF
    port map (
      I => refcnt(5),
      O => NlwBufferSignal_ras_OBUF_D2_PT_4_IN5
    );
  NlwBufferBlock_ras_OBUF_D2_PT_4_IN6 : X_BUF
    port map (
      I => refcnt(6),
      O => NlwBufferSignal_ras_OBUF_D2_PT_4_IN6
    );
  NlwBufferBlock_ras_OBUF_D2_PT_4_IN7 : X_BUF
    port map (
      I => refcnt(7),
      O => NlwBufferSignal_ras_OBUF_D2_PT_4_IN7
    );
  NlwBufferBlock_ras_OBUF_D2_PT_4_IN8 : X_BUF
    port map (
      I => ras_PIN_BUF_Q_63,
      O => NlwBufferSignal_ras_OBUF_D2_PT_4_IN8
    );
  NlwBufferBlock_ras_OBUF_D2_PT_4_IN9 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_ras_OBUF_D2_PT_4_IN9
    );
  NlwBufferBlock_ras_OBUF_D2_PT_4_IN10 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_ras_OBUF_D2_PT_4_IN10
    );
  NlwBufferBlock_ras_OBUF_D2_PT_4_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_ras_OBUF_D2_PT_4_IN11
    );
  NlwBufferBlock_ras_OBUF_D2_PT_4_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_ras_OBUF_D2_PT_4_IN12
    );
  NlwBufferBlock_ras_OBUF_D2_PT_4_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_ras_OBUF_D2_PT_4_IN13
    );
  NlwBufferBlock_ras_OBUF_D2_PT_4_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_ras_OBUF_D2_PT_4_IN14
    );
  NlwBufferBlock_ras_OBUF_D2_PT_4_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_ras_OBUF_D2_PT_4_IN15
    );
  NlwBufferBlock_ras_OBUF_D2_PT_5_IN0 : X_BUF
    port map (
      I => bank_4_IBUF_1,
      O => NlwBufferSignal_ras_OBUF_D2_PT_5_IN0
    );
  NlwBufferBlock_ras_OBUF_D2_PT_5_IN1 : X_BUF
    port map (
      I => bank_3_IBUF_3,
      O => NlwBufferSignal_ras_OBUF_D2_PT_5_IN1
    );
  NlwBufferBlock_ras_OBUF_D2_PT_5_IN2 : X_BUF
    port map (
      I => bank_2_IBUF_5,
      O => NlwBufferSignal_ras_OBUF_D2_PT_5_IN2
    );
  NlwBufferBlock_ras_OBUF_D2_PT_5_IN3 : X_BUF
    port map (
      I => bank_1_IBUF_7,
      O => NlwBufferSignal_ras_OBUF_D2_PT_5_IN3
    );
  NlwBufferBlock_ras_OBUF_D2_PT_5_IN4 : X_BUF
    port map (
      I => bank_0_IBUF_9,
      O => NlwBufferSignal_ras_OBUF_D2_PT_5_IN4
    );
  NlwBufferBlock_ras_OBUF_D2_PT_5_IN5 : X_BUF
    port map (
      I => a15_13_2_IBUF_11,
      O => NlwBufferSignal_ras_OBUF_D2_PT_5_IN5
    );
  NlwBufferBlock_ras_OBUF_D2_PT_5_IN6 : X_BUF
    port map (
      I => a15_13_1_IBUF_13,
      O => NlwBufferSignal_ras_OBUF_D2_PT_5_IN6
    );
  NlwBufferBlock_ras_OBUF_D2_PT_5_IN7 : X_BUF
    port map (
      I => a15_13_0_IBUF_15,
      O => NlwBufferSignal_ras_OBUF_D2_PT_5_IN7
    );
  NlwBufferBlock_ras_OBUF_D2_PT_5_IN8 : X_BUF
    port map (
      I => bank_6_IBUF_19,
      O => NlwBufferSignal_ras_OBUF_D2_PT_5_IN8
    );
  NlwBufferBlock_ras_OBUF_D2_PT_5_IN9 : X_BUF
    port map (
      I => bank_5_IBUF_21,
      O => NlwBufferSignal_ras_OBUF_D2_PT_5_IN9
    );
  NlwBufferBlock_ras_OBUF_D2_PT_5_IN10 : X_BUF
    port map (
      I => bank_7_IBUF_23,
      O => NlwBufferSignal_ras_OBUF_D2_PT_5_IN10
    );
  NlwBufferBlock_ras_OBUF_D2_PT_5_IN11 : X_BUF
    port map (
      I => ras_PIN_BUF_Q_63,
      O => NlwBufferSignal_ras_OBUF_D2_PT_5_IN11
    );
  NlwBufferBlock_ras_OBUF_D2_PT_5_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_ras_OBUF_D2_PT_5_IN12
    );
  NlwBufferBlock_ras_OBUF_D2_PT_5_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_ras_OBUF_D2_PT_5_IN13
    );
  NlwBufferBlock_ras_OBUF_D2_PT_5_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_ras_OBUF_D2_PT_5_IN14
    );
  NlwBufferBlock_ras_OBUF_D2_PT_5_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_ras_OBUF_D2_PT_5_IN15
    );
  NlwBufferBlock_ras_OBUF_D2_IN0 : X_BUF
    port map (
      I => ras_OBUF_D2_PT_0_233,
      O => NlwBufferSignal_ras_OBUF_D2_IN0
    );
  NlwBufferBlock_ras_OBUF_D2_IN1 : X_BUF
    port map (
      I => ras_OBUF_D2_PT_1_234,
      O => NlwBufferSignal_ras_OBUF_D2_IN1
    );
  NlwBufferBlock_ras_OBUF_D2_IN2 : X_BUF
    port map (
      I => ras_OBUF_D2_PT_2_235,
      O => NlwBufferSignal_ras_OBUF_D2_IN2
    );
  NlwBufferBlock_ras_OBUF_D2_IN3 : X_BUF
    port map (
      I => ras_OBUF_D2_PT_3_236,
      O => NlwBufferSignal_ras_OBUF_D2_IN3
    );
  NlwBufferBlock_ras_OBUF_D2_IN4 : X_BUF
    port map (
      I => ras_OBUF_D2_PT_4_241,
      O => NlwBufferSignal_ras_OBUF_D2_IN4
    );
  NlwBufferBlock_ras_OBUF_D2_IN5 : X_BUF
    port map (
      I => ras_OBUF_D2_PT_5_242,
      O => NlwBufferSignal_ras_OBUF_D2_IN5
    );
  NlwBufferBlock_iocnt_0_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => iocnt_0_D_244,
      O => NlwBufferSignal_iocnt_0_tsimcreated_xor_IN0
    );
  NlwBufferBlock_iocnt_0_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => iocnt_0_Q_243,
      O => NlwBufferSignal_iocnt_0_tsimcreated_xor_IN1
    );
  NlwBufferBlock_iocnt_0_REG_IN : X_BUF
    port map (
      I => iocnt_0_tsimcreated_xor_Q_245,
      O => NlwBufferSignal_iocnt_0_REG_IN
    );
  NlwBufferBlock_iocnt_0_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_iocnt_0_REG_CLK
    );
  NlwBufferBlock_iocnt_0_D_IN0 : X_BUF
    port map (
      I => iocnt_0_D1_246,
      O => NlwBufferSignal_iocnt_0_D_IN0
    );
  NlwBufferBlock_iocnt_0_D_IN1 : X_BUF
    port map (
      I => iocnt_0_D2_247,
      O => NlwBufferSignal_iocnt_0_D_IN1
    );
  NlwBufferBlock_iocnt_0_D2_PT_0_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_iocnt_0_D2_PT_0_IN0
    );
  NlwBufferBlock_iocnt_0_D2_PT_0_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_iocnt_0_D2_PT_0_IN1
    );
  NlwBufferBlock_iocnt_0_D2_PT_0_IN2 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_iocnt_0_D2_PT_0_IN2
    );
  NlwBufferBlock_iocnt_0_D2_PT_0_IN3 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_iocnt_0_D2_PT_0_IN3
    );
  NlwBufferBlock_iocnt_0_D2_PT_1_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_iocnt_0_D2_PT_1_IN0
    );
  NlwBufferBlock_iocnt_0_D2_PT_1_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_iocnt_0_D2_PT_1_IN1
    );
  NlwBufferBlock_iocnt_0_D2_PT_1_IN2 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_iocnt_0_D2_PT_1_IN2
    );
  NlwBufferBlock_iocnt_0_D2_PT_1_IN3 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_iocnt_0_D2_PT_1_IN3
    );
  NlwBufferBlock_iocnt_0_D2_PT_2_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_iocnt_0_D2_PT_2_IN0
    );
  NlwBufferBlock_iocnt_0_D2_PT_2_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_iocnt_0_D2_PT_2_IN1
    );
  NlwBufferBlock_iocnt_0_D2_PT_2_IN2 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_iocnt_0_D2_PT_2_IN2
    );
  NlwBufferBlock_iocnt_0_D2_PT_2_IN3 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_iocnt_0_D2_PT_2_IN3
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN0 : X_BUF
    port map (
      I => bank_4_IBUF_1,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN0
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN1 : X_BUF
    port map (
      I => bank_3_IBUF_3,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN1
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN2 : X_BUF
    port map (
      I => bank_2_IBUF_5,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN2
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN3 : X_BUF
    port map (
      I => bank_1_IBUF_7,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN3
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN4 : X_BUF
    port map (
      I => bank_0_IBUF_9,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN4
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN5 : X_BUF
    port map (
      I => a15_13_2_IBUF_11,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN5
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN6 : X_BUF
    port map (
      I => a15_13_1_IBUF_13,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN6
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN7 : X_BUF
    port map (
      I => a15_13_0_IBUF_15,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN7
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN8 : X_BUF
    port map (
      I => bank_6_IBUF_19,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN8
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN9 : X_BUF
    port map (
      I => bank_5_IBUF_21,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN9
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN10 : X_BUF
    port map (
      I => bank_7_IBUF_23,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN10
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN11 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN11
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN12 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN12
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN13 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN13
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN14 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN14
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN15 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN15
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN16 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN16
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN17 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN17
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN18 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN18
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN19 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN19
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN20 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN20
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN21 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN21
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN22 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN22
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN23 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN23
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN24 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN24
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN25 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN25
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN26 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN26
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN27 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN27
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN28 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN28
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN29 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN29
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN30 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN30
    );
  NlwBufferBlock_iocnt_0_D2_PT_3_IN31 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_iocnt_0_D2_PT_3_IN31
    );
  NlwBufferBlock_iocnt_0_D2_IN0 : X_BUF
    port map (
      I => iocnt_0_D2_PT_0_248,
      O => NlwBufferSignal_iocnt_0_D2_IN0
    );
  NlwBufferBlock_iocnt_0_D2_IN1 : X_BUF
    port map (
      I => iocnt_0_D2_PT_1_249,
      O => NlwBufferSignal_iocnt_0_D2_IN1
    );
  NlwBufferBlock_iocnt_0_D2_IN2 : X_BUF
    port map (
      I => iocnt_0_D2_PT_2_250,
      O => NlwBufferSignal_iocnt_0_D2_IN2
    );
  NlwBufferBlock_iocnt_0_D2_IN3 : X_BUF
    port map (
      I => iocnt_0_D2_PT_3_251,
      O => NlwBufferSignal_iocnt_0_D2_IN3
    );
  NlwBufferBlock_iocnt_1_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => iocnt_1_D_253,
      O => NlwBufferSignal_iocnt_1_tsimcreated_xor_IN0
    );
  NlwBufferBlock_iocnt_1_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => iocnt_1_Q_252,
      O => NlwBufferSignal_iocnt_1_tsimcreated_xor_IN1
    );
  NlwBufferBlock_iocnt_1_REG_IN : X_BUF
    port map (
      I => iocnt_1_tsimcreated_xor_Q_254,
      O => NlwBufferSignal_iocnt_1_REG_IN
    );
  NlwBufferBlock_iocnt_1_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_iocnt_1_REG_CLK
    );
  NlwBufferBlock_iocnt_1_D_IN0 : X_BUF
    port map (
      I => iocnt_1_D1_255,
      O => NlwBufferSignal_iocnt_1_D_IN0
    );
  NlwBufferBlock_iocnt_1_D_IN1 : X_BUF
    port map (
      I => iocnt_1_D2_256,
      O => NlwBufferSignal_iocnt_1_D_IN1
    );
  NlwBufferBlock_iocnt_1_D2_PT_0_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_iocnt_1_D2_PT_0_IN0
    );
  NlwBufferBlock_iocnt_1_D2_PT_0_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_iocnt_1_D2_PT_0_IN1
    );
  NlwBufferBlock_iocnt_1_D2_PT_0_IN2 : X_BUF
    port map (
      I => counter(2),
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
      I => counter(0),
      O => NlwBufferSignal_iocnt_1_D2_PT_1_IN0
    );
  NlwBufferBlock_iocnt_1_D2_PT_1_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_iocnt_1_D2_PT_1_IN1
    );
  NlwBufferBlock_iocnt_1_D2_PT_1_IN2 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_iocnt_1_D2_PT_1_IN2
    );
  NlwBufferBlock_iocnt_1_D2_PT_1_IN3 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_iocnt_1_D2_PT_1_IN3
    );
  NlwBufferBlock_iocnt_1_D2_PT_1_IN4 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_iocnt_1_D2_PT_1_IN4
    );
  NlwBufferBlock_iocnt_1_D2_IN0 : X_BUF
    port map (
      I => iocnt_1_D2_PT_0_257,
      O => NlwBufferSignal_iocnt_1_D2_IN0
    );
  NlwBufferBlock_iocnt_1_D2_IN1 : X_BUF
    port map (
      I => iocnt_1_D2_PT_1_258,
      O => NlwBufferSignal_iocnt_1_D2_IN1
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
      I => counter(0),
      O => NlwBufferSignal_iocnt_2_D2_PT_0_IN0
    );
  NlwBufferBlock_iocnt_2_D2_PT_0_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_iocnt_2_D2_PT_0_IN1
    );
  NlwBufferBlock_iocnt_2_D2_PT_0_IN2 : X_BUF
    port map (
      I => counter(2),
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
      I => counter(0),
      O => NlwBufferSignal_iocnt_2_D2_PT_1_IN0
    );
  NlwBufferBlock_iocnt_2_D2_PT_1_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_iocnt_2_D2_PT_1_IN1
    );
  NlwBufferBlock_iocnt_2_D2_PT_1_IN2 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_iocnt_2_D2_PT_1_IN2
    );
  NlwBufferBlock_iocnt_2_D2_PT_1_IN3 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_iocnt_2_D2_PT_1_IN3
    );
  NlwBufferBlock_iocnt_2_D2_PT_1_IN4 : X_BUF
    port map (
      I => iocnt(2),
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
      I => counter(0),
      O => NlwBufferSignal_counter_0_D2_IN0
    );
  NlwBufferBlock_counter_0_D2_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_counter_0_D2_IN1
    );
  NlwBufferBlock_counter_0_D2_IN2 : X_BUF
    port map (
      I => counter(2),
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
      I => counter(0),
      O => NlwBufferSignal_counter_1_D2_PT_1_IN0
    );
  NlwBufferBlock_counter_1_D2_PT_1_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_counter_1_D2_PT_1_IN1
    );
  NlwBufferBlock_counter_1_D2_PT_1_IN2 : X_BUF
    port map (
      I => counter(2),
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
  NlwBufferBlock_counter_2_REG_IN : X_BUF
    port map (
      I => counter_2_D_278,
      O => NlwBufferSignal_counter_2_REG_IN
    );
  NlwBufferBlock_counter_2_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_counter_2_REG_CLK
    );
  NlwBufferBlock_counter_2_D_IN0 : X_BUF
    port map (
      I => counter_2_D1_279,
      O => NlwBufferSignal_counter_2_D_IN0
    );
  NlwBufferBlock_counter_2_D_IN1 : X_BUF
    port map (
      I => counter_2_D2_280,
      O => NlwBufferSignal_counter_2_D_IN1
    );
  NlwBufferBlock_counter_2_D2_PT_0_IN0 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_counter_2_D2_PT_0_IN0
    );
  NlwBufferBlock_counter_2_D2_PT_0_IN1 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_counter_2_D2_PT_0_IN1
    );
  NlwBufferBlock_counter_2_D2_PT_1_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_counter_2_D2_PT_1_IN0
    );
  NlwBufferBlock_counter_2_D2_PT_1_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_counter_2_D2_PT_1_IN1
    );
  NlwBufferBlock_counter_2_D2_PT_1_IN2 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_counter_2_D2_PT_1_IN2
    );
  NlwBufferBlock_counter_2_D2_IN0 : X_BUF
    port map (
      I => counter_2_D2_PT_0_281,
      O => NlwBufferSignal_counter_2_D2_IN0
    );
  NlwBufferBlock_counter_2_D2_IN1 : X_BUF
    port map (
      I => counter_2_D2_PT_1_282,
      O => NlwBufferSignal_counter_2_D2_IN1
    );
  NlwBufferBlock_refcnt_0_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => refcnt_0_D_284,
      O => NlwBufferSignal_refcnt_0_tsimcreated_xor_IN0
    );
  NlwBufferBlock_refcnt_0_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => refcnt_0_Q_283,
      O => NlwBufferSignal_refcnt_0_tsimcreated_xor_IN1
    );
  NlwBufferBlock_refcnt_0_REG_IN : X_BUF
    port map (
      I => refcnt_0_tsimcreated_xor_Q_285,
      O => NlwBufferSignal_refcnt_0_REG_IN
    );
  NlwBufferBlock_refcnt_0_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_refcnt_0_REG_CLK
    );
  NlwBufferBlock_refcnt_0_D_IN0 : X_BUF
    port map (
      I => refcnt_0_D1_286,
      O => NlwBufferSignal_refcnt_0_D_IN0
    );
  NlwBufferBlock_refcnt_0_D_IN1 : X_BUF
    port map (
      I => refcnt_0_D2_287,
      O => NlwBufferSignal_refcnt_0_D_IN1
    );
  NlwBufferBlock_refcnt_0_D2_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_0_D2_IN0
    );
  NlwBufferBlock_refcnt_0_D2_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_0_D2_IN1
    );
  NlwBufferBlock_refcnt_0_D2_IN2 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_0_D2_IN2
    );
  NlwBufferBlock_refcnt_1_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => refcnt_1_D_290,
      O => NlwBufferSignal_refcnt_1_tsimcreated_xor_IN0
    );
  NlwBufferBlock_refcnt_1_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => refcnt_1_Q_288,
      O => NlwBufferSignal_refcnt_1_tsimcreated_xor_IN1
    );
  NlwBufferBlock_refcnt_1_REG_IN : X_BUF
    port map (
      I => refcnt_1_tsimcreated_xor_Q_291,
      O => NlwBufferSignal_refcnt_1_REG_IN
    );
  NlwBufferBlock_refcnt_1_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_refcnt_1_REG_CLK
    );
  NlwBufferBlock_refcnt_1_D_IN0 : X_BUF
    port map (
      I => refcnt_1_D1_292,
      O => NlwBufferSignal_refcnt_1_D_IN0
    );
  NlwBufferBlock_refcnt_1_D_IN1 : X_BUF
    port map (
      I => refcnt_1_D2_293,
      O => NlwBufferSignal_refcnt_1_D_IN1
    );
  NlwBufferBlock_refcnt_1_D2_PT_0_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_1_D2_PT_0_IN0
    );
  NlwBufferBlock_refcnt_1_D2_PT_0_IN1 : X_BUF
    port map (
      I => counter(0),
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
      I => counter(2),
      O => NlwBufferSignal_refcnt_1_D2_PT_2_IN0
    );
  NlwBufferBlock_refcnt_1_D2_PT_2_IN1 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_1_D2_PT_2_IN1
    );
  NlwBufferBlock_refcnt_1_D2_PT_3_IN0 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_refcnt_1_D2_PT_3_IN0
    );
  NlwBufferBlock_refcnt_1_D2_PT_3_IN1 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_refcnt_1_D2_PT_3_IN1
    );
  NlwBufferBlock_refcnt_1_D2_PT_4_IN0 : X_BUF
    port map (
      I => refcnt_4_EXP_298,
      O => NlwBufferSignal_refcnt_1_D2_PT_4_IN0
    );
  NlwBufferBlock_refcnt_1_D2_PT_4_IN1 : X_BUF
    port map (
      I => refcnt_4_EXP_298,
      O => NlwBufferSignal_refcnt_1_D2_PT_4_IN1
    );
  NlwBufferBlock_refcnt_1_D2_IN0 : X_BUF
    port map (
      I => refcnt_1_D2_PT_0_294,
      O => NlwBufferSignal_refcnt_1_D2_IN0
    );
  NlwBufferBlock_refcnt_1_D2_IN1 : X_BUF
    port map (
      I => refcnt_1_D2_PT_1_295,
      O => NlwBufferSignal_refcnt_1_D2_IN1
    );
  NlwBufferBlock_refcnt_1_D2_IN2 : X_BUF
    port map (
      I => refcnt_1_D2_PT_2_296,
      O => NlwBufferSignal_refcnt_1_D2_IN2
    );
  NlwBufferBlock_refcnt_1_D2_IN3 : X_BUF
    port map (
      I => refcnt_1_D2_PT_3_297,
      O => NlwBufferSignal_refcnt_1_D2_IN3
    );
  NlwBufferBlock_refcnt_1_D2_IN4 : X_BUF
    port map (
      I => refcnt_1_D2_PT_4_299,
      O => NlwBufferSignal_refcnt_1_D2_IN4
    );
  NlwBufferBlock_refcnt_1_EXP_tsimrenamed_net_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN0
    );
  NlwBufferBlock_refcnt_1_EXP_tsimrenamed_net_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN1
    );
  NlwBufferBlock_refcnt_1_EXP_tsimrenamed_net_IN2 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN2
    );
  NlwBufferBlock_refcnt_1_EXP_tsimrenamed_net_IN3 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN3
    );
  NlwBufferBlock_refcnt_1_EXP_tsimrenamed_net_IN4 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN4
    );
  NlwBufferBlock_refcnt_1_EXP_tsimrenamed_net_IN5 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN5
    );
  NlwBufferBlock_refcnt_1_EXP_tsimrenamed_net_IN6 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN6
    );
  NlwBufferBlock_refcnt_1_EXP_tsimrenamed_net_IN7 : X_BUF
    port map (
      I => refcnt(4),
      O => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN7
    );
  NlwBufferBlock_refcnt_1_EXP_tsimrenamed_net_IN8 : X_BUF
    port map (
      I => refcnt(5),
      O => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN8
    );
  NlwBufferBlock_refcnt_1_EXP_tsimrenamed_net_IN9 : X_BUF
    port map (
      I => refcnt(6),
      O => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN9
    );
  NlwBufferBlock_refcnt_1_EXP_tsimrenamed_net_IN10 : X_BUF
    port map (
      I => refcnt(7),
      O => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN10
    );
  NlwBufferBlock_refcnt_1_EXP_tsimrenamed_net_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN11
    );
  NlwBufferBlock_refcnt_1_EXP_tsimrenamed_net_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN12
    );
  NlwBufferBlock_refcnt_1_EXP_tsimrenamed_net_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN13
    );
  NlwBufferBlock_refcnt_1_EXP_tsimrenamed_net_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN14
    );
  NlwBufferBlock_refcnt_1_EXP_tsimrenamed_net_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN15
    );
  NlwBufferBlock_refcnt_2_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => refcnt_2_D_302,
      O => NlwBufferSignal_refcnt_2_tsimcreated_xor_IN0
    );
  NlwBufferBlock_refcnt_2_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => refcnt_2_Q_300,
      O => NlwBufferSignal_refcnt_2_tsimcreated_xor_IN1
    );
  NlwBufferBlock_refcnt_2_REG_IN : X_BUF
    port map (
      I => refcnt_2_tsimcreated_xor_Q_303,
      O => NlwBufferSignal_refcnt_2_REG_IN
    );
  NlwBufferBlock_refcnt_2_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_refcnt_2_REG_CLK
    );
  NlwBufferBlock_refcnt_2_D_IN0 : X_BUF
    port map (
      I => refcnt_2_D1_304,
      O => NlwBufferSignal_refcnt_2_D_IN0
    );
  NlwBufferBlock_refcnt_2_D_IN1 : X_BUF
    port map (
      I => refcnt_2_D2_305,
      O => NlwBufferSignal_refcnt_2_D_IN1
    );
  NlwBufferBlock_refcnt_2_D2_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_2_D2_IN0
    );
  NlwBufferBlock_refcnt_2_D2_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_2_D2_IN1
    );
  NlwBufferBlock_refcnt_2_D2_IN2 : X_BUF
    port map (
      I => counter(2),
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
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_refcnt_2_EXP_PT_0_IN0
    );
  NlwBufferBlock_refcnt_2_EXP_PT_0_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_refcnt_2_EXP_PT_0_IN1
    );
  NlwBufferBlock_refcnt_2_EXP_PT_0_IN2 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_2_EXP_PT_0_IN2
    );
  NlwBufferBlock_refcnt_2_EXP_PT_0_IN3 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_2_EXP_PT_0_IN3
    );
  NlwBufferBlock_refcnt_2_EXP_PT_0_IN4 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_2_EXP_PT_0_IN4
    );
  NlwBufferBlock_refcnt_2_EXP_PT_0_IN5 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_refcnt_2_EXP_PT_0_IN5
    );
  NlwBufferBlock_refcnt_2_EXP_PT_0_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_refcnt_2_EXP_PT_0_IN6
    );
  NlwBufferBlock_refcnt_2_EXP_PT_0_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_refcnt_2_EXP_PT_0_IN7
    );
  NlwBufferBlock_refcnt_2_EXP_PT_0_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_refcnt_2_EXP_PT_0_IN8
    );
  NlwBufferBlock_refcnt_2_EXP_PT_0_IN9 : X_BUF
    port map (
      I => cas2_PIN_BUF_Q_41,
      O => NlwBufferSignal_refcnt_2_EXP_PT_0_IN9
    );
  NlwBufferBlock_refcnt_2_EXP_PT_0_IN10 : X_BUF
    port map (
      I => refcnt(4),
      O => NlwBufferSignal_refcnt_2_EXP_PT_0_IN10
    );
  NlwBufferBlock_refcnt_2_EXP_PT_0_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_2_EXP_PT_0_IN11
    );
  NlwBufferBlock_refcnt_2_EXP_PT_0_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_2_EXP_PT_0_IN12
    );
  NlwBufferBlock_refcnt_2_EXP_PT_0_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_2_EXP_PT_0_IN13
    );
  NlwBufferBlock_refcnt_2_EXP_PT_0_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_2_EXP_PT_0_IN14
    );
  NlwBufferBlock_refcnt_2_EXP_PT_0_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_2_EXP_PT_0_IN15
    );
  NlwBufferBlock_refcnt_2_EXP_PT_1_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_refcnt_2_EXP_PT_1_IN0
    );
  NlwBufferBlock_refcnt_2_EXP_PT_1_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_refcnt_2_EXP_PT_1_IN1
    );
  NlwBufferBlock_refcnt_2_EXP_PT_1_IN2 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_2_EXP_PT_1_IN2
    );
  NlwBufferBlock_refcnt_2_EXP_PT_1_IN3 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_2_EXP_PT_1_IN3
    );
  NlwBufferBlock_refcnt_2_EXP_PT_1_IN4 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_2_EXP_PT_1_IN4
    );
  NlwBufferBlock_refcnt_2_EXP_PT_1_IN5 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_refcnt_2_EXP_PT_1_IN5
    );
  NlwBufferBlock_refcnt_2_EXP_PT_1_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_refcnt_2_EXP_PT_1_IN6
    );
  NlwBufferBlock_refcnt_2_EXP_PT_1_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_refcnt_2_EXP_PT_1_IN7
    );
  NlwBufferBlock_refcnt_2_EXP_PT_1_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_refcnt_2_EXP_PT_1_IN8
    );
  NlwBufferBlock_refcnt_2_EXP_PT_1_IN9 : X_BUF
    port map (
      I => cas2_PIN_BUF_Q_41,
      O => NlwBufferSignal_refcnt_2_EXP_PT_1_IN9
    );
  NlwBufferBlock_refcnt_2_EXP_PT_1_IN10 : X_BUF
    port map (
      I => refcnt(5),
      O => NlwBufferSignal_refcnt_2_EXP_PT_1_IN10
    );
  NlwBufferBlock_refcnt_2_EXP_PT_1_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_2_EXP_PT_1_IN11
    );
  NlwBufferBlock_refcnt_2_EXP_PT_1_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_2_EXP_PT_1_IN12
    );
  NlwBufferBlock_refcnt_2_EXP_PT_1_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_2_EXP_PT_1_IN13
    );
  NlwBufferBlock_refcnt_2_EXP_PT_1_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_2_EXP_PT_1_IN14
    );
  NlwBufferBlock_refcnt_2_EXP_PT_1_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_2_EXP_PT_1_IN15
    );
  NlwBufferBlock_refcnt_2_EXP_tsimrenamed_net_IN0 : X_BUF
    port map (
      I => refcnt_2_EXP_PT_0_306,
      O => NlwBufferSignal_refcnt_2_EXP_tsimrenamed_net_IN0
    );
  NlwBufferBlock_refcnt_2_EXP_tsimrenamed_net_IN1 : X_BUF
    port map (
      I => refcnt_2_EXP_PT_1_307,
      O => NlwBufferSignal_refcnt_2_EXP_tsimrenamed_net_IN1
    );
  NlwBufferBlock_refcnt_3_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => refcnt_3_D_310,
      O => NlwBufferSignal_refcnt_3_tsimcreated_xor_IN0
    );
  NlwBufferBlock_refcnt_3_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => refcnt_3_Q_308,
      O => NlwBufferSignal_refcnt_3_tsimcreated_xor_IN1
    );
  NlwBufferBlock_refcnt_3_REG_IN : X_BUF
    port map (
      I => refcnt_3_tsimcreated_xor_Q_311,
      O => NlwBufferSignal_refcnt_3_REG_IN
    );
  NlwBufferBlock_refcnt_3_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_refcnt_3_REG_CLK
    );
  NlwBufferBlock_refcnt_3_D_IN0 : X_BUF
    port map (
      I => refcnt_3_D1_312,
      O => NlwBufferSignal_refcnt_3_D_IN0
    );
  NlwBufferBlock_refcnt_3_D_IN1 : X_BUF
    port map (
      I => refcnt_3_D2_313,
      O => NlwBufferSignal_refcnt_3_D_IN1
    );
  NlwBufferBlock_refcnt_3_D2_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_3_D2_IN0
    );
  NlwBufferBlock_refcnt_3_D2_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_3_D2_IN1
    );
  NlwBufferBlock_refcnt_3_D2_IN2 : X_BUF
    port map (
      I => counter(2),
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
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_refcnt_3_EXP_PT_0_IN0
    );
  NlwBufferBlock_refcnt_3_EXP_PT_0_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_refcnt_3_EXP_PT_0_IN1
    );
  NlwBufferBlock_refcnt_3_EXP_PT_0_IN2 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_3_EXP_PT_0_IN2
    );
  NlwBufferBlock_refcnt_3_EXP_PT_0_IN3 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_3_EXP_PT_0_IN3
    );
  NlwBufferBlock_refcnt_3_EXP_PT_0_IN4 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_3_EXP_PT_0_IN4
    );
  NlwBufferBlock_refcnt_3_EXP_PT_0_IN5 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_refcnt_3_EXP_PT_0_IN5
    );
  NlwBufferBlock_refcnt_3_EXP_PT_0_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_refcnt_3_EXP_PT_0_IN6
    );
  NlwBufferBlock_refcnt_3_EXP_PT_0_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_refcnt_3_EXP_PT_0_IN7
    );
  NlwBufferBlock_refcnt_3_EXP_PT_0_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_refcnt_3_EXP_PT_0_IN8
    );
  NlwBufferBlock_refcnt_3_EXP_PT_0_IN9 : X_BUF
    port map (
      I => cas2_PIN_BUF_Q_41,
      O => NlwBufferSignal_refcnt_3_EXP_PT_0_IN9
    );
  NlwBufferBlock_refcnt_3_EXP_PT_0_IN10 : X_BUF
    port map (
      I => refcnt(6),
      O => NlwBufferSignal_refcnt_3_EXP_PT_0_IN10
    );
  NlwBufferBlock_refcnt_3_EXP_PT_0_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_3_EXP_PT_0_IN11
    );
  NlwBufferBlock_refcnt_3_EXP_PT_0_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_3_EXP_PT_0_IN12
    );
  NlwBufferBlock_refcnt_3_EXP_PT_0_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_3_EXP_PT_0_IN13
    );
  NlwBufferBlock_refcnt_3_EXP_PT_0_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_3_EXP_PT_0_IN14
    );
  NlwBufferBlock_refcnt_3_EXP_PT_0_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_3_EXP_PT_0_IN15
    );
  NlwBufferBlock_refcnt_3_EXP_PT_1_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_refcnt_3_EXP_PT_1_IN0
    );
  NlwBufferBlock_refcnt_3_EXP_PT_1_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_refcnt_3_EXP_PT_1_IN1
    );
  NlwBufferBlock_refcnt_3_EXP_PT_1_IN2 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_3_EXP_PT_1_IN2
    );
  NlwBufferBlock_refcnt_3_EXP_PT_1_IN3 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_3_EXP_PT_1_IN3
    );
  NlwBufferBlock_refcnt_3_EXP_PT_1_IN4 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_3_EXP_PT_1_IN4
    );
  NlwBufferBlock_refcnt_3_EXP_PT_1_IN5 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_refcnt_3_EXP_PT_1_IN5
    );
  NlwBufferBlock_refcnt_3_EXP_PT_1_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_refcnt_3_EXP_PT_1_IN6
    );
  NlwBufferBlock_refcnt_3_EXP_PT_1_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_refcnt_3_EXP_PT_1_IN7
    );
  NlwBufferBlock_refcnt_3_EXP_PT_1_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_refcnt_3_EXP_PT_1_IN8
    );
  NlwBufferBlock_refcnt_3_EXP_PT_1_IN9 : X_BUF
    port map (
      I => cas2_PIN_BUF_Q_41,
      O => NlwBufferSignal_refcnt_3_EXP_PT_1_IN9
    );
  NlwBufferBlock_refcnt_3_EXP_PT_1_IN10 : X_BUF
    port map (
      I => refcnt(7),
      O => NlwBufferSignal_refcnt_3_EXP_PT_1_IN10
    );
  NlwBufferBlock_refcnt_3_EXP_PT_1_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_3_EXP_PT_1_IN11
    );
  NlwBufferBlock_refcnt_3_EXP_PT_1_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_3_EXP_PT_1_IN12
    );
  NlwBufferBlock_refcnt_3_EXP_PT_1_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_3_EXP_PT_1_IN13
    );
  NlwBufferBlock_refcnt_3_EXP_PT_1_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_3_EXP_PT_1_IN14
    );
  NlwBufferBlock_refcnt_3_EXP_PT_1_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_3_EXP_PT_1_IN15
    );
  NlwBufferBlock_refcnt_3_EXP_tsimrenamed_net_IN0 : X_BUF
    port map (
      I => refcnt_3_EXP_PT_0_314,
      O => NlwBufferSignal_refcnt_3_EXP_tsimrenamed_net_IN0
    );
  NlwBufferBlock_refcnt_3_EXP_tsimrenamed_net_IN1 : X_BUF
    port map (
      I => refcnt_3_EXP_PT_1_315,
      O => NlwBufferSignal_refcnt_3_EXP_tsimrenamed_net_IN1
    );
  NlwBufferBlock_refcnt_4_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => refcnt_4_D_318,
      O => NlwBufferSignal_refcnt_4_tsimcreated_xor_IN0
    );
  NlwBufferBlock_refcnt_4_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => refcnt_4_Q_316,
      O => NlwBufferSignal_refcnt_4_tsimcreated_xor_IN1
    );
  NlwBufferBlock_refcnt_4_REG_IN : X_BUF
    port map (
      I => refcnt_4_tsimcreated_xor_Q_319,
      O => NlwBufferSignal_refcnt_4_REG_IN
    );
  NlwBufferBlock_refcnt_4_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_refcnt_4_REG_CLK
    );
  NlwBufferBlock_refcnt_4_D_IN0 : X_BUF
    port map (
      I => refcnt_4_D1_320,
      O => NlwBufferSignal_refcnt_4_D_IN0
    );
  NlwBufferBlock_refcnt_4_D_IN1 : X_BUF
    port map (
      I => refcnt_4_D2_321,
      O => NlwBufferSignal_refcnt_4_D_IN1
    );
  NlwBufferBlock_refcnt_4_D2_PT_0_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_4_D2_PT_0_IN0
    );
  NlwBufferBlock_refcnt_4_D2_PT_0_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_4_D2_PT_0_IN1
    );
  NlwBufferBlock_refcnt_4_D2_PT_0_IN2 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_4_D2_PT_0_IN2
    );
  NlwBufferBlock_refcnt_4_D2_PT_0_IN3 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_refcnt_4_D2_PT_0_IN3
    );
  NlwBufferBlock_refcnt_4_D2_PT_0_IN4 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_refcnt_4_D2_PT_0_IN4
    );
  NlwBufferBlock_refcnt_4_D2_PT_0_IN5 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_refcnt_4_D2_PT_0_IN5
    );
  NlwBufferBlock_refcnt_4_D2_PT_0_IN6 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_refcnt_4_D2_PT_0_IN6
    );
  NlwBufferBlock_refcnt_4_D2_PT_0_IN7 : X_BUF
    port map (
      I => refcnt(4),
      O => NlwBufferSignal_refcnt_4_D2_PT_0_IN7
    );
  NlwBufferBlock_refcnt_4_D2_PT_1_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_4_D2_PT_1_IN0
    );
  NlwBufferBlock_refcnt_4_D2_PT_1_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_4_D2_PT_1_IN1
    );
  NlwBufferBlock_refcnt_4_D2_PT_1_IN2 : X_BUF
    port map (
      I => counter(2),
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
      I => refcnt(5),
      O => NlwBufferSignal_refcnt_4_D2_PT_1_IN7
    );
  NlwBufferBlock_refcnt_4_D2_PT_2_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_4_D2_PT_2_IN0
    );
  NlwBufferBlock_refcnt_4_D2_PT_2_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_4_D2_PT_2_IN1
    );
  NlwBufferBlock_refcnt_4_D2_PT_2_IN2 : X_BUF
    port map (
      I => counter(2),
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
      I => refcnt(6),
      O => NlwBufferSignal_refcnt_4_D2_PT_2_IN7
    );
  NlwBufferBlock_refcnt_4_D2_PT_3_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_4_D2_PT_3_IN0
    );
  NlwBufferBlock_refcnt_4_D2_PT_3_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_4_D2_PT_3_IN1
    );
  NlwBufferBlock_refcnt_4_D2_PT_3_IN2 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_4_D2_PT_3_IN2
    );
  NlwBufferBlock_refcnt_4_D2_PT_3_IN3 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_refcnt_4_D2_PT_3_IN3
    );
  NlwBufferBlock_refcnt_4_D2_PT_3_IN4 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_refcnt_4_D2_PT_3_IN4
    );
  NlwBufferBlock_refcnt_4_D2_PT_3_IN5 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_refcnt_4_D2_PT_3_IN5
    );
  NlwBufferBlock_refcnt_4_D2_PT_3_IN6 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_refcnt_4_D2_PT_3_IN6
    );
  NlwBufferBlock_refcnt_4_D2_PT_3_IN7 : X_BUF
    port map (
      I => refcnt(7),
      O => NlwBufferSignal_refcnt_4_D2_PT_3_IN7
    );
  NlwBufferBlock_refcnt_4_D2_IN0 : X_BUF
    port map (
      I => refcnt_4_D2_PT_0_322,
      O => NlwBufferSignal_refcnt_4_D2_IN0
    );
  NlwBufferBlock_refcnt_4_D2_IN1 : X_BUF
    port map (
      I => refcnt_4_D2_PT_1_323,
      O => NlwBufferSignal_refcnt_4_D2_IN1
    );
  NlwBufferBlock_refcnt_4_D2_IN2 : X_BUF
    port map (
      I => refcnt_4_D2_PT_2_324,
      O => NlwBufferSignal_refcnt_4_D2_IN2
    );
  NlwBufferBlock_refcnt_4_D2_IN3 : X_BUF
    port map (
      I => refcnt_4_D2_PT_3_325,
      O => NlwBufferSignal_refcnt_4_D2_IN3
    );
  NlwBufferBlock_refcnt_4_EXP_tsimrenamed_net_IN0 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_refcnt_4_EXP_tsimrenamed_net_IN0
    );
  NlwBufferBlock_refcnt_4_EXP_tsimrenamed_net_IN1 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_refcnt_4_EXP_tsimrenamed_net_IN1
    );
  NlwBufferBlock_refcnt_4_EXP_tsimrenamed_net_IN2 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_refcnt_4_EXP_tsimrenamed_net_IN2
    );
  NlwBufferBlock_refcnt_4_EXP_tsimrenamed_net_IN3 : X_BUF
    port map (
      I => refcnt(4),
      O => NlwBufferSignal_refcnt_4_EXP_tsimrenamed_net_IN3
    );
  NlwBufferBlock_refcnt_4_EXP_tsimrenamed_net_IN4 : X_BUF
    port map (
      I => refcnt(5),
      O => NlwBufferSignal_refcnt_4_EXP_tsimrenamed_net_IN4
    );
  NlwBufferBlock_refcnt_4_EXP_tsimrenamed_net_IN5 : X_BUF
    port map (
      I => refcnt(6),
      O => NlwBufferSignal_refcnt_4_EXP_tsimrenamed_net_IN5
    );
  NlwBufferBlock_refcnt_4_EXP_tsimrenamed_net_IN6 : X_BUF
    port map (
      I => refcnt(7),
      O => NlwBufferSignal_refcnt_4_EXP_tsimrenamed_net_IN6
    );
  NlwBufferBlock_refcnt_5_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => refcnt_5_D_328,
      O => NlwBufferSignal_refcnt_5_tsimcreated_xor_IN0
    );
  NlwBufferBlock_refcnt_5_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => refcnt_5_Q_326,
      O => NlwBufferSignal_refcnt_5_tsimcreated_xor_IN1
    );
  NlwBufferBlock_refcnt_5_REG_IN : X_BUF
    port map (
      I => refcnt_5_tsimcreated_xor_Q_329,
      O => NlwBufferSignal_refcnt_5_REG_IN
    );
  NlwBufferBlock_refcnt_5_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_refcnt_5_REG_CLK
    );
  NlwBufferBlock_refcnt_5_D_IN0 : X_BUF
    port map (
      I => refcnt_5_D1_330,
      O => NlwBufferSignal_refcnt_5_D_IN0
    );
  NlwBufferBlock_refcnt_5_D_IN1 : X_BUF
    port map (
      I => refcnt_5_D2_331,
      O => NlwBufferSignal_refcnt_5_D_IN1
    );
  NlwBufferBlock_refcnt_5_D2_PT_0_IN0 : X_BUF
    port map (
      I => refcnt_6_EXP_332,
      O => NlwBufferSignal_refcnt_5_D2_PT_0_IN0
    );
  NlwBufferBlock_refcnt_5_D2_PT_0_IN1 : X_BUF
    port map (
      I => refcnt_6_EXP_332,
      O => NlwBufferSignal_refcnt_5_D2_PT_0_IN1
    );
  NlwBufferBlock_refcnt_5_D2_PT_1_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_5_D2_PT_1_IN0
    );
  NlwBufferBlock_refcnt_5_D2_PT_1_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_5_D2_PT_1_IN1
    );
  NlwBufferBlock_refcnt_5_D2_PT_1_IN2 : X_BUF
    port map (
      I => counter(2),
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
      I => refcnt(4),
      O => NlwBufferSignal_refcnt_5_D2_PT_1_IN7
    );
  NlwBufferBlock_refcnt_5_D2_PT_1_IN8 : X_BUF
    port map (
      I => refcnt(6),
      O => NlwBufferSignal_refcnt_5_D2_PT_1_IN8
    );
  NlwBufferBlock_refcnt_5_D2_PT_1_IN9 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_5_D2_PT_1_IN9
    );
  NlwBufferBlock_refcnt_5_D2_PT_1_IN10 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_5_D2_PT_1_IN10
    );
  NlwBufferBlock_refcnt_5_D2_PT_1_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_5_D2_PT_1_IN11
    );
  NlwBufferBlock_refcnt_5_D2_PT_1_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_5_D2_PT_1_IN12
    );
  NlwBufferBlock_refcnt_5_D2_PT_1_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_5_D2_PT_1_IN13
    );
  NlwBufferBlock_refcnt_5_D2_PT_1_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_5_D2_PT_1_IN14
    );
  NlwBufferBlock_refcnt_5_D2_PT_1_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_5_D2_PT_1_IN15
    );
  NlwBufferBlock_refcnt_5_D2_IN0 : X_BUF
    port map (
      I => refcnt_5_D2_PT_0_333,
      O => NlwBufferSignal_refcnt_5_D2_IN0
    );
  NlwBufferBlock_refcnt_5_D2_IN1 : X_BUF
    port map (
      I => refcnt_5_D2_PT_1_334,
      O => NlwBufferSignal_refcnt_5_D2_IN1
    );
  NlwBufferBlock_refcnt_5_EXP_PT_0_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_refcnt_5_EXP_PT_0_IN0
    );
  NlwBufferBlock_refcnt_5_EXP_PT_0_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_refcnt_5_EXP_PT_0_IN1
    );
  NlwBufferBlock_refcnt_5_EXP_PT_0_IN2 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_5_EXP_PT_0_IN2
    );
  NlwBufferBlock_refcnt_5_EXP_PT_0_IN3 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_5_EXP_PT_0_IN3
    );
  NlwBufferBlock_refcnt_5_EXP_PT_0_IN4 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_5_EXP_PT_0_IN4
    );
  NlwBufferBlock_refcnt_5_EXP_PT_0_IN5 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_refcnt_5_EXP_PT_0_IN5
    );
  NlwBufferBlock_refcnt_5_EXP_PT_0_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_refcnt_5_EXP_PT_0_IN6
    );
  NlwBufferBlock_refcnt_5_EXP_PT_0_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_refcnt_5_EXP_PT_0_IN7
    );
  NlwBufferBlock_refcnt_5_EXP_PT_0_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_refcnt_5_EXP_PT_0_IN8
    );
  NlwBufferBlock_refcnt_5_EXP_PT_0_IN9 : X_BUF
    port map (
      I => cas1_PIN_BUF_Q_39,
      O => NlwBufferSignal_refcnt_5_EXP_PT_0_IN9
    );
  NlwBufferBlock_refcnt_5_EXP_PT_0_IN10 : X_BUF
    port map (
      I => refcnt(4),
      O => NlwBufferSignal_refcnt_5_EXP_PT_0_IN10
    );
  NlwBufferBlock_refcnt_5_EXP_PT_0_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_5_EXP_PT_0_IN11
    );
  NlwBufferBlock_refcnt_5_EXP_PT_0_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_5_EXP_PT_0_IN12
    );
  NlwBufferBlock_refcnt_5_EXP_PT_0_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_5_EXP_PT_0_IN13
    );
  NlwBufferBlock_refcnt_5_EXP_PT_0_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_5_EXP_PT_0_IN14
    );
  NlwBufferBlock_refcnt_5_EXP_PT_0_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_5_EXP_PT_0_IN15
    );
  NlwBufferBlock_refcnt_5_EXP_PT_1_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_refcnt_5_EXP_PT_1_IN0
    );
  NlwBufferBlock_refcnt_5_EXP_PT_1_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_refcnt_5_EXP_PT_1_IN1
    );
  NlwBufferBlock_refcnt_5_EXP_PT_1_IN2 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_5_EXP_PT_1_IN2
    );
  NlwBufferBlock_refcnt_5_EXP_PT_1_IN3 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_5_EXP_PT_1_IN3
    );
  NlwBufferBlock_refcnt_5_EXP_PT_1_IN4 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_5_EXP_PT_1_IN4
    );
  NlwBufferBlock_refcnt_5_EXP_PT_1_IN5 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_refcnt_5_EXP_PT_1_IN5
    );
  NlwBufferBlock_refcnt_5_EXP_PT_1_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_refcnt_5_EXP_PT_1_IN6
    );
  NlwBufferBlock_refcnt_5_EXP_PT_1_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_refcnt_5_EXP_PT_1_IN7
    );
  NlwBufferBlock_refcnt_5_EXP_PT_1_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_refcnt_5_EXP_PT_1_IN8
    );
  NlwBufferBlock_refcnt_5_EXP_PT_1_IN9 : X_BUF
    port map (
      I => cas1_PIN_BUF_Q_39,
      O => NlwBufferSignal_refcnt_5_EXP_PT_1_IN9
    );
  NlwBufferBlock_refcnt_5_EXP_PT_1_IN10 : X_BUF
    port map (
      I => refcnt(5),
      O => NlwBufferSignal_refcnt_5_EXP_PT_1_IN10
    );
  NlwBufferBlock_refcnt_5_EXP_PT_1_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_5_EXP_PT_1_IN11
    );
  NlwBufferBlock_refcnt_5_EXP_PT_1_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_5_EXP_PT_1_IN12
    );
  NlwBufferBlock_refcnt_5_EXP_PT_1_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_5_EXP_PT_1_IN13
    );
  NlwBufferBlock_refcnt_5_EXP_PT_1_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_5_EXP_PT_1_IN14
    );
  NlwBufferBlock_refcnt_5_EXP_PT_1_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_5_EXP_PT_1_IN15
    );
  NlwBufferBlock_refcnt_5_EXP_PT_2_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_refcnt_5_EXP_PT_2_IN0
    );
  NlwBufferBlock_refcnt_5_EXP_PT_2_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_refcnt_5_EXP_PT_2_IN1
    );
  NlwBufferBlock_refcnt_5_EXP_PT_2_IN2 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_5_EXP_PT_2_IN2
    );
  NlwBufferBlock_refcnt_5_EXP_PT_2_IN3 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_5_EXP_PT_2_IN3
    );
  NlwBufferBlock_refcnt_5_EXP_PT_2_IN4 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_5_EXP_PT_2_IN4
    );
  NlwBufferBlock_refcnt_5_EXP_PT_2_IN5 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_refcnt_5_EXP_PT_2_IN5
    );
  NlwBufferBlock_refcnt_5_EXP_PT_2_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_refcnt_5_EXP_PT_2_IN6
    );
  NlwBufferBlock_refcnt_5_EXP_PT_2_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_refcnt_5_EXP_PT_2_IN7
    );
  NlwBufferBlock_refcnt_5_EXP_PT_2_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_refcnt_5_EXP_PT_2_IN8
    );
  NlwBufferBlock_refcnt_5_EXP_PT_2_IN9 : X_BUF
    port map (
      I => cas1_PIN_BUF_Q_39,
      O => NlwBufferSignal_refcnt_5_EXP_PT_2_IN9
    );
  NlwBufferBlock_refcnt_5_EXP_PT_2_IN10 : X_BUF
    port map (
      I => refcnt(6),
      O => NlwBufferSignal_refcnt_5_EXP_PT_2_IN10
    );
  NlwBufferBlock_refcnt_5_EXP_PT_2_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_5_EXP_PT_2_IN11
    );
  NlwBufferBlock_refcnt_5_EXP_PT_2_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_5_EXP_PT_2_IN12
    );
  NlwBufferBlock_refcnt_5_EXP_PT_2_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_5_EXP_PT_2_IN13
    );
  NlwBufferBlock_refcnt_5_EXP_PT_2_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_5_EXP_PT_2_IN14
    );
  NlwBufferBlock_refcnt_5_EXP_PT_2_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_5_EXP_PT_2_IN15
    );
  NlwBufferBlock_refcnt_5_EXP_PT_3_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_refcnt_5_EXP_PT_3_IN0
    );
  NlwBufferBlock_refcnt_5_EXP_PT_3_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_refcnt_5_EXP_PT_3_IN1
    );
  NlwBufferBlock_refcnt_5_EXP_PT_3_IN2 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_5_EXP_PT_3_IN2
    );
  NlwBufferBlock_refcnt_5_EXP_PT_3_IN3 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_5_EXP_PT_3_IN3
    );
  NlwBufferBlock_refcnt_5_EXP_PT_3_IN4 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_5_EXP_PT_3_IN4
    );
  NlwBufferBlock_refcnt_5_EXP_PT_3_IN5 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_refcnt_5_EXP_PT_3_IN5
    );
  NlwBufferBlock_refcnt_5_EXP_PT_3_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_refcnt_5_EXP_PT_3_IN6
    );
  NlwBufferBlock_refcnt_5_EXP_PT_3_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_refcnt_5_EXP_PT_3_IN7
    );
  NlwBufferBlock_refcnt_5_EXP_PT_3_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_refcnt_5_EXP_PT_3_IN8
    );
  NlwBufferBlock_refcnt_5_EXP_PT_3_IN9 : X_BUF
    port map (
      I => cas1_PIN_BUF_Q_39,
      O => NlwBufferSignal_refcnt_5_EXP_PT_3_IN9
    );
  NlwBufferBlock_refcnt_5_EXP_PT_3_IN10 : X_BUF
    port map (
      I => refcnt(7),
      O => NlwBufferSignal_refcnt_5_EXP_PT_3_IN10
    );
  NlwBufferBlock_refcnt_5_EXP_PT_3_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_5_EXP_PT_3_IN11
    );
  NlwBufferBlock_refcnt_5_EXP_PT_3_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_5_EXP_PT_3_IN12
    );
  NlwBufferBlock_refcnt_5_EXP_PT_3_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_5_EXP_PT_3_IN13
    );
  NlwBufferBlock_refcnt_5_EXP_PT_3_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_5_EXP_PT_3_IN14
    );
  NlwBufferBlock_refcnt_5_EXP_PT_3_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_5_EXP_PT_3_IN15
    );
  NlwBufferBlock_refcnt_5_EXP_tsimrenamed_net_IN0 : X_BUF
    port map (
      I => refcnt_5_EXP_PT_0_335,
      O => NlwBufferSignal_refcnt_5_EXP_tsimrenamed_net_IN0
    );
  NlwBufferBlock_refcnt_5_EXP_tsimrenamed_net_IN1 : X_BUF
    port map (
      I => refcnt_5_EXP_PT_1_336,
      O => NlwBufferSignal_refcnt_5_EXP_tsimrenamed_net_IN1
    );
  NlwBufferBlock_refcnt_5_EXP_tsimrenamed_net_IN2 : X_BUF
    port map (
      I => refcnt_5_EXP_PT_2_337,
      O => NlwBufferSignal_refcnt_5_EXP_tsimrenamed_net_IN2
    );
  NlwBufferBlock_refcnt_5_EXP_tsimrenamed_net_IN3 : X_BUF
    port map (
      I => refcnt_5_EXP_PT_3_338,
      O => NlwBufferSignal_refcnt_5_EXP_tsimrenamed_net_IN3
    );
  NlwBufferBlock_refcnt_6_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => refcnt_6_D_341,
      O => NlwBufferSignal_refcnt_6_tsimcreated_xor_IN0
    );
  NlwBufferBlock_refcnt_6_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => refcnt_6_Q_339,
      O => NlwBufferSignal_refcnt_6_tsimcreated_xor_IN1
    );
  NlwBufferBlock_refcnt_6_REG_IN : X_BUF
    port map (
      I => refcnt_6_tsimcreated_xor_Q_342,
      O => NlwBufferSignal_refcnt_6_REG_IN
    );
  NlwBufferBlock_refcnt_6_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_refcnt_6_REG_CLK
    );
  NlwBufferBlock_refcnt_6_D_IN0 : X_BUF
    port map (
      I => refcnt_6_D1_343,
      O => NlwBufferSignal_refcnt_6_D_IN0
    );
  NlwBufferBlock_refcnt_6_D_IN1 : X_BUF
    port map (
      I => refcnt_6_D2_344,
      O => NlwBufferSignal_refcnt_6_D_IN1
    );
  NlwBufferBlock_refcnt_6_D2_PT_0_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_6_D2_PT_0_IN0
    );
  NlwBufferBlock_refcnt_6_D2_PT_0_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_6_D2_PT_0_IN1
    );
  NlwBufferBlock_refcnt_6_D2_PT_0_IN2 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_6_D2_PT_0_IN2
    );
  NlwBufferBlock_refcnt_6_D2_PT_0_IN3 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_refcnt_6_D2_PT_0_IN3
    );
  NlwBufferBlock_refcnt_6_D2_PT_0_IN4 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_refcnt_6_D2_PT_0_IN4
    );
  NlwBufferBlock_refcnt_6_D2_PT_0_IN5 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_refcnt_6_D2_PT_0_IN5
    );
  NlwBufferBlock_refcnt_6_D2_PT_0_IN6 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_refcnt_6_D2_PT_0_IN6
    );
  NlwBufferBlock_refcnt_6_D2_PT_0_IN7 : X_BUF
    port map (
      I => refcnt(4),
      O => NlwBufferSignal_refcnt_6_D2_PT_0_IN7
    );
  NlwBufferBlock_refcnt_6_D2_PT_0_IN8 : X_BUF
    port map (
      I => refcnt(5),
      O => NlwBufferSignal_refcnt_6_D2_PT_0_IN8
    );
  NlwBufferBlock_refcnt_6_D2_PT_0_IN9 : X_BUF
    port map (
      I => refcnt(6),
      O => NlwBufferSignal_refcnt_6_D2_PT_0_IN9
    );
  NlwBufferBlock_refcnt_6_D2_PT_0_IN10 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_6_D2_PT_0_IN10
    );
  NlwBufferBlock_refcnt_6_D2_PT_0_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_6_D2_PT_0_IN11
    );
  NlwBufferBlock_refcnt_6_D2_PT_0_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_6_D2_PT_0_IN12
    );
  NlwBufferBlock_refcnt_6_D2_PT_0_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_6_D2_PT_0_IN13
    );
  NlwBufferBlock_refcnt_6_D2_PT_0_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_6_D2_PT_0_IN14
    );
  NlwBufferBlock_refcnt_6_D2_PT_0_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_6_D2_PT_0_IN15
    );
  NlwBufferBlock_refcnt_6_D2_PT_1_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_6_D2_PT_1_IN0
    );
  NlwBufferBlock_refcnt_6_D2_PT_1_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_6_D2_PT_1_IN1
    );
  NlwBufferBlock_refcnt_6_D2_PT_1_IN2 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_6_D2_PT_1_IN2
    );
  NlwBufferBlock_refcnt_6_D2_PT_1_IN3 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_refcnt_6_D2_PT_1_IN3
    );
  NlwBufferBlock_refcnt_6_D2_PT_1_IN4 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_refcnt_6_D2_PT_1_IN4
    );
  NlwBufferBlock_refcnt_6_D2_PT_1_IN5 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_refcnt_6_D2_PT_1_IN5
    );
  NlwBufferBlock_refcnt_6_D2_PT_1_IN6 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_refcnt_6_D2_PT_1_IN6
    );
  NlwBufferBlock_refcnt_6_D2_PT_1_IN7 : X_BUF
    port map (
      I => refcnt(4),
      O => NlwBufferSignal_refcnt_6_D2_PT_1_IN7
    );
  NlwBufferBlock_refcnt_6_D2_PT_1_IN8 : X_BUF
    port map (
      I => refcnt(5),
      O => NlwBufferSignal_refcnt_6_D2_PT_1_IN8
    );
  NlwBufferBlock_refcnt_6_D2_PT_1_IN9 : X_BUF
    port map (
      I => refcnt(7),
      O => NlwBufferSignal_refcnt_6_D2_PT_1_IN9
    );
  NlwBufferBlock_refcnt_6_D2_PT_1_IN10 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_6_D2_PT_1_IN10
    );
  NlwBufferBlock_refcnt_6_D2_PT_1_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_6_D2_PT_1_IN11
    );
  NlwBufferBlock_refcnt_6_D2_PT_1_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_6_D2_PT_1_IN12
    );
  NlwBufferBlock_refcnt_6_D2_PT_1_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_6_D2_PT_1_IN13
    );
  NlwBufferBlock_refcnt_6_D2_PT_1_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_6_D2_PT_1_IN14
    );
  NlwBufferBlock_refcnt_6_D2_PT_1_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_6_D2_PT_1_IN15
    );
  NlwBufferBlock_refcnt_6_D2_IN0 : X_BUF
    port map (
      I => refcnt_6_D2_PT_0_345,
      O => NlwBufferSignal_refcnt_6_D2_IN0
    );
  NlwBufferBlock_refcnt_6_D2_IN1 : X_BUF
    port map (
      I => refcnt_6_D2_PT_1_346,
      O => NlwBufferSignal_refcnt_6_D2_IN1
    );
  NlwBufferBlock_refcnt_6_EXP_PT_0_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_6_EXP_PT_0_IN0
    );
  NlwBufferBlock_refcnt_6_EXP_PT_0_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_6_EXP_PT_0_IN1
    );
  NlwBufferBlock_refcnt_6_EXP_PT_0_IN2 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_6_EXP_PT_0_IN2
    );
  NlwBufferBlock_refcnt_6_EXP_PT_0_IN3 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_refcnt_6_EXP_PT_0_IN3
    );
  NlwBufferBlock_refcnt_6_EXP_PT_0_IN4 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_refcnt_6_EXP_PT_0_IN4
    );
  NlwBufferBlock_refcnt_6_EXP_PT_0_IN5 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_refcnt_6_EXP_PT_0_IN5
    );
  NlwBufferBlock_refcnt_6_EXP_PT_0_IN6 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_refcnt_6_EXP_PT_0_IN6
    );
  NlwBufferBlock_refcnt_6_EXP_PT_0_IN7 : X_BUF
    port map (
      I => refcnt(4),
      O => NlwBufferSignal_refcnt_6_EXP_PT_0_IN7
    );
  NlwBufferBlock_refcnt_6_EXP_PT_0_IN8 : X_BUF
    port map (
      I => refcnt(5),
      O => NlwBufferSignal_refcnt_6_EXP_PT_0_IN8
    );
  NlwBufferBlock_refcnt_6_EXP_PT_0_IN9 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_6_EXP_PT_0_IN9
    );
  NlwBufferBlock_refcnt_6_EXP_PT_0_IN10 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_6_EXP_PT_0_IN10
    );
  NlwBufferBlock_refcnt_6_EXP_PT_0_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_6_EXP_PT_0_IN11
    );
  NlwBufferBlock_refcnt_6_EXP_PT_0_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_6_EXP_PT_0_IN12
    );
  NlwBufferBlock_refcnt_6_EXP_PT_0_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_6_EXP_PT_0_IN13
    );
  NlwBufferBlock_refcnt_6_EXP_PT_0_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_6_EXP_PT_0_IN14
    );
  NlwBufferBlock_refcnt_6_EXP_PT_0_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_6_EXP_PT_0_IN15
    );
  NlwBufferBlock_refcnt_6_EXP_PT_1_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_6_EXP_PT_1_IN0
    );
  NlwBufferBlock_refcnt_6_EXP_PT_1_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_6_EXP_PT_1_IN1
    );
  NlwBufferBlock_refcnt_6_EXP_PT_1_IN2 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_6_EXP_PT_1_IN2
    );
  NlwBufferBlock_refcnt_6_EXP_PT_1_IN3 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_refcnt_6_EXP_PT_1_IN3
    );
  NlwBufferBlock_refcnt_6_EXP_PT_1_IN4 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_refcnt_6_EXP_PT_1_IN4
    );
  NlwBufferBlock_refcnt_6_EXP_PT_1_IN5 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_refcnt_6_EXP_PT_1_IN5
    );
  NlwBufferBlock_refcnt_6_EXP_PT_1_IN6 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_refcnt_6_EXP_PT_1_IN6
    );
  NlwBufferBlock_refcnt_6_EXP_PT_1_IN7 : X_BUF
    port map (
      I => refcnt(4),
      O => NlwBufferSignal_refcnt_6_EXP_PT_1_IN7
    );
  NlwBufferBlock_refcnt_6_EXP_PT_1_IN8 : X_BUF
    port map (
      I => refcnt(7),
      O => NlwBufferSignal_refcnt_6_EXP_PT_1_IN8
    );
  NlwBufferBlock_refcnt_6_EXP_PT_1_IN9 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_6_EXP_PT_1_IN9
    );
  NlwBufferBlock_refcnt_6_EXP_PT_1_IN10 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_6_EXP_PT_1_IN10
    );
  NlwBufferBlock_refcnt_6_EXP_PT_1_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_6_EXP_PT_1_IN11
    );
  NlwBufferBlock_refcnt_6_EXP_PT_1_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_6_EXP_PT_1_IN12
    );
  NlwBufferBlock_refcnt_6_EXP_PT_1_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_6_EXP_PT_1_IN13
    );
  NlwBufferBlock_refcnt_6_EXP_PT_1_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_6_EXP_PT_1_IN14
    );
  NlwBufferBlock_refcnt_6_EXP_PT_1_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_6_EXP_PT_1_IN15
    );
  NlwBufferBlock_refcnt_6_EXP_tsimrenamed_net_IN0 : X_BUF
    port map (
      I => refcnt_6_EXP_PT_0_347,
      O => NlwBufferSignal_refcnt_6_EXP_tsimrenamed_net_IN0
    );
  NlwBufferBlock_refcnt_6_EXP_tsimrenamed_net_IN1 : X_BUF
    port map (
      I => refcnt_6_EXP_PT_1_348,
      O => NlwBufferSignal_refcnt_6_EXP_tsimrenamed_net_IN1
    );
  NlwBufferBlock_refcnt_7_tsimcreated_xor_IN0 : X_BUF
    port map (
      I => refcnt_7_D_351,
      O => NlwBufferSignal_refcnt_7_tsimcreated_xor_IN0
    );
  NlwBufferBlock_refcnt_7_tsimcreated_xor_IN1 : X_BUF
    port map (
      I => refcnt_7_Q_349,
      O => NlwBufferSignal_refcnt_7_tsimcreated_xor_IN1
    );
  NlwBufferBlock_refcnt_7_REG_IN : X_BUF
    port map (
      I => refcnt_7_tsimcreated_xor_Q_352,
      O => NlwBufferSignal_refcnt_7_REG_IN
    );
  NlwBufferBlock_refcnt_7_REG_CLK : X_BUF
    port map (
      I => FCLK_IO_0_31,
      O => NlwBufferSignal_refcnt_7_REG_CLK
    );
  NlwBufferBlock_refcnt_7_D_IN0 : X_BUF
    port map (
      I => refcnt_7_D1_353,
      O => NlwBufferSignal_refcnt_7_D_IN0
    );
  NlwBufferBlock_refcnt_7_D_IN1 : X_BUF
    port map (
      I => refcnt_7_D2_354,
      O => NlwBufferSignal_refcnt_7_D_IN1
    );
  NlwBufferBlock_refcnt_7_D2_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_7_D2_IN0
    );
  NlwBufferBlock_refcnt_7_D2_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_7_D2_IN1
    );
  NlwBufferBlock_refcnt_7_D2_IN2 : X_BUF
    port map (
      I => counter(2),
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
      I => refcnt(4),
      O => NlwBufferSignal_refcnt_7_D2_IN7
    );
  NlwBufferBlock_refcnt_7_D2_IN8 : X_BUF
    port map (
      I => refcnt(5),
      O => NlwBufferSignal_refcnt_7_D2_IN8
    );
  NlwBufferBlock_refcnt_7_D2_IN9 : X_BUF
    port map (
      I => refcnt(6),
      O => NlwBufferSignal_refcnt_7_D2_IN9
    );
  NlwBufferBlock_refcnt_7_D2_IN10 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_7_D2_IN10
    );
  NlwBufferBlock_refcnt_7_D2_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_7_D2_IN11
    );
  NlwBufferBlock_refcnt_7_D2_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_7_D2_IN12
    );
  NlwBufferBlock_refcnt_7_D2_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_7_D2_IN13
    );
  NlwBufferBlock_refcnt_7_D2_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_7_D2_IN14
    );
  NlwBufferBlock_refcnt_7_D2_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_7_D2_IN15
    );
  NlwBufferBlock_refcnt_7_EXP_PT_0_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_refcnt_7_EXP_PT_0_IN0
    );
  NlwBufferBlock_refcnt_7_EXP_PT_0_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_refcnt_7_EXP_PT_0_IN1
    );
  NlwBufferBlock_refcnt_7_EXP_PT_0_IN2 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_7_EXP_PT_0_IN2
    );
  NlwBufferBlock_refcnt_7_EXP_PT_0_IN3 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_7_EXP_PT_0_IN3
    );
  NlwBufferBlock_refcnt_7_EXP_PT_0_IN4 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_7_EXP_PT_0_IN4
    );
  NlwBufferBlock_refcnt_7_EXP_PT_0_IN5 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_refcnt_7_EXP_PT_0_IN5
    );
  NlwBufferBlock_refcnt_7_EXP_PT_0_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_refcnt_7_EXP_PT_0_IN6
    );
  NlwBufferBlock_refcnt_7_EXP_PT_0_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_refcnt_7_EXP_PT_0_IN7
    );
  NlwBufferBlock_refcnt_7_EXP_PT_0_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_refcnt_7_EXP_PT_0_IN8
    );
  NlwBufferBlock_refcnt_7_EXP_PT_0_IN9 : X_BUF
    port map (
      I => cas3_PIN_BUF_Q_43,
      O => NlwBufferSignal_refcnt_7_EXP_PT_0_IN9
    );
  NlwBufferBlock_refcnt_7_EXP_PT_0_IN10 : X_BUF
    port map (
      I => refcnt(4),
      O => NlwBufferSignal_refcnt_7_EXP_PT_0_IN10
    );
  NlwBufferBlock_refcnt_7_EXP_PT_0_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_7_EXP_PT_0_IN11
    );
  NlwBufferBlock_refcnt_7_EXP_PT_0_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_7_EXP_PT_0_IN12
    );
  NlwBufferBlock_refcnt_7_EXP_PT_0_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_7_EXP_PT_0_IN13
    );
  NlwBufferBlock_refcnt_7_EXP_PT_0_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_7_EXP_PT_0_IN14
    );
  NlwBufferBlock_refcnt_7_EXP_PT_0_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_7_EXP_PT_0_IN15
    );
  NlwBufferBlock_refcnt_7_EXP_PT_1_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_refcnt_7_EXP_PT_1_IN0
    );
  NlwBufferBlock_refcnt_7_EXP_PT_1_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_refcnt_7_EXP_PT_1_IN1
    );
  NlwBufferBlock_refcnt_7_EXP_PT_1_IN2 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_7_EXP_PT_1_IN2
    );
  NlwBufferBlock_refcnt_7_EXP_PT_1_IN3 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_7_EXP_PT_1_IN3
    );
  NlwBufferBlock_refcnt_7_EXP_PT_1_IN4 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_7_EXP_PT_1_IN4
    );
  NlwBufferBlock_refcnt_7_EXP_PT_1_IN5 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_refcnt_7_EXP_PT_1_IN5
    );
  NlwBufferBlock_refcnt_7_EXP_PT_1_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_refcnt_7_EXP_PT_1_IN6
    );
  NlwBufferBlock_refcnt_7_EXP_PT_1_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_refcnt_7_EXP_PT_1_IN7
    );
  NlwBufferBlock_refcnt_7_EXP_PT_1_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_refcnt_7_EXP_PT_1_IN8
    );
  NlwBufferBlock_refcnt_7_EXP_PT_1_IN9 : X_BUF
    port map (
      I => cas3_PIN_BUF_Q_43,
      O => NlwBufferSignal_refcnt_7_EXP_PT_1_IN9
    );
  NlwBufferBlock_refcnt_7_EXP_PT_1_IN10 : X_BUF
    port map (
      I => refcnt(5),
      O => NlwBufferSignal_refcnt_7_EXP_PT_1_IN10
    );
  NlwBufferBlock_refcnt_7_EXP_PT_1_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_7_EXP_PT_1_IN11
    );
  NlwBufferBlock_refcnt_7_EXP_PT_1_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_7_EXP_PT_1_IN12
    );
  NlwBufferBlock_refcnt_7_EXP_PT_1_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_7_EXP_PT_1_IN13
    );
  NlwBufferBlock_refcnt_7_EXP_PT_1_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_7_EXP_PT_1_IN14
    );
  NlwBufferBlock_refcnt_7_EXP_PT_1_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_7_EXP_PT_1_IN15
    );
  NlwBufferBlock_refcnt_7_EXP_PT_2_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_refcnt_7_EXP_PT_2_IN0
    );
  NlwBufferBlock_refcnt_7_EXP_PT_2_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_refcnt_7_EXP_PT_2_IN1
    );
  NlwBufferBlock_refcnt_7_EXP_PT_2_IN2 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_7_EXP_PT_2_IN2
    );
  NlwBufferBlock_refcnt_7_EXP_PT_2_IN3 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_7_EXP_PT_2_IN3
    );
  NlwBufferBlock_refcnt_7_EXP_PT_2_IN4 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_7_EXP_PT_2_IN4
    );
  NlwBufferBlock_refcnt_7_EXP_PT_2_IN5 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_refcnt_7_EXP_PT_2_IN5
    );
  NlwBufferBlock_refcnt_7_EXP_PT_2_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_refcnt_7_EXP_PT_2_IN6
    );
  NlwBufferBlock_refcnt_7_EXP_PT_2_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_refcnt_7_EXP_PT_2_IN7
    );
  NlwBufferBlock_refcnt_7_EXP_PT_2_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_refcnt_7_EXP_PT_2_IN8
    );
  NlwBufferBlock_refcnt_7_EXP_PT_2_IN9 : X_BUF
    port map (
      I => cas3_PIN_BUF_Q_43,
      O => NlwBufferSignal_refcnt_7_EXP_PT_2_IN9
    );
  NlwBufferBlock_refcnt_7_EXP_PT_2_IN10 : X_BUF
    port map (
      I => refcnt(6),
      O => NlwBufferSignal_refcnt_7_EXP_PT_2_IN10
    );
  NlwBufferBlock_refcnt_7_EXP_PT_2_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_7_EXP_PT_2_IN11
    );
  NlwBufferBlock_refcnt_7_EXP_PT_2_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_7_EXP_PT_2_IN12
    );
  NlwBufferBlock_refcnt_7_EXP_PT_2_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_7_EXP_PT_2_IN13
    );
  NlwBufferBlock_refcnt_7_EXP_PT_2_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_7_EXP_PT_2_IN14
    );
  NlwBufferBlock_refcnt_7_EXP_PT_2_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_7_EXP_PT_2_IN15
    );
  NlwBufferBlock_refcnt_7_EXP_PT_3_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_refcnt_7_EXP_PT_3_IN0
    );
  NlwBufferBlock_refcnt_7_EXP_PT_3_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_refcnt_7_EXP_PT_3_IN1
    );
  NlwBufferBlock_refcnt_7_EXP_PT_3_IN2 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_refcnt_7_EXP_PT_3_IN2
    );
  NlwBufferBlock_refcnt_7_EXP_PT_3_IN3 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_refcnt_7_EXP_PT_3_IN3
    );
  NlwBufferBlock_refcnt_7_EXP_PT_3_IN4 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_refcnt_7_EXP_PT_3_IN4
    );
  NlwBufferBlock_refcnt_7_EXP_PT_3_IN5 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_refcnt_7_EXP_PT_3_IN5
    );
  NlwBufferBlock_refcnt_7_EXP_PT_3_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_refcnt_7_EXP_PT_3_IN6
    );
  NlwBufferBlock_refcnt_7_EXP_PT_3_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_refcnt_7_EXP_PT_3_IN7
    );
  NlwBufferBlock_refcnt_7_EXP_PT_3_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_refcnt_7_EXP_PT_3_IN8
    );
  NlwBufferBlock_refcnt_7_EXP_PT_3_IN9 : X_BUF
    port map (
      I => cas3_PIN_BUF_Q_43,
      O => NlwBufferSignal_refcnt_7_EXP_PT_3_IN9
    );
  NlwBufferBlock_refcnt_7_EXP_PT_3_IN10 : X_BUF
    port map (
      I => refcnt(7),
      O => NlwBufferSignal_refcnt_7_EXP_PT_3_IN10
    );
  NlwBufferBlock_refcnt_7_EXP_PT_3_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_7_EXP_PT_3_IN11
    );
  NlwBufferBlock_refcnt_7_EXP_PT_3_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_7_EXP_PT_3_IN12
    );
  NlwBufferBlock_refcnt_7_EXP_PT_3_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_7_EXP_PT_3_IN13
    );
  NlwBufferBlock_refcnt_7_EXP_PT_3_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_7_EXP_PT_3_IN14
    );
  NlwBufferBlock_refcnt_7_EXP_PT_3_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_refcnt_7_EXP_PT_3_IN15
    );
  NlwBufferBlock_refcnt_7_EXP_tsimrenamed_net_IN0 : X_BUF
    port map (
      I => refcnt_7_EXP_PT_0_355,
      O => NlwBufferSignal_refcnt_7_EXP_tsimrenamed_net_IN0
    );
  NlwBufferBlock_refcnt_7_EXP_tsimrenamed_net_IN1 : X_BUF
    port map (
      I => refcnt_7_EXP_PT_1_356,
      O => NlwBufferSignal_refcnt_7_EXP_tsimrenamed_net_IN1
    );
  NlwBufferBlock_refcnt_7_EXP_tsimrenamed_net_IN2 : X_BUF
    port map (
      I => refcnt_7_EXP_PT_2_357,
      O => NlwBufferSignal_refcnt_7_EXP_tsimrenamed_net_IN2
    );
  NlwBufferBlock_refcnt_7_EXP_tsimrenamed_net_IN3 : X_BUF
    port map (
      I => refcnt_7_EXP_PT_3_358,
      O => NlwBufferSignal_refcnt_7_EXP_tsimrenamed_net_IN3
    );
  NlwBufferBlock_EXP0_EXP_PT_0_IN0 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_EXP0_EXP_PT_0_IN0
    );
  NlwBufferBlock_EXP0_EXP_PT_0_IN1 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_EXP0_EXP_PT_0_IN1
    );
  NlwBufferBlock_EXP0_EXP_PT_0_IN2 : X_BUF
    port map (
      I => phi0_PIN_BUF_Q_61,
      O => NlwBufferSignal_EXP0_EXP_PT_0_IN2
    );
  NlwBufferBlock_EXP0_EXP_PT_1_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_EXP0_EXP_PT_1_IN0
    );
  NlwBufferBlock_EXP0_EXP_PT_1_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_EXP0_EXP_PT_1_IN1
    );
  NlwBufferBlock_EXP0_EXP_PT_1_IN2 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_EXP0_EXP_PT_1_IN2
    );
  NlwBufferBlock_EXP0_EXP_PT_1_IN3 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_EXP0_EXP_PT_1_IN3
    );
  NlwBufferBlock_EXP0_EXP_PT_1_IN4 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_EXP0_EXP_PT_1_IN4
    );
  NlwBufferBlock_EXP0_EXP_PT_1_IN5 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_EXP0_EXP_PT_1_IN5
    );
  NlwBufferBlock_EXP0_EXP_PT_1_IN6 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_EXP0_EXP_PT_1_IN6
    );
  NlwBufferBlock_EXP0_EXP_PT_1_IN7 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_EXP0_EXP_PT_1_IN7
    );
  NlwBufferBlock_EXP0_EXP_PT_1_IN8 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_EXP0_EXP_PT_1_IN8
    );
  NlwBufferBlock_EXP0_EXP_PT_1_IN9 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_EXP0_EXP_PT_1_IN9
    );
  NlwBufferBlock_EXP0_EXP_PT_1_IN10 : X_BUF
    port map (
      I => refcnt(4),
      O => NlwBufferSignal_EXP0_EXP_PT_1_IN10
    );
  NlwBufferBlock_EXP0_EXP_PT_1_IN11 : X_BUF
    port map (
      I => refcnt(5),
      O => NlwBufferSignal_EXP0_EXP_PT_1_IN11
    );
  NlwBufferBlock_EXP0_EXP_PT_1_IN12 : X_BUF
    port map (
      I => refcnt(6),
      O => NlwBufferSignal_EXP0_EXP_PT_1_IN12
    );
  NlwBufferBlock_EXP0_EXP_PT_1_IN13 : X_BUF
    port map (
      I => refcnt(7),
      O => NlwBufferSignal_EXP0_EXP_PT_1_IN13
    );
  NlwBufferBlock_EXP0_EXP_PT_1_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP0_EXP_PT_1_IN14
    );
  NlwBufferBlock_EXP0_EXP_PT_1_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP0_EXP_PT_1_IN15
    );
  NlwBufferBlock_EXP0_EXP_tsimrenamed_net_IN0 : X_BUF
    port map (
      I => EXP0_EXP_PT_0_360,
      O => NlwBufferSignal_EXP0_EXP_tsimrenamed_net_IN0
    );
  NlwBufferBlock_EXP0_EXP_tsimrenamed_net_IN1 : X_BUF
    port map (
      I => EXP0_EXP_PT_1_361,
      O => NlwBufferSignal_EXP0_EXP_tsimrenamed_net_IN1
    );
  NlwBufferBlock_EXP1_EXP_PT_0_IN0 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_EXP1_EXP_PT_0_IN0
    );
  NlwBufferBlock_EXP1_EXP_PT_0_IN1 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_EXP1_EXP_PT_0_IN1
    );
  NlwBufferBlock_EXP1_EXP_PT_0_IN2 : X_BUF
    port map (
      I => phi1_PIN_BUF_Q_35,
      O => NlwBufferSignal_EXP1_EXP_PT_0_IN2
    );
  NlwBufferBlock_EXP1_EXP_PT_1_IN0 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_EXP1_EXP_PT_1_IN0
    );
  NlwBufferBlock_EXP1_EXP_PT_1_IN1 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_EXP1_EXP_PT_1_IN1
    );
  NlwBufferBlock_EXP1_EXP_PT_1_IN2 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_EXP1_EXP_PT_1_IN2
    );
  NlwBufferBlock_EXP1_EXP_PT_1_IN3 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_EXP1_EXP_PT_1_IN3
    );
  NlwBufferBlock_EXP1_EXP_PT_1_IN4 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_EXP1_EXP_PT_1_IN4
    );
  NlwBufferBlock_EXP1_EXP_PT_1_IN5 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_EXP1_EXP_PT_1_IN5
    );
  NlwBufferBlock_EXP1_EXP_PT_1_IN6 : X_BUF
    port map (
      I => refcnt(0),
      O => NlwBufferSignal_EXP1_EXP_PT_1_IN6
    );
  NlwBufferBlock_EXP1_EXP_PT_1_IN7 : X_BUF
    port map (
      I => refcnt(1),
      O => NlwBufferSignal_EXP1_EXP_PT_1_IN7
    );
  NlwBufferBlock_EXP1_EXP_PT_1_IN8 : X_BUF
    port map (
      I => refcnt(2),
      O => NlwBufferSignal_EXP1_EXP_PT_1_IN8
    );
  NlwBufferBlock_EXP1_EXP_PT_1_IN9 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_EXP1_EXP_PT_1_IN9
    );
  NlwBufferBlock_EXP1_EXP_PT_1_IN10 : X_BUF
    port map (
      I => refcnt(4),
      O => NlwBufferSignal_EXP1_EXP_PT_1_IN10
    );
  NlwBufferBlock_EXP1_EXP_PT_1_IN11 : X_BUF
    port map (
      I => refcnt(5),
      O => NlwBufferSignal_EXP1_EXP_PT_1_IN11
    );
  NlwBufferBlock_EXP1_EXP_PT_1_IN12 : X_BUF
    port map (
      I => refcnt(6),
      O => NlwBufferSignal_EXP1_EXP_PT_1_IN12
    );
  NlwBufferBlock_EXP1_EXP_PT_1_IN13 : X_BUF
    port map (
      I => refcnt(7),
      O => NlwBufferSignal_EXP1_EXP_PT_1_IN13
    );
  NlwBufferBlock_EXP1_EXP_PT_1_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP1_EXP_PT_1_IN14
    );
  NlwBufferBlock_EXP1_EXP_PT_1_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP1_EXP_PT_1_IN15
    );
  NlwBufferBlock_EXP1_EXP_tsimrenamed_net_IN0 : X_BUF
    port map (
      I => EXP1_EXP_PT_0_363,
      O => NlwBufferSignal_EXP1_EXP_tsimrenamed_net_IN0
    );
  NlwBufferBlock_EXP1_EXP_tsimrenamed_net_IN1 : X_BUF
    port map (
      I => EXP1_EXP_PT_1_364,
      O => NlwBufferSignal_EXP1_EXP_tsimrenamed_net_IN1
    );
  NlwBufferBlock_EXP2_EXP_tsimrenamed_net_IN0 : X_BUF
    port map (
      I => bank_4_IBUF_1,
      O => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN0
    );
  NlwBufferBlock_EXP2_EXP_tsimrenamed_net_IN1 : X_BUF
    port map (
      I => bank_3_IBUF_3,
      O => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN1
    );
  NlwBufferBlock_EXP2_EXP_tsimrenamed_net_IN2 : X_BUF
    port map (
      I => bank_2_IBUF_5,
      O => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN2
    );
  NlwBufferBlock_EXP2_EXP_tsimrenamed_net_IN3 : X_BUF
    port map (
      I => bank_1_IBUF_7,
      O => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN3
    );
  NlwBufferBlock_EXP2_EXP_tsimrenamed_net_IN4 : X_BUF
    port map (
      I => bank_0_IBUF_9,
      O => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN4
    );
  NlwBufferBlock_EXP2_EXP_tsimrenamed_net_IN5 : X_BUF
    port map (
      I => a15_13_2_IBUF_11,
      O => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN5
    );
  NlwBufferBlock_EXP2_EXP_tsimrenamed_net_IN6 : X_BUF
    port map (
      I => a15_13_1_IBUF_13,
      O => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN6
    );
  NlwBufferBlock_EXP2_EXP_tsimrenamed_net_IN7 : X_BUF
    port map (
      I => a15_13_0_IBUF_15,
      O => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN7
    );
  NlwBufferBlock_EXP2_EXP_tsimrenamed_net_IN8 : X_BUF
    port map (
      I => rw_IBUF_17,
      O => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN8
    );
  NlwBufferBlock_EXP2_EXP_tsimrenamed_net_IN9 : X_BUF
    port map (
      I => bank_6_IBUF_19,
      O => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN9
    );
  NlwBufferBlock_EXP2_EXP_tsimrenamed_net_IN10 : X_BUF
    port map (
      I => bank_5_IBUF_21,
      O => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN10
    );
  NlwBufferBlock_EXP2_EXP_tsimrenamed_net_IN11 : X_BUF
    port map (
      I => bank_7_IBUF_23,
      O => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN11
    );
  NlwBufferBlock_EXP2_EXP_tsimrenamed_net_IN12 : X_BUF
    port map (
      I => ras_PIN_BUF_Q_63,
      O => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN12
    );
  NlwBufferBlock_EXP2_EXP_tsimrenamed_net_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN13
    );
  NlwBufferBlock_EXP2_EXP_tsimrenamed_net_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN14
    );
  NlwBufferBlock_EXP2_EXP_tsimrenamed_net_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN15
    );
  NlwBufferBlock_EXP3_EXP_PT_0_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_EXP3_EXP_PT_0_IN0
    );
  NlwBufferBlock_EXP3_EXP_PT_0_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_EXP3_EXP_PT_0_IN1
    );
  NlwBufferBlock_EXP3_EXP_PT_0_IN2 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_EXP3_EXP_PT_0_IN2
    );
  NlwBufferBlock_EXP3_EXP_PT_0_IN3 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_EXP3_EXP_PT_0_IN3
    );
  NlwBufferBlock_EXP3_EXP_PT_0_IN4 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_EXP3_EXP_PT_0_IN4
    );
  NlwBufferBlock_EXP3_EXP_PT_0_IN5 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_EXP3_EXP_PT_0_IN5
    );
  NlwBufferBlock_EXP3_EXP_PT_0_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_EXP3_EXP_PT_0_IN6
    );
  NlwBufferBlock_EXP3_EXP_PT_0_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_EXP3_EXP_PT_0_IN7
    );
  NlwBufferBlock_EXP3_EXP_PT_0_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_EXP3_EXP_PT_0_IN8
    );
  NlwBufferBlock_EXP3_EXP_PT_0_IN9 : X_BUF
    port map (
      I => refcnt(3),
      O => NlwBufferSignal_EXP3_EXP_PT_0_IN9
    );
  NlwBufferBlock_EXP3_EXP_PT_0_IN10 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP3_EXP_PT_0_IN10
    );
  NlwBufferBlock_EXP3_EXP_PT_0_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP3_EXP_PT_0_IN11
    );
  NlwBufferBlock_EXP3_EXP_PT_0_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP3_EXP_PT_0_IN12
    );
  NlwBufferBlock_EXP3_EXP_PT_0_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP3_EXP_PT_0_IN13
    );
  NlwBufferBlock_EXP3_EXP_PT_0_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP3_EXP_PT_0_IN14
    );
  NlwBufferBlock_EXP3_EXP_PT_0_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP3_EXP_PT_0_IN15
    );
  NlwBufferBlock_EXP3_EXP_PT_1_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_EXP3_EXP_PT_1_IN0
    );
  NlwBufferBlock_EXP3_EXP_PT_1_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_EXP3_EXP_PT_1_IN1
    );
  NlwBufferBlock_EXP3_EXP_PT_1_IN2 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_EXP3_EXP_PT_1_IN2
    );
  NlwBufferBlock_EXP3_EXP_PT_1_IN3 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_EXP3_EXP_PT_1_IN3
    );
  NlwBufferBlock_EXP3_EXP_PT_1_IN4 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_EXP3_EXP_PT_1_IN4
    );
  NlwBufferBlock_EXP3_EXP_PT_1_IN5 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_EXP3_EXP_PT_1_IN5
    );
  NlwBufferBlock_EXP3_EXP_PT_1_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_EXP3_EXP_PT_1_IN6
    );
  NlwBufferBlock_EXP3_EXP_PT_1_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_EXP3_EXP_PT_1_IN7
    );
  NlwBufferBlock_EXP3_EXP_PT_1_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_EXP3_EXP_PT_1_IN8
    );
  NlwBufferBlock_EXP3_EXP_PT_1_IN9 : X_BUF
    port map (
      I => refcnt(4),
      O => NlwBufferSignal_EXP3_EXP_PT_1_IN9
    );
  NlwBufferBlock_EXP3_EXP_PT_1_IN10 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP3_EXP_PT_1_IN10
    );
  NlwBufferBlock_EXP3_EXP_PT_1_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP3_EXP_PT_1_IN11
    );
  NlwBufferBlock_EXP3_EXP_PT_1_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP3_EXP_PT_1_IN12
    );
  NlwBufferBlock_EXP3_EXP_PT_1_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP3_EXP_PT_1_IN13
    );
  NlwBufferBlock_EXP3_EXP_PT_1_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP3_EXP_PT_1_IN14
    );
  NlwBufferBlock_EXP3_EXP_PT_1_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP3_EXP_PT_1_IN15
    );
  NlwBufferBlock_EXP3_EXP_PT_2_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_EXP3_EXP_PT_2_IN0
    );
  NlwBufferBlock_EXP3_EXP_PT_2_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_EXP3_EXP_PT_2_IN1
    );
  NlwBufferBlock_EXP3_EXP_PT_2_IN2 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_EXP3_EXP_PT_2_IN2
    );
  NlwBufferBlock_EXP3_EXP_PT_2_IN3 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_EXP3_EXP_PT_2_IN3
    );
  NlwBufferBlock_EXP3_EXP_PT_2_IN4 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_EXP3_EXP_PT_2_IN4
    );
  NlwBufferBlock_EXP3_EXP_PT_2_IN5 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_EXP3_EXP_PT_2_IN5
    );
  NlwBufferBlock_EXP3_EXP_PT_2_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_EXP3_EXP_PT_2_IN6
    );
  NlwBufferBlock_EXP3_EXP_PT_2_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_EXP3_EXP_PT_2_IN7
    );
  NlwBufferBlock_EXP3_EXP_PT_2_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_EXP3_EXP_PT_2_IN8
    );
  NlwBufferBlock_EXP3_EXP_PT_2_IN9 : X_BUF
    port map (
      I => refcnt(5),
      O => NlwBufferSignal_EXP3_EXP_PT_2_IN9
    );
  NlwBufferBlock_EXP3_EXP_PT_2_IN10 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP3_EXP_PT_2_IN10
    );
  NlwBufferBlock_EXP3_EXP_PT_2_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP3_EXP_PT_2_IN11
    );
  NlwBufferBlock_EXP3_EXP_PT_2_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP3_EXP_PT_2_IN12
    );
  NlwBufferBlock_EXP3_EXP_PT_2_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP3_EXP_PT_2_IN13
    );
  NlwBufferBlock_EXP3_EXP_PT_2_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP3_EXP_PT_2_IN14
    );
  NlwBufferBlock_EXP3_EXP_PT_2_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP3_EXP_PT_2_IN15
    );
  NlwBufferBlock_EXP3_EXP_PT_3_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_EXP3_EXP_PT_3_IN0
    );
  NlwBufferBlock_EXP3_EXP_PT_3_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_EXP3_EXP_PT_3_IN1
    );
  NlwBufferBlock_EXP3_EXP_PT_3_IN2 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_EXP3_EXP_PT_3_IN2
    );
  NlwBufferBlock_EXP3_EXP_PT_3_IN3 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_EXP3_EXP_PT_3_IN3
    );
  NlwBufferBlock_EXP3_EXP_PT_3_IN4 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_EXP3_EXP_PT_3_IN4
    );
  NlwBufferBlock_EXP3_EXP_PT_3_IN5 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_EXP3_EXP_PT_3_IN5
    );
  NlwBufferBlock_EXP3_EXP_PT_3_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_EXP3_EXP_PT_3_IN6
    );
  NlwBufferBlock_EXP3_EXP_PT_3_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_EXP3_EXP_PT_3_IN7
    );
  NlwBufferBlock_EXP3_EXP_PT_3_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_EXP3_EXP_PT_3_IN8
    );
  NlwBufferBlock_EXP3_EXP_PT_3_IN9 : X_BUF
    port map (
      I => refcnt(6),
      O => NlwBufferSignal_EXP3_EXP_PT_3_IN9
    );
  NlwBufferBlock_EXP3_EXP_PT_3_IN10 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP3_EXP_PT_3_IN10
    );
  NlwBufferBlock_EXP3_EXP_PT_3_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP3_EXP_PT_3_IN11
    );
  NlwBufferBlock_EXP3_EXP_PT_3_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP3_EXP_PT_3_IN12
    );
  NlwBufferBlock_EXP3_EXP_PT_3_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP3_EXP_PT_3_IN13
    );
  NlwBufferBlock_EXP3_EXP_PT_3_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP3_EXP_PT_3_IN14
    );
  NlwBufferBlock_EXP3_EXP_PT_3_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP3_EXP_PT_3_IN15
    );
  NlwBufferBlock_EXP3_EXP_PT_4_IN0 : X_BUF
    port map (
      I => a12_11_1_IBUF_25,
      O => NlwBufferSignal_EXP3_EXP_PT_4_IN0
    );
  NlwBufferBlock_EXP3_EXP_PT_4_IN1 : X_BUF
    port map (
      I => a12_11_0_IBUF_27,
      O => NlwBufferSignal_EXP3_EXP_PT_4_IN1
    );
  NlwBufferBlock_EXP3_EXP_PT_4_IN2 : X_BUF
    port map (
      I => counter(0),
      O => NlwBufferSignal_EXP3_EXP_PT_4_IN2
    );
  NlwBufferBlock_EXP3_EXP_PT_4_IN3 : X_BUF
    port map (
      I => counter(1),
      O => NlwBufferSignal_EXP3_EXP_PT_4_IN3
    );
  NlwBufferBlock_EXP3_EXP_PT_4_IN4 : X_BUF
    port map (
      I => counter(2),
      O => NlwBufferSignal_EXP3_EXP_PT_4_IN4
    );
  NlwBufferBlock_EXP3_EXP_PT_4_IN5 : X_BUF
    port map (
      I => rom_PIN_BUF_Q_33,
      O => NlwBufferSignal_EXP3_EXP_PT_4_IN5
    );
  NlwBufferBlock_EXP3_EXP_PT_4_IN6 : X_BUF
    port map (
      I => iocnt(1),
      O => NlwBufferSignal_EXP3_EXP_PT_4_IN6
    );
  NlwBufferBlock_EXP3_EXP_PT_4_IN7 : X_BUF
    port map (
      I => iocnt(0),
      O => NlwBufferSignal_EXP3_EXP_PT_4_IN7
    );
  NlwBufferBlock_EXP3_EXP_PT_4_IN8 : X_BUF
    port map (
      I => iocnt(2),
      O => NlwBufferSignal_EXP3_EXP_PT_4_IN8
    );
  NlwBufferBlock_EXP3_EXP_PT_4_IN9 : X_BUF
    port map (
      I => refcnt(7),
      O => NlwBufferSignal_EXP3_EXP_PT_4_IN9
    );
  NlwBufferBlock_EXP3_EXP_PT_4_IN10 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP3_EXP_PT_4_IN10
    );
  NlwBufferBlock_EXP3_EXP_PT_4_IN11 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP3_EXP_PT_4_IN11
    );
  NlwBufferBlock_EXP3_EXP_PT_4_IN12 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP3_EXP_PT_4_IN12
    );
  NlwBufferBlock_EXP3_EXP_PT_4_IN13 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP3_EXP_PT_4_IN13
    );
  NlwBufferBlock_EXP3_EXP_PT_4_IN14 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP3_EXP_PT_4_IN14
    );
  NlwBufferBlock_EXP3_EXP_PT_4_IN15 : X_BUF
    port map (
      I => Vcc_84,
      O => NlwBufferSignal_EXP3_EXP_PT_4_IN15
    );
  NlwBufferBlock_EXP3_EXP_tsimrenamed_net_IN0 : X_BUF
    port map (
      I => EXP3_EXP_PT_0_367,
      O => NlwBufferSignal_EXP3_EXP_tsimrenamed_net_IN0
    );
  NlwBufferBlock_EXP3_EXP_tsimrenamed_net_IN1 : X_BUF
    port map (
      I => EXP3_EXP_PT_1_368,
      O => NlwBufferSignal_EXP3_EXP_tsimrenamed_net_IN1
    );
  NlwBufferBlock_EXP3_EXP_tsimrenamed_net_IN2 : X_BUF
    port map (
      I => EXP3_EXP_PT_2_369,
      O => NlwBufferSignal_EXP3_EXP_tsimrenamed_net_IN2
    );
  NlwBufferBlock_EXP3_EXP_tsimrenamed_net_IN3 : X_BUF
    port map (
      I => EXP3_EXP_PT_3_370,
      O => NlwBufferSignal_EXP3_EXP_tsimrenamed_net_IN3
    );
  NlwBufferBlock_EXP3_EXP_tsimrenamed_net_IN4 : X_BUF
    port map (
      I => EXP3_EXP_PT_4_371,
      O => NlwBufferSignal_EXP3_EXP_tsimrenamed_net_IN4
    );
  NlwInverterBlock_rom_OBUF_D2_PT_0_IN0 : X_INV
    port map (
      I => NlwBufferSignal_rom_OBUF_D2_PT_0_IN0,
      O => NlwInverterSignal_rom_OBUF_D2_PT_0_IN0
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
  NlwInverterBlock_rom_OBUF_D2_PT_1_IN9 : X_INV
    port map (
      I => NlwBufferSignal_rom_OBUF_D2_PT_1_IN9,
      O => NlwInverterSignal_rom_OBUF_D2_PT_1_IN9
    );
  NlwInverterBlock_rom_OBUF_D2_PT_1_IN10 : X_INV
    port map (
      I => NlwBufferSignal_rom_OBUF_D2_PT_1_IN10,
      O => NlwInverterSignal_rom_OBUF_D2_PT_1_IN10
    );
  NlwInverterBlock_rom_OBUF_D2_PT_1_IN11 : X_INV
    port map (
      I => NlwBufferSignal_rom_OBUF_D2_PT_1_IN11,
      O => NlwInverterSignal_rom_OBUF_D2_PT_1_IN11
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
  NlwInverterBlock_phi1_OBUF_D2_PT_4_IN2 : X_INV
    port map (
      I => NlwBufferSignal_phi1_OBUF_D2_PT_4_IN2,
      O => NlwInverterSignal_phi1_OBUF_D2_PT_4_IN2
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
  NlwInverterBlock_cas0_OBUF_D_IN0 : X_INV
    port map (
      I => NlwBufferSignal_cas0_OBUF_D_IN0,
      O => NlwInverterSignal_cas0_OBUF_D_IN0
    );
  NlwInverterBlock_cas0_OBUF_D2_PT_2_IN1 : X_INV
    port map (
      I => NlwBufferSignal_cas0_OBUF_D2_PT_2_IN1,
      O => NlwInverterSignal_cas0_OBUF_D2_PT_2_IN1
    );
  NlwInverterBlock_cas0_OBUF_D2_PT_3_IN0 : X_INV
    port map (
      I => NlwBufferSignal_cas0_OBUF_D2_PT_3_IN0,
      O => NlwInverterSignal_cas0_OBUF_D2_PT_3_IN0
    );
  NlwInverterBlock_cas0_OBUF_D2_PT_3_IN2 : X_INV
    port map (
      I => NlwBufferSignal_cas0_OBUF_D2_PT_3_IN2,
      O => NlwInverterSignal_cas0_OBUF_D2_PT_3_IN2
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
  NlwInverterBlock_cas0_OBUF_D2_PT_4_IN2 : X_INV
    port map (
      I => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN2,
      O => NlwInverterSignal_cas0_OBUF_D2_PT_4_IN2
    );
  NlwInverterBlock_cas0_OBUF_D2_PT_4_IN3 : X_INV
    port map (
      I => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN3,
      O => NlwInverterSignal_cas0_OBUF_D2_PT_4_IN3
    );
  NlwInverterBlock_cas0_OBUF_D2_PT_4_IN6 : X_INV
    port map (
      I => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN6,
      O => NlwInverterSignal_cas0_OBUF_D2_PT_4_IN6
    );
  NlwInverterBlock_cas0_OBUF_D2_PT_4_IN7 : X_INV
    port map (
      I => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN7,
      O => NlwInverterSignal_cas0_OBUF_D2_PT_4_IN7
    );
  NlwInverterBlock_cas0_OBUF_D2_PT_4_IN8 : X_INV
    port map (
      I => NlwBufferSignal_cas0_OBUF_D2_PT_4_IN8,
      O => NlwInverterSignal_cas0_OBUF_D2_PT_4_IN8
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
  NlwInverterBlock_cas0_OBUF_D2_PT_5_IN2 : X_INV
    port map (
      I => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN2,
      O => NlwInverterSignal_cas0_OBUF_D2_PT_5_IN2
    );
  NlwInverterBlock_cas0_OBUF_D2_PT_5_IN3 : X_INV
    port map (
      I => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN3,
      O => NlwInverterSignal_cas0_OBUF_D2_PT_5_IN3
    );
  NlwInverterBlock_cas0_OBUF_D2_PT_5_IN6 : X_INV
    port map (
      I => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN6,
      O => NlwInverterSignal_cas0_OBUF_D2_PT_5_IN6
    );
  NlwInverterBlock_cas0_OBUF_D2_PT_5_IN7 : X_INV
    port map (
      I => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN7,
      O => NlwInverterSignal_cas0_OBUF_D2_PT_5_IN7
    );
  NlwInverterBlock_cas0_OBUF_D2_PT_5_IN8 : X_INV
    port map (
      I => NlwBufferSignal_cas0_OBUF_D2_PT_5_IN8,
      O => NlwInverterSignal_cas0_OBUF_D2_PT_5_IN8
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
  NlwInverterBlock_cas0_OBUF_D2_PT_6_IN2 : X_INV
    port map (
      I => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN2,
      O => NlwInverterSignal_cas0_OBUF_D2_PT_6_IN2
    );
  NlwInverterBlock_cas0_OBUF_D2_PT_6_IN3 : X_INV
    port map (
      I => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN3,
      O => NlwInverterSignal_cas0_OBUF_D2_PT_6_IN3
    );
  NlwInverterBlock_cas0_OBUF_D2_PT_6_IN6 : X_INV
    port map (
      I => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN6,
      O => NlwInverterSignal_cas0_OBUF_D2_PT_6_IN6
    );
  NlwInverterBlock_cas0_OBUF_D2_PT_6_IN7 : X_INV
    port map (
      I => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN7,
      O => NlwInverterSignal_cas0_OBUF_D2_PT_6_IN7
    );
  NlwInverterBlock_cas0_OBUF_D2_PT_6_IN8 : X_INV
    port map (
      I => NlwBufferSignal_cas0_OBUF_D2_PT_6_IN8,
      O => NlwInverterSignal_cas0_OBUF_D2_PT_6_IN8
    );
  NlwInverterBlock_cas1_OBUF_D2_PT_1_IN0 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_D2_PT_1_IN0,
      O => NlwInverterSignal_cas1_OBUF_D2_PT_1_IN0
    );
  NlwInverterBlock_cas1_OBUF_D2_PT_1_IN3 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_D2_PT_1_IN3,
      O => NlwInverterSignal_cas1_OBUF_D2_PT_1_IN3
    );
  NlwInverterBlock_cas1_OBUF_D2_PT_2_IN0 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN0,
      O => NlwInverterSignal_cas1_OBUF_D2_PT_2_IN0
    );
  NlwInverterBlock_cas1_OBUF_D2_PT_2_IN2 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN2,
      O => NlwInverterSignal_cas1_OBUF_D2_PT_2_IN2
    );
  NlwInverterBlock_cas1_OBUF_D2_PT_2_IN3 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN3,
      O => NlwInverterSignal_cas1_OBUF_D2_PT_2_IN3
    );
  NlwInverterBlock_cas1_OBUF_D2_PT_2_IN6 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN6,
      O => NlwInverterSignal_cas1_OBUF_D2_PT_2_IN6
    );
  NlwInverterBlock_cas1_OBUF_D2_PT_2_IN7 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN7,
      O => NlwInverterSignal_cas1_OBUF_D2_PT_2_IN7
    );
  NlwInverterBlock_cas1_OBUF_D2_PT_2_IN8 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_D2_PT_2_IN8,
      O => NlwInverterSignal_cas1_OBUF_D2_PT_2_IN8
    );
  NlwInverterBlock_cas1_OBUF_D2_PT_3_IN0 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN0,
      O => NlwInverterSignal_cas1_OBUF_D2_PT_3_IN0
    );
  NlwInverterBlock_cas1_OBUF_D2_PT_3_IN2 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN2,
      O => NlwInverterSignal_cas1_OBUF_D2_PT_3_IN2
    );
  NlwInverterBlock_cas1_OBUF_D2_PT_3_IN3 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN3,
      O => NlwInverterSignal_cas1_OBUF_D2_PT_3_IN3
    );
  NlwInverterBlock_cas1_OBUF_D2_PT_3_IN6 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN6,
      O => NlwInverterSignal_cas1_OBUF_D2_PT_3_IN6
    );
  NlwInverterBlock_cas1_OBUF_D2_PT_3_IN7 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN7,
      O => NlwInverterSignal_cas1_OBUF_D2_PT_3_IN7
    );
  NlwInverterBlock_cas1_OBUF_D2_PT_3_IN8 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_D2_PT_3_IN8,
      O => NlwInverterSignal_cas1_OBUF_D2_PT_3_IN8
    );
  NlwInverterBlock_cas1_OBUF_D2_PT_4_IN0 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_D2_PT_4_IN0,
      O => NlwInverterSignal_cas1_OBUF_D2_PT_4_IN0
    );
  NlwInverterBlock_cas1_OBUF_D2_PT_4_IN2 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_D2_PT_4_IN2,
      O => NlwInverterSignal_cas1_OBUF_D2_PT_4_IN2
    );
  NlwInverterBlock_cas1_OBUF_D2_PT_4_IN3 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_D2_PT_4_IN3,
      O => NlwInverterSignal_cas1_OBUF_D2_PT_4_IN3
    );
  NlwInverterBlock_cas1_OBUF_D2_PT_4_IN6 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_D2_PT_4_IN6,
      O => NlwInverterSignal_cas1_OBUF_D2_PT_4_IN6
    );
  NlwInverterBlock_cas1_OBUF_D2_PT_4_IN7 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_D2_PT_4_IN7,
      O => NlwInverterSignal_cas1_OBUF_D2_PT_4_IN7
    );
  NlwInverterBlock_cas1_OBUF_D2_PT_4_IN8 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_D2_PT_4_IN8,
      O => NlwInverterSignal_cas1_OBUF_D2_PT_4_IN8
    );
  NlwInverterBlock_cas1_OBUF_D2_PT_5_IN0 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_D2_PT_5_IN0,
      O => NlwInverterSignal_cas1_OBUF_D2_PT_5_IN0
    );
  NlwInverterBlock_cas1_OBUF_D2_PT_5_IN2 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_D2_PT_5_IN2,
      O => NlwInverterSignal_cas1_OBUF_D2_PT_5_IN2
    );
  NlwInverterBlock_cas1_OBUF_D2_PT_5_IN3 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_D2_PT_5_IN3,
      O => NlwInverterSignal_cas1_OBUF_D2_PT_5_IN3
    );
  NlwInverterBlock_cas1_OBUF_D2_PT_5_IN6 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_D2_PT_5_IN6,
      O => NlwInverterSignal_cas1_OBUF_D2_PT_5_IN6
    );
  NlwInverterBlock_cas1_OBUF_D2_PT_5_IN7 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_D2_PT_5_IN7,
      O => NlwInverterSignal_cas1_OBUF_D2_PT_5_IN7
    );
  NlwInverterBlock_cas1_OBUF_D2_PT_5_IN8 : X_INV
    port map (
      I => NlwBufferSignal_cas1_OBUF_D2_PT_5_IN8,
      O => NlwInverterSignal_cas1_OBUF_D2_PT_5_IN8
    );
  NlwInverterBlock_cas2_OBUF_D2_PT_2_IN0 : X_INV
    port map (
      I => NlwBufferSignal_cas2_OBUF_D2_PT_2_IN0,
      O => NlwInverterSignal_cas2_OBUF_D2_PT_2_IN0
    );
  NlwInverterBlock_cas2_OBUF_D2_PT_2_IN3 : X_INV
    port map (
      I => NlwBufferSignal_cas2_OBUF_D2_PT_2_IN3,
      O => NlwInverterSignal_cas2_OBUF_D2_PT_2_IN3
    );
  NlwInverterBlock_cas2_OBUF_D2_PT_3_IN1 : X_INV
    port map (
      I => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN1,
      O => NlwInverterSignal_cas2_OBUF_D2_PT_3_IN1
    );
  NlwInverterBlock_cas2_OBUF_D2_PT_3_IN2 : X_INV
    port map (
      I => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN2,
      O => NlwInverterSignal_cas2_OBUF_D2_PT_3_IN2
    );
  NlwInverterBlock_cas2_OBUF_D2_PT_3_IN3 : X_INV
    port map (
      I => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN3,
      O => NlwInverterSignal_cas2_OBUF_D2_PT_3_IN3
    );
  NlwInverterBlock_cas2_OBUF_D2_PT_3_IN6 : X_INV
    port map (
      I => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN6,
      O => NlwInverterSignal_cas2_OBUF_D2_PT_3_IN6
    );
  NlwInverterBlock_cas2_OBUF_D2_PT_3_IN7 : X_INV
    port map (
      I => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN7,
      O => NlwInverterSignal_cas2_OBUF_D2_PT_3_IN7
    );
  NlwInverterBlock_cas2_OBUF_D2_PT_3_IN8 : X_INV
    port map (
      I => NlwBufferSignal_cas2_OBUF_D2_PT_3_IN8,
      O => NlwInverterSignal_cas2_OBUF_D2_PT_3_IN8
    );
  NlwInverterBlock_cas2_OBUF_D2_PT_4_IN1 : X_INV
    port map (
      I => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN1,
      O => NlwInverterSignal_cas2_OBUF_D2_PT_4_IN1
    );
  NlwInverterBlock_cas2_OBUF_D2_PT_4_IN2 : X_INV
    port map (
      I => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN2,
      O => NlwInverterSignal_cas2_OBUF_D2_PT_4_IN2
    );
  NlwInverterBlock_cas2_OBUF_D2_PT_4_IN3 : X_INV
    port map (
      I => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN3,
      O => NlwInverterSignal_cas2_OBUF_D2_PT_4_IN3
    );
  NlwInverterBlock_cas2_OBUF_D2_PT_4_IN6 : X_INV
    port map (
      I => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN6,
      O => NlwInverterSignal_cas2_OBUF_D2_PT_4_IN6
    );
  NlwInverterBlock_cas2_OBUF_D2_PT_4_IN7 : X_INV
    port map (
      I => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN7,
      O => NlwInverterSignal_cas2_OBUF_D2_PT_4_IN7
    );
  NlwInverterBlock_cas2_OBUF_D2_PT_4_IN8 : X_INV
    port map (
      I => NlwBufferSignal_cas2_OBUF_D2_PT_4_IN8,
      O => NlwInverterSignal_cas2_OBUF_D2_PT_4_IN8
    );
  NlwInverterBlock_cas2_OBUF_D2_PT_5_IN1 : X_INV
    port map (
      I => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN1,
      O => NlwInverterSignal_cas2_OBUF_D2_PT_5_IN1
    );
  NlwInverterBlock_cas2_OBUF_D2_PT_5_IN2 : X_INV
    port map (
      I => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN2,
      O => NlwInverterSignal_cas2_OBUF_D2_PT_5_IN2
    );
  NlwInverterBlock_cas2_OBUF_D2_PT_5_IN3 : X_INV
    port map (
      I => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN3,
      O => NlwInverterSignal_cas2_OBUF_D2_PT_5_IN3
    );
  NlwInverterBlock_cas2_OBUF_D2_PT_5_IN6 : X_INV
    port map (
      I => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN6,
      O => NlwInverterSignal_cas2_OBUF_D2_PT_5_IN6
    );
  NlwInverterBlock_cas2_OBUF_D2_PT_5_IN7 : X_INV
    port map (
      I => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN7,
      O => NlwInverterSignal_cas2_OBUF_D2_PT_5_IN7
    );
  NlwInverterBlock_cas2_OBUF_D2_PT_5_IN8 : X_INV
    port map (
      I => NlwBufferSignal_cas2_OBUF_D2_PT_5_IN8,
      O => NlwInverterSignal_cas2_OBUF_D2_PT_5_IN8
    );
  NlwInverterBlock_cas2_OBUF_D2_PT_6_IN1 : X_INV
    port map (
      I => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN1,
      O => NlwInverterSignal_cas2_OBUF_D2_PT_6_IN1
    );
  NlwInverterBlock_cas2_OBUF_D2_PT_6_IN2 : X_INV
    port map (
      I => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN2,
      O => NlwInverterSignal_cas2_OBUF_D2_PT_6_IN2
    );
  NlwInverterBlock_cas2_OBUF_D2_PT_6_IN3 : X_INV
    port map (
      I => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN3,
      O => NlwInverterSignal_cas2_OBUF_D2_PT_6_IN3
    );
  NlwInverterBlock_cas2_OBUF_D2_PT_6_IN6 : X_INV
    port map (
      I => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN6,
      O => NlwInverterSignal_cas2_OBUF_D2_PT_6_IN6
    );
  NlwInverterBlock_cas2_OBUF_D2_PT_6_IN7 : X_INV
    port map (
      I => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN7,
      O => NlwInverterSignal_cas2_OBUF_D2_PT_6_IN7
    );
  NlwInverterBlock_cas2_OBUF_D2_PT_6_IN8 : X_INV
    port map (
      I => NlwBufferSignal_cas2_OBUF_D2_PT_6_IN8,
      O => NlwInverterSignal_cas2_OBUF_D2_PT_6_IN8
    );
  NlwInverterBlock_cas3_OBUF_D2_PT_1_IN0 : X_INV
    port map (
      I => NlwBufferSignal_cas3_OBUF_D2_PT_1_IN0,
      O => NlwInverterSignal_cas3_OBUF_D2_PT_1_IN0
    );
  NlwInverterBlock_cas3_OBUF_D2_PT_1_IN3 : X_INV
    port map (
      I => NlwBufferSignal_cas3_OBUF_D2_PT_1_IN3,
      O => NlwInverterSignal_cas3_OBUF_D2_PT_1_IN3
    );
  NlwInverterBlock_cas3_OBUF_D2_PT_2_IN2 : X_INV
    port map (
      I => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN2,
      O => NlwInverterSignal_cas3_OBUF_D2_PT_2_IN2
    );
  NlwInverterBlock_cas3_OBUF_D2_PT_2_IN3 : X_INV
    port map (
      I => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN3,
      O => NlwInverterSignal_cas3_OBUF_D2_PT_2_IN3
    );
  NlwInverterBlock_cas3_OBUF_D2_PT_2_IN6 : X_INV
    port map (
      I => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN6,
      O => NlwInverterSignal_cas3_OBUF_D2_PT_2_IN6
    );
  NlwInverterBlock_cas3_OBUF_D2_PT_2_IN7 : X_INV
    port map (
      I => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN7,
      O => NlwInverterSignal_cas3_OBUF_D2_PT_2_IN7
    );
  NlwInverterBlock_cas3_OBUF_D2_PT_2_IN8 : X_INV
    port map (
      I => NlwBufferSignal_cas3_OBUF_D2_PT_2_IN8,
      O => NlwInverterSignal_cas3_OBUF_D2_PT_2_IN8
    );
  NlwInverterBlock_cas3_OBUF_D2_PT_3_IN2 : X_INV
    port map (
      I => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN2,
      O => NlwInverterSignal_cas3_OBUF_D2_PT_3_IN2
    );
  NlwInverterBlock_cas3_OBUF_D2_PT_3_IN3 : X_INV
    port map (
      I => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN3,
      O => NlwInverterSignal_cas3_OBUF_D2_PT_3_IN3
    );
  NlwInverterBlock_cas3_OBUF_D2_PT_3_IN6 : X_INV
    port map (
      I => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN6,
      O => NlwInverterSignal_cas3_OBUF_D2_PT_3_IN6
    );
  NlwInverterBlock_cas3_OBUF_D2_PT_3_IN7 : X_INV
    port map (
      I => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN7,
      O => NlwInverterSignal_cas3_OBUF_D2_PT_3_IN7
    );
  NlwInverterBlock_cas3_OBUF_D2_PT_3_IN8 : X_INV
    port map (
      I => NlwBufferSignal_cas3_OBUF_D2_PT_3_IN8,
      O => NlwInverterSignal_cas3_OBUF_D2_PT_3_IN8
    );
  NlwInverterBlock_cas3_OBUF_D2_PT_4_IN2 : X_INV
    port map (
      I => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN2,
      O => NlwInverterSignal_cas3_OBUF_D2_PT_4_IN2
    );
  NlwInverterBlock_cas3_OBUF_D2_PT_4_IN3 : X_INV
    port map (
      I => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN3,
      O => NlwInverterSignal_cas3_OBUF_D2_PT_4_IN3
    );
  NlwInverterBlock_cas3_OBUF_D2_PT_4_IN6 : X_INV
    port map (
      I => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN6,
      O => NlwInverterSignal_cas3_OBUF_D2_PT_4_IN6
    );
  NlwInverterBlock_cas3_OBUF_D2_PT_4_IN7 : X_INV
    port map (
      I => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN7,
      O => NlwInverterSignal_cas3_OBUF_D2_PT_4_IN7
    );
  NlwInverterBlock_cas3_OBUF_D2_PT_4_IN8 : X_INV
    port map (
      I => NlwBufferSignal_cas3_OBUF_D2_PT_4_IN8,
      O => NlwInverterSignal_cas3_OBUF_D2_PT_4_IN8
    );
  NlwInverterBlock_cas3_OBUF_D2_PT_5_IN2 : X_INV
    port map (
      I => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN2,
      O => NlwInverterSignal_cas3_OBUF_D2_PT_5_IN2
    );
  NlwInverterBlock_cas3_OBUF_D2_PT_5_IN3 : X_INV
    port map (
      I => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN3,
      O => NlwInverterSignal_cas3_OBUF_D2_PT_5_IN3
    );
  NlwInverterBlock_cas3_OBUF_D2_PT_5_IN6 : X_INV
    port map (
      I => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN6,
      O => NlwInverterSignal_cas3_OBUF_D2_PT_5_IN6
    );
  NlwInverterBlock_cas3_OBUF_D2_PT_5_IN7 : X_INV
    port map (
      I => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN7,
      O => NlwInverterSignal_cas3_OBUF_D2_PT_5_IN7
    );
  NlwInverterBlock_cas3_OBUF_D2_PT_5_IN8 : X_INV
    port map (
      I => NlwBufferSignal_cas3_OBUF_D2_PT_5_IN8,
      O => NlwInverterSignal_cas3_OBUF_D2_PT_5_IN8
    );
  NlwInverterBlock_io0_OBUF_D2_PT_0_IN0 : X_INV
    port map (
      I => NlwBufferSignal_io0_OBUF_D2_PT_0_IN0,
      O => NlwInverterSignal_io0_OBUF_D2_PT_0_IN0
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
  NlwInverterBlock_io0_OBUF_D2_PT_1_IN3 : X_INV
    port map (
      I => NlwBufferSignal_io0_OBUF_D2_PT_1_IN3,
      O => NlwInverterSignal_io0_OBUF_D2_PT_1_IN3
    );
  NlwInverterBlock_io0_OBUF_D2_PT_1_IN6 : X_INV
    port map (
      I => NlwBufferSignal_io0_OBUF_D2_PT_1_IN6,
      O => NlwInverterSignal_io0_OBUF_D2_PT_1_IN6
    );
  NlwInverterBlock_io0_OBUF_D2_PT_1_IN8 : X_INV
    port map (
      I => NlwBufferSignal_io0_OBUF_D2_PT_1_IN8,
      O => NlwInverterSignal_io0_OBUF_D2_PT_1_IN8
    );
  NlwInverterBlock_io1_OBUF_D2_PT_0_IN0 : X_INV
    port map (
      I => NlwBufferSignal_io1_OBUF_D2_PT_0_IN0,
      O => NlwInverterSignal_io1_OBUF_D2_PT_0_IN0
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
  NlwInverterBlock_io1_OBUF_D2_PT_1_IN3 : X_INV
    port map (
      I => NlwBufferSignal_io1_OBUF_D2_PT_1_IN3,
      O => NlwInverterSignal_io1_OBUF_D2_PT_1_IN3
    );
  NlwInverterBlock_io1_OBUF_D2_PT_1_IN6 : X_INV
    port map (
      I => NlwBufferSignal_io1_OBUF_D2_PT_1_IN6,
      O => NlwInverterSignal_io1_OBUF_D2_PT_1_IN6
    );
  NlwInverterBlock_io1_OBUF_D2_PT_1_IN8 : X_INV
    port map (
      I => NlwBufferSignal_io1_OBUF_D2_PT_1_IN8,
      O => NlwInverterSignal_io1_OBUF_D2_PT_1_IN8
    );
  NlwInverterBlock_io2_OBUF_D2_PT_0_IN0 : X_INV
    port map (
      I => NlwBufferSignal_io2_OBUF_D2_PT_0_IN0,
      O => NlwInverterSignal_io2_OBUF_D2_PT_0_IN0
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
  NlwInverterBlock_io2_OBUF_D2_PT_1_IN3 : X_INV
    port map (
      I => NlwBufferSignal_io2_OBUF_D2_PT_1_IN3,
      O => NlwInverterSignal_io2_OBUF_D2_PT_1_IN3
    );
  NlwInverterBlock_io2_OBUF_D2_PT_1_IN6 : X_INV
    port map (
      I => NlwBufferSignal_io2_OBUF_D2_PT_1_IN6,
      O => NlwInverterSignal_io2_OBUF_D2_PT_1_IN6
    );
  NlwInverterBlock_io2_OBUF_D2_PT_1_IN8 : X_INV
    port map (
      I => NlwBufferSignal_io2_OBUF_D2_PT_1_IN8,
      O => NlwInverterSignal_io2_OBUF_D2_PT_1_IN8
    );
  NlwInverterBlock_io3_OBUF_D2_PT_0_IN0 : X_INV
    port map (
      I => NlwBufferSignal_io3_OBUF_D2_PT_0_IN0,
      O => NlwInverterSignal_io3_OBUF_D2_PT_0_IN0
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
  NlwInverterBlock_io3_OBUF_D2_PT_1_IN3 : X_INV
    port map (
      I => NlwBufferSignal_io3_OBUF_D2_PT_1_IN3,
      O => NlwInverterSignal_io3_OBUF_D2_PT_1_IN3
    );
  NlwInverterBlock_io3_OBUF_D2_PT_1_IN6 : X_INV
    port map (
      I => NlwBufferSignal_io3_OBUF_D2_PT_1_IN6,
      O => NlwInverterSignal_io3_OBUF_D2_PT_1_IN6
    );
  NlwInverterBlock_io3_OBUF_D2_PT_1_IN8 : X_INV
    port map (
      I => NlwBufferSignal_io3_OBUF_D2_PT_1_IN8,
      O => NlwInverterSignal_io3_OBUF_D2_PT_1_IN8
    );
  NlwInverterBlock_io4_OBUF_D2_PT_0_IN0 : X_INV
    port map (
      I => NlwBufferSignal_io4_OBUF_D2_PT_0_IN0,
      O => NlwInverterSignal_io4_OBUF_D2_PT_0_IN0
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
  NlwInverterBlock_io4_OBUF_D2_PT_1_IN3 : X_INV
    port map (
      I => NlwBufferSignal_io4_OBUF_D2_PT_1_IN3,
      O => NlwInverterSignal_io4_OBUF_D2_PT_1_IN3
    );
  NlwInverterBlock_io4_OBUF_D2_PT_1_IN6 : X_INV
    port map (
      I => NlwBufferSignal_io4_OBUF_D2_PT_1_IN6,
      O => NlwInverterSignal_io4_OBUF_D2_PT_1_IN6
    );
  NlwInverterBlock_io4_OBUF_D2_PT_1_IN8 : X_INV
    port map (
      I => NlwBufferSignal_io4_OBUF_D2_PT_1_IN8,
      O => NlwInverterSignal_io4_OBUF_D2_PT_1_IN8
    );
  NlwInverterBlock_io5_OBUF_D2_PT_0_IN0 : X_INV
    port map (
      I => NlwBufferSignal_io5_OBUF_D2_PT_0_IN0,
      O => NlwInverterSignal_io5_OBUF_D2_PT_0_IN0
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
  NlwInverterBlock_io5_OBUF_D2_PT_1_IN3 : X_INV
    port map (
      I => NlwBufferSignal_io5_OBUF_D2_PT_1_IN3,
      O => NlwInverterSignal_io5_OBUF_D2_PT_1_IN3
    );
  NlwInverterBlock_io5_OBUF_D2_PT_1_IN6 : X_INV
    port map (
      I => NlwBufferSignal_io5_OBUF_D2_PT_1_IN6,
      O => NlwInverterSignal_io5_OBUF_D2_PT_1_IN6
    );
  NlwInverterBlock_io5_OBUF_D2_PT_1_IN8 : X_INV
    port map (
      I => NlwBufferSignal_io5_OBUF_D2_PT_1_IN8,
      O => NlwInverterSignal_io5_OBUF_D2_PT_1_IN8
    );
  NlwInverterBlock_io6_OBUF_D2_PT_0_IN0 : X_INV
    port map (
      I => NlwBufferSignal_io6_OBUF_D2_PT_0_IN0,
      O => NlwInverterSignal_io6_OBUF_D2_PT_0_IN0
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
  NlwInverterBlock_io6_OBUF_D2_PT_1_IN3 : X_INV
    port map (
      I => NlwBufferSignal_io6_OBUF_D2_PT_1_IN3,
      O => NlwInverterSignal_io6_OBUF_D2_PT_1_IN3
    );
  NlwInverterBlock_io6_OBUF_D2_PT_1_IN6 : X_INV
    port map (
      I => NlwBufferSignal_io6_OBUF_D2_PT_1_IN6,
      O => NlwInverterSignal_io6_OBUF_D2_PT_1_IN6
    );
  NlwInverterBlock_io6_OBUF_D2_PT_1_IN8 : X_INV
    port map (
      I => NlwBufferSignal_io6_OBUF_D2_PT_1_IN8,
      O => NlwInverterSignal_io6_OBUF_D2_PT_1_IN8
    );
  NlwInverterBlock_io7_OBUF_D2_PT_0_IN0 : X_INV
    port map (
      I => NlwBufferSignal_io7_OBUF_D2_PT_0_IN0,
      O => NlwInverterSignal_io7_OBUF_D2_PT_0_IN0
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
  NlwInverterBlock_io7_OBUF_D2_PT_1_IN3 : X_INV
    port map (
      I => NlwBufferSignal_io7_OBUF_D2_PT_1_IN3,
      O => NlwInverterSignal_io7_OBUF_D2_PT_1_IN3
    );
  NlwInverterBlock_io7_OBUF_D2_PT_1_IN6 : X_INV
    port map (
      I => NlwBufferSignal_io7_OBUF_D2_PT_1_IN6,
      O => NlwInverterSignal_io7_OBUF_D2_PT_1_IN6
    );
  NlwInverterBlock_io7_OBUF_D2_PT_1_IN8 : X_INV
    port map (
      I => NlwBufferSignal_io7_OBUF_D2_PT_1_IN8,
      O => NlwInverterSignal_io7_OBUF_D2_PT_1_IN8
    );
  NlwInverterBlock_phi0_OBUF_D2_PT_2_IN0 : X_INV
    port map (
      I => NlwBufferSignal_phi0_OBUF_D2_PT_2_IN0,
      O => NlwInverterSignal_phi0_OBUF_D2_PT_2_IN0
    );
  NlwInverterBlock_phi0_OBUF_D2_PT_4_IN0 : X_INV
    port map (
      I => NlwBufferSignal_phi0_OBUF_D2_PT_4_IN0,
      O => NlwInverterSignal_phi0_OBUF_D2_PT_4_IN0
    );
  NlwInverterBlock_phi0_OBUF_D2_PT_4_IN2 : X_INV
    port map (
      I => NlwBufferSignal_phi0_OBUF_D2_PT_4_IN2,
      O => NlwInverterSignal_phi0_OBUF_D2_PT_4_IN2
    );
  NlwInverterBlock_phi0_OBUF_D2_PT_5_IN0 : X_INV
    port map (
      I => NlwBufferSignal_phi0_OBUF_D2_PT_5_IN0,
      O => NlwInverterSignal_phi0_OBUF_D2_PT_5_IN0
    );
  NlwInverterBlock_ras_OBUF_D2_PT_1_IN0 : X_INV
    port map (
      I => NlwBufferSignal_ras_OBUF_D2_PT_1_IN0,
      O => NlwInverterSignal_ras_OBUF_D2_PT_1_IN0
    );
  NlwInverterBlock_ras_OBUF_D2_PT_3_IN1 : X_INV
    port map (
      I => NlwBufferSignal_ras_OBUF_D2_PT_3_IN1,
      O => NlwInverterSignal_ras_OBUF_D2_PT_3_IN1
    );
  NlwInverterBlock_ras_OBUF_D2_PT_4_IN0 : X_INV
    port map (
      I => NlwBufferSignal_ras_OBUF_D2_PT_4_IN0,
      O => NlwInverterSignal_ras_OBUF_D2_PT_4_IN0
    );
  NlwInverterBlock_ras_OBUF_D2_PT_4_IN1 : X_INV
    port map (
      I => NlwBufferSignal_ras_OBUF_D2_PT_4_IN1,
      O => NlwInverterSignal_ras_OBUF_D2_PT_4_IN1
    );
  NlwInverterBlock_ras_OBUF_D2_PT_4_IN2 : X_INV
    port map (
      I => NlwBufferSignal_ras_OBUF_D2_PT_4_IN2,
      O => NlwInverterSignal_ras_OBUF_D2_PT_4_IN2
    );
  NlwInverterBlock_ras_OBUF_D2_PT_4_IN3 : X_INV
    port map (
      I => NlwBufferSignal_ras_OBUF_D2_PT_4_IN3,
      O => NlwInverterSignal_ras_OBUF_D2_PT_4_IN3
    );
  NlwInverterBlock_ras_OBUF_D2_PT_4_IN4 : X_INV
    port map (
      I => NlwBufferSignal_ras_OBUF_D2_PT_4_IN4,
      O => NlwInverterSignal_ras_OBUF_D2_PT_4_IN4
    );
  NlwInverterBlock_ras_OBUF_D2_PT_4_IN5 : X_INV
    port map (
      I => NlwBufferSignal_ras_OBUF_D2_PT_4_IN5,
      O => NlwInverterSignal_ras_OBUF_D2_PT_4_IN5
    );
  NlwInverterBlock_ras_OBUF_D2_PT_4_IN6 : X_INV
    port map (
      I => NlwBufferSignal_ras_OBUF_D2_PT_4_IN6,
      O => NlwInverterSignal_ras_OBUF_D2_PT_4_IN6
    );
  NlwInverterBlock_ras_OBUF_D2_PT_4_IN7 : X_INV
    port map (
      I => NlwBufferSignal_ras_OBUF_D2_PT_4_IN7,
      O => NlwInverterSignal_ras_OBUF_D2_PT_4_IN7
    );
  NlwInverterBlock_iocnt_0_D2_PT_0_IN0 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_0_D2_PT_0_IN0,
      O => NlwInverterSignal_iocnt_0_D2_PT_0_IN0
    );
  NlwInverterBlock_iocnt_0_D2_PT_1_IN0 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_0_D2_PT_1_IN0,
      O => NlwInverterSignal_iocnt_0_D2_PT_1_IN0
    );
  NlwInverterBlock_iocnt_0_D2_PT_2_IN0 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_0_D2_PT_2_IN0,
      O => NlwInverterSignal_iocnt_0_D2_PT_2_IN0
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
  NlwInverterBlock_iocnt_0_D2_PT_3_IN15 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_0_D2_PT_3_IN15,
      O => NlwInverterSignal_iocnt_0_D2_PT_3_IN15
    );
  NlwInverterBlock_iocnt_0_D2_PT_3_IN16 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_0_D2_PT_3_IN16,
      O => NlwInverterSignal_iocnt_0_D2_PT_3_IN16
    );
  NlwInverterBlock_iocnt_1_D2_PT_0_IN0 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_1_D2_PT_0_IN0,
      O => NlwInverterSignal_iocnt_1_D2_PT_0_IN0
    );
  NlwInverterBlock_iocnt_1_D2_PT_1_IN0 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_1_D2_PT_1_IN0,
      O => NlwInverterSignal_iocnt_1_D2_PT_1_IN0
    );
  NlwInverterBlock_iocnt_1_D2_PT_1_IN4 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_1_D2_PT_1_IN4,
      O => NlwInverterSignal_iocnt_1_D2_PT_1_IN4
    );
  NlwInverterBlock_iocnt_2_D2_PT_0_IN0 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_2_D2_PT_0_IN0,
      O => NlwInverterSignal_iocnt_2_D2_PT_0_IN0
    );
  NlwInverterBlock_iocnt_2_D2_PT_1_IN0 : X_INV
    port map (
      I => NlwBufferSignal_iocnt_2_D2_PT_1_IN0,
      O => NlwInverterSignal_iocnt_2_D2_PT_1_IN0
    );
  NlwInverterBlock_counter_0_D_IN0 : X_INV
    port map (
      I => NlwBufferSignal_counter_0_D_IN0,
      O => NlwInverterSignal_counter_0_D_IN0
    );
  NlwInverterBlock_counter_0_D2_IN0 : X_INV
    port map (
      I => NlwBufferSignal_counter_0_D2_IN0,
      O => NlwInverterSignal_counter_0_D2_IN0
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
  NlwInverterBlock_counter_1_D2_PT_1_IN2 : X_INV
    port map (
      I => NlwBufferSignal_counter_1_D2_PT_1_IN2,
      O => NlwInverterSignal_counter_1_D2_PT_1_IN2
    );
  NlwInverterBlock_counter_2_D2_PT_0_IN0 : X_INV
    port map (
      I => NlwBufferSignal_counter_2_D2_PT_0_IN0,
      O => NlwInverterSignal_counter_2_D2_PT_0_IN0
    );
  NlwInverterBlock_counter_2_D2_PT_1_IN2 : X_INV
    port map (
      I => NlwBufferSignal_counter_2_D2_PT_1_IN2,
      O => NlwInverterSignal_counter_2_D2_PT_1_IN2
    );
  NlwInverterBlock_refcnt_0_D2_IN0 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_0_D2_IN0,
      O => NlwInverterSignal_refcnt_0_D2_IN0
    );
  NlwInverterBlock_refcnt_1_D_IN0 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_1_D_IN0,
      O => NlwInverterSignal_refcnt_1_D_IN0
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
  NlwInverterBlock_refcnt_1_D2_PT_2_IN0 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_1_D2_PT_2_IN0,
      O => NlwInverterSignal_refcnt_1_D2_PT_2_IN0
    );
  NlwInverterBlock_refcnt_1_D2_PT_2_IN1 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_1_D2_PT_2_IN1,
      O => NlwInverterSignal_refcnt_1_D2_PT_2_IN1
    );
  NlwInverterBlock_refcnt_1_EXP_tsimrenamed_net_IN0 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN0,
      O => NlwInverterSignal_refcnt_1_EXP_tsimrenamed_net_IN0
    );
  NlwInverterBlock_refcnt_1_EXP_tsimrenamed_net_IN1 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN1,
      O => NlwInverterSignal_refcnt_1_EXP_tsimrenamed_net_IN1
    );
  NlwInverterBlock_refcnt_1_EXP_tsimrenamed_net_IN2 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN2,
      O => NlwInverterSignal_refcnt_1_EXP_tsimrenamed_net_IN2
    );
  NlwInverterBlock_refcnt_1_EXP_tsimrenamed_net_IN3 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN3,
      O => NlwInverterSignal_refcnt_1_EXP_tsimrenamed_net_IN3
    );
  NlwInverterBlock_refcnt_1_EXP_tsimrenamed_net_IN4 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN4,
      O => NlwInverterSignal_refcnt_1_EXP_tsimrenamed_net_IN4
    );
  NlwInverterBlock_refcnt_1_EXP_tsimrenamed_net_IN5 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN5,
      O => NlwInverterSignal_refcnt_1_EXP_tsimrenamed_net_IN5
    );
  NlwInverterBlock_refcnt_1_EXP_tsimrenamed_net_IN6 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN6,
      O => NlwInverterSignal_refcnt_1_EXP_tsimrenamed_net_IN6
    );
  NlwInverterBlock_refcnt_1_EXP_tsimrenamed_net_IN7 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN7,
      O => NlwInverterSignal_refcnt_1_EXP_tsimrenamed_net_IN7
    );
  NlwInverterBlock_refcnt_1_EXP_tsimrenamed_net_IN8 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN8,
      O => NlwInverterSignal_refcnt_1_EXP_tsimrenamed_net_IN8
    );
  NlwInverterBlock_refcnt_1_EXP_tsimrenamed_net_IN9 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN9,
      O => NlwInverterSignal_refcnt_1_EXP_tsimrenamed_net_IN9
    );
  NlwInverterBlock_refcnt_1_EXP_tsimrenamed_net_IN10 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_1_EXP_tsimrenamed_net_IN10,
      O => NlwInverterSignal_refcnt_1_EXP_tsimrenamed_net_IN10
    );
  NlwInverterBlock_refcnt_2_D2_IN0 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_2_D2_IN0,
      O => NlwInverterSignal_refcnt_2_D2_IN0
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
  NlwInverterBlock_refcnt_2_EXP_PT_0_IN1 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_2_EXP_PT_0_IN1,
      O => NlwInverterSignal_refcnt_2_EXP_PT_0_IN1
    );
  NlwInverterBlock_refcnt_2_EXP_PT_0_IN2 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_2_EXP_PT_0_IN2,
      O => NlwInverterSignal_refcnt_2_EXP_PT_0_IN2
    );
  NlwInverterBlock_refcnt_2_EXP_PT_0_IN3 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_2_EXP_PT_0_IN3,
      O => NlwInverterSignal_refcnt_2_EXP_PT_0_IN3
    );
  NlwInverterBlock_refcnt_2_EXP_PT_0_IN6 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_2_EXP_PT_0_IN6,
      O => NlwInverterSignal_refcnt_2_EXP_PT_0_IN6
    );
  NlwInverterBlock_refcnt_2_EXP_PT_0_IN7 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_2_EXP_PT_0_IN7,
      O => NlwInverterSignal_refcnt_2_EXP_PT_0_IN7
    );
  NlwInverterBlock_refcnt_2_EXP_PT_0_IN8 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_2_EXP_PT_0_IN8,
      O => NlwInverterSignal_refcnt_2_EXP_PT_0_IN8
    );
  NlwInverterBlock_refcnt_2_EXP_PT_1_IN1 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_2_EXP_PT_1_IN1,
      O => NlwInverterSignal_refcnt_2_EXP_PT_1_IN1
    );
  NlwInverterBlock_refcnt_2_EXP_PT_1_IN2 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_2_EXP_PT_1_IN2,
      O => NlwInverterSignal_refcnt_2_EXP_PT_1_IN2
    );
  NlwInverterBlock_refcnt_2_EXP_PT_1_IN3 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_2_EXP_PT_1_IN3,
      O => NlwInverterSignal_refcnt_2_EXP_PT_1_IN3
    );
  NlwInverterBlock_refcnt_2_EXP_PT_1_IN6 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_2_EXP_PT_1_IN6,
      O => NlwInverterSignal_refcnt_2_EXP_PT_1_IN6
    );
  NlwInverterBlock_refcnt_2_EXP_PT_1_IN7 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_2_EXP_PT_1_IN7,
      O => NlwInverterSignal_refcnt_2_EXP_PT_1_IN7
    );
  NlwInverterBlock_refcnt_2_EXP_PT_1_IN8 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_2_EXP_PT_1_IN8,
      O => NlwInverterSignal_refcnt_2_EXP_PT_1_IN8
    );
  NlwInverterBlock_refcnt_3_D2_IN0 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_3_D2_IN0,
      O => NlwInverterSignal_refcnt_3_D2_IN0
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
  NlwInverterBlock_refcnt_3_EXP_PT_0_IN1 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_3_EXP_PT_0_IN1,
      O => NlwInverterSignal_refcnt_3_EXP_PT_0_IN1
    );
  NlwInverterBlock_refcnt_3_EXP_PT_0_IN2 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_3_EXP_PT_0_IN2,
      O => NlwInverterSignal_refcnt_3_EXP_PT_0_IN2
    );
  NlwInverterBlock_refcnt_3_EXP_PT_0_IN3 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_3_EXP_PT_0_IN3,
      O => NlwInverterSignal_refcnt_3_EXP_PT_0_IN3
    );
  NlwInverterBlock_refcnt_3_EXP_PT_0_IN6 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_3_EXP_PT_0_IN6,
      O => NlwInverterSignal_refcnt_3_EXP_PT_0_IN6
    );
  NlwInverterBlock_refcnt_3_EXP_PT_0_IN7 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_3_EXP_PT_0_IN7,
      O => NlwInverterSignal_refcnt_3_EXP_PT_0_IN7
    );
  NlwInverterBlock_refcnt_3_EXP_PT_0_IN8 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_3_EXP_PT_0_IN8,
      O => NlwInverterSignal_refcnt_3_EXP_PT_0_IN8
    );
  NlwInverterBlock_refcnt_3_EXP_PT_1_IN1 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_3_EXP_PT_1_IN1,
      O => NlwInverterSignal_refcnt_3_EXP_PT_1_IN1
    );
  NlwInverterBlock_refcnt_3_EXP_PT_1_IN2 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_3_EXP_PT_1_IN2,
      O => NlwInverterSignal_refcnt_3_EXP_PT_1_IN2
    );
  NlwInverterBlock_refcnt_3_EXP_PT_1_IN3 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_3_EXP_PT_1_IN3,
      O => NlwInverterSignal_refcnt_3_EXP_PT_1_IN3
    );
  NlwInverterBlock_refcnt_3_EXP_PT_1_IN6 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_3_EXP_PT_1_IN6,
      O => NlwInverterSignal_refcnt_3_EXP_PT_1_IN6
    );
  NlwInverterBlock_refcnt_3_EXP_PT_1_IN7 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_3_EXP_PT_1_IN7,
      O => NlwInverterSignal_refcnt_3_EXP_PT_1_IN7
    );
  NlwInverterBlock_refcnt_3_EXP_PT_1_IN8 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_3_EXP_PT_1_IN8,
      O => NlwInverterSignal_refcnt_3_EXP_PT_1_IN8
    );
  NlwInverterBlock_refcnt_4_D2_PT_0_IN0 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_D2_PT_0_IN0,
      O => NlwInverterSignal_refcnt_4_D2_PT_0_IN0
    );
  NlwInverterBlock_refcnt_4_D2_PT_0_IN3 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_D2_PT_0_IN3,
      O => NlwInverterSignal_refcnt_4_D2_PT_0_IN3
    );
  NlwInverterBlock_refcnt_4_D2_PT_0_IN4 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_D2_PT_0_IN4,
      O => NlwInverterSignal_refcnt_4_D2_PT_0_IN4
    );
  NlwInverterBlock_refcnt_4_D2_PT_0_IN5 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_D2_PT_0_IN5,
      O => NlwInverterSignal_refcnt_4_D2_PT_0_IN5
    );
  NlwInverterBlock_refcnt_4_D2_PT_0_IN6 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_D2_PT_0_IN6,
      O => NlwInverterSignal_refcnt_4_D2_PT_0_IN6
    );
  NlwInverterBlock_refcnt_4_D2_PT_1_IN0 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_D2_PT_1_IN0,
      O => NlwInverterSignal_refcnt_4_D2_PT_1_IN0
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
  NlwInverterBlock_refcnt_4_D2_PT_2_IN0 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_D2_PT_2_IN0,
      O => NlwInverterSignal_refcnt_4_D2_PT_2_IN0
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
  NlwInverterBlock_refcnt_4_D2_PT_3_IN0 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_D2_PT_3_IN0,
      O => NlwInverterSignal_refcnt_4_D2_PT_3_IN0
    );
  NlwInverterBlock_refcnt_4_D2_PT_3_IN3 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_D2_PT_3_IN3,
      O => NlwInverterSignal_refcnt_4_D2_PT_3_IN3
    );
  NlwInverterBlock_refcnt_4_D2_PT_3_IN4 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_D2_PT_3_IN4,
      O => NlwInverterSignal_refcnt_4_D2_PT_3_IN4
    );
  NlwInverterBlock_refcnt_4_D2_PT_3_IN5 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_D2_PT_3_IN5,
      O => NlwInverterSignal_refcnt_4_D2_PT_3_IN5
    );
  NlwInverterBlock_refcnt_4_D2_PT_3_IN6 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_D2_PT_3_IN6,
      O => NlwInverterSignal_refcnt_4_D2_PT_3_IN6
    );
  NlwInverterBlock_refcnt_4_EXP_tsimrenamed_net_IN0 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_EXP_tsimrenamed_net_IN0,
      O => NlwInverterSignal_refcnt_4_EXP_tsimrenamed_net_IN0
    );
  NlwInverterBlock_refcnt_4_EXP_tsimrenamed_net_IN1 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_EXP_tsimrenamed_net_IN1,
      O => NlwInverterSignal_refcnt_4_EXP_tsimrenamed_net_IN1
    );
  NlwInverterBlock_refcnt_4_EXP_tsimrenamed_net_IN2 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_EXP_tsimrenamed_net_IN2,
      O => NlwInverterSignal_refcnt_4_EXP_tsimrenamed_net_IN2
    );
  NlwInverterBlock_refcnt_4_EXP_tsimrenamed_net_IN3 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_EXP_tsimrenamed_net_IN3,
      O => NlwInverterSignal_refcnt_4_EXP_tsimrenamed_net_IN3
    );
  NlwInverterBlock_refcnt_4_EXP_tsimrenamed_net_IN4 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_EXP_tsimrenamed_net_IN4,
      O => NlwInverterSignal_refcnt_4_EXP_tsimrenamed_net_IN4
    );
  NlwInverterBlock_refcnt_4_EXP_tsimrenamed_net_IN5 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_EXP_tsimrenamed_net_IN5,
      O => NlwInverterSignal_refcnt_4_EXP_tsimrenamed_net_IN5
    );
  NlwInverterBlock_refcnt_4_EXP_tsimrenamed_net_IN6 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_4_EXP_tsimrenamed_net_IN6,
      O => NlwInverterSignal_refcnt_4_EXP_tsimrenamed_net_IN6
    );
  NlwInverterBlock_refcnt_5_D2_PT_1_IN0 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_D2_PT_1_IN0,
      O => NlwInverterSignal_refcnt_5_D2_PT_1_IN0
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
  NlwInverterBlock_refcnt_5_D2_PT_1_IN7 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_D2_PT_1_IN7,
      O => NlwInverterSignal_refcnt_5_D2_PT_1_IN7
    );
  NlwInverterBlock_refcnt_5_EXP_PT_0_IN0 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_EXP_PT_0_IN0,
      O => NlwInverterSignal_refcnt_5_EXP_PT_0_IN0
    );
  NlwInverterBlock_refcnt_5_EXP_PT_0_IN2 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_EXP_PT_0_IN2,
      O => NlwInverterSignal_refcnt_5_EXP_PT_0_IN2
    );
  NlwInverterBlock_refcnt_5_EXP_PT_0_IN3 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_EXP_PT_0_IN3,
      O => NlwInverterSignal_refcnt_5_EXP_PT_0_IN3
    );
  NlwInverterBlock_refcnt_5_EXP_PT_0_IN6 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_EXP_PT_0_IN6,
      O => NlwInverterSignal_refcnt_5_EXP_PT_0_IN6
    );
  NlwInverterBlock_refcnt_5_EXP_PT_0_IN7 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_EXP_PT_0_IN7,
      O => NlwInverterSignal_refcnt_5_EXP_PT_0_IN7
    );
  NlwInverterBlock_refcnt_5_EXP_PT_0_IN8 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_EXP_PT_0_IN8,
      O => NlwInverterSignal_refcnt_5_EXP_PT_0_IN8
    );
  NlwInverterBlock_refcnt_5_EXP_PT_1_IN0 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_EXP_PT_1_IN0,
      O => NlwInverterSignal_refcnt_5_EXP_PT_1_IN0
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
  NlwInverterBlock_refcnt_5_EXP_PT_1_IN6 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_EXP_PT_1_IN6,
      O => NlwInverterSignal_refcnt_5_EXP_PT_1_IN6
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
  NlwInverterBlock_refcnt_5_EXP_PT_2_IN0 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_EXP_PT_2_IN0,
      O => NlwInverterSignal_refcnt_5_EXP_PT_2_IN0
    );
  NlwInverterBlock_refcnt_5_EXP_PT_2_IN2 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_EXP_PT_2_IN2,
      O => NlwInverterSignal_refcnt_5_EXP_PT_2_IN2
    );
  NlwInverterBlock_refcnt_5_EXP_PT_2_IN3 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_EXP_PT_2_IN3,
      O => NlwInverterSignal_refcnt_5_EXP_PT_2_IN3
    );
  NlwInverterBlock_refcnt_5_EXP_PT_2_IN6 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_EXP_PT_2_IN6,
      O => NlwInverterSignal_refcnt_5_EXP_PT_2_IN6
    );
  NlwInverterBlock_refcnt_5_EXP_PT_2_IN7 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_EXP_PT_2_IN7,
      O => NlwInverterSignal_refcnt_5_EXP_PT_2_IN7
    );
  NlwInverterBlock_refcnt_5_EXP_PT_2_IN8 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_EXP_PT_2_IN8,
      O => NlwInverterSignal_refcnt_5_EXP_PT_2_IN8
    );
  NlwInverterBlock_refcnt_5_EXP_PT_3_IN0 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_EXP_PT_3_IN0,
      O => NlwInverterSignal_refcnt_5_EXP_PT_3_IN0
    );
  NlwInverterBlock_refcnt_5_EXP_PT_3_IN2 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_EXP_PT_3_IN2,
      O => NlwInverterSignal_refcnt_5_EXP_PT_3_IN2
    );
  NlwInverterBlock_refcnt_5_EXP_PT_3_IN3 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_EXP_PT_3_IN3,
      O => NlwInverterSignal_refcnt_5_EXP_PT_3_IN3
    );
  NlwInverterBlock_refcnt_5_EXP_PT_3_IN6 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_EXP_PT_3_IN6,
      O => NlwInverterSignal_refcnt_5_EXP_PT_3_IN6
    );
  NlwInverterBlock_refcnt_5_EXP_PT_3_IN7 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_EXP_PT_3_IN7,
      O => NlwInverterSignal_refcnt_5_EXP_PT_3_IN7
    );
  NlwInverterBlock_refcnt_5_EXP_PT_3_IN8 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_5_EXP_PT_3_IN8,
      O => NlwInverterSignal_refcnt_5_EXP_PT_3_IN8
    );
  NlwInverterBlock_refcnt_6_D2_PT_0_IN0 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_6_D2_PT_0_IN0,
      O => NlwInverterSignal_refcnt_6_D2_PT_0_IN0
    );
  NlwInverterBlock_refcnt_6_D2_PT_0_IN3 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_6_D2_PT_0_IN3,
      O => NlwInverterSignal_refcnt_6_D2_PT_0_IN3
    );
  NlwInverterBlock_refcnt_6_D2_PT_0_IN4 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_6_D2_PT_0_IN4,
      O => NlwInverterSignal_refcnt_6_D2_PT_0_IN4
    );
  NlwInverterBlock_refcnt_6_D2_PT_0_IN5 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_6_D2_PT_0_IN5,
      O => NlwInverterSignal_refcnt_6_D2_PT_0_IN5
    );
  NlwInverterBlock_refcnt_6_D2_PT_0_IN6 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_6_D2_PT_0_IN6,
      O => NlwInverterSignal_refcnt_6_D2_PT_0_IN6
    );
  NlwInverterBlock_refcnt_6_D2_PT_0_IN7 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_6_D2_PT_0_IN7,
      O => NlwInverterSignal_refcnt_6_D2_PT_0_IN7
    );
  NlwInverterBlock_refcnt_6_D2_PT_0_IN8 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_6_D2_PT_0_IN8,
      O => NlwInverterSignal_refcnt_6_D2_PT_0_IN8
    );
  NlwInverterBlock_refcnt_6_D2_PT_1_IN0 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_6_D2_PT_1_IN0,
      O => NlwInverterSignal_refcnt_6_D2_PT_1_IN0
    );
  NlwInverterBlock_refcnt_6_D2_PT_1_IN3 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_6_D2_PT_1_IN3,
      O => NlwInverterSignal_refcnt_6_D2_PT_1_IN3
    );
  NlwInverterBlock_refcnt_6_D2_PT_1_IN4 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_6_D2_PT_1_IN4,
      O => NlwInverterSignal_refcnt_6_D2_PT_1_IN4
    );
  NlwInverterBlock_refcnt_6_D2_PT_1_IN5 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_6_D2_PT_1_IN5,
      O => NlwInverterSignal_refcnt_6_D2_PT_1_IN5
    );
  NlwInverterBlock_refcnt_6_D2_PT_1_IN6 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_6_D2_PT_1_IN6,
      O => NlwInverterSignal_refcnt_6_D2_PT_1_IN6
    );
  NlwInverterBlock_refcnt_6_D2_PT_1_IN7 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_6_D2_PT_1_IN7,
      O => NlwInverterSignal_refcnt_6_D2_PT_1_IN7
    );
  NlwInverterBlock_refcnt_6_D2_PT_1_IN8 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_6_D2_PT_1_IN8,
      O => NlwInverterSignal_refcnt_6_D2_PT_1_IN8
    );
  NlwInverterBlock_refcnt_6_EXP_PT_0_IN0 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_6_EXP_PT_0_IN0,
      O => NlwInverterSignal_refcnt_6_EXP_PT_0_IN0
    );
  NlwInverterBlock_refcnt_6_EXP_PT_0_IN3 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_6_EXP_PT_0_IN3,
      O => NlwInverterSignal_refcnt_6_EXP_PT_0_IN3
    );
  NlwInverterBlock_refcnt_6_EXP_PT_0_IN4 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_6_EXP_PT_0_IN4,
      O => NlwInverterSignal_refcnt_6_EXP_PT_0_IN4
    );
  NlwInverterBlock_refcnt_6_EXP_PT_0_IN5 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_6_EXP_PT_0_IN5,
      O => NlwInverterSignal_refcnt_6_EXP_PT_0_IN5
    );
  NlwInverterBlock_refcnt_6_EXP_PT_0_IN6 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_6_EXP_PT_0_IN6,
      O => NlwInverterSignal_refcnt_6_EXP_PT_0_IN6
    );
  NlwInverterBlock_refcnt_6_EXP_PT_0_IN7 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_6_EXP_PT_0_IN7,
      O => NlwInverterSignal_refcnt_6_EXP_PT_0_IN7
    );
  NlwInverterBlock_refcnt_6_EXP_PT_1_IN0 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_6_EXP_PT_1_IN0,
      O => NlwInverterSignal_refcnt_6_EXP_PT_1_IN0
    );
  NlwInverterBlock_refcnt_6_EXP_PT_1_IN3 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_6_EXP_PT_1_IN3,
      O => NlwInverterSignal_refcnt_6_EXP_PT_1_IN3
    );
  NlwInverterBlock_refcnt_6_EXP_PT_1_IN4 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_6_EXP_PT_1_IN4,
      O => NlwInverterSignal_refcnt_6_EXP_PT_1_IN4
    );
  NlwInverterBlock_refcnt_6_EXP_PT_1_IN5 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_6_EXP_PT_1_IN5,
      O => NlwInverterSignal_refcnt_6_EXP_PT_1_IN5
    );
  NlwInverterBlock_refcnt_6_EXP_PT_1_IN6 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_6_EXP_PT_1_IN6,
      O => NlwInverterSignal_refcnt_6_EXP_PT_1_IN6
    );
  NlwInverterBlock_refcnt_6_EXP_PT_1_IN7 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_6_EXP_PT_1_IN7,
      O => NlwInverterSignal_refcnt_6_EXP_PT_1_IN7
    );
  NlwInverterBlock_refcnt_7_D2_IN0 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_D2_IN0,
      O => NlwInverterSignal_refcnt_7_D2_IN0
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
  NlwInverterBlock_refcnt_7_EXP_PT_0_IN2 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_EXP_PT_0_IN2,
      O => NlwInverterSignal_refcnt_7_EXP_PT_0_IN2
    );
  NlwInverterBlock_refcnt_7_EXP_PT_0_IN3 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_EXP_PT_0_IN3,
      O => NlwInverterSignal_refcnt_7_EXP_PT_0_IN3
    );
  NlwInverterBlock_refcnt_7_EXP_PT_0_IN6 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_EXP_PT_0_IN6,
      O => NlwInverterSignal_refcnt_7_EXP_PT_0_IN6
    );
  NlwInverterBlock_refcnt_7_EXP_PT_0_IN7 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_EXP_PT_0_IN7,
      O => NlwInverterSignal_refcnt_7_EXP_PT_0_IN7
    );
  NlwInverterBlock_refcnt_7_EXP_PT_0_IN8 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_EXP_PT_0_IN8,
      O => NlwInverterSignal_refcnt_7_EXP_PT_0_IN8
    );
  NlwInverterBlock_refcnt_7_EXP_PT_1_IN2 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_EXP_PT_1_IN2,
      O => NlwInverterSignal_refcnt_7_EXP_PT_1_IN2
    );
  NlwInverterBlock_refcnt_7_EXP_PT_1_IN3 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_EXP_PT_1_IN3,
      O => NlwInverterSignal_refcnt_7_EXP_PT_1_IN3
    );
  NlwInverterBlock_refcnt_7_EXP_PT_1_IN6 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_EXP_PT_1_IN6,
      O => NlwInverterSignal_refcnt_7_EXP_PT_1_IN6
    );
  NlwInverterBlock_refcnt_7_EXP_PT_1_IN7 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_EXP_PT_1_IN7,
      O => NlwInverterSignal_refcnt_7_EXP_PT_1_IN7
    );
  NlwInverterBlock_refcnt_7_EXP_PT_1_IN8 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_EXP_PT_1_IN8,
      O => NlwInverterSignal_refcnt_7_EXP_PT_1_IN8
    );
  NlwInverterBlock_refcnt_7_EXP_PT_2_IN2 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_EXP_PT_2_IN2,
      O => NlwInverterSignal_refcnt_7_EXP_PT_2_IN2
    );
  NlwInverterBlock_refcnt_7_EXP_PT_2_IN3 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_EXP_PT_2_IN3,
      O => NlwInverterSignal_refcnt_7_EXP_PT_2_IN3
    );
  NlwInverterBlock_refcnt_7_EXP_PT_2_IN6 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_EXP_PT_2_IN6,
      O => NlwInverterSignal_refcnt_7_EXP_PT_2_IN6
    );
  NlwInverterBlock_refcnt_7_EXP_PT_2_IN7 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_EXP_PT_2_IN7,
      O => NlwInverterSignal_refcnt_7_EXP_PT_2_IN7
    );
  NlwInverterBlock_refcnt_7_EXP_PT_2_IN8 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_EXP_PT_2_IN8,
      O => NlwInverterSignal_refcnt_7_EXP_PT_2_IN8
    );
  NlwInverterBlock_refcnt_7_EXP_PT_3_IN2 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_EXP_PT_3_IN2,
      O => NlwInverterSignal_refcnt_7_EXP_PT_3_IN2
    );
  NlwInverterBlock_refcnt_7_EXP_PT_3_IN3 : X_INV
    port map (
      I => NlwBufferSignal_refcnt_7_EXP_PT_3_IN3,
      O => NlwInverterSignal_refcnt_7_EXP_PT_3_IN3
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
  NlwInverterBlock_EXP0_EXP_PT_0_IN1 : X_INV
    port map (
      I => NlwBufferSignal_EXP0_EXP_PT_0_IN1,
      O => NlwInverterSignal_EXP0_EXP_PT_0_IN1
    );
  NlwInverterBlock_EXP0_EXP_PT_1_IN0 : X_INV
    port map (
      I => NlwBufferSignal_EXP0_EXP_PT_1_IN0,
      O => NlwInverterSignal_EXP0_EXP_PT_1_IN0
    );
  NlwInverterBlock_EXP0_EXP_PT_1_IN3 : X_INV
    port map (
      I => NlwBufferSignal_EXP0_EXP_PT_1_IN3,
      O => NlwInverterSignal_EXP0_EXP_PT_1_IN3
    );
  NlwInverterBlock_EXP0_EXP_PT_1_IN4 : X_INV
    port map (
      I => NlwBufferSignal_EXP0_EXP_PT_1_IN4,
      O => NlwInverterSignal_EXP0_EXP_PT_1_IN4
    );
  NlwInverterBlock_EXP0_EXP_PT_1_IN5 : X_INV
    port map (
      I => NlwBufferSignal_EXP0_EXP_PT_1_IN5,
      O => NlwInverterSignal_EXP0_EXP_PT_1_IN5
    );
  NlwInverterBlock_EXP0_EXP_PT_1_IN6 : X_INV
    port map (
      I => NlwBufferSignal_EXP0_EXP_PT_1_IN6,
      O => NlwInverterSignal_EXP0_EXP_PT_1_IN6
    );
  NlwInverterBlock_EXP0_EXP_PT_1_IN7 : X_INV
    port map (
      I => NlwBufferSignal_EXP0_EXP_PT_1_IN7,
      O => NlwInverterSignal_EXP0_EXP_PT_1_IN7
    );
  NlwInverterBlock_EXP0_EXP_PT_1_IN8 : X_INV
    port map (
      I => NlwBufferSignal_EXP0_EXP_PT_1_IN8,
      O => NlwInverterSignal_EXP0_EXP_PT_1_IN8
    );
  NlwInverterBlock_EXP0_EXP_PT_1_IN9 : X_INV
    port map (
      I => NlwBufferSignal_EXP0_EXP_PT_1_IN9,
      O => NlwInverterSignal_EXP0_EXP_PT_1_IN9
    );
  NlwInverterBlock_EXP0_EXP_PT_1_IN10 : X_INV
    port map (
      I => NlwBufferSignal_EXP0_EXP_PT_1_IN10,
      O => NlwInverterSignal_EXP0_EXP_PT_1_IN10
    );
  NlwInverterBlock_EXP0_EXP_PT_1_IN11 : X_INV
    port map (
      I => NlwBufferSignal_EXP0_EXP_PT_1_IN11,
      O => NlwInverterSignal_EXP0_EXP_PT_1_IN11
    );
  NlwInverterBlock_EXP0_EXP_PT_1_IN12 : X_INV
    port map (
      I => NlwBufferSignal_EXP0_EXP_PT_1_IN12,
      O => NlwInverterSignal_EXP0_EXP_PT_1_IN12
    );
  NlwInverterBlock_EXP0_EXP_PT_1_IN13 : X_INV
    port map (
      I => NlwBufferSignal_EXP0_EXP_PT_1_IN13,
      O => NlwInverterSignal_EXP0_EXP_PT_1_IN13
    );
  NlwInverterBlock_EXP1_EXP_PT_0_IN1 : X_INV
    port map (
      I => NlwBufferSignal_EXP1_EXP_PT_0_IN1,
      O => NlwInverterSignal_EXP1_EXP_PT_0_IN1
    );
  NlwInverterBlock_EXP1_EXP_PT_0_IN2 : X_INV
    port map (
      I => NlwBufferSignal_EXP1_EXP_PT_0_IN2,
      O => NlwInverterSignal_EXP1_EXP_PT_0_IN2
    );
  NlwInverterBlock_EXP1_EXP_PT_1_IN0 : X_INV
    port map (
      I => NlwBufferSignal_EXP1_EXP_PT_1_IN0,
      O => NlwInverterSignal_EXP1_EXP_PT_1_IN0
    );
  NlwInverterBlock_EXP1_EXP_PT_1_IN3 : X_INV
    port map (
      I => NlwBufferSignal_EXP1_EXP_PT_1_IN3,
      O => NlwInverterSignal_EXP1_EXP_PT_1_IN3
    );
  NlwInverterBlock_EXP1_EXP_PT_1_IN4 : X_INV
    port map (
      I => NlwBufferSignal_EXP1_EXP_PT_1_IN4,
      O => NlwInverterSignal_EXP1_EXP_PT_1_IN4
    );
  NlwInverterBlock_EXP1_EXP_PT_1_IN5 : X_INV
    port map (
      I => NlwBufferSignal_EXP1_EXP_PT_1_IN5,
      O => NlwInverterSignal_EXP1_EXP_PT_1_IN5
    );
  NlwInverterBlock_EXP1_EXP_PT_1_IN6 : X_INV
    port map (
      I => NlwBufferSignal_EXP1_EXP_PT_1_IN6,
      O => NlwInverterSignal_EXP1_EXP_PT_1_IN6
    );
  NlwInverterBlock_EXP1_EXP_PT_1_IN7 : X_INV
    port map (
      I => NlwBufferSignal_EXP1_EXP_PT_1_IN7,
      O => NlwInverterSignal_EXP1_EXP_PT_1_IN7
    );
  NlwInverterBlock_EXP1_EXP_PT_1_IN8 : X_INV
    port map (
      I => NlwBufferSignal_EXP1_EXP_PT_1_IN8,
      O => NlwInverterSignal_EXP1_EXP_PT_1_IN8
    );
  NlwInverterBlock_EXP1_EXP_PT_1_IN9 : X_INV
    port map (
      I => NlwBufferSignal_EXP1_EXP_PT_1_IN9,
      O => NlwInverterSignal_EXP1_EXP_PT_1_IN9
    );
  NlwInverterBlock_EXP1_EXP_PT_1_IN10 : X_INV
    port map (
      I => NlwBufferSignal_EXP1_EXP_PT_1_IN10,
      O => NlwInverterSignal_EXP1_EXP_PT_1_IN10
    );
  NlwInverterBlock_EXP1_EXP_PT_1_IN11 : X_INV
    port map (
      I => NlwBufferSignal_EXP1_EXP_PT_1_IN11,
      O => NlwInverterSignal_EXP1_EXP_PT_1_IN11
    );
  NlwInverterBlock_EXP1_EXP_PT_1_IN12 : X_INV
    port map (
      I => NlwBufferSignal_EXP1_EXP_PT_1_IN12,
      O => NlwInverterSignal_EXP1_EXP_PT_1_IN12
    );
  NlwInverterBlock_EXP1_EXP_PT_1_IN13 : X_INV
    port map (
      I => NlwBufferSignal_EXP1_EXP_PT_1_IN13,
      O => NlwInverterSignal_EXP1_EXP_PT_1_IN13
    );
  NlwInverterBlock_EXP2_EXP_tsimrenamed_net_IN0 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN0,
      O => NlwInverterSignal_EXP2_EXP_tsimrenamed_net_IN0
    );
  NlwInverterBlock_EXP2_EXP_tsimrenamed_net_IN1 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN1,
      O => NlwInverterSignal_EXP2_EXP_tsimrenamed_net_IN1
    );
  NlwInverterBlock_EXP2_EXP_tsimrenamed_net_IN2 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN2,
      O => NlwInverterSignal_EXP2_EXP_tsimrenamed_net_IN2
    );
  NlwInverterBlock_EXP2_EXP_tsimrenamed_net_IN3 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN3,
      O => NlwInverterSignal_EXP2_EXP_tsimrenamed_net_IN3
    );
  NlwInverterBlock_EXP2_EXP_tsimrenamed_net_IN4 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN4,
      O => NlwInverterSignal_EXP2_EXP_tsimrenamed_net_IN4
    );
  NlwInverterBlock_EXP2_EXP_tsimrenamed_net_IN9 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN9,
      O => NlwInverterSignal_EXP2_EXP_tsimrenamed_net_IN9
    );
  NlwInverterBlock_EXP2_EXP_tsimrenamed_net_IN10 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN10,
      O => NlwInverterSignal_EXP2_EXP_tsimrenamed_net_IN10
    );
  NlwInverterBlock_EXP2_EXP_tsimrenamed_net_IN11 : X_INV
    port map (
      I => NlwBufferSignal_EXP2_EXP_tsimrenamed_net_IN11,
      O => NlwInverterSignal_EXP2_EXP_tsimrenamed_net_IN11
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
  NlwInverterBlock_EXP3_EXP_PT_0_IN2 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_0_IN2,
      O => NlwInverterSignal_EXP3_EXP_PT_0_IN2
    );
  NlwInverterBlock_EXP3_EXP_PT_0_IN3 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_0_IN3,
      O => NlwInverterSignal_EXP3_EXP_PT_0_IN3
    );
  NlwInverterBlock_EXP3_EXP_PT_0_IN6 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_0_IN6,
      O => NlwInverterSignal_EXP3_EXP_PT_0_IN6
    );
  NlwInverterBlock_EXP3_EXP_PT_0_IN7 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_0_IN7,
      O => NlwInverterSignal_EXP3_EXP_PT_0_IN7
    );
  NlwInverterBlock_EXP3_EXP_PT_0_IN8 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_0_IN8,
      O => NlwInverterSignal_EXP3_EXP_PT_0_IN8
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
  NlwInverterBlock_EXP3_EXP_PT_1_IN2 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_1_IN2,
      O => NlwInverterSignal_EXP3_EXP_PT_1_IN2
    );
  NlwInverterBlock_EXP3_EXP_PT_1_IN3 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_1_IN3,
      O => NlwInverterSignal_EXP3_EXP_PT_1_IN3
    );
  NlwInverterBlock_EXP3_EXP_PT_1_IN6 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_1_IN6,
      O => NlwInverterSignal_EXP3_EXP_PT_1_IN6
    );
  NlwInverterBlock_EXP3_EXP_PT_1_IN7 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_1_IN7,
      O => NlwInverterSignal_EXP3_EXP_PT_1_IN7
    );
  NlwInverterBlock_EXP3_EXP_PT_1_IN8 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_1_IN8,
      O => NlwInverterSignal_EXP3_EXP_PT_1_IN8
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
  NlwInverterBlock_EXP3_EXP_PT_2_IN2 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_2_IN2,
      O => NlwInverterSignal_EXP3_EXP_PT_2_IN2
    );
  NlwInverterBlock_EXP3_EXP_PT_2_IN3 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_2_IN3,
      O => NlwInverterSignal_EXP3_EXP_PT_2_IN3
    );
  NlwInverterBlock_EXP3_EXP_PT_2_IN6 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_2_IN6,
      O => NlwInverterSignal_EXP3_EXP_PT_2_IN6
    );
  NlwInverterBlock_EXP3_EXP_PT_2_IN7 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_2_IN7,
      O => NlwInverterSignal_EXP3_EXP_PT_2_IN7
    );
  NlwInverterBlock_EXP3_EXP_PT_2_IN8 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_2_IN8,
      O => NlwInverterSignal_EXP3_EXP_PT_2_IN8
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
  NlwInverterBlock_EXP3_EXP_PT_3_IN2 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_3_IN2,
      O => NlwInverterSignal_EXP3_EXP_PT_3_IN2
    );
  NlwInverterBlock_EXP3_EXP_PT_3_IN3 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_3_IN3,
      O => NlwInverterSignal_EXP3_EXP_PT_3_IN3
    );
  NlwInverterBlock_EXP3_EXP_PT_3_IN6 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_3_IN6,
      O => NlwInverterSignal_EXP3_EXP_PT_3_IN6
    );
  NlwInverterBlock_EXP3_EXP_PT_3_IN7 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_3_IN7,
      O => NlwInverterSignal_EXP3_EXP_PT_3_IN7
    );
  NlwInverterBlock_EXP3_EXP_PT_3_IN8 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_3_IN8,
      O => NlwInverterSignal_EXP3_EXP_PT_3_IN8
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
  NlwInverterBlock_EXP3_EXP_PT_4_IN2 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_4_IN2,
      O => NlwInverterSignal_EXP3_EXP_PT_4_IN2
    );
  NlwInverterBlock_EXP3_EXP_PT_4_IN3 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_4_IN3,
      O => NlwInverterSignal_EXP3_EXP_PT_4_IN3
    );
  NlwInverterBlock_EXP3_EXP_PT_4_IN6 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_4_IN6,
      O => NlwInverterSignal_EXP3_EXP_PT_4_IN6
    );
  NlwInverterBlock_EXP3_EXP_PT_4_IN7 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_4_IN7,
      O => NlwInverterSignal_EXP3_EXP_PT_4_IN7
    );
  NlwInverterBlock_EXP3_EXP_PT_4_IN8 : X_INV
    port map (
      I => NlwBufferSignal_EXP3_EXP_PT_4_IN8,
      O => NlwInverterSignal_EXP3_EXP_PT_4_IN8
    );
  NlwBlockROC : X_ROC
    generic map (ROC_WIDTH => 100 ns)
    port map (O => PRLD);

end Structure;

