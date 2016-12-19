library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity teste_tb is
end teste_tb;

architecture testbench of teste_tb is
	component teste is
	port (tst_clk : in std_logic;
			speed : out std_logic;
			score3, score2, score1, score0 : buffer integer range 0 to 9;
			score3_7seg, score2_7seg, score1_7seg, score0_7seg : out std_logic_vector(6 downto 0)  -- 7 bit decoded output.
		  );
	end component;
	
	signal tst_clk, speed : std_logic;
	signal score3, score2, score1, score0 : integer range 0 to 9;
	signal score3_7seg, score2_7seg, score1_7seg, score0_7seg : std_logic_vector(6 downto 0);
	
begin
	i1: teste port map(tst_clk, speed, score3, score2, score1, score0, score3_7seg, score2_7seg, score1_7seg, score0_7seg);
	
	process begin
		for I in 0 to 5000 loop
			tst_clk <= '0'; wait for 10 ns;
			tst_clk <= '1'; wait for 10 ns;
		end loop;
		wait;
	end process;
end testbench;