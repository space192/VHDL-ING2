library IEEE;
use ieee.std_logic_1164.all;
use work.all;


entity RegisterLED is
	port(
	clk : in std_logic;
	valeur : in std_logic_vector(0 to 7);
	SER : out std_logic;
	SCLK : out std_logic;
	SRCLK : inout std_logic);
end RegisterLED;


architecture structural of registerLED is
signal counter : integer := 7;
begin
	process(valeur)
	begin
	end process;
	process(clk)
	begin
		if clk'event and clk ='1' then
			if SRCLK = '1' then
				if counter = 0 then
					counter <= 7;
					SCLK <= '1';
				elsif counter = 7 then
					SCLK <= '0';
					counter <= counter -1;
				else
					counter <= counter -1;
				end if;
				SRCLK <= '0';
			else
				SER <= valeur(counter);
				SRCLK <= '1';
			end if;
		end if;
	end process;
end structural;