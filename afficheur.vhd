library IEEE;
use ieee.std_logic_1164.all;
use work.all;

entity afficheur is port(
	valeur : in std_logic_vector(0 to 3);
	enable : in std_logic := '1';
	signal resultS : out std_logic_vector(7 downto 0));
end afficheur;


architecture structural of afficheur is
begin
	process(valeur)
	begin
	if enable = '1' then
		if (valeur = "0000") then
			resultS <= "11000000";
		elsif (valeur = "0001") then
			resultS <= "11111001";
		elsif (valeur = "0010") then
			resultS <= "10100100";
		elsif (valeur = "0011") then
			resultS <= "10110000";
		elsif (valeur = "0100") then
			resultS <= "10011001";
		elsif (valeur = "0101") then
			resultS <= "10010010";
		elsif (valeur = "0110") then
			resultS <= "10000010";
		elsif (valeur = "0111") then
			resultS <= "11111000";
		elsif (valeur = "1000") then
			resultS <= "10000000";
		elsif (valeur = "1001") then
			resultS <= "10010000";
		end if;
	else
		resultS <= "11000000";
	end if;
	end process;
end structural;