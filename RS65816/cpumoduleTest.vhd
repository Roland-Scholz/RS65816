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
				a15_13	: in  STD_LOGIC_VECTOR (2 downto 0);
				bank     : in  STD_LOGIC_VECTOR (7 downto 0);
				vda		: in std_logic;
				vpa		: in std_logic;
				ras		: out std_logic;
				cas		: out std_logic;		
				io			: inout std_logic;		
				rom		: inout std_logic;		
				phi0		: out std_logic
			);
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
	signal bank : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
	signal a15_13 : STD_LOGIC_VECTOR (2 downto 0) := "111";
	signal vda : std_logic := '0';
	signal vpa : std_logic := '1';

 	--Outputs
   signal phi0 : std_logic;
   signal ras : std_logic;
   signal cas : std_logic;
	signal io : std_logic;
	signal rom : std_logic;
	
   -- Clock period definitions
   constant clk_period : time := 15.625 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: cpumodule PORT MAP (
          clk => clk,
			 ras => ras,
			 cas => cas,
			 bank => bank,
			 a15_13 => a15_13,
			 vpa => vpa,
			 vda => vda,
			 io => io,
			 rom => rom,
          phi0 => phi0
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
      wait for 100 ns;	
		
		-- insert stimulus here 
		bank <= "00000000";
      wait for clk_period*4*7;
		
		vda <= '1';
		vpa <= '0';
		
		bank <= "11111111";
		wait for clk_period*4*7;

		bank <= "00000001";
		--wait for clk_period*4*7;
      
      wait;
   end process;

END;
