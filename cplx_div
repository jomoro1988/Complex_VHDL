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

entity cplx_div is
    Port ( A : in  complex;
           B : in  complex;
           C : out  complex;
           ce : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC);
end cplx_div;

architecture Behavioral of cplx_div is
	signal temp : complex; 
	signal denom : float (6 downto -9);
begin
	stage1 : process (ce, clk, rst)
	begin
		if (rst = '1') then
			C.re <= (others => '0');
			C.im <= (others => '0');
			temp <= (others => '0');
			denom <= (others => '0');
		else
			if (clk'event and clk = '1') then
				if (ce = '1') then
					temp <= 
				end if; 
			end if; 
		end if;
	end process stage1;


end Behavioral;

