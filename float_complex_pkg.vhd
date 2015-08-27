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

package complex_short is

	constant real_start : natural := 31;
	constant imag_start : natural := 15;

	constant exp_width : natural  := 6;
	constant man_width : natural  := 9;

	constant expon_base: natural   := 31;

  -- Signal description
	type UNRESOLVED_complex is array (31 downto 0) of STD_ULOGIC;  -- main type

	subtype U_complex is UNRESOLVED_complex;
	subtype complex is UNRESOLVED_complex;

	procedure break_number (              -- internal version
    input_value     : in  UNRESOLVED_complex;
    r_fract : out UNSIGNED;
    r_expon : out UNSIGNED;
    r_sign  : out STD_ULOGIC;
    i_fract : out UNSIGNED;
    i_expon : out UNSIGNED;
    i_sign  : out STD_ULOGIC);

  function build_number (r_sign, i_sign : std_ulogic; real_sfrac, imag_sfrac, real_exp, imag_exp : UNSIGNED) return UNRESOLVED_complex;
  function fract_signed_shift (f_sign : std_ulogic; value : unsigned; shift : integer) return signed ;
  function fract_signed (f_sign : std_ulogic; value : unsigned) return signed;

	function find_leftmost (input_value : signed; Y : STD_ULOGIC) return integer;

	function to_complex (arg: std_ulogic_vector(31 downto 0)) return UNRESOLVED_complex;

  function negate(arg : UNRESOLVED_complex) return UNRESOLVED_complex;

	--function to_sulv (arg : UNRESOLVED_complex) return STD_ULOGIC_VECTOR;
	--alias to_StdULogicVector is to_sulv [UNRESOLVED_complex return STD_ULOGIC_VECTOR];
	--alias to_Std_ULogic_Vector is to_sulv [UNRESOLVED_complex return STD_ULOGIC_VECTOR];

	function add(l, r : UNRESOLVED_complex) return UNRESOLVED_complex;
  function "+" (l, r : UNRESOLVED_complex) return UNRESOLVED_complex;

  function sub(l, r : UNRESOLVED_complex) return UNRESOLVED_complex;
  function "-" (l, r : UNRESOLVED_complex) return UNRESOLVED_complex;

end complex_short;

package body complex_short is

--function to_sulv (arg : UNRESOLVED_float) return STD_ULOGIC_VECTOR is
--    variable result : STD_ULOGIC_VECTOR (arg'length-1 downto 0);
--begin  -- function to_std_ulogic_vector
--    result := STD_ULOGIC_VECTOR(arg);
--    return result;
--end function to_sulv;

function to_complex (arg : std_ulogic_vector(31 downto 0)) return UNRESOLVED_complex is
	variable result : UNRESOLVED_complex;
begin 
	  result(real_start) := arg(real_start);
    result(imag_start) := arg(imag_start);
    result(real_start-1 downto real_start-exp_width) := UNRESOLVED_complex(arg(real_start-1 downto real_start-exp_width));
    result(imag_start-1 downto imag_start-exp_width) := UNRESOLVED_complex(arg(imag_start-1 downto imag_start-exp_width));
    result(imag_start + man_width downto imag_start +1) := UNRESOLVED_complex(arg(imag_start + man_width downto imag_start +1));
    result(man_width-1 downto 0) := UNRESOLVED_complex(arg(man_width-1 downto 0));
	return result;
end function to_complex;

function fract_signed (f_sign : std_ulogic; value : unsigned) return signed is
  variable result : signed (value'range);
begin
  if f_sign = '1' then
    result := -signed(value);
  else 
    result := signed(value);
  end if;
  return result;
end function;

function fract_signed_shift (f_sign : std_ulogic; value : unsigned; shift : integer) return signed is
  variable result : signed (value'range);
  variable temp : unsigned (value'left downto -3);
begin
  temp := shift_right(value, shift);
  if temp(-1) = '1' then
    temp(0) := '1';
  end if;

  if f_sign = '1' then
    result := -signed(temp(value'left downto 0));
  else 
    result := signed(temp(value'left downto 0));
  end if;
  return  result;
end function;

function find_leftmost (input_value : signed; Y : STD_ULOGIC)
    return integer is
  begin
    for INDEX in input_value'range loop
      if input_value(INDEX) = Y then
        return INDEX;
      end if;
    end loop;
    return -1;
  end function find_leftmost;

  procedure break_number (              -- internal version
    input_value    : in  UNRESOLVED_complex;
    r_fract : out UNSIGNED ;
    r_expon : out UNSIGNED ;
    r_sign  : out STD_ULOGIC;
    i_fract : out UNSIGNED ;
    i_expon : out UNSIGNED;
    i_sign  : out STD_ULOGIC) is
  begin
    r_sign := input_value(31);
    r_expon := unsigned(input_value(30 downto 25));
    r_fract := "001" & unsigned(input_value(24 downto 16));
    i_sign := input_value(15);
    i_expon := unsigned(input_value(14 downto 9));
    i_fract := "001" & unsigned(input_value(8 downto 0));
  end procedure break_number;

  function build_number (r_sign, i_sign : std_ulogic; real_sfrac, imag_sfrac, real_exp, imag_exp : UNSIGNED) 
    return UNRESOLVED_complex is
    variable result : UNRESOLVED_complex;
  begin
    result := complex(r_sign & std_logic_vector(real_exp) & std_logic_vector(real_sfrac) & i_sign & std_logic_vector(imag_exp) & std_logic_vector(imag_sfrac));
    return result;
  end function build_number;

  	function add (l, r : UNRESOLVED_complex) 
  		return UNRESOLVED_complex is
      variable shift_i, shift_r, pos_i, pos_r, correction : integer;
  		variable lr_exp, li_exp, rr_exp, ri_exp : unsigned (5 downto 0);
      variable resr_exp, resi_exp, resrt_exp, resit_exp : unsigned (5 downto 0);
  		variable resr_man, resi_man : unsigned (8 downto 0);
      variable lr_man, li_man, rr_man, ri_man, man_temp : unsigned (11 downto 0);
      variable resrs_man, resis_man, resrc_man, resic_man, resrt_man, resit_man : signed (11 downto 0);
  		variable lr_sign, li_sign, rr_sign, ri_sign, resr_sign, resi_sign : STD_ULOGIC;
      variable result : UNRESOLVED_complex;
  	begin
  		break_number(
  			input_value => l,
  			r_fract => lr_man,   -- 9 downto 0
  			i_fract => li_man,   -- 1 & mantissa
  			r_expon => lr_exp,
  			i_expon => li_exp,
  			r_sign  => lr_sign,
  			i_sign  => li_sign);

  		break_number(
  			input_value => r,
  			r_fract => rr_man,  
  			i_fract => ri_man,
  			r_expon => rr_exp,
  			i_expon => ri_exp,
  			r_sign  => rr_sign,
  			i_sign  => ri_sign);

  		shift_r := to_integer(lr_exp) - to_integer(rr_exp);
  		shift_i := to_integer(li_exp) - to_integer(ri_exp);

   		if shift_r < 0 then
  			resrs_man := fract_signed_shift(lr_sign, lr_man, -shift_r); -- 9+1 downto 0
  			resrc_man := fract_signed(rr_sign, rr_man);
  			resrt_exp := rr_exp;
  		elsif shift_r > 0 then
  			resrs_man := fract_signed_shift(rr_sign,rr_man, shift_r);
  			resrc_man := fract_signed(lr_sign, lr_man);
  			resrt_exp := lr_exp;
  		else
  			resrs_man := fract_signed(lr_sign, lr_man);
  			resrc_man := fract_signed(rr_sign, rr_man);
  			resrt_exp := rr_exp;
		end if;

		if shift_i < 0 then
  			resis_man := fract_signed_shift(li_sign, li_man, -shift_i);
  			resic_man := fract_signed(ri_sign, ri_man);
  			resit_exp := ri_exp;
  		elsif shift_i > 0 then
  			resis_man := fract_signed_shift(ri_sign, ri_man, shift_i);
  			resic_man := fract_signed(li_sign, li_man);
  			resit_exp := li_exp;
  		else
  			resis_man := fract_signed(li_sign, li_man);
  			resic_man := fract_signed(ri_sign, ri_man);                -- 9+1 downto 0
  			resit_exp := li_exp;
		end if;

		resrt_man := resrs_man + resrc_man; -- 9+1+1 downto 0
		resit_man := resis_man + resic_man;

    if resrt_man(resrt_man'left) = '1' then
      resr_sign := resrt_man(resrt_man'left);
      resrt_man := -resrt_man;
    else      
      resr_sign := resrt_man(resrt_man'left);
    end if;

    if resit_man(resit_man'left) = '1' then
      resi_sign := resit_man(resit_man'left);
      resit_man := -resit_man;
    else 
       resi_sign := resit_man(resit_man'left);
    end if;

		pos_r := find_leftmost(resrt_man, '1');
		pos_i := find_leftmost(resit_man, '1');

    if pos_r > man_width then
      correction := pos_r - man_width;
      man_temp := shift_right(unsigned(resrt_man), correction);
      resr_exp := resrt_exp + to_unsigned(correction,4);
    elsif pos_r < man_width then
      correction := man_width - pos_r;
      man_temp := shift_left(unsigned(resrt_man), correction);      
      resr_exp := resrt_exp - to_unsigned(correction,4);
    else
      man_temp := unsigned(resrt_man);
      resr_exp := resrt_exp;
    end if;

    resr_man := man_temp(8 downto 0);

    if pos_i > man_width then
      correction := pos_i - man_width;
      man_temp := shift_right(unsigned(resit_man), correction);
      resi_exp := resit_exp + to_unsigned(correction,4);
    elsif pos_i < man_width then
      correction := man_width - pos_i;
      man_temp := shift_left(unsigned(resit_man), correction);      
      resi_exp := resit_exp - to_unsigned(correction,4);
    else
      man_temp := unsigned(resit_man);
      resi_exp := resit_exp;
    end if;

    resi_man := man_temp(8 downto 0);

    result := build_number(resr_sign, resi_sign, resr_man, resi_man, resr_exp, resi_exp);

    return result;

  	end function add;

    function negate (arg : UNRESOLVED_complex)
      return UNRESOLVED_complex is
      variable result : UNRESOLVED_complex;
      variable r_man, i_man : unsigned(11 downto 0);
      variable r_exp, i_exp : unsigned (5 downto 0);
      variable r_sig, i_sig, r_sig_o, i_sig_o : std_ulogic;
    begin
      break_number(
        input_value => arg,
        r_fract => r_man,  
        i_fract => i_man,
        r_expon => r_exp,
        i_expon => i_exp,
        r_sign  => r_sig,
        i_sign  => i_sig);

        r_sig_o := not r_sig;
        i_sig_o := not i_sig;

        result := build_number(r_sig_o, i_sig_o, r_man(8 downto 0), i_man(8 downto 0), r_exp, i_exp);
        return result;

    end function negate;

    function sub(l,r : UNRESOLVED_complex)
      return UNRESOLVED_complex is
      variable result, temp : UNRESOLVED_complex;
    begin 
      temp := negate(r);
      result := add(l,temp);
      return result;
    end function sub;

    function "-" (l, r : UNRESOLVED_complex) 
      return UNRESOLVED_complex is
      variable result : UNRESOLVED_complex;
    begin
      result := sub(l,r);
      return result;
    end function "-";

    function "+" (l, r : UNRESOLVED_complex) 
      return UNRESOLVED_complex is
      variable result : UNRESOLVED_complex;
    begin
      result := add(l,r);
      return result;
    end function "+";


end package body complex_short;