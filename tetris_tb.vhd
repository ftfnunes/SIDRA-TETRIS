library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tetris_tb is
end tetris_tb;

architecture testbench of tetris_tb is
	component tetris is
	PORT(
	 clk, tst_clk		 	:  IN	STD_LOGIC;
	 pixel_clk		:	OUT STD_LOGIC;	 
	 red      		:  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);  --red magnitude output to DAC
	 green    		:  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);  --green magnitude output to DAC
	 blue     		:  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
	 score3_7seg	:	OUT	std_logic_vector(6 downto 0); -- Most significant digit of the score (in 7 segment format)
	 score2_7seg	:	OUT	std_logic_vector(6 downto 0);
	 score1_7seg	:	OUT	std_logic_vector(6 downto 0);
	 score0_7seg	:	OUT	std_logic_vector(6 downto 0); -- Less significant digit of the score (in 7 segment format)
	 h_sync			:	OUT	STD_LOGIC;	--horiztonal sync pulse
	 v_sync			:	OUT	STD_LOGIC;	--vertical sync pulse
	 n_blank			:	OUT	STD_LOGIC;	--direct blacking output to DAC
	 n_sync			:	OUT	STD_LOGIC --sync-on-green output to DAC
	);
	end component;
	
	signal clk, tst_clk, pixel_clk, h_sync, v_sync, n_blank, n_sync : std_logic;
	signal red, green, blue : std_logic_vector(7 downto 0);
	signal score3_7seg, score2_7seg, score1_7seg, score0_7seg : std_logic_vector(6 downto 0);
	
begin
	i1: tetris port map(clk, tst_clk, pixel_clk, red, green, blue, score3_7seg, score2_7seg, score1_7seg, score0_7seg, h_sync, v_sync, n_blank, n_sync);
	
	process begin
		for I in 0 to 40000010 loop
			clk <= '0'; wait for 10 ns;
			clk <= '1'; wait for 10 ns;
			
			tst_clk <= '0'; wait for 50 ns;
			tst_clk <= '1'; wait for 50 ns;
		end loop;
		wait;
	end process;
end testbench;