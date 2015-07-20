-- --------------------------------------------------------------------
-- "float_complex_pkg" package contains functions for complex floating point math.
--
-- --------------------------------------------------------------------
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

  constant cplx_sign_width     : NATURAL    := 1;
  constant cplx_exponent_width : NATURAL    := 5;
  constant cplx_fraction_width : NATURAL    := 10;

  constant cplx_imag_width : NATURAL    := 16;
  constant cplx_real_width : NATURAL    := 16;

  -- Author David Bishop (dbishop@vhdl.org)

  -- Note that the size of the vector is not defined here, but in
  -- the package which calls this one.
  type UNRESOLVED_complex is array (INTEGER range <>) of STD_ULOGIC;  -- main type
  subtype U_complex is UNRESOLVED_complex;

  subtype complex is UNRESOLVED_complex;

end package float_complex_pkg;

-------------------------------------------------------------------------------
-- Proposed package body for the float_complex_pkg package.
-- Version    : $Revision: 0.1 $
-- Date       : $Date: 2015-07-20 $
-------------------------------------------------------------------------------

package body float_complex_pkg is


end package body float_complex_pkg;
