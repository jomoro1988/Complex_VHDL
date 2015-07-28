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
use IEEE.NUMERIC_STD.all;

library ieee_proposed;
use ieee_proposed.fixed_float_types.all;
use ieee_proposed.float_pkg.all;

package complex_short is

	constant real_start : natural := 31;
	constant imag_start : natural := 15;

	constant exp_width : natural  := 6;
	constant man_width : natural  := 9;

	constant expon_base: SIGNED   := 31;

  -- Signal description
	type UNRESOLVED_float is array (INTEGER range <>) of STD_ULOGIC;  -- main type

	subtype U_complex is UNRESOLVED_complex;
	subtype complex is UNRESOLVED_complex;

	procedure break_number (              -- internal version
    arg     : in  UNRESOLVED_complex;
    r_fract : out UNSIGNED;
    r_expon : out SIGNED;
    r_sign  : out STD_ULOGIC;
    i_fract : out UNSIGNED;
    i_expon : out SIGNED;
    i_sign  : out STD_ULOGIC);

	function find_leftmost (ARG : UNSIGNED; Y : STD_ULOGIC) return INTEGER;

	function to_complex (arg: std_ulogic_vector(31 downto 0)) return UNRESOLVED_complex;

	function to_sulv (arg : UNRESOLVED_complex) return STD_ULOGIC_VECTOR;
	alias to_StdULogicVector is to_sulv [UNRESOLVED_complex return STD_ULOGIC_VECTOR];
	alias to_Std_ULogic_Vector is to_sulv [UNRESOLVED_complex return STD_ULOGIC_VECTOR];

	function add(l, r : UNRESOLVED_complex) return UNRESOLVED_complex;

end complex_short;

package body complex_short is

function to_sulv (
    arg : UNRESOLVED_float)             -- fp vector
    return STD_ULOGIC_VECTOR is
    variable result : STD_ULOGIC_VECTOR (arg'length-1 downto 0);
begin  -- function to_std_ulogic_vector
    result := STD_ULOGIC_VECTOR (arg);
    return result;
end function to_sulv;

function to_complex (arg : std_ulogic_vector(31 downto 0)) return UNRESOLVED_complex is
	variable result : UNRESOLVED_complex;
begin 
	result := UNRESOLVED_complex(arg);
	return result;
end function to_complex;

function find_leftmost (ARG : UNSIGNED; Y : STD_ULOGIC)
    return INTEGER is
  begin
    for INDEX in ARG'range loop
      if ARG(INDEX) = Y then
        return INDEX;
      end if;
    end loop;
    return -1;
  end function find_leftmost;

  procedure break_number (              -- internal version
    arg     : in  UNRESOLVED_complex;
    r_fract : out UNSIGNED;
    r_expon : out SIGNED;
    r_sign  : out STD_ULOGIC;
    i_fract : out UNSIGNED;
    i_expon : out SIGNED;
    i_sign  : out STD_ULOGIC) is
  begin
  	r_sign := arg(real_start);
  	i_sign := arg(imag_start);
  	r_expon := arg(real_start-1 downto real_start-exp_width);
  	i_expon := arg(imag_start-1 downto imag_start-exp_width);
  	r_fract := arg(imag_start + man_width downto imag_start +1);
  	i_fract := arg(man_width-1 downto 0);
  end procedure break_number;

  function add (l, r : UNRESOLVED_complex) 
  	return UNRESOLVED_complex is
  begin
  	
  end function add;



end package body complex_short;