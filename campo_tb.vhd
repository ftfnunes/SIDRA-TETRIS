library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity campo_tb is
end campo_tb;

architecture testbench of campo_tb is
	component campo is
	port ( w_en, clk, rst_geral, collision: in std_logic;
			 i_vga : in integer range 0 to 19;
			 j_vga : in integer range 0 to 9;
			 i_write : in integer range 0 to 19;
			 j_write : in integer range 0 to 9; 
			 i_read : in integer range 0 to 19; 
			 j_read : in integer range 0 to 9; 
			 data_in : in std_logic;
			 data_out_vga : out std_logic := '0';
			 data_out_read : out std_logic := '0';
			 speedup : buffer std_logic := '0';
			 score3, score2, score1, score0 : buffer integer range 0 to 9 := 2);
	end component;
	
	signal clk : std_logic;
	signal score3, score2, score1, score0 : integer range 0 to 9;
	signal d_out_vga, d_out, d_in, speedup : STD_LOGIC;
	signal collision, w_en : STD_LOGIC;
	signal i_vga, i_r, i_wr : integer range 0 to 19;
	signal j_vga, j_r, j_wr : integer range 0 to 9;
	--signal score3_7seg, score2_7seg, score1_7seg, score0_7seg : std_logic_vector(6 downto 0);
	
begin
	i1: campo port map (w_en, clk, '0', collision, i_vga, j_vga, i_wr, j_wr, i_r, j_r, d_in, d_out_vga, d_out, speedup, score3, score2, score1, score0);
	
	process begin
		for I in 0 to 5000 loop
			clk <= '0'; wait for 10 ns;
			clk <= '1'; wait for 10 ns;
		end loop;
		wait;
	end process;
end testbench;