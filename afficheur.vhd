library IEEE;
use ieee.std_logic_1164.all;
use work.all;

entity afficheur is port(
	valeur : in std_logic_vector(0 to 3);
	valeur2 : in std_logic_vector(0 to 3):= "1111";
	enable : in std_logic := '1';
	stdby : in std_logic := '0';
	signal resultS : out std_logic_vector(7 downto 0));
end afficheur;


architecture structural of afficheur is
begin
	process(valeur, valeur2, enable, stdby)
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
		else
			resultS <= "11000000";
		end if;
	elsif stdby = '1' and enable = '0' then
		--resultS <= "11000000";
		if (valeur2 = "0000") then
			resultS <= "11000000";
		elsif (valeur2 = "0001") then
			resultS <= "11111001";
		elsif (valeur2 = "0010") then
			resultS <= "10100100";
		elsif (valeur2 = "0011") then
			resultS <= "10110000";
		elsif (valeur2 = "0100") then
			resultS <= "10011001";
		elsif (valeur2 = "0101") then
			resultS <= "10010010";
		elsif (valeur2 = "0110") then
			resultS <= "10000010";
		elsif (valeur2 = "0111") then
			resultS <= "11111000";
		elsif (valeur2 = "1000") then
			resultS <= "10000000";
		elsif (valeur2 = "1001") then
			resultS <= "10010000";
		elsif (valeur2 = "1111") then
			resultS <= "11000000";
		end if;
	elsif enable = '0' and stdby = '0' then
		resultS <= "11000000";
	end if;
	end process;
end structural;