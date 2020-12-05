library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity PWM_DAC2 is
   generic ( width : integer := 9);
   Port    ( reset_n    : in  STD_LOGIC;
			    EN		: in STD_LOGIC;
             clk        : in  STD_LOGIC;
             pwm_out    : out STD_LOGIC
           );
end PWM_DAC2;

architecture Behavioral of PWM_DAC2 is

signal counter : unsigned (width-1 downto 0);
signal temp : unsigned (width-1 downto 0) := (others => '1');
signal duty_cycle : unsigned (width-1 downto 0) := temp srl 1;
       
begin

   count : process(clk, reset_n)
   begin
       if( reset_n = '0') then
           counter <= (others => '0');
       elsif (rising_edge(clk) and EN = '1') then 
		   counter <= counter + 1;
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