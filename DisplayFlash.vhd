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

signal dc_width : STD_LOGIC_VECTOR(3 downto 0);
signal EN : STD_LOGIC;
signal pwm_out : STD_LOGIC;
--signal distance_t : unsigned(12 downto 0);

component D2DDC is
	port(	distance : in STD_LOGIC_VECTOR(12 downto 0); -- added to choose width
			dc_width : out STD_LOGIC_VECTOR (3 downto 0) -- largest width wanted will fit
		);
end component;

component downcounter is
    Generic ( period  : natural := 1000); -- number to count       
    PORT    ( clk     : in  STD_LOGIC; -- clock to be divided
              reset_n : in  STD_LOGIC; -- active-high reset
              --enable  : in  STD_LOGIC; -- active-high enable			-- set to always high 
              zero    : out STD_LOGIC  -- creates a positive pulse every time current_count hits zero
			);
end component;

component PWM_DAC2 is
   Port    ( reset_n    : in  STD_LOGIC;
			    EN		: in STD_LOGIC; -- used to slow down counter to make flashing visible to human eye
             clk        : in  STD_LOGIC;
			    dc_width : in STD_LOGIC_VECTOR (3 downto 0);
             pwm_out    : out STD_LOGIC
           );
end component;

begin

	D2DDC_ins : D2DDC
		port map (	distance => distance,
				dc_width => dc_width 
				);

	downcounter_ins : downcounter
		--generic map ( period  : natural := 1000); -- number to count       
		port map ( clk => clk, 
				  reset_n => reset_n, 
				  zero => EN
				);

	PWM_DAC2_ins : PWM_DAC2
		port map ( reset_n => reset_n,
			    EN	=> EN, -- used to slow down counter to make flashing visible to human eye
             clk  => clk,
			    dc_width => dc_width,
             pwm_out => pwm_out
           );
	
	--distance_t <= unsigned(distance);
	
	select_out : process(distance, blank_out_temp, pwm_out)
		--signal distance_t : unsigned(12 downto 0) := unsigned(distance);
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
