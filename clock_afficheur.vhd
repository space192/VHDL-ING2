library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;


entity clock_afficheur is
	generic(max : integer);
	port(
		signal clkS : in std_logic;
		signal clkOut : out std_logic;
		signal resultat : out std_logic_vector(0 to 3));
end clock_afficheur;


architecture structural of clock_afficheur is
signal count2 : integer := 0;
signal count : INTEGER:= max;
begin
	process(clkS)
	begin
		if clkS'event and clkS = '1' then
			if count = 0 then
				count <= 9;
				clkOut <= '1';
			else
				count <= count - 1;
				clkOut <= '0';
			end if;
		end if;
	end process;
	resultat <= std_logic_vector(to_unsigned(count, 4));
end structural;