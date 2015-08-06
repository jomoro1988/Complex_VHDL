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

function find_leftmost (ARG : std_ulogic_vector; Y : STD_ULOGIC)
    return INTEGER is
  begin
    for INDEX in ARG'range-1 loop
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

  function build_number (real_sfrac, imag_sfrac : signed, real_exp, imag_exp : UNSIGNED) 
    return UNRESOLVED_complex is
    variable result : UNRESOLVED_complex;
  begin
    result(real_start) := real_sfrac'left;
    result(imag_start) := imag_sfrac'left;
    result(real_start-1 downto real_start-exp_width) := real_exp;
    result(imag_start-1 downto imag_start-exp_width) :=imag_exp;
    result(imag_start + man_width downto imag_start +1) := real_sfrac(real_sfrac'left-1 downto 0);
    result(man_width-1 downto 0) := imag_sfrac(imag_sfrac'left-1 downto 0);
    return result;
  end function build_number;

  	function add (l, r : UNRESOLVED_complex) 
  		return UNRESOLVED_complex is
  		variable guard_bit : integer := 3;
  		variable lr_exp, li_exp, rr_exp, ri_exp, shift_i, shift_r, resr_exp, resi_exp, resrt_exp, resit_exp : unsigned;
  		variable pos_i, pos_r, expr_corr, expi_corr : UNSIGNED;
  		variable lr_man, li_man, rr_man, ri_man : std_ulogic_vector (man_width-1 downto 0);
  		variable resrs_man, resis_man, resrc_man, resic_man, resr_man, resi_man : signed;
  		variable lr_sign, li_sign, rr_sign, ri_sign, resr_sign, resi_sign : STD_ULOGIC;
      variable result : UNRESOLVED_complex;
  	begin
  		break_number(
  			arg => l,
  			r_fract => lr_man,
  			i_fract => li_man,
  			r_expon => lr_exp,
  			i_expon => li_exp,
  			r_sign  => lr_sign,
  			i_sign  => li_sign);

  		break_number(
  			arg => r,
  			r_fract => rr_man,
  			i_fract => ri_man,
  			r_expon => rr_exp,
  			i_expon => ri_exp,
  			r_sign  => rr_sign,
  			i_sign  => ri_sign);

  		shift_r := lr_exp - rr_exp;
  		shift_i := li_exp - ri_exp;

  		if shift_r < 0 then
  			resrs_man := to_signed(lr_sign & shift_right (lr_man, to_integer(-shift_r)));
  			resrc_man := to_signed(rr_sign & rr_man);
  			resrt_exp := rr_exp;
  		elsif shift_r > 0 then
  			resrs_man := to_signed(rr_sign & shift_right (rr_man, to_integer(shift_r)));
  			resrc_man := to_signed(lr_sign & lr_man);
  			resrt_exp := lr_exp;
  		else
  			resrs_man := to_signed(lr_sign & lr_man);
  			resrc_man := to_signed(rr_sign & rr_man);
  			resrt_exp := rr_exp;
		end if;

		if shift_i < 0 then
  			resis_man := to_signed(li_sign & shift_right (li_man, to_integer(-shift_i)));
  			resic_man := to_signed(ri_sign & ri_man);
  			resit_exp := ri_exp;
  		elsif shift_i > 0 then
  			resis_man := to_signed(ri_sign & shift_right (ri_man, to_integer(shift_i)));
  			resic_man := to_signed(li_sign & li_man);
  			resit_exp := li_exp;
  		elsif
  			resis_man := to_signed(li_sign & li_man);
  			resic_man := to_signed(ri_sign & ri_man);
  			resit_exp := li_exp;
		end if;

		resr_man := resrs_man + resrc_man;
		resi_man := resis_man + resic_man;

		pos_r := find_leftmost(resr_man, '1');
		pos_i := find_leftmost(resi_man, '1');

		expr_corr := pos_r - man_width-1;
    expi_corr := pos_i - man_width-1;

    resr_exp := resrt_exp + expr_corr;
    resi_exp := resit_exp + expi_corr;

    result := build_number(resr_man, resi_man, resr_exp, resi_exp);

    return result;

  	end function add;



end package body complex_short;