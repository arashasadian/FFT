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

entity testbench is
end testbench;

architecture tb of testbench is

component ROMGEN is  
    port(
        enable : in std_logic;
        rom_sin : out rom_type;
        rom_cos : out rom_type
        );
end component;

component DFT is
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
end component DFT;

constant N : integer := 4;
signal FFTInput : array_of_integer(N-1 downto 0);
signal enable : std_logic;
signal rom_sin, rom_cos : rom_type;
signal FFTOutputReal, FFTOutputImag, real_shamt, imag_shamt : array_of_integer(N-1 downto 0);

begin
    rom_gen_module : ROMGEN port map(enable,rom_sin,rom_cos);
    dft_module : DFT generic map(N) port map(FFTInput, rom_sin, rom_cos, FFTOutputReal, real_shamt, FFTOutputImag, imag_shamt);
    process begin
        
        enable <= '1' ; wait for 10 ns;
        enable <= '0' ; 
        FFTInput(0) <= 10 ;
        FFTInput(1) <= 20  ;
        FFTInput(2) <= 30;
        FFTInput(3) <= 40 ;
        -- report to_string(FFTOutputReal(1));
        wait for 200 ns;

    end process; 
     

end architecture tb;
        