library IEEE;
use ieee.std_logic_1164.all;
use work.all;


entity Sirene is
	generic(
			max : in integer := 0;
			max2 : in integer := 0);
	port(
		clk : in std_logic;
		selec : in std_logic_vector(0 to 1);
		buzzer : out std_logic;
		valeur : in integer);
end Sirene;


architecture structural of Sirene is
begin
	process(clk)
	variable temp : integer := 0;
	variable temp2 : integer := 0;
	variable switch : std_logic := '1';
	begin
		if rising_edge(clk) then
			if valeur <= 5 and (selec = "00" or selec = "01") then
				if temp2 <= (valeur * 5000000) then
					temp2 := temp2+1;
					switch := '1';
				elsif temp2 > (valeur * 5000000) and temp2 < (valeur * 10000000) then
					temp2 := temp2 +1;
					switch := '0';
				elsif temp2 >= (valeur * 10000000) then
					temp2 := 0;
					switch := '0';
				end if;
			elsif valeur = 0 then
				switch := '0';
			else
				switch := '0';
			end if;
			if selec = "00" then
				if temp <= (max/2) then
					temp := temp + 1;
					if switch = '1' then
						buzzer <= '1';
					end if;
				elsif temp > (max/2) and temp < max then
					buzzer <= '0';
					temp := temp + 1;
				elsif temp >= max then
					temp := 0;
					buzzer <= '0';
				end if;
			elsif selec = "01" then
				if temp <= (max2/2) then
					temp := temp + 1;
					if switch = '1' then
						buzzer <= '1';
					end if;
				elsif temp > (max2/2) and temp < max2 then
					buzzer <= '0';
					temp := temp + 1;
				elsif temp >= max2 then
					temp := 0;
					buzzer <= '0';
				end if;
			elsif selec = "11" then
				temp := 0;
				buzzer <= '0';
			end if;
		end if;
	end process;
end structural;
		