library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity buzzer is
	port ( distance : in STD_LOGIC_VECTOR(12 downto 0);
			clk : in  STD_LOGIC;
			reset_n : in  STD_LOGIC;
			pwm_out : out STD_LOGIC
		);
end buzzer;

architecture behaviour of buzzer is

signal EN : STD_LOGIC;

component downcounter_buzzer is    
    PORT    ( clk     : in  STD_LOGIC; -- clock to be divided
              reset_n : in  STD_LOGIC; -- active-high reset
              enable  : in  STD_LOGIC; -- active-high enable			-- set to always high 
			  distance : in STD_LOGIC_VECTOR(12 downto 0);
              zero    : out STD_LOGIC  -- creates a positive pulse every time current_count hits zero
			);
end component;

component PWM_DAC2 is
   generic ( width : integer := 9);
   Port    ( reset_n    : in  STD_LOGIC;
			    EN		: in STD_LOGIC; -- used to slow down counter to make flashing visible to human eye
             clk        : in  STD_LOGIC;
             pwm_out    : out STD_LOGIC
           );
end component;

begin

	downcounter_buzzer_ins : downcounter_buzzer    
		port map ( clk => clk, 
				  reset_n => reset_n, 
				  enable => '1',
				  distance => distance,
				  zero => EN
				);

	PWM_DAC2_ins : PWM_DAC2
		--generic map ( width => 2)
		port map ( reset_n => reset_n,
			    EN	=> EN, 
             clk  => clk,
             pwm_out => pwm_out
           );

end;
