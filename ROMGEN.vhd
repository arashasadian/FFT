library ieee;
use ieee.std_logic_1164.all;
use work.all;
use work.assests.all;
use ieee.numeric_std.all;
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;
use ieee.float_pkg.all;
use STD.textio.all;
use ieee.std_logic_textio.all;



entity ROMGEN is  
    port(
        enable : in std_logic;
        rom_sin : out rom_type;
        rom_cos : out rom_type
        );
end entity ROMGEN;

architecture READFFILE of ROMGEN is
    signal ff : float32;
    signal vint : integer := 256;
    signal array_of_ints : array_of_integer(629 downto 0);
begin
    process(enable)
    file file_sin                   : text open read_mode is "lut_sin.txt";
    file file_cos                   : text open read_mode is "lut_cos.txt";

    variable row1                    : line;
    variable row2                    : line;

    variable index1 : integer := 0;
    variable index2 : integer := 0;

    variable temp1 : integer;
    variable temp2 : integer;

    begin          
        while(not endfile(file_sin)) loop
            readline(file_sin,row1);
            read(row1,temp1);
            rom_sin(index1) <= temp1;
            index1 := index1 + 1;
        end loop;

        while(not endfile(file_cos)) loop
            readline(file_cos,row2);
            read(row2,temp2);
            rom_cos(index2) <= temp2;
            index2 := index2 + 1;
        end loop;
    
    end process;
end READFFILE;