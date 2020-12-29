library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;               -- Needed for shifts

entity ADC_Conversion_wrapper is  
    Port( MAX10_CLK1_50      : in STD_LOGIC;
          response_valid_out : out STD_LOGIC;
          ADC_out            : out STD_LOGIC_VECTOR (11 downto 0)
         );
end ADC_Conversion_wrapper;

architecture RTL of ADC_Conversion_wrapper is

component ADC_Conversion is    -- test_ADC is  
    Port( MAX10_CLK1_50      : in STD_LOGIC;
          response_valid_out : out STD_LOGIC;
          ADC_out            : out STD_LOGIC_VECTOR (11 downto 0)
         );
end component;

begin
ADC_Conversion_ins: ADC_Conversion  PORT MAP(  -- test_ADC  PORT MAP(      
                                    MAX10_CLK1_50      => MAX10_CLK1_50,
                                    response_valid_out => response_valid_out,
                                    ADC_out            => ADC_out
												);	

end RTL;

ARCHITECTURE simulation OF ADC_Conversion_wrapper IS
Signal counter :              STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
Signal response_valid_out_i : std_logic;
Signal use_response_i : std_logic;
begin

response_valid_out <= response_valid_out_i;
something: process
begin
	ADC_out(11 downto 0) <= "000000000000";

	response_valid_out_i <= '0'; wait for 980 ns;
	response_valid_out_i <= '1'; wait for 20 ns; 
	response_valid_out_i <= '0';
	wait for 6 ms;
    
	ADC_out(11 downto 0) <= "001011010000";

	response_valid_out_i <= '0'; wait for 980 ns;
	response_valid_out_i <= '1'; wait for 20 ns; 
	response_valid_out_i <= '0';
	wait for 12 ms;
	
	ADC_out(11 downto 0) <= "001000101000";	
	 
	response_valid_out_i <= '0'; wait for 980 ns;
	response_valid_out_i <= '1'; wait for 20 ns; 	 
	response_valid_out_i <= '0';      
	wait for 20 ms;        
end process;
end simulation;