library IEEE;
use ieee.std_logic_1164.all;
use work.all;


entity clockM is 
	generic(	
		max : in INTEGER);
	port(
		signal clkS : in std_logic;
		signal clockout : out std_logic);
end clockM;


architecture structural of clockM is
signal num : INTEGER range 0 to max := 0;
begin
	process(clkS)
	begin
		if clkS'event and clkS = '1' then
			if num = max-1 then
				num <= 0;
				clockout <= '1';
			else
				num <= num + 1;
				clockout <= '0';
			end if;
		end if;
	end  process;
end structural;