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

	function find_leftmost(arg : std_ulogic_vector) return std_ulogic_vector;
	function to_sulv (arg : complex) return std_ulogic_vector;
	function to_complex (arg: std_ulogic_vector) return complex;

end complex_short;

package body complex_short is

function to_sulv (arg : complex) return is
	variable result : std_ulogic_vector;
begin 
	result := std_ulogic_vector(arg);
	return result;
end function to_sulv;

function to_complex (arg : complex) return is
	variable result : complex;
begin 
	result := complex(arg);
	return result;
end function to_complex;



end package body complex_short;