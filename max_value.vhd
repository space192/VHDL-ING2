library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;


entity max_value is
	port(
		clock, stdby : in std_logic;
		maxV : out integer;
		--LEDR1, LEDO1, LEDV1, LEDR2, LEDO2, LEDV2 : out std_logic;
		TAB_LED1, TAB_LED2 : out std_logic_vector(0 to 7);
		result, result2 : out std_logic_vector(7 downto 0);
		selecBuzzer : out std_logic_vector(0 to 1);
		signal counter : inout integer := 0;
		maxV1, maxV2, maxV3,maxV4: in integer;
		total : in std_logic_vector(3 downto 0));
end max_value;


architecture structural of max_value is
signal temp : std_logic_vector(0 to 3);
begin
	process(clock)
	begin
		if stdby = '0' then
			if clock'event and clock = '1' then
				if counter = 3 then
					counter <= 0;
				elsif not(counter = 4) then
					counter <= counter + 1;
				end if;
			end if;
		end if;
	end process;
	process(counter,stdby)
	begin
		if stdby ='0' then
			if counter = 0 then -- feu 1 au rouge et feu 2 au vert
				--maxV <= maxV1;
				if total(0) = '1' then
					maxV <= maxV1;
				else
					maxV <= 30;
				end if;
				temp <= "0001"; -- temp est responsable de l'affiche de l'état de la machine de moore
				--LEDR1 <= '1'; LEDO1 <= '0'; LEDV1 <= '0'; LEDR2 <= '0'; LEDO2 <= '0'; LEDV2 <= '1';
				TAB_LED1 <= "01001000";
				TAB_LED2 <= "00010100";
				selecBuzzer <= "11";
			elsif counter = 1 then -- feu 1 au rouge et feu 2 au orange
				--maxV <= maxV2;
				if total(1) = '1' then
					maxV <= maxV2;
				else
					maxV <= 5;
				end if;
				temp <= "0010";
				--LEDR1 <= '1'; LEDO1 <= '0'; LEDV1 <= '0'; LEDR2 <= '0'; LEDO2 <= '1'; LEDV2 <= '0';
				TAB_LED1 <= "01001000";
				TAB_LED2 <= "00100100";
				selecBuzzer <= "01";
			elsif counter = 2 then --feu 1 au vert et feu 2 au rouge
				--maxV <= maxV3;
				if total(2) = '1' then
					maxV <= maxV3;
				else
					maxV <= 45;
				end if;
				temp <= "0011";
				--LEDR1 <= '0'; LEDO1 <= '0'; LEDV1 <= '1'; LEDR2 <= '1'; LEDO2 <= '0'; LEDV2 <= '0';
				TAB_LED1 <= "00010100";
				TAB_LED2 <= "01001000";
				selecBuzzer <= "11";
			elsif counter = 3 then -- feu 1 au orange et feu 2 au rouge
				--maxV <= maxv4;
				if total(3) = '1' then
					maxV <= maxV4;
				else
					maxV <= 5;
				end if;
				temp <= "0100";
				--LEDR1 <= '0'; LEDO1 <= '1'; LEDV1 <= '0'; LEDR2 <= '1'; LEDO2 <= '0'; LEDV2 <= '0';
				TAB_LED1 <= "00100100";
				TAB_LED2 <= "01001000";
				selecBuzzer <= "00";
			end if;
		elsif stdby = '1' then
			temp <= "0101";
		end if;
	end process;
	
	fState : entity work.afficheur(structural)
	port map(valeur => temp, resultS => result);
	fState2 : entity work.afficheur(structural)
	port map(valeur => "0000", resultS => result2);
end structural;