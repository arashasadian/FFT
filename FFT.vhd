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


entity FFT is
    generic(N : positive := 256);
    port(
        FFTInput : in array_of_integer(N-1 downto 0);
        rom_sin : in rom_type;
        rom_cos : in rom_type;
        FFTOutputReal : out array_of_float(N-1 downto 0);
        FFTOutputImag : out array_of_float(N-1 downto 0)
    );
end FFT;

architecture behavioral of FFT is
begin
    process(FFTInput)
    variable tempOdd_imag, tempOdd_real, tempEven_imag, tempEven_real : float32;
    variable period_in_2pi : float32;
    variable mult_ans : float32;
    variable sin_read, cos_read : float32;
    variable res_real, res_imag, sin_read_res, cos_read_res : float32;
    variable mult_ans_res, period_in_2pi_res : float32;
    
    begin
        
        outer:for k in 0 to (N/2)-1 loop
            tempOdd_real := to_float(0);
            tempOdd_imag := to_float(0);
            tempEven_real := to_float(0);
            tempEven_imag := to_float(0);
            res_imag  := to_float(0);
            res_real :=  to_float(0);
            inner:for m in 0 to (N/2)-1 loop
                mult_ans := (2 * 3.14 * to_float(m) * to_float(k) )/ (N/2);
                period_in_2pi := mult_ans mod (2 * 3.14);
                sin_read := to_float(rom_sin(to_integer(period_in_2pi)) / (10 ** 16));
                cos_read := to_float(rom_cos(to_integer(period_in_2pi)) / (10 ** 16));
                tempOdd_real := tempOdd_real + (FFTInput(2 * m  + 1) * cos_read);
                tempOdd_imag := tempOdd_imag + (FFTInput(2 * m + 1) * sin_read);
                tempEven_real := tempEven_real + (FFTInput(2 * m  ) * cos_read);
                tempEven_imag := tempEven_imag + (FFTInput(2 * m ) * sin_read);
                
            end loop inner;
            mult_ans_res := (2 * 3.14 * to_float(k) )/ (N);
            period_in_2pi_res := mult_ans_res mod (2 * 3.14);
            sin_read_res := to_float(rom_sin(to_integer(period_in_2pi_res)) / (10 ** 16));
            cos_read_res := to_float(rom_cos(to_integer(period_in_2pi_res)) / (10 ** 16));
            
            res_real := tempEven_real + (cos_read_res * tempOdd_real) + (sin_read_res * tempOdd_imag);
            res_imag := tempEven_imag - (sin_read_res  * tempOdd_real) + (cos_read_res * tempOdd_imag);
            FFTOutputReal(k) <= res_real;
            FFTOutputImag(k) <= res_imag;
            report to_string(tempOdd_real);


            res_real := tempEven_real - (cos_read_res * tempOdd_real) + (sin_read_res * tempOdd_imag);
            res_imag := tempEven_imag + (sin_read_res  * tempOdd_real) - (cos_read_res * tempOdd_imag);
            FFTOutputReal(k + (N/2)) <= res_real;
            FFTOutputImag(k + (N/2)) <= res_imag;
        end loop outer;
        
    end process;

end behavioral;





