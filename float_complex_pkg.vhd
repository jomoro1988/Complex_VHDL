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
  constant cplx_exponent_width : NATURAL    := 5;
  constant cplx_fraction_width : NATURAL    := 10;

  constant cplx_imag_width : NATURAL    := 16;
  constant cplx_real_width : NATURAL    := 16;

  type UNRESOLVED_complex is array (0 to 31) of STD_ULOGIC;  -- main type
  subtype U_complex is UNRESOLVED_complex;

  subtype complex is UNRESOLVED_complex;

  -- Arithmetic function
  function add(      l, r : UNRESOLVED_complex) return UNRESOLVED_complex;
  function subtract( l, r : UNRESOLVED_complex) return UNRESOLVED_complex;
  function multiply( l, r : UNRESOLVED_complex) return UNRESOLVED_complex;
  function divide(   l, r : UNRESOLVED_complex) return UNRESOLVED_complex;
  function divideby2( arg : UNRESOLVED_complex) return UNRESOLVED_complex;
  function conjugate( arg : UNRESOLVED_complex) return UNRESOLVED_complex;

  -- Comparaison functions
  function ne(l, r : UNRESOLVED_complex) return boolean;
  function eq(l, r : UNRESOLVED_complex) return boolean;
  function gt(l, r : UNRESOLVED_complex) return boolean;
  function lt(l, r : UNRESOLVED_complex) return boolean;
  function lte(l, r : UNRESOLVED_complex) return boolean;
  function gte(l, r : UNRESOLVED_complex) return boolean;

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


end package body float_complex_pkg;
