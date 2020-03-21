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


entity CORDIC_TEST is
end entity;


architecture aaa of CORDIC_TEST is

    signal degree, s, c, sh : signed(31 downto 0);
    signal clk : std_logic := '0';
    
    component CORDIC is
        generic (ITER : integer := 12);
        port(
            clk : in std_logic;
            degree : in signed(31 downto 0);
            sin_out, cos_out, shamt :out signed(31 downto 0)
        );
    end component CORDIC;
    begin
    DUT:CORDIC port map(clk, degree, s, c, sh);
    process begin
        degree <= to_signed(70000, 32);
        wait for 31000 ns;
        degree <= to_signed(90000, 32);
        wait for 31000 ns;
    end process;
    
    clk <= not(clk) after 1500 ns;

end architecture aaa;