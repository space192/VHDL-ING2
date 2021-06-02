library IEEE;
use ieee.std_logic_1164.all;
use work.all;
use ieee.numeric_std.all;

entity changementValeur is
port(
	unite, dizieme, centieme : in std_logic_vector(3 downto 0);
	dizaine, unites : out std_logic_vector(0 to 3);
	--maxV : out integer;
	stdby : in std_logic;
	SW : in std_logic_vector(3 downto 0);
	out1,out2,out3,out4 : out integer);
end entity;


architecture structural of changementValeur is
signal temp : integer;
begin
	process(stdby, SW, unite, dizieme)
	begin
		if stdby = '1' then
			if not(SW = "0000") then
				temp <= ((((to_integer(unsigned(unite))*10) + to_integer(unsigned(dizieme)))*20625)/10000);
				dizaine <= std_logic_vector(to_unsigned(temp / 10, 4));
				unites <= std_logic_vector(to_unsigned(temp mod 10, 4));
			end if;
			if SW(0) = '1' then
				out1 <= temp;
			end if;
			if SW(1) = '1' then
				out2 <= temp;
			end if;
			if SW(2) = '1' then
				out3 <= temp;
			end if;
			if SW(3) = '1' then
				out4 <= temp;
			end if;
		end if;
	end process;
end structural;
