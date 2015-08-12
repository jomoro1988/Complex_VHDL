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
	signal temp, Ap : complex; 
	signal denom : float (6 downto -9);
begin
	stage1 : process (ce, clk, rst)
	begin
		if (rst = '1') then
			denom <= (others => '0');
			Ap.re <= (others => '0');
			Ap.im <= (others => '0');
		else
			if (clk'event and clk = '1') then
				if (ce = '1') then
					denom <= (A.re * A.re) + (B.re * B.re);
					Ap.re <= A.re;
					Ap.im <= -A.im;
				end if; 
			end if; 
		end if;
	end process stage1;

stage2 : process (ce, clk, rst)
		variable k1 : float(6 downto -9);
	begin
		if (rst = '1') then
			k1 := (others => '0');
			temp.re <= (others => '0');
			temp.im <= (others => '0');
		else
			if (clk'event and clk = '1') then
				if (ce = '1') then
					k1 := A.re * (Ap.re + Ap.im);

					temp.re <= k1 - (Ap.im * (A.re + A.im));
					temp.im <= k1 + (Ap.re * (A.im - A.re));					 
				end if; 
			end if; 
		end if;
	end process stage2;

	stage3 : process (ce, clk, rst)
	begin
		if (rst = '1') then
			C.re <= (others => '0');
			C.im <= (others => '0');
		else
			if (clk'event and clk = '1') then
				if (ce = '1') then
					c.re <= temp.re / denom;
					C.im <= temp.im / denom;									 
				end if; 
			end if; 
		end if;
	end process stage3;
end Behavioral;

