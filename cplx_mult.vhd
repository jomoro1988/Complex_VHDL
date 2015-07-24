----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:36:47 07/22/2015 
-- Design Name: 
-- Module Name:    top - Behavioral 
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

entity top is
    Port ( ce, clk, rst : in std_logic;    		
    	   A : in  complex;
           B : in  complex;
           C : out  complex);
end top;

architecture Behavioral of top is
begin
	stage1 : process (clk, ce, rst)
		variable k1 : float (6 downto -9);
	begin
		if (rst = '1') then
			k1 := (others => '0');
			C.re <= (others => '0');
			C.im <= (others => '0');
		else 
			if (clk'event and clk = '1') then
				if (ce = '1') then
					k1 := A.re * (B.re + B.im);

					C.re <= k1 - (B.im * (A.re + A.im));
					C.im <= k1 + (B.re * (A.im - A.re));
				end if; 
			end if; 
		end if;
	end process stage1;

end Behavioral;

