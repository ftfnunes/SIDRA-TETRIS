library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity timer_tb is
end timer_tb;

architecture testbench of timer_tb is
	component timer is
	port ( clk, speedup : in std_logic;
			 control_clk, collision_clk : out std_logic := '0');
	end component;
	
	signal clk, speedup, control_clk, collision_clk : std_logic;
	
begin
	i1: timer port map(clk, speedup, control_clk, collision_clk);
	
	process begin
		for I in 0 to 40000010 loop
			clk <= '0'; wait for 10 ns;
			clk <= '1'; wait for 10 ns;
		end loop;
		wait;
	end process;
end testbench;