----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:05:42 07/24/2015 
-- Design Name: 
-- Module Name:    cplx_add - Behavioral 
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

library ieee_proposed;
use ieee_proposed.float_pkg.all;

use work.complex_short.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cplx_add is
    Port ( A : in std_logic_vector (31 downto 0);
           B : in std_logic_vector (31 downto 0);
           C : out std_logic_vector (31 downto 0);
           ce : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC);
end cplx_add;

architecture Behavioral of cplx_add is
	variable atemp : complex := to_complex(A);
	variable btemp : complex := to_complex(B);
	variable ctemp : complex;
begin
	stage1 : process (ce, clk, rst)
	begin
		if (rst = '1') then
			ctemp.re <= (others => '0');
			ctemp.im <= (others => '0');
		else
			if (clk'event and clk = '1') then
				if (ce = '1') then
					ctemp.re <= atemp.re + btemp.re;
					ctemp.im <= atemp.im + btemp.im;
				end if; 
			end if; 
		end if;
		C <= to_sulv(ctemp);
	end process stage1;


end Behavioral;

