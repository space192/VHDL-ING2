library IEEE;
use ieee.std_logic_1164.all;
use work.all;


entity RegisterLED is
	port(
	valeur : in std_logic_vector(0 to 7);
	SER : out std_logic;
	SCLK : out std_logic;
	SRCLK : out std_logic);
end RegisterLED;


architecture structural of registerLED is
begin
	process(valeur)
	variable N : integer := 0;
	begin
		SCLK <= '0';
		for N in 0 to 7 loop
			SRCLK <= '0';
			SER <= valeur(N);
			SRCLK <= '1';
		end loop;
		SCLK <= '1';
	end process;
end structural;