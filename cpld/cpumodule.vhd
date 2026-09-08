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
Port	(	clk		: in std_logic;
			bank     : in std_logic_vector (7 downto 0);
			a15_13	: in std_logic_vector (2 downto 0);
			a12_11	: in std_logic_vector (1 downto 0);
			a10		: in std_logic;
			vda		: in std_logic;
			vpa		: in std_logic;
			rw			: in std_logic;
			ras		: out std_logic := '1';
         cas0		: out std_logic := '1';
         cas1		: out std_logic := '1';
         cas2		: out std_logic := '1';
         cas3		: out std_logic := '1';
--			icnt0		: out std_logic;
--			icnt1		: out std_logic;
--			icnt2		: out std_logic;
         io0		: out std_logic := '1';
         io1		: out std_logic := '1';
         io2		: out std_logic := '1';
         io3		: out std_logic := '1';
         io4		: out std_logic := '1';
         io5		: out std_logic := '1';
         io6		: out std_logic := '1';
         io7		: out std_logic := '1';
			rom		: inout std_logic := '1';
			phi0		: out std_logic := '1';
			phi1		: out std_logic := '0'
			);
end cpumodule;

--
-- ras/cas = 11 lines
-- ras = bank & a15-a13
-- cas = a10-a0
--
-- ram 00:0000 - ff:ffff		(16mb)
-- rom 00:e000 - 00:ffff		( 8kb)
-- io  ff:c000 - ff:ffff		( 1kb x 8)
--

architecture Behavioral of cpumodule is
	constant REFTICKS : STD_LOGIC_VECTOR (7 downto 0) := "10001101";		--141 (9,142 Mhz / 0,064Mhz = 142,85)

	signal counter	: STD_LOGIC_VECTOR (2 downto 0) := "000";
	signal refcnt : STD_LOGIC_VECTOR (7 downto 0) := "00000100";
	signal iocnt : STD_LOGIC_VECTOR (2 downto 0) := "000";
	signal phi : std_logic;
	--signal cas : std_logic;
	
	--signal vpa : std_logic := '1';
	--signal vda : std_logic := '1';
	
	-- (vpa = '1' or vda = '1') and
	-- vda = '1' and vpa = '0' and 
	-- 
begin
	process (clk)
	begin
		if falling_edge(clk) then
			
			counter <= counter + 1;
			
			case counter is
			when "000" =>
				if refcnt = 0 then
					cas0 <= '0';
				else
					cas0 <= '1';
				end if;
				
			when "001" =>			
				if bank = "00000000" and a15_13 = "111" and rw = '1' and (vda = '1' or vpa = '1') then
					rom <= '0';
				elsif bank = "11111111" and a15_13 = "111" and iocnt = 0 and vda = '1' and vpa = '0' then
					iocnt <= "001";
				end if;
				
				if (not ((bank = "00000000" and a15_13 = "111" and rw = '1') or (bank = "11111111" and a15_13 = "111" ))) or refcnt = 0 then	
					if refcnt = 0 or vda = '1' or vpa = '1' then
						ras <= '0';
					end if;
				end if;
				
			when "010" =>
				phi0 <= '1';
				phi1 <= '0';
				
				cas0 <= '1';
				
			when "100" =>
				if refcnt /= 0 and rom = '1' and iocnt = 0 and (vda = '1' or vpa = '1') then
					case a12_11 is 
					when "00" => cas0 <= '0';
					when "01" => cas1 <= '0';
					when "10" => cas2 <= '0';
					when "11" => cas3 <= '0';
					when others =>
					end case;
				end if;
				
			when "101" =>
				ras <= '1';
				
			when "110" =>
				cas0 <= '1';
				cas1 <= '1';
				cas2 <= '1';
				cas3 <= '1';
				
				counter <= "000";
				
				if iocnt = 0 or iocnt = 5 or (rom = '1' and refcnt /= 0 and iocnt = 0) then
					phi0 <= '0';
					phi1 <= '1';
				end if;
				
				if refcnt = 0 then
					refcnt <= REFTICKS;
					
					if rom = '1' and iocnt = 0 then
						phi0 <= '1';
						phi1 <= '0';
					end if;				
				else 
					refcnt <= refcnt - 1;
				end if;
				
				if iocnt /= 0 then
				
					iocnt <= iocnt + 1;
				
					if iocnt = 1 then
						case a12_11 & a10 is
						when "000" => io0 <= '0';
						when "001" => io1 <= '0';
						when "010" => io2 <= '0';
						when "011" => io3 <= '0';
						when "100" => io4 <= '0';
						when "101" => io5 <= '0';
						when "110" => io6 <= '0';
						when "111" => io7 <= '0';
						when others =>
						end case;
					end if;
					
					if iocnt = 5 then
						io0 <= '1';
						io1 <= '1';
						io2 <= '1';
						io3 <= '1';
						io4 <= '1';
						io5 <= '1';
						io6 <= '1';
						io7 <= '1';
						iocnt <= "000";
					end if;
				end if;
					
				rom <= '1';	
				
			when others =>
			
			end case;
		end if;
			
	end process;
	
--	icnt0 <= iocnt(0);
--	icnt1 <= iocnt(1);
--	icnt2 <= iocnt(2);
	
end Behavioral;

