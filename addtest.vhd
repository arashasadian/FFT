entity addtest is
end entity;

architecture aa of addtest is

    component ADDER is
        port(adder_input1 : in integer ;
        adder_input2 : in integer;
        inp1_shamt : in integer;
        inp2_shamt : in integer;
        adder_out  : out integer;
        out_shamt : out integer
    );
    end component ADDER;
    signal a, b, c, d : integer;

begin
    aaa : ADDER port map(a, b, 0, 0, c, d);
    identifier : process
    begin
        a <= 5;
        b <= 6;
        wait for 1000 ns;
    end process ; -- identifier

end aa ; -- aa