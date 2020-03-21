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

entity DFT_CELL is
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
end DFT_CELL;


architecture arch of DFT_CELL is

    component ADDER512 is
        port(
            adder_inp_list : in array_of_integer(N-1 downto 0);
            adder_inp_list_shamt : in array_of_integer(N-1 downto 0);
            adder_output : out integer;
            adder_output_shamt : out integer
        );
    end component ADDER512;

    component MULTIPLIER is
        port (
          mult_inp1 : in integer;
          mult_inp2 : in integer;
          inp1_shamt : in integer;
          inp2_shamt : in integer;
          mult_out : out integer;
          out_shamt : out integer
        ) ;
      end component MULTIPLIER;


    signal mult_res_real, mult_res_real_shamt : array_of_integer(N - 1 downto 0);
    signal mult_res_imag, mult_res_imag_shamt : array_of_integer(N - 1 downto 0);
    signal sum_res_real, sum_res_real_shamt : integer;
    signal sum_res_imag, sum_res_imag_shamt : integer;
    signal sin_read, cos_read : array_of_integer(N-1 downto 0);
    signal period_in_2pi, mult_ans : array_of_float(N-1 downto 0);


    begin
        mult_gen:for i in 0 to N - 1 generate
        process
        variable sin_read, cos_read : integer;
        variable period_in_2pi, mult_ans : float32;
        begin
            mult_ans := (2 * 3.14 * to_float(i) * to_float(k) ) / (N/2);
            period_in_2pi := mult_ans mod (2 * 3.14);
            sin_read := rom_sin(to_integer(period_in_2pi));
            cos_read := rom_cos(to_integer(period_in_2pi));
        end process;
        real_mult: MULTIPLIER port map(dft_input(i), cos_read(i), 0, -16, mult_res_real(i), mult_res_real_shamt(i));
        imag_mult: MULTIPLIER port map(dft_input(i), sin_read(i), 0, -16, mult_res_imag(i), mult_res_imag_shamt(i));
        end generate mult_gen;

        adder512_real:ADDER512 port map(mult_res_real, mult_res_real_shamt, sum_res_real, sum_res_real_shamt);
        adder512_imag:ADDER512 port map(mult_res_imag, mult_res_imag_shamt, sum_res_imag, sum_res_imag_shamt);
        
        dft_output_real <= sum_res_real;
        dft_output_imag <= sum_res_imag;
        real_shamt <= sum_res_real_shamt;
        imag_shamt <= sum_res_imag_shamt;
end arch ; -- arch