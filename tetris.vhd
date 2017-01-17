LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity tetris is PORT(
	 clk, tst_clk, right_b, left_b, down_b, rotate_b	:  IN	STD_LOGIC;
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
	 n_sync			:	OUT	STD_LOGIC; --sync-on-green output to DAC
	 turnoff_dot	:	OUT	STD_LOGIC_VECTOR(3 downto 0); --signals used to turn off the dot from the 7 segment display
	 bt_7seg_left	:	OUT	std_logic_vector(0 to 7); --7seg display that draws next type of the next block
	 bt_7seg_right	:	OUT	std_logic_vector(0 to 7);
	 sgmt_block_number : out std_logic_vector(0 to 7); --number of the next block
	 r_sHEX 				:	out std_logiC_VECTOR (6 downto 0);
	 coll				:	out std_logic
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
			 i_read1 : in integer range 0 to 19; 
			 j_read1 : in integer range 0 to 9; 
			 i_read2 : in integer range 0 to 19; 
			 j_read2 : in integer range 0 to 9;
			 i_read3 : in integer range 0 to 19; 
			 j_read3 : in integer range 0 to 9;  
			 data_in : in std_logic;
			 data_out_vga : out std_logic := '0';
			 data_out1 : out std_logic := '0';
			 data_out2 : out std_logic := '0';
			 data_out3 : out std_logic := '0';
			 speedup : buffer std_logic := '0';
			 score3, score2, score1, score0 : buffer integer range 0 to 9 := 0);
end component;

component active_block is
	port(
		clk, control_clk, start, collision, wren, right_move, left_move: in std_logic;
		block_type: in std_logic_vector(2 downto 0);
		i1, i2 , i3, i4: in integer range -2 to 19;
		j1, j2, j3, j4: in integer range 0 to 9;
		i1out, i2out , i3out, i4out: out integer range -2 to 19;
		j1out, j2out, j3out, j4out: out integer range 0 to 9
	);
end component;

component random_uniform is
    generic (OUT_WIDTH : integer := 3);
    Port ( clk : in  STD_LOGIC;
           random :  out  std_logic_vector(OUT_WIDTH-1 downto 0);
            SEED : in STD_LOGIC_VECTOR(30 downto 0):= (others => '0');
			  reset : in  STD_LOGIC);
end component;

component bcd_to_7seg is
port (clk : in std_logic;
      bcd : in integer range 0 to 9;  --BCD input
      segment7 : out std_logic_vector(6 downto 0)  -- 7 bit decoded output.
     );
end component;

component collision_detec is
	port(
		clk, start, t_collision, isFilled1, control_clk: in std_logic;
		i1, i2, i3, i4: in integer range -2 to 19;
		j1, j2, j3, j4: in integer range 0 to 9;
		collisionBlock: out std_logic;
		wrenField, gameOver: out std_logic;
		i1_r, iWrite: out integer range 0 to 19;
		j1_r, jWrite: out integer range 0 to 9
	);
end component;
component blocktype_to_7seg is
port (clk : in std_logic;
      block_type : in std_logic_vector(2 downto 0);
      segment7_left : out std_logic_vector(0 to 7);  -- 8 bit decoded output. (7 segment + dot)
		segment7_right : out std_logic_vector(0 to 7);
		sgmt_block_number : out std_logic_vector(0 to 7) -- display that will show the number of the block
     );
end component;
component timer is
	port ( clk, speedup, start, gameOver : in std_logic;
			 control_clk, collision_clk : out std_logic := '0');
end component;

component side_moves is
	port(
		clk, start, t_collision, isFilled, lMove, rMove, control_clk: in std_logic;
		i1, i2, i3, i4: in integer range -2 to 19;
		j1, j2, j3, j4: in integer range 0 to 9;
		left_moveBlock, right_moveBlock, working: out std_logic;
		i: out integer range 0 to 19;
		j: out integer range 0 to 9;
		r_s: buffer integer range 0 to 5;
		coll : buffer std_logic
	);
end component;

component binary_counter is

	generic
	(
		MIN_COUNT : natural := 0;
		MAX_COUNT : natural := 20000000
	);

	port
	(
		clk		  : in std_logic;
		reset	  : in std_logic;
		enable	  : in std_logic;
		q		  : out integer range MIN_COUNT to MAX_COUNT
	);

end component;

component rotation is
	port(
		clk, roda, isFilled: in std_logic;
		block_type: in integer range 0 to 6;
		i1, i2, i3, i4: in integer range -2 to 19;
		j1, j2, j3, j4: in integer range 0 to 9;
		makeRotation, rotating: out std_logic;
		i: buffer integer range 0 to 19;
		j: buffer integer range 0 to 9;
		i1out, i2out, i3out, i4out: out integer range -2 to 19;
		j1out, j2out, j3out, j4out: out integer range 0 to 9
	);
end component;


signal row, column : INTEGER;
signal c0, d_en, d_out_vga, d_out1, d_out2, d_out3, d_in, rnd_rst, s_work, r_work, e_clk : STD_LOGIC;
signal collision, w_en, control_clk, start, wren_active, r_m, l_m, speedup, t_collision, rotates, wren_Block, gameOver, lMove, rMove: STD_LOGIC := '0';
signal i1_active, i2_active, i3_active, i4_active, i1, i2, i3, i4 : INTEGER range -2 to 19;
signal j1_active, j2_active, j3_active, j4_active, j1, j2, j3, j4 : INTEGER range 0 to 9;
signal i_vga, i_r1, i_r2, i_r3, i_wr : integer range 0 to 19;
signal j_vga, j_r1, j_r2, j_r3, j_wr : integer range 0 to 9;
signal score3, score2, score1, score0 : integer range 0 to 9;
signal block_type, current_block_type, next_block_type : std_logic_vector (2 downto 0);
signal seed : STD_LOGIC_VECTOR(30 downto 0); 
signal new_block : std_logic;
signal aux_left_b, aux_right_b, aux_rotate_b : std_logic_vector(2 downto 0) := "000";
signal r_s: integer range 0 to 5;
begin

	process (aux_left_b) begin
		if(aux_left_b = "111" and lMove = '1') then
			lMove <= '0';
		elsif(rising_edge(aux_left_b(2)) and lMove = '0') then
			lMove <= '1';
		end if;
	end process;
	
	process (aux_right_b) begin
		if(aux_right_b = "111" and rMove = '1') then
			rMove <= '0';
		elsif(rising_edge(aux_right_b(2)) and rMove = '0') then
			rMove <= '1';
		end if;
	end process;
	
	process (aux_rotate_b) begin
		if(aux_rotate_b = "111" and rotates = '1') then
			rotates <= '0';
		elsif(rising_edge(aux_rotate_b(1)) and rotates = '0') then
			rotates <= '1';
		end if;
	end process;
	
	process (clk, left_b) begin
		if(rising_edge(clk) and left_b = '1' and aux_left_b = "000") then
			aux_left_b <= "100";
		elsif(rising_edge(clk) and left_b = '1' and aux_left_b = "100") then
			aux_left_b <= "110";
		elsif(rising_edge(clk) and left_b = '1' and aux_left_b = "110") then
			aux_left_b <= "111";
		elsif(rising_edge(clk) and left_b = '1' and aux_left_b = "111") then
			aux_left_b <= "110";
		elsif(rising_edge(clk) and left_b = '0') then
			aux_left_b <= "000";
		end if;
	end process;

	process (clk, right_b) begin
		if(rising_edge(clk) and right_b = '1' and aux_right_b = "000") then
			aux_right_b <= "100";
		elsif(rising_edge(clk) and right_b = '1' and aux_right_b = "100") then
			aux_right_b <= "110";
		elsif(rising_edge(clk) and right_b = '1' and aux_right_b = "110") then
			aux_right_b <= "111";
		elsif(rising_edge(clk) and right_b = '1' and aux_right_b = "111") then
			aux_right_b <= "110";
		elsif(rising_edge(clk) and right_b = '0') then
			aux_right_b <= "000";
		end if;
	end process;
	
	process (clk, rotate_b) begin
		if(rising_edge(clk) and rotate_b = '1' and aux_rotate_b = "000") then
			aux_rotate_b <= "100";
		elsif(rising_edge(clk) and rotate_b = '1' and aux_rotate_b = "100") then
			aux_rotate_b <= "110";
		elsif(rising_edge(clk) and rotate_b = '1' and aux_rotate_b = "110") then
			aux_rotate_b <= "111";
		elsif(rising_edge(clk) and rotate_b = '1' and aux_rotate_b = "111") then
			aux_rotate_b <= "110";
		elsif(rising_edge(clk) and rotate_b = '0') then
			aux_rotate_b <= "000";
		end if;
	end process;
	
	turnoff_dot <= (others => '1');
	pixel_clk <= c0;
	
	new_block <= collision or start;
	
	next_block_type <= block_type when (rising_edge(clk) and new_block = '1');
	current_block_type <= next_block_type when (rising_edge(clk) and new_block = '1');
	
	p: pll port map ('0', clk, c0);
	c: vga_controller port map (c0, '1', h_sync, v_sync, d_en, column, row, n_blank, n_sync);
	ig: image_generator port map (d_en, row, column,  i1_active, i2_active, i3_active, i4_active, j1_active, j2_active, j3_active, j4_active, d_out_vga, red, green, blue, i_vga, j_vga);
	t : campo port map (w_en, clk, '0', collision, i_vga, j_vga, i_wr, j_wr, i_r1, j_r1, i_r2, j_r2, i_r3, j_r3, '1', d_out_vga, d_out1, d_out2, d_out3, speedup, score3, score2, score1, score0);
	ab : active_block port map (clk, control_clk, start, collision, wren_active, r_m, l_m, next_block_type, i1, i2, i3, i4, j1, j2, j3, j4, i1_active, i2_active, i3_active, i4_active, j1_active, j2_active, j3_active, j4_active);
	rand : random_uniform port map (clk, block_type, seed, rnd_rst);
	cd : collision_detec port map (clk, start, t_collision, d_out1, control_clk, i1_active, i2_active, i3_active, i4_active, j1_active, j2_active, j3_active, j4_active, collision, w_en, gameOver, i_r1, i_wr, j_r1, j_wr);
	bcd_to_7seg_3 : bcd_to_7seg port map (clk, score3, score3_7seg);
	bcd_to_7seg_2 : bcd_to_7seg port map (clk, score2, score2_7seg);
	bcd_to_7seg_1 : bcd_to_7seg port map (clk, score1, score1_7seg);
	bcd_to_7seg_0 : bcd_to_7seg port map (clk, score0, score0_7seg);
	sides: bcd_to_7seg port map (clk, r_s, r_sHEX);
	bt_to_7seg	  : blocktype_to_7seg port map (clk, next_block_type, bt_7seg_left, bt_7seg_right, sgmt_block_number);
	tmer : timer port map (clk, speedup, start, gameOver, control_clk, t_collision);
	s_m : side_moves port map(clk, start, t_collision, d_out2, lMove, rMove, control_clk, i1_active, i2_active, i3_active, i4_active, j1_active, j2_active, j3_active, j4_active, l_m, r_m, s_work, i_r2, j_r2, r_s, coll);
	rot : rotation port map (clk, rotates, d_out3, to_integer(unsigned(current_block_type)), i1_active, i2_active, i3_active, i4_active, j1_active, j2_active, j3_active, j4_active, wren_active, r_work, i_r3, j_r3, i1, i2, i3, i4, j1, j2, j3, j4);
	
	--testes
	
	teste_campo: process(clk)
		variable count : INTEGER := 0;
	begin
		if(rising_edge(clk)) then
			if(count = 0) then
				start <= '0';
				
			count := count + 1;
			elsif	(count = 1) then
				start <= '1';
				
			count := count + 1;
			elsif (count = 2) then
				start <= '0';
				
			count := count + 1;
			end if;
		end if;
	end process;
	
end behavior;