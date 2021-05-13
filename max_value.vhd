library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;


entity max_value is
	port(
		clock : in std_logic;
		maxV : out integer;
		--LEDR1, LEDO1, LEDV1, LEDR2, LEDO2, LEDV2 : out std_logic;
		result, result2 : out std_logic_vector(7 downto 0);
		signal counter : inout integer := 0);
end max_value;


architecture structural of max_value is
signal temp : std_logic_vector(0 to 3);
begin
	process(clock)
	begin
		if clock'event and clock = '1' then
			if counter = 3 then
				counter <= 0;
			else
				counter <= counter + 1;
			end if;
		end if;
	end process;
	process(counter)
	begin
		if counter = 0 then -- feu 1 au rouge et feu 2 au vert
			maxV <= 30;
			temp <= "0001";
			--LEDR1 <= '1'; LEDO1 <= '0'; LEDV1 <= '0'; LEDR2 <= '0'; LEDO2 <= '0'; LEDV2 <= '1';
		elsif counter = 1 then -- feu 1 au rouge et feu 2 au orange
			maxV <= 5;
			temp <= "0010";
			--LEDR1 <= '1'; LEDO1 <= '0'; LEDV1 <= '0'; LEDR2 <= '0'; LEDO2 <= '1'; LEDV2 <= '0';
		elsif counter = 2 then --feu 1 au vert et feu 2 au rouge
			maxV <= 45;
			temp <= "0011";
			--LEDR1 <= '0'; LEDO1 <= '0'; LEDV1 <= '1'; LEDR2 <= '1'; LEDO2 <= '0'; LEDV2 <= '0';
		elsif counter = 3 then -- feu 1 au orange et feu 2 au rouge
			maxV <= 5;
			temp <= "0100";
			--LEDR1 <= '0'; LEDO1 <= '1'; LEDV1 <= '0'; LEDR2 <= '1'; LEDO2 <= '0'; LEDV2 <= '0';
		elsif counter = 5 then
			maxV <= 0;
			temp <= "0101";
		end if;
	end process;
	fState : entity afficheur(structural)
	port map(valeur => temp, resultS => result);
	fState2 : entity afficheur(structural)
	port map(valeur => "0000", resultS => result2);
end structural;