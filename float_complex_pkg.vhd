-- --------------------------------------------------------------------
-- "float_complex_pkg" package contains functions for complex floating point math.
--
-- --------------------------------------------------------------------
-- Prototypes of float_complex_pkg functions
-- Version    : $Revision: 0.1 $
-- Date       : $Date: 2015-07-20 $
-- --------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

library ieee_proposed;
use ieee_proposed.float_pkg.all;

package float_complex_pkg is

  -- Signal description
	type UNRESOLVED_complex is record   -- main type
		Re : float(6 downto -9);
		Im : float(6 downto -9);
	end record;

	subtype U_complex is UNRESOLVED_complex;
	subtype complex is UNRESOLVED_complex;

	-- Arithmetic function
	function mag      (arg : UNRESOLVED_complex) return float;

	function add      (l, r : UNRESOLVED_complex) return UNRESOLVED_complex;
	function subtract (l, r : UNRESOLVED_complex) return UNRESOLVED_complex;
	function multiply (l, r : UNRESOLVED_complex) return UNRESOLVED_complex;
	function divide   (l, r : UNRESOLVED_complex) return UNRESOLVED_complex;

	function conjugate(arg : UNRESOLVED_complex) return UNRESOLVED_complex;

	-- Overloaded arithmetic operator
	function "+" (l, r   : UNRESOLVED_complex) return UNRESOLVED_complex;
	function "-" (l, r   : UNRESOLVED_complex) return UNRESOLVED_complex;
	function "*" (l, r   : UNRESOLVED_complex) return UNRESOLVED_complex;
	function "/" (l, r   : UNRESOLVED_complex) return UNRESOLVED_complex;

    --function find_rightmost (arg : STD_ULOGIC_VECTOR) return INTEGER;

	--function to_complex(a : UNRESOLVED_float,  b : UNRESOLVED_float) return UNRESOLVED_complex;
	--function to_complex(a : INTEGER,           b : UNRESOLVED_float) return UNRESOLVED_complex; 
	--function to_complex(a : SIGNED,            b : UNRESOLVED_float) return UNRESOLVED_complex;
	--function to_complex(a : REAL,              b : UNRESOLVED_float) return UNRESOLVED_complex;
	--function to_complex(a : UNSIGNED,          b : UNRESOLVED_float) return UNRESOLVED_complex;
	--function to_complex(a : STD_ULOGIC_VECTOR, b : UNRESOLVED_float) return UNRESOLVED_complex;
	--function to_complex(a : UNRESOLVED_ufixed, b : UNRESOLVED_float) return UNRESOLVED_complex;
	--function to_complex(a : UNRESOLVED_sfixed, b : UNRESOLVED_float) return UNRESOLVED_complex;

	--function to_complex(a : UNRESOLVED_float,  b : INTEGER) return UNRESOLVED_complex;
	--function to_complex(a : INTEGER,           b : INTEGER) return UNRESOLVED_complex; 
	--function to_complex(a : SIGNED,            b : INTEGER) return UNRESOLVED_complex;
	--function to_complex(a : REAL,              b : INTEGER) return UNRESOLVED_complex;
	--function to_complex(a : UNSIGNED,          b : INTEGER) return UNRESOLVED_complex;
	--function to_complex(a : STD_ULOGIC_VECTOR, b : INTEGER) return UNRESOLVED_complex;
	--function to_complex(a : UNRESOLVED_ufixed, b : INTEGER) return UNRESOLVED_complex;
	--function to_complex(a : UNRESOLVED_sfixed, b : INTEGER) return UNRESOLVED_complex;

	--function to_complex(a : UNRESOLVED_float,  b : SIGNED) return UNRESOLVED_complex;
	--function to_complex(a : INTEGER,           b : SIGNED) return UNRESOLVED_complex; 
	--function to_complex(a : SIGNED,            b : SIGNED) return UNRESOLVED_complex;
	--function to_complex(a : REAL,              b : SIGNED) return UNRESOLVED_complex;
	--function to_complex(a : UNSIGNED,          b : SIGNED) return UNRESOLVED_complex;
	--function to_complex(a : STD_ULOGIC_VECTOR, b : SIGNED) return UNRESOLVED_complex;
	--function to_complex(a : UNRESOLVED_ufixed, b : SIGNED) return UNRESOLVED_complex;
	--function to_complex(a : UNRESOLVED_sfixed, b : SIGNED) return UNRESOLVED_complex;

	--function to_complex(a : UNRESOLVED_float,  b : REAL) return UNRESOLVED_complex;
	--function to_complex(a : INTEGER,           b : REAL) return UNRESOLVED_complex; 
	--function to_complex(a : SIGNED,            b : REAL) return UNRESOLVED_complex;
	--function to_complex(a : REAL,              b : REAL) return UNRESOLVED_complex;
	--function to_complex(a : UNSIGNED,          b : REAL) return UNRESOLVED_complex;
	--function to_complex(a : STD_ULOGIC_VECTOR, b : REAL) return UNRESOLVED_complex;
	--function to_complex(a : UNRESOLVED_ufixed, b : REAL) return UNRESOLVED_complex;
	--function to_complex(a : UNRESOLVED_sfixed, b : REAL) return UNRESOLVED_complex;

	--function to_complex(a : UNRESOLVED_float,  b : UNSIGNED) return UNRESOLVED_complex;
	--function to_complex(a : INTEGER,           b : UNSIGNED) return UNRESOLVED_complex; 
	--function to_complex(a : SIGNED,            b : UNSIGNED) return UNRESOLVED_complex;
	--function to_complex(a : REAL,              b : UNSIGNED) return UNRESOLVED_complex;
	--function to_complex(a : UNSIGNED,          b : UNSIGNED) return UNRESOLVED_complex;
	--function to_complex(a : STD_ULOGIC_VECTOR, b : UNSIGNED) return UNRESOLVED_complex;
	--function to_complex(a : UNRESOLVED_ufixed, b : UNSIGNED) return UNRESOLVED_complex;
	--function to_complex(a : UNRESOLVED_sfixed, b : UNSIGNED) return UNRESOLVED_complex;

	--function to_complex(a : UNRESOLVED_float,  b : STD_ULOGIC_VECTOR) return UNRESOLVED_complex;
	--function to_complex(a : INTEGER,           b : STD_ULOGIC_VECTOR) return UNRESOLVED_complex; 
	--function to_complex(a : SIGNED,            b : STD_ULOGIC_VECTOR) return UNRESOLVED_complex;
	--function to_complex(a : REAL,              b : STD_ULOGIC_VECTOR) return UNRESOLVED_complex;
	--function to_complex(a : UNSIGNED,          b : STD_ULOGIC_VECTOR) return UNRESOLVED_complex;
	--function to_complex(a : STD_ULOGIC_VECTOR, b : STD_ULOGIC_VECTOR) return UNRESOLVED_complex;
	--function to_complex(a : UNRESOLVED_ufixed, b : STD_ULOGIC_VECTOR) return UNRESOLVED_complex;
	--function to_complex(a : UNRESOLVED_sfixed, b : STD_ULOGIC_VECTOR) return UNRESOLVED_complex;

	--function to_complex(a : UNRESOLVED_float,  b : UNRESOLVED_ufixed) return UNRESOLVED_complex;
	--function to_complex(a : INTEGER,           b : UNRESOLVED_ufixed) return UNRESOLVED_complex; 
	--function to_complex(a : SIGNED,            b : UNRESOLVED_ufixed) return UNRESOLVED_complex;
	--function to_complex(a : REAL,              b : UNRESOLVED_ufixed) return UNRESOLVED_complex;
	--function to_complex(a : UNSIGNED,          b : UNRESOLVED_ufixed) return UNRESOLVED_complex;
	--function to_complex(a : STD_ULOGIC_VECTOR, b : UNRESOLVED_ufixed) return UNRESOLVED_complex;
	--function to_complex(a : UNRESOLVED_ufixed, b : UNRESOLVED_ufixed) return UNRESOLVED_complex;
	--function to_complex(a : UNRESOLVED_sfixed, b : UNRESOLVED_ufixed) return UNRESOLVED_complex;

	--function to_complex(a : UNRESOLVED_float,  b : UNRESOLVED_sfixed) return UNRESOLVED_complex;
	--function to_complex(a : INTEGER,           b : UNRESOLVED_sfixed) return UNRESOLVED_complex; 
	--function to_complex(a : SIGNED,            b : UNRESOLVED_sfixed) return UNRESOLVED_complex;
	--function to_complex(a : REAL,              b : UNRESOLVED_sfixed) return UNRESOLVED_complex;
	--function to_complex(a : UNSIGNED,          b : UNRESOLVED_sfixed) return UNRESOLVED_complex;
	--function to_complex(a : STD_ULOGIC_VECTOR, b : UNRESOLVED_sfixed) return UNRESOLVED_complex;
	--function to_complex(a : UNRESOLVED_ufixed, b : UNRESOLVED_sfixed) return UNRESOLVED_complex;
	--function to_complex(a : UNRESOLVED_sfixed, b : UNRESOLVED_sfixed) return UNRESOLVED_complex;

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

	function add      (l, r : UNRESOLVED_complex) 
		return UNRESOLVED_complex is
		variable result : UNRESOLVED_complex;
	begin
		result.Re := l.Re + r.Re;
		result.Im := l.Im + r.Im;
		return result;
	end function add;

	function subtract (l, r : UNRESOLVED_complex) 
		return UNRESOLVED_complex is
		variable result : UNRESOLVED_complex;
	begin
		result.Re := l.Re - r.Re;
		result.Im := l.Im - r.Im;
		return result;
	end function subtract;

	function multiply (l, r : UNRESOLVED_complex) return UNRESOLVED_complex is
		variable result : UNRESOLVED_complex;
		variable k1, k2, k3 : float (6 downto -9);
	begin 
		k1 := l.re * (r.re + r.im);
		k2 := r.im * (l.re + l.im);
		k3 := r.re * (l.im - l.re);

		result.re := k1 - k2;
		result.im := k1 + k3;
		return result;
	end function multiply;

	function divide   (l, r : UNRESOLVED_complex) return UNRESOLVED_complex is
		variable result, temp : UNRESOLVED_complex;
		variable denom        : float (6 downto -9);
	begin 
		temp := (l * conjugate(r));
		denom := mag(r);
		result.re := temp.re / denom;
		result.im := temp.im / denom;
		return result;
	end function divide;

	function conjugate(arg : UNRESOLVED_complex) return UNRESOLVED_complex is
		variable result : UNRESOLVED_complex;
	begin 
		result.Re := arg.Re;
		result.Im := -arg.Im;
		return result;
	end function conjugate;

	function mag (arg : UNRESOLVED_complex) return float is
		variable a, b, result : float (6 downto -9);
	begin
		a := (arg.re * arg.re);
		b := (arg.im * arg.im);
		result := a + b;
		return result;
	end function mag; 

	-- Overloaded arithmetic operator
	function "+" (l, r   : UNRESOLVED_complex) return UNRESOLVED_complex is 
	begin 
		return add (l,r);
	end function "+";

	function "-" (l, r   : UNRESOLVED_complex) return UNRESOLVED_complex is 
	begin 
		return subtract (l,r); 
	end function "-";

	function "*" (l, r   : UNRESOLVED_complex) return UNRESOLVED_complex is 
	begin 
		return multiply (l,r);
	end function "*";

	function "/" (l, r   : UNRESOLVED_complex) return UNRESOLVED_complex is 
	begin 
		return divide (l,r);
	end function "/";

end package body float_complex_pkg;
