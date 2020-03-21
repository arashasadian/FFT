library ieee;
use ieee.std_logic_1164.all;
use work.all;
use work.assests.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;
entity NADDER is
    generic (N : integer := 4);
    port (
        adder_inp_list : in array_of_integer(N-1 downto 0);
        adder_inp_list_shamt : in array_of_integer(N-1 downto 0);
        adder_output : out array_of_integer((N/2)-1 downto 0);
        adder_output_shamt : out array_of_integer((N/2)-1 downto 0)
    ) ;
end NADDER;

architecture arch of NADDER is

    component ADDER is
        port(
            adder_input1 : in integer ;
            adder_input2 : in integer;
            inp1_shamt : in integer;
            inp2_shamt : in integer;
            adder_out  : out integer;
            out_shamt : out integer
        );
    end component ADDER;
    signal temp_res, temp_shamt : array_of_integer((N/2)-1 downto 0);

begin
    add_gen:for i in 0 to (N/2) - 1 generate
        adder_mod: ADDER port map(adder_inp_list(2 * i), adder_inp_list((2*i) + 1), adder_inp_list_shamt(2 * i),adder_inp_list_shamt((2*i) + 1), temp_res(i), temp_shamt(i));
    end generate add_gen;
    adder_output_shamt <= temp_shamt;
    adder_output <= temp_res;
end arch ; -- arch