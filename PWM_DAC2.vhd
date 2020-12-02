library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity PWM_DAC2 is
   generic ( width : integer := 9);
   Port    ( reset_n    : in  STD_LOGIC;
			    EN		: in STD_LOGIC; -- used to slow down counter to make flashing visible to human eye
             clk        : in  STD_LOGIC;
             --duty_cycle : in  STD_LOGIC_VECTOR (width-1 downto 0);
			 --dc_width : in STD_LOGIC_VECTOR (3 downto 0);
             pwm_out    : out STD_LOGIC
           );
end PWM_DAC2;

architecture Behavioral of PWM_DAC2 is

--signal N : natural;
-- signal counter_max : integer; -- range 0 to (2**N-1);--unsigned (width_c-1 downto 0);
-- signal counter : integer;
-- signal duty_cycle : integer;
--signal temp : unsigned (width_c-1 downto 0);

signal counter : unsigned (width-1 downto 0);
signal temp : unsigned (width-1 downto 0) := (others => '1');
signal duty_cycle : unsigned (width-1 downto 0) := temp srl 1;
       
begin
	--width_c <= to_integer(unsigned(dc_width));
	--temp <= (others => '1');
	--duty_cycle <= temp srl 1; -- duty cylce will be half of the max counter value
	
	--N <= to_integer(unsigned(dc_width));
	--counter_max <= 2**N-1;
	--duty_cycle <= counter_max * (1/2);

   count : process(clk, reset_n)
   begin
       if( reset_n = '0') then
           counter <= (others => '0');--(others => '0');
       elsif (rising_edge(clk) and EN = '1') then 
		   counter <= counter + 1;
       end if;
   end process;
 
   compare : process(counter, duty_cycle)
   begin    
       if (counter <= duty_cycle) then -- how does the equal sign give a metastable value?
           pwm_out <= '0';
       else 
           pwm_out <= '1';
       end if;
   end process;
  
end Behavioral;