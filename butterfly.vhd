library ieee;
use ieee.std_logic_1164.all;
use work.all;
use work.assests.all;

entity butterfly is
    generic(N : integer := 512);
    port(DFTinput : in array_of_integer;
        DFToutputReal : out array_of_float;
        DFToutputImag : out array_of_float
    );
end butterfly;

architecture butterflyBody of butterfly is
signal tempReal, tempImag : std_logic_vector(7 downto 0);
-- component sinlut is


-- end component;
-- component coslut is 


-- end component;
begin
    process(DFTinput) is
    begin
       
    end process;
end butterflyBody;