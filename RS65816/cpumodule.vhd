----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:49:20 08/31/2026 
-- Design Name: 
-- Module Name:    cpumodule - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cpumodule is
Port	(	clk		: in  std_logic;
			bank     : in STD_LOGIC_VECTOR (7 downto 0);
			a15_13	: in  STD_LOGIC_VECTOR (2 downto 0);
			vda		: in std_logic;
			vpa		: in std_logic;
			ras		: out std_logic;
         cas		: out std_logic;		
         io			: inout std_logic;
			rom		: inout std_logic;
			phi0		: out std_logic
			);
end cpumodule;

architecture Behavioral of cpumodule is
	constant REFTICKS : STD_LOGIC_VECTOR (7 downto 0) := "10001101";		--141 (9,142 Mhz / 0,064Mhz = 142,85)

	signal counter	: STD_LOGIC_VECTOR (2 downto 0) := "000";
	signal refcnt : STD_LOGIC_VECTOR (7 downto 0) := "00000011";
	signal iocnt : STD_LOGIC_VECTOR (2 downto 0) := "000";
begin
	process (clk)
	begin
		if falling_edge(clk) then
			
			counter <= counter + 1;
			
			case counter is
			when "001" =>			
				if bank = "00000000" and a15_13 = "111" and (vpa = '1' or vda = '1') then
					rom <= '0';
				end if;
				if bank = "11111111" and a15_13 = "111" and vda = '1' and vpa = '0' then
					if iocnt = 0 then
						io <= '0';
						iocnt <= "001";
					end if;
				end if;
			
			when "110" =>
				counter <= "000";
				if refcnt = 0 then
					refcnt <= REFTICKS;
				else 
					refcnt <= refcnt - 1;
				end if;
				
				if iocnt /= 0 then
					iocnt <= iocnt + 1;
					if iocnt = 7 then
						io <= '1';
					end if;
				end if;
					
				rom <= '1';	
				
			when others =>
			
			end case;
		end if;
			
	end process;
		
	phi0 <=	'0' when counter >= 0 and counter <= 2 and refcnt /= REFTICKS and iocnt <= 1 else
				'1';
	
	ras <=	'0' when counter >= 2 and counter <= 5 and (((vpa = '1' or vda = '1') and io = '1' and rom = '1') or refcnt =  0) else
				'1';
	
	cas <=	'0' when (refcnt /= 0 and counter >= 5 and counter <= 6 and io = '1' and rom = '1' and (vpa = '1' or vda = '1'))
					   or (refcnt =  0 and counter >= 1 and counter <= 2) else
				'1';
	
end Behavioral;

