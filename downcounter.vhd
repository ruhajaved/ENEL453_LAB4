library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.ceil;
use IEEE.math_real.log2;

entity downcounter is
    --Generic ( period  : natural := 5); -- number to count    					-- change back to 6 000000   
    PORT    ( clk     : in  STD_LOGIC; -- clock to be divided
              reset_n : in  STD_LOGIC; -- active-high reset
              enable  : in  STD_LOGIC; -- active-high enable
			  distance : in STD_LOGIC_VECTOR(12 downto 0); -- added to choose width
              zero    : out STD_LOGIC  -- creates a positive pulse every time current_count hits zero
                                       -- useful to enable another device, like to slow down a counter
              -- value  : out STD_LOGIC_VECTOR(integer(ceil(log2(real(period)))) - 1 downto 0) -- outputs the current_count value, if needed
         );
end downcounter;

architecture Behavioral of downcounter is

   signal current_count : integer;
   signal period : integer;
   signal distance_t : unsigned(12 downto 0);
   
   -- with distance select period <=
		-- 6_000_000 when (distance > 1500 and distance < 2000),
		-- 5_500_000 when (distance > 1000 and distance < 1500),
		-- 5_000_000 when (distance > 500 and distance < 1000),
		-- 4_500_000 else 

  
BEGIN

	distance_t <= unsigned(distance);
	
	select_period : process(distance)
		begin
		if (distance_t < 500) then -- can you do this comparison?
			period <= 4; --45_000;
		elsif (distance_t < 1000) then
			period <= 5; --50_000;
		elsif (distance_t < 1500) then
			period <= 6; --50_500;
		else --if (distance_t < 2000) then should work for anything above 2000 and if anything is above 2000 it'll just get blocked later on
			period <= 7; --60_000;	
		--else
		--	period <= ; -- check if this can't be zero
		end if;
		end process;
   
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
