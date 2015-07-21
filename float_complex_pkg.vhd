-- --------------------------------------------------------------------
-- "float_complex_pkg" package contains functions for complex floating point math.
--
-- --------------------------------------------------------------------
-- Prototypes of float_complex_pkg functions
-- Version    : $Revision: 0.1 $
-- Date       : $Date: 2015-07-20 $
-- --------------------------------------------------------------------

use STD.TEXTIO.all;
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;

package float_complex_pkg is

  -- Signal description
	constant cplx_sign_width     : NATURAL    := 1;
	constant cplx_exponent_width : NATURAL    := 6;
	constant cplx_fraction_width : NATURAL    := 9;

	constant cplx_imag_width     : NATURAL    := 16;
	constant cplx_real_width     : NATURAL    := 16;

	type UNRESOLVED_complex is array (0 to 31) of STD_ULOGIC;  -- main type
	subtype U_complex is UNRESOLVED_complex;

	subtype complex is UNRESOLVED_complex;

	-- Arithmetic function
	function add      (l, r : UNRESOLVED_complex) return UNRESOLVED_complex;
	function subtract (l, r : UNRESOLVED_complex) return UNRESOLVED_complex;
	function multiply (l, r : UNRESOLVED_complex) return UNRESOLVED_complex;
	function divide   (l, r : UNRESOLVED_complex) return UNRESOLVED_complex;

	function divideby2(arg : UNRESOLVED_complex) return UNRESOLVED_complex;
	function conjugate(arg : UNRESOLVED_complex) return UNRESOLVED_complex;
	function negate   (arg : UNRESOLVED_complex) return UNRESOLVED_complex;
	-- Overloaded arithmetic operator
	function "+" (l, r   : UNRESOLVED_complex) return UNRESOLVED_complex;
	function "-" (l, r   : UNRESOLVED_complex) return UNRESOLVED_complex;
	function "*" (l, r   : UNRESOLVED_complex) return UNRESOLVED_complex;
	function "/" (l, r   : UNRESOLVED_complex) return UNRESOLVED_complex;

	function "-" (arg : UNRESOLVED_complex) return UNRESOLVED_complex;

	-- Comparaison functions
	function ne(l, r : UNRESOLVED_complex) return BOOLEAN;
	function eq(l, r : UNRESOLVED_complex) return BOOLEAN;
	function gt(l, r : UNRESOLVED_complex) return BOOLEAN;
	function lt(l, r : UNRESOLVED_complex) return BOOLEAN;
	function le(l, r : UNRESOLVED_complex) return BOOLEAN;
	function ge(l, r : UNRESOLVED_complex) return BOOLEAN;


	function "="  (l, r : UNRESOLVED_complex) return BOOLEAN;
	function "/=" (l, r : UNRESOLVED_complex) return BOOLEAN;
	function ">=" (l, r : UNRESOLVED_complex) return BOOLEAN;
	function "<=" (l, r : UNRESOLVED_complex) return BOOLEAN;
	function ">"  (l, r : UNRESOLVED_complex) return BOOLEAN;
	function "<"  (l, r : UNRESOLVED_complex) return BOOLEAN;

	procedure break_number (
		arg      : in UNRESOLVED_complex;
		r_fract  : out UNSIGNED;
		r_expon  : out SIGNED;
		r_sign   : out STD_ULOGIC;   
		i_fract  : out UNSIGNED;
		i_expon  : out SIGNED;
		i_sign   : out STD_ULOGIC);

	function normalize(
		r_fract  : UNSIGNED;
		r_expon  : SIGNED;
		r_sign   : STD_ULOGIC;   
		i_fract  : UNSIGNED;
		i_expon  : SIGNED;
		i_sign   : STD_ULOGIC)
		return UNRESOLVED_complex;

	function to_complex(a : UNRESOLVED_float,  b : UNRESOLVED_float) return UNRESOLVED_complex;
	function to_complex(a : INTEGER,           b : UNRESOLVED_float) return UNRESOLVED_complex; 
	function to_complex(a : SIGNED,            b : UNRESOLVED_float) return UNRESOLVED_complex;
	function to_complex(a : REAL,              b : UNRESOLVED_float) return UNRESOLVED_complex;
	function to_complex(a : UNSIGNED,          b : UNRESOLVED_float) return UNRESOLVED_complex;
	function to_complex(a : STD_ULOGIC_VECTOR, b : UNRESOLVED_float) return UNRESOLVED_complex;
	function to_complex(a : UNRESOLVED_ufixed, b : UNRESOLVED_float) return UNRESOLVED_complex;
	function to_complex(a : UNRESOLVED_sfixed, b : UNRESOLVED_float) return UNRESOLVED_complex;

	function to_complex(a : UNRESOLVED_float,  b : INTEGER) return UNRESOLVED_complex;
	function to_complex(a : INTEGER,           b : INTEGER) return UNRESOLVED_complex; 
	function to_complex(a : SIGNED,            b : INTEGER) return UNRESOLVED_complex;
	function to_complex(a : REAL,              b : INTEGER) return UNRESOLVED_complex;
	function to_complex(a : UNSIGNED,          b : INTEGER) return UNRESOLVED_complex;
	function to_complex(a : STD_ULOGIC_VECTOR, b : INTEGER) return UNRESOLVED_complex;
	function to_complex(a : UNRESOLVED_ufixed, b : INTEGER) return UNRESOLVED_complex;
	function to_complex(a : UNRESOLVED_sfixed, b : INTEGER) return UNRESOLVED_complex;

	function to_complex(a : UNRESOLVED_float,  b : SIGNED) return UNRESOLVED_complex;
	function to_complex(a : INTEGER,           b : SIGNED) return UNRESOLVED_complex; 
	function to_complex(a : SIGNED,            b : SIGNED) return UNRESOLVED_complex;
	function to_complex(a : REAL,              b : SIGNED) return UNRESOLVED_complex;
	function to_complex(a : UNSIGNED,          b : SIGNED) return UNRESOLVED_complex;
	function to_complex(a : STD_ULOGIC_VECTOR, b : SIGNED) return UNRESOLVED_complex;
	function to_complex(a : UNRESOLVED_ufixed, b : SIGNED) return UNRESOLVED_complex;
	function to_complex(a : UNRESOLVED_sfixed, b : SIGNED) return UNRESOLVED_complex;

	function to_complex(a : UNRESOLVED_float,  b : REAL) return UNRESOLVED_complex;
	function to_complex(a : INTEGER,           b : REAL) return UNRESOLVED_complex; 
	function to_complex(a : SIGNED,            b : REAL) return UNRESOLVED_complex;
	function to_complex(a : REAL,              b : REAL) return UNRESOLVED_complex;
	function to_complex(a : UNSIGNED,          b : REAL) return UNRESOLVED_complex;
	function to_complex(a : STD_ULOGIC_VECTOR, b : REAL) return UNRESOLVED_complex;
	function to_complex(a : UNRESOLVED_ufixed, b : REAL) return UNRESOLVED_complex;
	function to_complex(a : UNRESOLVED_sfixed, b : REAL) return UNRESOLVED_complex;

	function to_complex(a : UNRESOLVED_float,  b : UNSIGNED) return UNRESOLVED_complex;
	function to_complex(a : INTEGER,           b : UNSIGNED) return UNRESOLVED_complex; 
	function to_complex(a : SIGNED,            b : UNSIGNED) return UNRESOLVED_complex;
	function to_complex(a : REAL,              b : UNSIGNED) return UNRESOLVED_complex;
	function to_complex(a : UNSIGNED,          b : UNSIGNED) return UNRESOLVED_complex;
	function to_complex(a : STD_ULOGIC_VECTOR, b : UNSIGNED) return UNRESOLVED_complex;
	function to_complex(a : UNRESOLVED_ufixed, b : UNSIGNED) return UNRESOLVED_complex;
	function to_complex(a : UNRESOLVED_sfixed, b : UNSIGNED) return UNRESOLVED_complex;

	function to_complex(a : UNRESOLVED_float,  b : STD_ULOGIC_VECTOR) return UNRESOLVED_complex;
	function to_complex(a : INTEGER,           b : STD_ULOGIC_VECTOR) return UNRESOLVED_complex; 
	function to_complex(a : SIGNED,            b : STD_ULOGIC_VECTOR) return UNRESOLVED_complex;
	function to_complex(a : REAL,              b : STD_ULOGIC_VECTOR) return UNRESOLVED_complex;
	function to_complex(a : UNSIGNED,          b : STD_ULOGIC_VECTOR) return UNRESOLVED_complex;
	function to_complex(a : STD_ULOGIC_VECTOR, b : STD_ULOGIC_VECTOR) return UNRESOLVED_complex;
	function to_complex(a : UNRESOLVED_ufixed, b : STD_ULOGIC_VECTOR) return UNRESOLVED_complex;
	function to_complex(a : UNRESOLVED_sfixed, b : STD_ULOGIC_VECTOR) return UNRESOLVED_complex;

	function to_complex(a : UNRESOLVED_float,  b : UNRESOLVED_ufixed) return UNRESOLVED_complex;
	function to_complex(a : INTEGER,           b : UNRESOLVED_ufixed) return UNRESOLVED_complex; 
	function to_complex(a : SIGNED,            b : UNRESOLVED_ufixed) return UNRESOLVED_complex;
	function to_complex(a : REAL,              b : UNRESOLVED_ufixed) return UNRESOLVED_complex;
	function to_complex(a : UNSIGNED,          b : UNRESOLVED_ufixed) return UNRESOLVED_complex;
	function to_complex(a : STD_ULOGIC_VECTOR, b : UNRESOLVED_ufixed) return UNRESOLVED_complex;
	function to_complex(a : UNRESOLVED_ufixed, b : UNRESOLVED_ufixed) return UNRESOLVED_complex;
	function to_complex(a : UNRESOLVED_sfixed, b : UNRESOLVED_ufixed) return UNRESOLVED_complex;

	function to_complex(a : UNRESOLVED_float,  b : UNRESOLVED_sfixed) return UNRESOLVED_complex;
	function to_complex(a : INTEGER,           b : UNRESOLVED_sfixed) return UNRESOLVED_complex; 
	function to_complex(a : SIGNED,            b : UNRESOLVED_sfixed) return UNRESOLVED_complex;
	function to_complex(a : REAL,              b : UNRESOLVED_sfixed) return UNRESOLVED_complex;
	function to_complex(a : UNSIGNED,          b : UNRESOLVED_sfixed) return UNRESOLVED_complex;
	function to_complex(a : STD_ULOGIC_VECTOR, b : UNRESOLVED_sfixed) return UNRESOLVED_complex;
	function to_complex(a : UNRESOLVED_ufixed, b : UNRESOLVED_sfixed) return UNRESOLVED_complex;
	function to_complex(a : UNRESOLVED_sfixed, b : UNRESOLVED_sfixed) return UNRESOLVED_complex;

	function real_to_float(arg : UNRESOLVED_complex) return UNRESOLVED_float;
	function imag_to_float(arg : UNRESOLVED_complex) return UNRESOLVED_float;

	function real_to_int(arg : UNRESOLVED_complex) return INTEGER;
	function imag_to_in(arg : UNRESOLVED_complex) return INTEGER;

	function real_to_signed(arg : UNRESOLVED_complex) return SIGNED;
	function imag_to_signed(arg : UNRESOLVED_complex) return SIGNED;

	function real_to_real(arg : UNRESOLVED_complex) return REAL;
	function imag_to_real(arg : UNRESOLVED_complex) return REAL;

	function real_to_unsigned(arg : UNRESOLVED_complex) return UNSIGNED;
	function imag_to_unsigned(arg : UNRESOLVED_complex) return UNSIGNED;

	function real_to_slv(arg : UNRESOLVED_complex) return STD_ULOGIC_VECTOR;
	function imag_to_slv(arg : UNRESOLVED_complex) return STD_ULOGIC_VECTOR;

	function real_to_ufixed(arg : UNRESOLVED_complex) return UNRESOLVED_ufixed;
	function imag_to_ufixed(arg : UNRESOLVED_complex) return UNRESOLVED_ufixed;

	function real_to_sfixed(arg : UNRESOLVED_complex) return UNRESOLVED_sfixed;
	function imag_to_sfixed(arg : UNRESOLVED_complex) return UNRESOLVED_sfixed;


-------------------------------------------------------------------------------
  -- *** Private function ***
  -- Bit operation 
-------------------------------------------------------------------------------
  

end package float_complex_pkg;

-------------------------------------------------------------------------------
-- Proposed package body for the float_complex_pkg package.
-- Version    : $Revision: 0.1 $
-- Date       : $Date: 2015-07-20 $
-------------------------------------------------------------------------------

package body float_complex_pkg is

	procedure break_number (              -- internal version
		arg         : in  UNRESOLVED_complex;
		r_fract     : out UNSIGNED;
		r_expon     : out SIGNED;
		r_sign      : out STD_ULOGIC;
		i_fract     : out UNSIGNED;
		i_expon     : out SIGNED;
		i_sign      : out STD_ULOGIC) is
	begin
		r_sign  (cplx_sign_width-1 downto 0)     := STD_ULOGIC (to_slv(arg(31)));
		r_expon (cplx_exponent_width-1 downto 0) := SIGNED     (to_slv(arg(30 downto 25)));
		r_fract (cplx_fraction_width-1 downto 0) := UNSIGNED   (to_slv(arg(24 downto 16)));
		i_sign  (cplx_sign_width-1 downto 0)     := STD_ULOGIC (to_slv(arg(15)));
		i_expon (cplx_exponent_width-1 downto 0) := SIGNED     (to_slv(arg(14 downto 9)));
		i_fract (cplx_fraction_width-1 downto 0) := UNSIGNED   (to_slv(arg(8 downto 0)));
	end procedure break_number;

	function normalize (
		r_fract  : UNSIGNED;
		r_expon  : SIGNED;
		r_sign   : STD_ULOGIC;   
		i_fract  : UNSIGNED;
		i_expon  : SIGNED;
		i_sign   : STD_ULOGIC)
		return UNRESOLVED_complex is
	begin
	    
    end function normalize;



end package body float_complex_pkg;
