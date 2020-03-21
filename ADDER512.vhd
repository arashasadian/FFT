library ieee;
use ieee.std_logic_1164.all;
use work.all;
use work.assests.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity ADDER512 is
    port(
        adder_inp_list : in array_of_integer(4-1 downto 0);
        adder_inp_list_shamt : in array_of_integer(4-1 downto 0);
        adder_output : out integer;
        adder_output_shamt : out integer
    );
end ADDER512;

architecture arch of ADDER512 is

    component NADDER is
        generic (N : integer := 4);
        port (
            adder_inp_list : in array_of_integer(N-1 downto 0);
            adder_inp_list_shamt : in array_of_integer(N-1 downto 0);
            adder_output : out array_of_integer((N/2)-1 downto 0);
            adder_output_shamt : out array_of_integer((N/2)-1 downto 0)
        ) ;
    end component NADDER;

    -- signal temp256, temp_shamt256 : array_of_integer(256-1 downto 0);
    -- signal temp128, temp_shamt128 : array_of_integer(128-1 downto 0);
    -- signal temp64, temp_shamt64 : array_of_integer(64-1 downto 0);
    -- signal temp32, temp_shamt32 : array_of_integer(32-1 downto 0);
    -- signal temp16, temp_shamt16 : array_of_integer(16-1 downto 0);
    -- signal temp8, temp_shamt8 : array_of_integer(8-1 downto 0);
    signal temp4, temp_shamt4 : array_of_integer(4-1 downto 0);
    signal temp2, temp_shamt2 : array_of_integer(2-1 downto 0);
    signal temp1, temp_shamt1 : array_of_integer(1-1 downto 0);
    begin 
        -- nadder_gen256: NADDER generic map(512) port map(adder_inp_list, adder_inp_list_shamt, temp256, temp_shamt256);
        -- nadder_gen128: NADDER generic map(256) port map(temp256, temp_shamt256, temp128, temp_shamt128);
        -- nadder_gen64: NADDER generic map(128) port map(temp128, temp_shamt128, temp64, temp_shamt64);
        -- nadder_gen32: NADDER generic map(64) port map(temp64, temp_shamt64, temp32, temp_shamt32);
        -- nadder_gen16: NADDER generic map(32) port map(temp32, temp_shamt32, temp16, temp_shamt16);
        -- nadder_gen8: NADDER generic map(16) port map(temp16, temp_shamt16, temp8, temp_shamt8);
        -- nadder_gen4: NADDER generic map(8) port map(temp8, temp_shamt8, temp4, temp_shamt4);
        nadder_gen2: NADDER generic map(4) port map(adder_inp_list, adder_inp_list_shamt, temp2, temp_shamt2);
        nadder_gen1: NADDER generic map(2) port map(temp2, temp_shamt2, temp1, temp_shamt1);
        adder_output <= temp1(0);
        adder_output_shamt <= temp_shamt1(0);
end architecture arch;