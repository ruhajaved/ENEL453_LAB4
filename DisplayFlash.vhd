library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity DisplayFlash is
	port ( distance : in STD_LOGIC_VECTOR(12 downto 0);
			clk : in  STD_LOGIC;
			reset_n : in  STD_LOGIC;
			blank_out_temp : in STD_LOGIC_VECTOR(5 downto 0);
			blank_out : out STD_LOGIC_VECTOR(5 downto 0)
		);
end DisplayFlash;

architecture behaviour of DisplayFlash is

signal EN : STD_LOGIC;
signal pwm_out : STD_LOGIC;

component downcounter_display is    
    port    ( clk     : in  STD_LOGIC;
              reset_n : in  STD_LOGIC; 
              enable  : in  STD_LOGIC; 
			  distance : in STD_LOGIC_VECTOR(12 downto 0);
              zero    : out STD_LOGIC 
			);
end component;

component PWM_DAC2 is
   generic ( width : integer := 9);
   Port    ( reset_n    : in  STD_LOGIC;
			    EN		: in STD_LOGIC;
             clk        : in  STD_LOGIC;
             pwm_out    : out STD_LOGIC
           );
end component;

begin

	downcounter_display_ins : downcounter_display
		port map ( clk => clk, 
				  reset_n => reset_n, 
				  enable => '1',
				  distance => distance,
				  zero => EN
				);

	PWM_DAC2_ins : PWM_DAC2
		port map ( reset_n => reset_n,
			    EN	=> EN,
             clk  => clk,
             pwm_out => pwm_out
           );
	
	select_out : process(distance, blank_out_temp, pwm_out)
	begin
		if (unsigned(distance) >= 2000) then
			blank_out <= blank_out_temp;
		else
			if (pwm_out = '0') then
				blank_out <= "111111";
			else
				blank_out <= blank_out_temp;
			end if;
		end if;
	end process;

end;
