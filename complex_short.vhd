--
--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 
--
--   To use any of the example code shown below, uncomment the lines and modify as necessary
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;

library ieee_proposed;
use ieee_proposed.float_pkg.all;

package complex_short is

  -- Signal description
	type UNRESOLVED_complex is record   -- main type
		Re : float(6 downto -9);
		Im : float(6 downto -9);
	end record;

	subtype U_complex is UNRESOLVED_complex;
	subtype complex is UNRESOLVED_complex;

end complex_short;

