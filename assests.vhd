library ieee;
use ieee.std_logic_1164.all;
use work.all;
use ieee.numeric_std.all;
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;
use ieee.float_pkg.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

package assests is 
    type array_of_integer is array(natural range <>) of integer;
    type array_of_float is array(natural range <>) of float32;
    type rom_type is array(629 downto 0) of integer;
    type arc_rom is array(11 downto 0) of signed(15 downto 0);
end assests;