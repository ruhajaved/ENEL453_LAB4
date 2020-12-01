library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity D2DDC is
	port(	distance : in STD_LOGIC_VECTOR(12 downto 0); -- added to choose width
			dc_width : out STD_LOGIC_VECTOR (3 downto 0) -- largest width wanted will fit
		);
end;

architecture behaviour of D2DDC is

signal distance_t : unsigned(12 downto 0) := unsigned(distance);

begin

	width_c : process(distance) -- correct sensitivty list?
	
	variable width_temp : integer;
	
	begin
		if (distance_t < 500) then -- can you do this comparison?
			width_temp := 1;
		elsif (distance_t < 1000) then
			width_temp := 2;
		elsif (distance_t < 1500) then
			width_temp := 4;
		elsif (distance_t < 2000) then
			width_temp := 5;	
		else
			width_temp := 0; -- check if this can't be zero
		end if;
		
		dc_width <= std_logic_vector(to_unsigned(width_temp, dc_width'length));
	end process;

end;