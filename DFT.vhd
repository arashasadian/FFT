library ieee;
use ieee.std_logic_1164.all;
use work.all;
use work.assests.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity DFT is
    generic (N : integer := 4);
    port(
        dft_input : in array_of_integer(N-1 downto 0);
        rom_sin : in rom_type;
        rom_cos : in rom_type;
        dft_output_real : out array_of_integer(N-1 downto 0);
        dft_output_real_shamt : out array_of_integer(N-1 downto 0);
        dft_output_imag : out array_of_integer(N-1 downto 0);
        dft_output_imag_shamt : out array_of_integer(N-1 downto 0)
    );
end DFT;


architecture arch of DFT is

    component DFT_CELL is
        generic (N : integer := 4);
        port(
            dft_input : in array_of_integer(N-1 downto 0);
            k : in integer;
            rom_sin : in rom_type;
            rom_cos : in rom_type;
            dft_output_real : out integer;
            dft_output_imag : out integer;
            real_shamt, imag_shamt : out integer
        );
    end component DFT_CELL;
    
    signal output_real, output_real_shamt, output_imag, output_imag_shamt :array_of_integer(N - 1 downto 0);

begin

    dft_cell_gen:for i in 0 to N-1 generate
        dft_cell_mod: DFT_CELL generic map (N) port map(dft_input, i, rom_sin, rom_cos, output_real(i), output_imag(i), output_real_shamt(i), output_imag_shamt(i));
    end generate dft_cell_gen;
    dft_output_real <= output_real;
    dft_output_real_shamt <= output_real_shamt;
    dft_output_imag <= output_imag;
    dft_output_imag_shamt <= output_imag_shamt;
        
end arch ; -- arch