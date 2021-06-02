library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity top_level_ADC is
	port(
		clk : in std_logic;
		output, output2, output3 : out std_logic_vector(3 downto 0));
end entity;


architecture structural of top_level_ADC is
	component hello_adc is
        port (
            --  adc_control_core_command.valid
            adc_control_core_command_valid          : in  std_logic;
            -- .channel
            adc_control_core_command_channel        : in  std_logic_vector(4 downto 0) := (others => '0');
            -- .startofpacket
            adc_control_core_command_startofpacket  : in  std_logic := '0';
            -- .endofpacket
            adc_control_core_command_endofpacket    : in  std_logic := '0';
            -- .ready
            adc_control_core_command_ready          : out std_logic;
            -- adc_control_core_response.valid
            adc_control_core_response_valid         : out std_logic;
            -- .channel
            adc_control_core_response_channel       : out std_logic_vector(4 downto 0);
            -- .data
            adc_control_core_response_data          : out std_logic_vector(11 downto 0);
            -- .startofpacket
            adc_control_core_response_startofpacket : out std_logic;
            -- .endofpacket
            adc_control_core_response_endofpacket   : out std_logic;
            -- clk.clk
            clk_clk                                 : in  std_logic := '0';
            -- clock_bridge_out_clk.clk
            clock_bridge_out_clk_clk                : out std_logic;
            -- reset.reset_n
            reset_reset_n                           : in  std_logic := '0'
        );
    end component hello_adc;
	 
	 
	 component adc_sample_to_BCD is
        port (
            adc_sample  : in std_logic_vector(11 downto 0);
            vol         : out std_logic_vector(12 downto 0);
            ones        : out std_logic_vector(3 downto 0);
            tenths      : out std_logic_vector(3 downto 0);
            hundredths  : out std_logic_vector(3 downto 0);
            thousandths : out std_logic_vector(3 downto 0)
        );
    end component;
	 
	 
	 signal req_channel, cur_channel : std_logic_vector(4 downto 0);
    signal sample_data              : std_logic_vector(11 downto 0);
    signal adc_cc_command_ready     : std_logic;
    signal adc_cc_response_valid    : std_logic;
    signal adc_cc_response_channel  : std_logic_vector(4 downto 0);
    signal adc_cc_response_data     : std_logic_vector(11 downto 0);

    -- BCD signals
    signal ones        : std_logic_vector(3 downto 0);
    signal tenths      : std_logic_vector(3 downto 0);
    signal hundredths  : std_logic_vector(3 downto 0);
    signal thousandths : std_logic_vector(3 downto 0);
	 
	 
	 signal sys_clk, nreset, reset : std_logic;
begin
	reset <= '0';
   nreset <= not reset;
	
	adc_command : process(sys_clk, adc_cc_command_ready)
        variable temp : std_logic_vector(4 downto 0) := (others => '0');
    begin
        if rising_edge(sys_clk) then
            if (adc_cc_command_ready = '1') then
                temp(2 downto 0) := "001";
            end if;
        end if;
        req_channel <= temp;
    end process;
	
	adc_read : process(sys_clk, adc_cc_response_valid)
        variable reading : std_logic_vector(11 downto 0) := (others => '0');
        variable ch      : std_logic_vector(4 downto 0) := (others => '0');
    begin
        if rising_edge(sys_clk) then
            if (adc_cc_response_valid = '1') then
                reading := adc_cc_response_data;
                ch := adc_cc_response_channel;
            end if;
        end if;
        cur_channel <= ch;
        sample_data <= reading;
    end process;
	 
	 adc_sample_to_BCD_conv : adc_sample_to_BCD
    port map (
        adc_sample => sample_data,
        vol => open,
        ones => ones,
        tenths => tenths,
        hundredths => hundredths,
        thousandths => thousandths
    );
	 
	 qsys_u0 : component hello_adc
    port map (
        -- command always valid
        adc_control_core_command_valid => '1',
        adc_control_core_command_channel => req_channel,
        -- startofpacket and endofpacket are ignored in adc_control_core
        adc_control_core_command_startofpacket => '1',
        adc_control_core_command_endofpacket => '1',
        adc_control_core_command_ready => adc_cc_command_ready,
        adc_control_core_response_valid => adc_cc_response_valid,
        adc_control_core_response_channel => adc_cc_response_channel,
        adc_control_core_response_data => adc_cc_response_data,
        adc_control_core_response_startofpacket => open,
        adc_control_core_response_endofpacket => open,
        clk_clk => clk,
        clock_bridge_out_clk_clk => sys_clk,
        reset_reset_n => nreset
    );
	 output <= ones;
	 output2 <= tenths;
	 output3 <= hundredths;
end architecture structural;