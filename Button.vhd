library IEEE;
use ieee.std_logic_1164.all;
use work.all;

entity debounce is
    port(
        inp : in STD_LOGIC;
        cclk : in STD_LOGIC;
        outp : inout STD_LOGIC
        );
end debounce;

architecture structural of debounce is 
signal delay:STD_LOGIC;
signal count : integer := 0;
begin
    process(cclk)
    begin
        if cclk'event and cclk = '1'  then
            if(inp = '1') then
                delay <= '0';
            else 
                delay <= '1';
                     if(count = 0) then
                         count <= 1;
                     else 
                         count <= 0;
                         end if;
                end if;
        end if;
		   if(count = 0) then
        outp <= delay;
     else
         outp <= '1';
     end if;
    end process;
    
end structural;