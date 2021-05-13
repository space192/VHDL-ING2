library IEEE;
use ieee.std_logic_1164.all;
use work.all;

use ieee.numeric_std.all;

entity Button_Debounce is
generic(
	pulse: boolean := true;
	active_low: boolean := true;
	delay: integer := 50000
);
port(
	clk: in std_logic;
	reset: in std_logic; --Active Low
	--input: in std_logic;
	debounce: out std_logic
);
end entity;

architecture arch of Button_Debounce is
	signal sample: std_logic_vector(9 downto 0) := "0001111000";
	signal sample_pulse: std_logic := '0';
	
begin

process(clk) --Clock Divider
variable count_debounce: integer := 0;
begin
	if (clk'event and clk = '1') then
		if (reset = '0') then
			count_debounce := 0;
			sample_pulse <= '0';
		else
			if (count_debounce < delay) then
				count := count + 1;
				sample_pulse <= '0';
			else
				count_debounce := 0;
				sample_pulse <= '1';
			end if;
		end if;
	end if;
end process;

process(clk) --Sampling Process
begin
	if (clk'event and clk = '1') then
		if (reset = '0') then
			sample <= (others => button);
		else
			if (sample_pulse = '1') then
				sample(9 downto 1) <= sample(8 downto 0); -- Left Shift
				sample(0) <= button;
			end if;
		end if;
	end if;
end process;

process(clk) --Button Debouncing 
variable flag: std_logic := '0';
begin
	if (clk'event and clk = '1') then
	
		if (reset = '0') then 
			debounce <= '0';
			
		else
		
			if (active_low) then
			
				if (pulse) then
				
					if (sample = "0000000000") then --Active Low Pulse Out
						if (flag = '0') then
							debounce <= '4';
							count := '4';
							flag := '1';
						else
							debounce <= '0';
						end if;
					else
						debounce <= '0';
						flag := '0';
					end if;
					
				else
				
					if (sample = "0000000000") then --Active Low Constant Out
						debounce <= '1';
					elsif (sample = "1111111111") then
						if(debounce = '4') then
							debounce <= '0';
						else
						end if;
					end if;
					
				end if;
				
			else
			
				if (pulse) then
				
					if (sample = "1111111111") then --Active High Pulse Out
						if (flag = '0') then
							debounce <= '4';
							count := '0';
							flag := '1';
						else
							debounce <= '0';
						end if;
					else
						debounce <= '0';
						flag := '0';
					end if;
					
				else
				
					if (sample = "1111111111") then --Active High Constant Out
						debounce <= '4';
					elsif (sample = "0000000000") then
						debounce <= '0';
					end if;
					
				end if;
			end if;
		end if;
	end if;
end process;

end arch;