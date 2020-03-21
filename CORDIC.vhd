library ieee;
use ieee.std_logic_1164.all;
use work.all;
use work.assests.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;


entity CORDIC is
    generic (
        ITER : integer := 12;
        PERCISION : integer := 32
        );
    port(
        clk : in std_logic;
        degree : in signed(PERCISION - 1 downto 0);
        sin_out, cos_out, shamt :out signed(PERCISION - 1 downto 0)
    );
end entity CORDIC;

architecture behavioural of CORDIC is
    constant scaling_factor : signed(PERCISION - 1 downto 0) := to_signed(6072, PERCISION);
    constant scaling_factor_shamt : signed(PERCISION - 1 downto 0) := to_signed(-4, PERCISION);
    signal arctans : arc_rom;

    begin

    arctans(0)  <= to_signed(45000, PERCISION);
    arctans(1)  <= to_signed(26565, PERCISION);
    arctans(2)  <= to_signed(14036, PERCISION);
    arctans(3)  <= to_signed(7125, PERCISION);
    arctans(4)  <= to_signed(3576, PERCISION);
    arctans(5)  <= to_signed(1789, PERCISION);
    arctans(6)  <= to_signed(895, PERCISION);
    arctans(7)  <= to_signed(447, PERCISION);
    arctans(8)  <= to_signed(223, PERCISION);
    arctans(9)  <= to_signed(111, PERCISION);
    arctans(10) <= to_signed(55, PERCISION);
    arctans(11) <= to_signed(27, PERCISION);
    shamt <= to_signed(-4, PERCISION);
    main_process : process(clk)
        variable x, y, x_n, y_n, z, t : signed(PERCISION - 1 downto 0);
        variable sign_bit : bit := '0';
    begin
        if rising_edge(clk) then
            y   := (others => '0');
            x_n := (others => '0');
            y_n := (others => '0');
            t   := (others => '0');
            x := scaling_factor;
            z := degree;
            report "The value of 'z' is " & integer'image(to_integer(z));
            main_loop:for i in 0 to 11 loop
                if to_integer(z) >= 0 then
                    sign_bit := '0';
                    report "The value of 's' is 1";
                else
                    sign_bit := '1';
                    report "The value of 's' is -1";
                end if;
                t := y sra i;
                x_n := x + t when sign_bit = '1' else x - t;
                t := x sra i;
                y_n := y - t when sign_bit = '1' else y + t;
                y := y_n;
                x := x_n;
                t := arctans(i);
                z := z + t when sign_bit = '1' else z - t;
                report "The value of 'x' is " & integer'image(to_integer(x_n));
                report "The value of 'y' is " & integer'image(to_integer(y_n));
                report "The value of 'z' is " & integer'image(to_integer(z));
                report "---------------------------------------------------";
            end loop main_loop;
            sin_out <= y_n;
            cos_out <= x_n;
        end if;
    end process ; -- main_process
end architecture behavioural;