library ieee;
use ieee.std_logic_1164.all;

entity registerfile is 
    generic(N : integer := 1024);
    port(input_array : in std_logic_vector(N-1 downto 0);
        output_array : out std_logic_vector(N-1 downto 0);
        enable : in std_logic
    );
end registerfile;


architecture registerfile_arch of registerfile is
begin
    process(enable) is
    begin
        if rising_edge(enable) then
            output_array <= input_array;
        end if;
    end process;
end registerfile_arch;

