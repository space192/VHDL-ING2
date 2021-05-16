library IEEE;
use ieee.std_logic_1164.all;
use work.all;
use ieee.numeric_std.all;

entity EtatFeu is 
	port(
	clkS, stdby : in std_logic;
	clkOut : out std_logic;
	maxV : in integer;
	signal dizaine, unite : out std_logic_vector(0 to 3);
	signal valeur : out integer);
end EtatFeu;


architecture structural of EtatFeu is
signal count : integer := 0;
signal count2 : integer := maxV;
signal temp, temp2 : integer;
begin
	process(clkS)
	begin
		if clkS'event and clkS = '1' then
			if stdby = '0' then
				if count = maxV then
					count <= 0;
					clkOut <= '1';
				else
					count <= count +1;
					clkOut <= '0';
				end if;
			
				if count2 = 0 then
					count2 <= maxV;
				else
					count2 <= count2 -1;
				end if;
			elsif stdby ='1' then
				temp <= 0;
				temp2 <= 0;
			end if;
		end if;
		temp <= count2 /10;
		temp2 <= count2 mod 10;
	end process;
	valeur <= count2;
	dizaine <= std_logic_vector(to_unsigned(temp, 4));
	unite <= std_logic_vector(to_unsigned(temp2, 4));
end structural;