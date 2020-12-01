library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity PWM_DAC2 is
   --Generic ( width : integer := 9);
   Port    ( reset_n    : in  STD_LOGIC;
			    EN		: in STD_LOGIC; -- used to slow down counter to make flashing visible to human eye
             clk        : in  STD_LOGIC;
             --duty_cycle : in  STD_LOGIC_VECTOR (width-1 downto 0);
			    dc_width : in STD_LOGIC_VECTOR (3 downto 0);
             pwm_out    : out STD_LOGIC
           );
end PWM_DAC2;

architecture Behavioral of PWM_DAC2 is

signal N : integer;
signal counter_max : integer;--unsigned (width_c-1 downto 0);
signal counter : integer;
signal duty_cycle : integer;
--signal temp : unsigned (width_c-1 downto 0);
       
begin
	--width_c <= to_integer(unsigned(dc_width));
	--temp <= (others => '1');
	--duty_cycle <= temp srl 1; -- duty cylce will be half of the max counter value
	
	N <= to_integer(unsigned(dc_width));
	counter_max <= 2**N-1;
	duty_cycle <= 2**(N-1)-1;

   count : process(clk, reset_n)
   begin
       if( reset_n = '0') then
           counter <= 0;--(others => '0');
       elsif (rising_edge(clk) and EN = '1') then 
				if (counter < counter_max) then
					counter <= counter + 1;
				else
					counter <= 0;
				end if;
       end if;
   end process;
 
   compare : process(counter, duty_cycle)
   begin    
       if (counter <= duty_cycle) then
           pwm_out <= '0';
       else 
           pwm_out <= '1';
       end if;
   end process;
  
end Behavioral;