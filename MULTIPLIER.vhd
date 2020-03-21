entity MULTIPLIER is
  port (
    mult_inp1 : in integer;
    mult_inp2 : in integer;
    inp1_shamt : in integer;
    inp2_shamt : in integer;
    mult_out : out integer;
    out_shamt : out integer
  ) ;
end MULTIPLIER;

architecture arch of MULTIPLIER is
begin
    process(mult_inp1, mult_inp2, inp1_shamt, inp2_shamt) begin
        mult_out <= mult_inp1 * mult_inp2;
        out_shamt <= inp1_shamt + inp2_shamt;
    end process;
end arch ; -- arch