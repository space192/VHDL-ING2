library IEEE;
use ieee.std_logic_1164.all;
use work.all;


entity AffichageTemps is 
	port(
		signal enable1, enable2 : out std_logic;
		signal compteur : in integer);
end AffichageTemps;


architecture structural of AffichageTemps is
begin
	process(compteur)
	begin
		if compteur = 0 or compteur = 1 then
			enable1 <= '1';
			enable2 <= '0';
		elsif compteur = 2 or compteur = 3 then
			enable1 <= '0';
			enable2 <= '1';
		end if;
	end  process;
end structural;