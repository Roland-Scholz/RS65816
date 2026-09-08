--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:12:16 08/31/2026
-- Design Name:   
-- Module Name:   C:/github/RS65816/RS65816/cpumoduleTest.vhd
-- Project Name:  RS65816
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: cpumodule
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY cpumoduleTest IS
END cpumoduleTest;
 
ARCHITECTURE behavior OF cpumoduleTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT cpumodule
    Port	(	clk		: in  std_logic;
				bank     : in STD_LOGIC_VECTOR (7 downto 0);
				a15_13	: in  STD_LOGIC_VECTOR (2 downto 0);
				a12_11	: in  STD_LOGIC_VECTOR (1 downto 0);
				a10		: in  std_logic;
				vda		: in std_logic;
				vpa		: in std_logic;
				rw			: in std_logic;
				ras		: out std_logic;
				cas0		: out std_logic;
				cas1		: out std_logic;
				cas2		: out std_logic;
				cas3		: out std_logic;
--				icnt0		: out std_logic;
--				icnt1		: out std_logic;
--				icnt2		: out std_logic;
				io0		: out std_logic;
				io1		: out std_logic;
				io2		: out std_logic;
				io3		: out std_logic;
				io4		: out std_logic;
				io5		: out std_logic;
				io6		: out std_logic;
				io7		: out std_logic;
				rom		: inout std_logic;
				phi0		: out std_logic;
				phi1		: out std_logic
			);
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
	signal bank : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
	signal a15_13 : STD_LOGIC_VECTOR (2 downto 0) := "111";
	signal a12_11 : STD_LOGIC_VECTOR (1 downto 0) := "00";
	signal a10 : std_logic := '1';
	signal vda : std_logic := '1';
	signal vpa : std_logic := '0';
	signal rw : std_logic := '1';

 	--Outputs
   signal phi0 : std_logic;
   signal phi1 : std_logic;
   signal ras : std_logic;
   signal cas0 : std_logic;
   signal cas1 : std_logic;
   signal cas2 : std_logic;
   signal cas3 : std_logic;
	signal io0 : std_logic;
	signal io1 : std_logic;
	signal io2 : std_logic;
	signal io3 : std_logic;
	signal io4 : std_logic;
	signal io5 : std_logic;
	signal io6 : std_logic;
	signal io7 : std_logic;
	signal rom : std_logic;
--	signal icnt0 : std_logic;
--	signal icnt1 : std_logic;
--	signal icnt2 : std_logic;
			
   -- Clock period definitions
   constant clk_period : time := 15.625 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: cpumodule PORT MAP (
          clk => clk,
			 ras => ras,
			 cas0 => cas0,
			 cas1 => cas1,
			 cas2 => cas2,
			 cas3 => cas3,
			 bank => bank,
--			 icnt0 => icnt0,	
--			 icnt1 => icnt1,	
--			 icnt2 => icnt2,	
			 a15_13 => a15_13,
			 a12_11 => a12_11,
			 a10 => a10,
			 vpa => vpa,
			 vda => vda,
			 rw => rw,
			 io0 => io0,
			 io1 => io1,
			 io2 => io2,
			 io3 => io3,
			 io4 => io4,
			 io5 => io5,
			 io6 => io6,
			 io7 => io7,
			 rom => rom,
          phi0 => phi0,
			 phi1 => phi1
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      --wait for 100 ns;	
		
		-- insert stimulus here 
		--bank <= "11111111";
      --wait for clk_period*5*7;

		--a12_11 <= "01";
				
		--bank <= "11111111";
		--wait for clk_period*4*7;

		bank <= "00000000";
		wait for clk_period*6*7;
		
      bank <= "00000001";
		wait for clk_period*4*7;
		
		bank <= "11111111";
      wait for clk_period*4*7;
      wait;
   end process;

END;
