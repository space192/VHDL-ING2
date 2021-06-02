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
signal maxVtest : integer;
signal temp, temp2 : integer;
begin
	process(clkS, stdby)
	variable passage : std_logic := '1';
	variable count3 : std_logic := '0';
	begin
		if rising_edge(clkS) then
			if stdby = '0' then
				if passage = '1' then
					count <= 0;
					count2 <= maxV;
					passage := '0';
				else
					--if count = maxV then
						--count <= 0;
						--clkOut <= '1';
					--else
						--count <= count +1;
						--clkOut <= '0';
					--end if;
				
					if count2 = 1 then
						--count2 <= maxV;
						count2 <= -10;
						passage := '1';
						clkOut <= '1';
					else
						count2 <= count2 -1;
						clkOut <= '0';
					end if;
				end if;
			elsif stdby ='1' then
				temp <= 0;
				temp2 <= 0;
				passage := '1';
			end if;
		end if;
		if stdby = '0' then
			temp <= count2 /10;
			temp2 <= count2 mod 10;
			dizaine <= std_logic_vector(to_unsigned(temp, 4));
			unite <= std_logic_vector(to_unsigned(temp2, 4));
		end if;
		valeur <= count2;
	end process;
	
	
end structural;