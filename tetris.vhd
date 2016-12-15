LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tetris is PORT(
	 clk		 	:  IN	STD_LOGIC;
	 pixel_clk	:	OUT STD_LOGIC;	 
	 red      	:  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);  --red magnitude output to DAC
	 green    	:  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);  --green magnitude output to DAC
	 blue     	:  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
	 h_sync		:	OUT	STD_LOGIC;	--horiztonal sync pulse
	 v_sync		:	OUT	STD_LOGIC;	--vertical sync pulse
	 n_blank		:	OUT	STD_LOGIC;	--direct blacking output to DAC
	 n_sync		:	OUT	STD_LOGIC --sync-on-green output to DAC
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
    ff_mat_status 	:	IN STD_LOGIC;
	 red      			:  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);  --red magnitude output to DAC
    green    			:  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0) ;  --green magnitude output to DAC
    blue     			:	OUT  STD_LOGIC_VECTOR(7 DOWNTO 0); --blue magnitude output to DAC
	 i 					: 	OUT UNSIGNED(4 DOWNTO 0);
	 j 					: 	OUT UNSIGNED(3 DOWNTO 0));
END COMPONENT;

component pll IS
	PORT
	(
		areset		: IN STD_LOGIC  := '0';
		inclk0		: IN STD_LOGIC  := '0';
		c0		: OUT STD_LOGIC 
	);
END component;

signal row, column : INTEGER;
signal c0, d_en, status : STD_LOGIC;
signal i : unsigned(4 downto 0);
signal j : unsigned(3 downto 0);
begin
	pixel_clk <= c0;
	p: pll port map ('0', clk, c0);
	c: vga_controller port map (c0, '1', h_sync, v_sync, d_en, column, row, n_blank, n_sync);
	ig: image_generator port map (d_en, row, column, status, red, green, blue, i, j);
end behavior;



