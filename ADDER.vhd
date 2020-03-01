library ieee;
use ieee.std_logic_1164.all;
use work.all;
use work.assests.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;


entity ADDER is
    port(adder_input1 : in integer ;
        adder_input2 : in integer;
        inp1_shamt : in integer;
        inp2_shamt : in integer;
        adder_out  : out integer;
        out_shamt : out integer
    );
end entity ADDER;

architecture arch of ADDER is
begin
    process(adder_input1, adder_input2, inp1_shamt, inp2_shamt) 
    variable inp : integer;
    begin
        if (inp2_shamt = inp1_shamt) then
            adder_out <= adder_input1 + adder_input2;
            out_shamt <= inp1_shamt;
        elsif (inp1_shamt > inp2_shamt) then
            out_shamt <= inp2_shamt;
            inp := adder_input1 * (10 ** (inp1_shamt - inp2_shamt));
            adder_out <= inp + adder_input2;
        else
            out_shamt <= inp1_shamt;
            inp := adder_input2 * (10 ** (inp2_shamt - inp1_shamt));
            adder_out <= inp + adder_input1;
        end if;
    end process;
end arch ; -- arch