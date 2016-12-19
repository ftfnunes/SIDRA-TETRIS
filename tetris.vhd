LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity tetris is PORT(
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
end tetris;

architecture behavior of tetris is
COMPONENT vga_controller IS
	PORT(
		pixel_clk	:	IN		STD_LOGIC;	--pixel clock at frequency of VGA mode being used
		reset_n		:	IN		STD_LOGIC;	--active low asycnchronous reset
		h_sync		:	OUT	STD_LOGIC;	--horiztonal sync pulse
		v_sync		:	OUT	STD_LOGIC;	--vertical sync pulse
		disp_ena		:	OUT	STD_LOGIC;	--display enable ('1' = display time, '0' = blanking time)
		column		:	OUT	INTEGER;		--horizontal pixel coordinate
		row			:	OUT	INTEGER;		--vertical pixel coordinate
		n_blank		:	OUT	STD_LOGIC;	--direct blacking output to DAC
		n_sync		:	OUT	STD_LOGIC); --sync-on-green output to DAC
END COMPONENT;
COMPONENT image_generator IS
  PORT(
    disp_ena 			:  IN   STD_LOGIC;  --display enable ('1' = display time, '0' = blanking time)
    row      			:  IN   INTEGER;    --row pixel coordinate
    column   			:  IN   INTEGER;    --column pixel coordinate
    i1_active, i2_active, i3_active, i4_active : IN INTEGER RANGE -2 TO 19;
	 j1_active, j2_active, j3_active, j4_active : IN INTEGER RANGE 0 TO 9;
	 ff_mat_status 	:	IN STD_LOGIC;
	 red      			:  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');  --red magnitude output to DAC
    green    			:  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');  --green magnitude output to DAC
    blue     			:	OUT  STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0'); --blue magnitude output to DAC
	 i 					: 	OUT INTEGER range -2 to 19;
	 j 					: 	OUT INTEGER range 0 to 9);
END COMPONENT;

component pll IS
	PORT
	(
		areset		: IN STD_LOGIC  := '0';
		inclk0		: IN STD_LOGIC  := '0';
		c0		: OUT STD_LOGIC 
	);
END component;
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
			 score3, score2, score1, score0 : buffer integer range 0 to 9 := 0);
end component;

component active_block is
	port(
		clk, control_clk, start, collision, wren, right_move, left_move: in std_logic;
		block_type: in integer range 0 to 6;
		i1, i2 , i3, i4: in integer range -2 to 19;
		j1, j2, j3, j4: in integer range 0 to 9;
		i1out, i2out , i3out, i4out: out integer range -2 to 19;
		j1out, j2out, j3out, j4out: out integer range 0 to 9
	);
end component;

component random_uniform is
    generic (OUT_WIDTH : integer := 11);
   Port ( clk : in  STD_LOGIC;
           random : out  integer range 0 to (OUT_WIDTH-1);
            SEED : in STD_LOGIC_VECTOR(30 downto 0):= (others => '0');
			  reset : in  STD_LOGIC);
end component;

component bcd_to_7seg is
port (clk : in std_logic;
      bcd : in integer range 0 to 9;  --BCD input
      segment7 : out std_logic_vector(6 downto 0)  -- 7 bit decoded output.
     );
end component;

signal row, column : INTEGER;
signal c0, d_en, d_out_vga, d_out, d_in, rnd_rst, speedup : STD_LOGIC;
signal collision, w_en, control_clk, start, wren_active, r_m, l_m: STD_LOGIC := '0';
signal i1_active, i2_active, i3_active, i4_active, i1, i2, i3, i4 : INTEGER range -2 to 19;
signal j1_active, j2_active, j3_active, j4_active, j1, j2, j3, j4 : INTEGER range 0 to 9;
signal i_vga, i_r, i_wr : integer range 0 to 19;
signal j_vga, j_r, j_wr : integer range 0 to 9;
signal score3, score2, score1, score0 : integer range 0 to 9;
signal block_type : integer range 0 to 6;
signal seed : STD_LOGIC_VECTOR(30 downto 0); 

begin

	pixel_clk <= c0;
	
	p: pll port map ('0', clk, c0);
	c: vga_controller port map (c0, '1', h_sync, v_sync, d_en, column, row, n_blank, n_sync);
	ig: image_generator port map (d_en, row, column,  i1_active, i2_active, i3_active, i4_active, j1_active, j2_active, j3_active, j4_active, d_out_vga, red, green, blue, i_vga, j_vga);
	t : campo port map (w_en, tst_clk, '0', collision, i_vga, j_vga, i_wr, j_wr, i_r, j_r, d_in, d_out_vga, d_out, speedup, score3, score2, score1, score0);
	ab : active_block port map (tst_clk, control_clk, start, collision, wren_active, r_m, l_m, block_type, i1, i2, i3, i4, j1, j2, j3, j4, i1_active, i2_active, i3_active, i4_active, j1_active, j2_active, j3_active, j4_active);
	rand : random_uniform port map (clk, block_type, seed, rnd_rst);
	bcd_to_7seg_3 : bcd_to_7seg port map (tst_clk, score3, score3_7seg);
	bcd_to_7seg_2 : bcd_to_7seg port map (tst_clk, score2, score2_7seg);
	bcd_to_7seg_1 : bcd_to_7seg port map (tst_clk, score1, score1_7seg);
	bcd_to_7seg_0 : bcd_to_7seg port map (tst_clk, score0, score0_7seg);
	
	
	teste_campo: process(clk)
		variable cont : INTEGER := 0;
	begin
		if(rising_edge(tst_clk)) then
			if(cont = 0) then
				rnd_rst <= '1';
				w_en <= '1';
				i_wr <= 19;
				j_wr <= 0;
				d_in <= '1';
				collision <= '0';
				cont := cont + 1;
			elsif(cont = 1) then
				w_en <= '1';
				rnd_rst <= '0';
				i_wr <= 19;
				j_wr <= 1;
				d_in <= '1';
				collision <= '0';
				cont := cont + 1;
			elsif(cont = 2) then
				w_en <= '1';
				i_wr <= 19;
				j_wr <= 2;
				d_in <= '1';
				collision <= '0';
				cont := cont + 1;
			elsif(cont = 3) then
				w_en <= '1';
				i_wr <= 19;
				j_wr <= 3;
				d_in <= '1';
				collision <= '0';
				cont := cont + 1;
			elsif(cont = 4) then
				w_en <= '1';
				i_wr <= 19;
				j_wr <= 4;
				d_in <= '1';
				collision <= '0';
				cont := cont + 1;
			elsif(cont = 5) then
				w_en <= '1';
				i_wr <= 19;
				j_wr <= 5;
				d_in <= '1';
				collision <= '0';
				cont := cont + 1;
			elsif(cont = 6) then
				w_en <= '1';
				i_wr <= 19;
				j_wr <= 6;
				d_in <= '1';
				collision <= '0';
				cont := cont + 1;
			elsif(cont = 7) then
				w_en <= '1';
				i_wr <= 19;
				j_wr <= 7;
				d_in <= '1';
				collision <= '0';
				cont := cont + 1;
			elsif(cont = 8) then
				w_en <= '1';
				i_wr <= 19;
				j_wr <= 8;
				d_in <= '1';
				collision <= '0';
				cont := cont + 1;
			elsif(cont = 9) then
				w_en <= '1';
				i_wr <= 19;
				j_wr <= 9;
				d_in <= '1';
				collision <= '0';
				cont := cont + 1;
			elsif(cont = 10) then
				w_en <= '1';
				i_wr <= 17;
				j_wr <= 0;
				d_in <= '1';
				collision <= '0';
				cont := cont + 1;
			elsif(cont = 11) then
				w_en <= '1';
				i_wr <= 17;
				j_wr <= 1;
				d_in <= '1';
				collision <= '0';
				cont := cont + 1;
			elsif(cont = 12) then
				w_en <= '1';
				i_wr <= 17;
				j_wr <= 2;
				d_in <= '1';
				collision <= '0';
				cont := cont + 1;
			elsif(cont = 13) then
				w_en <= '1';
				i_wr <= 17;
				j_wr <= 3;
				d_in <= '1';
				collision <= '0';
				cont := cont + 1;
			elsif(cont = 14) then
				w_en <= '1';
				i_wr <= 17;
				j_wr <= 4;
				d_in <= '1';
				collision <= '0';
				cont := cont + 1;
			elsif(cont = 15) then
				w_en <= '1';
				i_wr <= 17;
				j_wr <= 5;
				d_in <= '1';
				collision <= '0';
				cont := cont + 1;
			elsif(cont = 16) then
				w_en <= '1';
				i_wr <= 17;
				j_wr <= 6;
				d_in <= '1';
				collision <= '0';
				cont := cont + 1;
			elsif(cont = 17) then
				w_en <= '1';
				i_wr <= 17;
				j_wr <= 7;
				d_in <= '1';
				collision <= '0';
				cont := cont + 1;
			elsif(cont = 18) then
				w_en <= '1';
				i_wr <= 17;
				j_wr <= 8;
				d_in <= '1';
				collision <= '0';
				cont := cont + 1;
			elsif(cont = 19) then
				w_en <= '1';
				i_wr <= 17;
				j_wr <= 9;
				d_in <= '1';
				collision <= '0';
				cont := cont + 1;
			elsif (cont = 20) then
				w_en <= '1';
				i_wr <= 18;
				j_wr <= 3;
				d_in <= '1';
				cont := cont + 1;
				collision <= '0';
			elsif (cont = 21) then
				w_en <= '1';
				i_wr <= 16;
				j_wr <= 3;
				d_in <= '1';
				cont := cont + 1;
				collision <= '0';
			elsif (cont = 22) then
				d_in <= '0';
				w_en <= '0';
				cont := cont + 1;
				
				collision <= '1';
			elsif (cont < 27) then
				cont := cont + 1;
				collision <= '0';
				control_clk <= '1';
			elsif (cont = 27) then
				cont := cont + 1;
				control_clk <= '0';
				collision <= '0';
				l_m <= '1';
			end if;
		end if;
	end process;
	
end behavior;