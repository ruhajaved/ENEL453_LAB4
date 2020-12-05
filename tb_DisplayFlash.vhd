library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity tb_DisplayFlash is
end tb_DisplayFlash;

architecture tb of tb_DisplayFlash is

    component DisplayFlash
        port (distance       : in std_logic_vector (12 downto 0);
              clk            : in std_logic;
              reset_n        : in std_logic;
              blank_out_temp : in std_logic_vector (5 downto 0);
              blank_out      : out std_logic_vector (5 downto 0));
    end component;

    signal distance       : std_logic_vector (12 downto 0);
    signal clk            : std_logic;
    signal reset_n        : std_logic;
    signal blank_out_temp : std_logic_vector (5 downto 0);
    signal blank_out      : std_logic_vector (5 downto 0);

    constant TbPeriod : time := 20 ns;
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : DisplayFlash
    port map (distance       => distance,
              clk            => clk,
              reset_n        => reset_n,
              blank_out_temp => blank_out_temp,
              blank_out      => blank_out);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        distance <= (others => '0');
        blank_out_temp <= "110011";

        -- Reset generation
        -- EDIT: Check that reset_n is really your reset signal
        reset_n <= '0';
            wait for 100 * TbPeriod;
		reset_n <= '1';
            wait for 100 * TbPeriod;
		distance <= "0" & x"802";
            wait for 100 * TbPeriod;
		distance <= "0" & x"5DC";
			wait for 100 * TbPeriod;
		distance <= "0" & x"0DC";
			wait for 100 * TbPeriod;
		distance <= "0" & x"35C";
			wait for 100 * TbPeriod;
		distance <= "0" & x"550";
			wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;