library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.ceil;
use IEEE.math_real.log2;
use work.buzzer_LUT_pkg.all;

entity downcounter_buzzer is
    PORT    ( clk     : in  STD_LOGIC; -- clock to be divided
              reset_n : in  STD_LOGIC; -- active-high reset
              enable  : in  STD_LOGIC; -- active-high enable
			  distance : in STD_LOGIC_VECTOR(12 downto 0); 
              zero    : out STD_LOGIC 
              -- value  : out STD_LOGIC_VECTOR(integer(ceil(log2(real(period)))) - 1 downto 0) -- outputs the current_count value, if needed
         );
end downcounter_buzzer;

architecture Behavioral of downcounter_buzzer is

   signal current_count : integer;
   signal period : integer;
  
BEGIN

	period <= DtoBP_LUT(to_integer(unsigned(distance)));
   
   downcount : process(clk,reset_n) begin
     if (reset_n = '0') then 
          current_count <= 0 ;
          zero          <= '0';	
     elsif (rising_edge(clk)) then 
        if (enable = '1') then
           if (current_count = 0) then
             current_count <= period - 1;
             zero          <= '1';
           else 
             current_count <= current_count - 1;
             zero          <= '0';
           end if;
        else 
           zero <= '0';
        end if;
     end if;
   end process;
   
   -- value <= std_logic_vector(to_signed(current_count, value'length)); -- helps output the current_count value, if needed
   
END Behavioral;
