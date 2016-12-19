library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity teste is
port (tst_clk : in std_logic;
		speed : buffer std_logic;
      score3, score2, score1, score0 : buffer integer range 0 to 9;
      score3_7seg, score2_7seg, score1_7seg, score0_7seg : out std_logic_vector(6 downto 0)  -- 7 bit decoded output.
     );
end teste;
architecture Behavioral of teste is

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

	component bcd_to_7seg is
	port (clk : in std_logic;
      bcd : in integer range 0 to 9;  --BCD input
      segment7 : out std_logic_vector(6 downto 0)  -- 7 bit decoded output.
     );
	end component;
	
signal d_out_vga, d_out, d_in, speedup : STD_LOGIC;
signal collision, w_en : STD_LOGIC;
signal i_vga, i_r, i_wr : integer range 0 to 19;
signal j_vga, j_r, j_wr : integer range 0 to 9;

begin
	i1 : campo port map (w_en, tst_clk, '0', collision, i_vga, j_vga, i_wr, j_wr, i_r, j_r, d_in, d_out_vga, d_out, speed, score3, score2, score1, score0);

	bcd_to_7seg_3 : bcd_to_7seg port map (tst_clk, score3, score3_7seg);
	bcd_to_7seg_2 : bcd_to_7seg port map (tst_clk, score2, score2_7seg);
	bcd_to_7seg_1 : bcd_to_7seg port map (tst_clk, score1, score1_7seg);
	bcd_to_7seg_0 : bcd_to_7seg port map (tst_clk, score0, score0_7seg);

end Behavioral;