-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"

-- DATE "12/15/2016 21:40:21"

-- 
-- Device: Altera EP2C70F896C6 Package FBGA896
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY CYCLONEII;
LIBRARY IEEE;
USE CYCLONEII.CYCLONEII_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	tetris IS
    PORT (
	clk : IN std_logic;
	pixel_clk : OUT std_logic;
	red : OUT std_logic_vector(7 DOWNTO 0);
	green : OUT std_logic_vector(7 DOWNTO 0);
	blue : OUT std_logic_vector(7 DOWNTO 0);
	h_sync : OUT std_logic;
	v_sync : OUT std_logic;
	n_blank : OUT std_logic;
	n_sync : OUT std_logic
	);
END tetris;

-- Design Ports Information
-- pixel_clk	=>  Location: PIN_D24,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- red[0]	=>  Location: PIN_D23,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- red[1]	=>  Location: PIN_E23,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- red[2]	=>  Location: PIN_E22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- red[3]	=>  Location: PIN_D22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- red[4]	=>  Location: PIN_H21,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- red[5]	=>  Location: PIN_G21,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- red[6]	=>  Location: PIN_H20,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- red[7]	=>  Location: PIN_F20,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- green[0]	=>  Location: PIN_A10,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- green[1]	=>  Location: PIN_B11,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- green[2]	=>  Location: PIN_A11,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- green[3]	=>  Location: PIN_C12,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- green[4]	=>  Location: PIN_B12,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- green[5]	=>  Location: PIN_A12,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- green[6]	=>  Location: PIN_C13,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- green[7]	=>  Location: PIN_B13,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- blue[0]	=>  Location: PIN_B16,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- blue[1]	=>  Location: PIN_C16,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- blue[2]	=>  Location: PIN_A17,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- blue[3]	=>  Location: PIN_B17,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- blue[4]	=>  Location: PIN_C18,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- blue[5]	=>  Location: PIN_B18,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- blue[6]	=>  Location: PIN_B19,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- blue[7]	=>  Location: PIN_A19,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- h_sync	=>  Location: PIN_J19,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- v_sync	=>  Location: PIN_H19,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- n_blank	=>  Location: PIN_C15,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- n_sync	=>  Location: PIN_B15,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- clk	=>  Location: PIN_AD15,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default


ARCHITECTURE structure OF tetris IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_pixel_clk : std_logic;
SIGNAL ww_red : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_green : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_blue : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_h_sync : std_logic;
SIGNAL ww_v_sync : std_logic;
SIGNAL ww_n_blank : std_logic;
SIGNAL ww_n_sync : std_logic;
SIGNAL \p|altpll_component|pll_INCLK_bus\ : std_logic_vector(1 DOWNTO 0);
SIGNAL \p|altpll_component|pll_CLK_bus\ : std_logic_vector(2 DOWNTO 0);
SIGNAL \p|altpll_component|_clk0~clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \p|altpll_component|pll~CLK1\ : std_logic;
SIGNAL \p|altpll_component|pll~CLK2\ : std_logic;
SIGNAL \c|Add1~2_combout\ : std_logic;
SIGNAL \c|Add1~4_combout\ : std_logic;
SIGNAL \c|Add1~12_combout\ : std_logic;
SIGNAL \c|Add1~16_combout\ : std_logic;
SIGNAL \c|Add0~4_combout\ : std_logic;
SIGNAL \c|Add0~6_combout\ : std_logic;
SIGNAL \ig|process_0~3_combout\ : std_logic;
SIGNAL \ig|process_0~6_combout\ : std_logic;
SIGNAL \ig|process_0~9_combout\ : std_logic;
SIGNAL \ig|process_0~10_combout\ : std_logic;
SIGNAL \c|LessThan0~0_combout\ : std_logic;
SIGNAL \c|LessThan0~1_combout\ : std_logic;
SIGNAL \c|LessThan0~2_combout\ : std_logic;
SIGNAL \c|h_count~2_combout\ : std_logic;
SIGNAL \c|h_count~8_combout\ : std_logic;
SIGNAL \c|h_count~9_combout\ : std_logic;
SIGNAL \c|process_0~2_combout\ : std_logic;
SIGNAL \c|process_0~3_combout\ : std_logic;
SIGNAL \c|process_0~4_combout\ : std_logic;
SIGNAL \c|process_0~5_combout\ : std_logic;
SIGNAL \c|process_0~6_combout\ : std_logic;
SIGNAL \c|process_0~10_combout\ : std_logic;
SIGNAL \c|column[0]~0_combout\ : std_logic;
SIGNAL \clk~combout\ : std_logic;
SIGNAL \p|altpll_component|_clk0\ : std_logic;
SIGNAL \p|altpll_component|_clk0~clkctrl_outclk\ : std_logic;
SIGNAL \c|Add0~0_combout\ : std_logic;
SIGNAL \c|h_count~7_combout\ : std_logic;
SIGNAL \c|Add0~1\ : std_logic;
SIGNAL \c|Add0~2_combout\ : std_logic;
SIGNAL \c|h_count~10_combout\ : std_logic;
SIGNAL \c|Add0~3\ : std_logic;
SIGNAL \c|Add0~5\ : std_logic;
SIGNAL \c|Add0~7\ : std_logic;
SIGNAL \c|Add0~9\ : std_logic;
SIGNAL \c|Add0~10_combout\ : std_logic;
SIGNAL \c|h_count~3_combout\ : std_logic;
SIGNAL \c|Add0~11\ : std_logic;
SIGNAL \c|Add0~13\ : std_logic;
SIGNAL \c|Add0~15\ : std_logic;
SIGNAL \c|Add0~17\ : std_logic;
SIGNAL \c|Add0~18_combout\ : std_logic;
SIGNAL \c|h_count~6_combout\ : std_logic;
SIGNAL \c|Add0~16_combout\ : std_logic;
SIGNAL \c|h_count~5_combout\ : std_logic;
SIGNAL \c|Add0~19\ : std_logic;
SIGNAL \c|Add0~20_combout\ : std_logic;
SIGNAL \c|h_count~0_combout\ : std_logic;
SIGNAL \c|LessThan0~3_combout\ : std_logic;
SIGNAL \c|Add0~14_combout\ : std_logic;
SIGNAL \c|h_count~1_combout\ : std_logic;
SIGNAL \ig|process_0~11_combout\ : std_logic;
SIGNAL \c|Add1~28_combout\ : std_logic;
SIGNAL \c|Add1~1\ : std_logic;
SIGNAL \c|Add1~3\ : std_logic;
SIGNAL \c|Add1~5\ : std_logic;
SIGNAL \c|Add1~7\ : std_logic;
SIGNAL \c|Add1~8_combout\ : std_logic;
SIGNAL \c|Add1~26_combout\ : std_logic;
SIGNAL \c|Add1~9\ : std_logic;
SIGNAL \c|Add1~10_combout\ : std_logic;
SIGNAL \c|Add1~25_combout\ : std_logic;
SIGNAL \c|Add1~11\ : std_logic;
SIGNAL \c|Add1~13\ : std_logic;
SIGNAL \c|Add1~14_combout\ : std_logic;
SIGNAL \c|Add1~23_combout\ : std_logic;
SIGNAL \c|LessThan1~2_combout\ : std_logic;
SIGNAL \c|Add1~6_combout\ : std_logic;
SIGNAL \c|Add1~27_combout\ : std_logic;
SIGNAL \c|Add1~29_combout\ : std_logic;
SIGNAL \c|LessThan1~0_combout\ : std_logic;
SIGNAL \c|LessThan1~1_combout\ : std_logic;
SIGNAL \c|Add1~18_combout\ : std_logic;
SIGNAL \c|Add1~19_combout\ : std_logic;
SIGNAL \c|Add1~15\ : std_logic;
SIGNAL \c|Add1~17\ : std_logic;
SIGNAL \c|Add1~20_combout\ : std_logic;
SIGNAL \c|Add1~22_combout\ : std_logic;
SIGNAL \c|LessThan7~0_combout\ : std_logic;
SIGNAL \ig|process_0~5_combout\ : std_logic;
SIGNAL \ig|process_0~7_combout\ : std_logic;
SIGNAL \ig|process_0~8_combout\ : std_logic;
SIGNAL \c|Add1~0_combout\ : std_logic;
SIGNAL \c|Add1~30_combout\ : std_logic;
SIGNAL \c|row[0]~0_combout\ : std_logic;
SIGNAL \c|Add1~24_combout\ : std_logic;
SIGNAL \ig|process_0~2_combout\ : std_logic;
SIGNAL \ig|process_0~4_combout\ : std_logic;
SIGNAL \ig|process_0~12_combout\ : std_logic;
SIGNAL \c|row[31]~feeder_combout\ : std_logic;
SIGNAL \c|Add0~8_combout\ : std_logic;
SIGNAL \c|h_count~4_combout\ : std_logic;
SIGNAL \ig|process_0~0_combout\ : std_logic;
SIGNAL \c|column[31]~feeder_combout\ : std_logic;
SIGNAL \ig|process_0~1_combout\ : std_logic;
SIGNAL \c|process_0~12_combout\ : std_logic;
SIGNAL \c|disp_ena~regout\ : std_logic;
SIGNAL \ig|blue[0]~0_combout\ : std_logic;
SIGNAL \c|Add0~12_combout\ : std_logic;
SIGNAL \c|process_0~7_combout\ : std_logic;
SIGNAL \c|process_0~8_combout\ : std_logic;
SIGNAL \c|h_sync~regout\ : std_logic;
SIGNAL \c|process_0~9_combout\ : std_logic;
SIGNAL \c|process_0~11_combout\ : std_logic;
SIGNAL \c|v_sync~regout\ : std_logic;
SIGNAL \c|v_count\ : std_logic_vector(9 DOWNTO 0);
SIGNAL \c|row\ : std_logic_vector(31 DOWNTO 0);
SIGNAL \c|h_count\ : std_logic_vector(10 DOWNTO 0);
SIGNAL \c|column\ : std_logic_vector(31 DOWNTO 0);
SIGNAL \c|ALT_INV_h_count~0_combout\ : std_logic;

BEGIN

ww_clk <= clk;
pixel_clk <= ww_pixel_clk;
red <= ww_red;
green <= ww_green;
blue <= ww_blue;
h_sync <= ww_h_sync;
v_sync <= ww_v_sync;
n_blank <= ww_n_blank;
n_sync <= ww_n_sync;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\p|altpll_component|pll_INCLK_bus\ <= (gnd & \clk~combout\);

\p|altpll_component|_clk0\ <= \p|altpll_component|pll_CLK_bus\(0);
\p|altpll_component|pll~CLK1\ <= \p|altpll_component|pll_CLK_bus\(1);
\p|altpll_component|pll~CLK2\ <= \p|altpll_component|pll_CLK_bus\(2);

\p|altpll_component|_clk0~clkctrl_INCLK_bus\ <= (gnd & gnd & gnd & \p|altpll_component|_clk0\);
\c|ALT_INV_h_count~0_combout\ <= NOT \c|h_count~0_combout\;

-- Location: LCCOMB_X68_Y46_N12
\c|Add1~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|Add1~2_combout\ = (\c|v_count\(1) & (!\c|Add1~1\)) # (!\c|v_count\(1) & ((\c|Add1~1\) # (GND)))
-- \c|Add1~3\ = CARRY((!\c|Add1~1\) # (!\c|v_count\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \c|v_count\(1),
	datad => VCC,
	cin => \c|Add1~1\,
	combout => \c|Add1~2_combout\,
	cout => \c|Add1~3\);

-- Location: LCCOMB_X68_Y46_N14
\c|Add1~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|Add1~4_combout\ = (\c|v_count\(2) & (\c|Add1~3\ $ (GND))) # (!\c|v_count\(2) & (!\c|Add1~3\ & VCC))
-- \c|Add1~5\ = CARRY((\c|v_count\(2) & !\c|Add1~3\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \c|v_count\(2),
	datad => VCC,
	cin => \c|Add1~3\,
	combout => \c|Add1~4_combout\,
	cout => \c|Add1~5\);

-- Location: LCCOMB_X68_Y46_N22
\c|Add1~12\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|Add1~12_combout\ = (\c|v_count\(6) & (\c|Add1~11\ $ (GND))) # (!\c|v_count\(6) & (!\c|Add1~11\ & VCC))
-- \c|Add1~13\ = CARRY((\c|v_count\(6) & !\c|Add1~11\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \c|v_count\(6),
	datad => VCC,
	cin => \c|Add1~11\,
	combout => \c|Add1~12_combout\,
	cout => \c|Add1~13\);

-- Location: LCCOMB_X68_Y46_N26
\c|Add1~16\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|Add1~16_combout\ = (\c|v_count\(8) & (\c|Add1~15\ $ (GND))) # (!\c|v_count\(8) & (!\c|Add1~15\ & VCC))
-- \c|Add1~17\ = CARRY((\c|v_count\(8) & !\c|Add1~15\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \c|v_count\(8),
	datad => VCC,
	cin => \c|Add1~15\,
	combout => \c|Add1~16_combout\,
	cout => \c|Add1~17\);

-- Location: LCCOMB_X67_Y47_N12
\c|Add0~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|Add0~4_combout\ = (\c|h_count\(2) & (\c|Add0~3\ $ (GND))) # (!\c|h_count\(2) & (!\c|Add0~3\ & VCC))
-- \c|Add0~5\ = CARRY((\c|h_count\(2) & !\c|Add0~3\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \c|h_count\(2),
	datad => VCC,
	cin => \c|Add0~3\,
	combout => \c|Add0~4_combout\,
	cout => \c|Add0~5\);

-- Location: LCCOMB_X67_Y47_N14
\c|Add0~6\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|Add0~6_combout\ = (\c|h_count\(3) & (!\c|Add0~5\)) # (!\c|h_count\(3) & ((\c|Add0~5\) # (GND)))
-- \c|Add0~7\ = CARRY((!\c|Add0~5\) # (!\c|h_count\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \c|h_count\(3),
	datad => VCC,
	cin => \c|Add0~5\,
	combout => \c|Add0~6_combout\,
	cout => \c|Add0~7\);

-- Location: LCFF_X66_Y47_N11
\c|column[6]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	datain => \c|h_count~2_combout\,
	ena => \c|ALT_INV_h_count~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|column\(6));

-- Location: LCFF_X68_Y46_N9
\c|row[3]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	datain => \c|Add1~27_combout\,
	ena => \c|LessThan7~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|row\(3));

-- Location: LCCOMB_X67_Y46_N6
\ig|process_0~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \ig|process_0~3_combout\ = (\c|row\(1) & (\c|row\(2) & (\c|row\(3) & \c|row\(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|row\(1),
	datab => \c|row\(2),
	datac => \c|row\(3),
	datad => \c|row\(4),
	combout => \ig|process_0~3_combout\);

-- Location: LCCOMB_X67_Y46_N30
\ig|process_0~6\ : cycloneii_lcell_comb
-- Equation(s):
-- \ig|process_0~6_combout\ = (!\c|row\(7) & (!\c|row\(8) & (!\c|row\(6) & !\c|row\(9))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|row\(7),
	datab => \c|row\(8),
	datac => \c|row\(6),
	datad => \c|row\(9),
	combout => \ig|process_0~6_combout\);

-- Location: LCFF_X68_Y47_N11
\c|column[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	datain => \c|column[0]~0_combout\,
	ena => \c|ALT_INV_h_count~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|column\(0));

-- Location: LCFF_X68_Y47_N13
\c|column[3]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	sdata => \c|h_count~8_combout\,
	sload => VCC,
	ena => \c|ALT_INV_h_count~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|column\(3));

-- Location: LCFF_X68_Y47_N7
\c|column[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	sdata => \c|h_count~9_combout\,
	sload => VCC,
	ena => \c|ALT_INV_h_count~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|column\(2));

-- Location: LCFF_X68_Y47_N9
\c|column[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	datain => \c|h_count~10_combout\,
	ena => \c|ALT_INV_h_count~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|column\(1));

-- Location: LCCOMB_X68_Y47_N6
\ig|process_0~9\ : cycloneii_lcell_comb
-- Equation(s):
-- \ig|process_0~9_combout\ = (!\c|column\(3) & (!\c|column\(1) & (!\c|column\(2) & \c|column\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|column\(3),
	datab => \c|column\(1),
	datac => \c|column\(2),
	datad => \c|column\(0),
	combout => \ig|process_0~9_combout\);

-- Location: LCCOMB_X66_Y47_N16
\ig|process_0~10\ : cycloneii_lcell_comb
-- Equation(s):
-- \ig|process_0~10_combout\ = ((!\c|column\(5) & ((\ig|process_0~9_combout\) # (!\c|column\(4))))) # (!\c|column\(6))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100010111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|column\(5),
	datab => \ig|process_0~9_combout\,
	datac => \c|column\(4),
	datad => \c|column\(6),
	combout => \ig|process_0~10_combout\);

-- Location: LCFF_X67_Y47_N21
\c|h_count[6]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	sdata => \c|h_count~2_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|h_count\(6));

-- Location: LCFF_X67_Y47_N7
\c|h_count[4]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	sdata => \c|h_count~4_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|h_count\(4));

-- Location: LCFF_X68_Y47_N5
\c|h_count[3]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	datain => \c|h_count~8_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|h_count\(3));

-- Location: LCFF_X68_Y47_N15
\c|h_count[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	datain => \c|h_count~9_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|h_count\(2));

-- Location: LCCOMB_X67_Y47_N6
\c|LessThan0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|LessThan0~0_combout\ = (((!\c|h_count\(2)) # (!\c|h_count\(4))) # (!\c|h_count\(5))) # (!\c|h_count\(3))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|h_count\(3),
	datab => \c|h_count\(5),
	datac => \c|h_count\(4),
	datad => \c|h_count\(2),
	combout => \c|LessThan0~0_combout\);

-- Location: LCCOMB_X67_Y47_N30
\c|LessThan0~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|LessThan0~1_combout\ = (!\c|LessThan0~0_combout\ & (\c|h_count\(1) & \c|h_count\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \c|LessThan0~0_combout\,
	datac => \c|h_count\(1),
	datad => \c|h_count\(0),
	combout => \c|LessThan0~1_combout\);

-- Location: LCCOMB_X67_Y47_N4
\c|LessThan0~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|LessThan0~2_combout\ = (\c|h_count\(6)) # ((\c|h_count\(7)) # (\c|LessThan0~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|h_count\(6),
	datac => \c|h_count\(7),
	datad => \c|LessThan0~1_combout\,
	combout => \c|LessThan0~2_combout\);

-- Location: LCCOMB_X66_Y47_N10
\c|h_count~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|h_count~2_combout\ = (\c|LessThan0~3_combout\ & \c|Add0~12_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \c|LessThan0~3_combout\,
	datad => \c|Add0~12_combout\,
	combout => \c|h_count~2_combout\);

-- Location: LCCOMB_X68_Y47_N4
\c|h_count~8\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|h_count~8_combout\ = (\c|LessThan0~3_combout\ & \c|Add0~6_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \c|LessThan0~3_combout\,
	datad => \c|Add0~6_combout\,
	combout => \c|h_count~8_combout\);

-- Location: LCCOMB_X68_Y47_N14
\c|h_count~9\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|h_count~9_combout\ = (\c|Add0~4_combout\ & \c|LessThan0~3_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \c|Add0~4_combout\,
	datac => \c|LessThan0~3_combout\,
	combout => \c|h_count~9_combout\);

-- Location: LCCOMB_X68_Y47_N0
\c|process_0~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|process_0~2_combout\ = (\c|Add0~14_combout\ & \c|Add0~10_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \c|Add0~14_combout\,
	datac => \c|Add0~10_combout\,
	combout => \c|process_0~2_combout\);

-- Location: LCCOMB_X68_Y47_N2
\c|process_0~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|process_0~3_combout\ = (\c|LessThan0~3_combout\ & ((\c|Add0~2_combout\) # ((\c|Add0~4_combout\) # (\c|Add0~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|Add0~2_combout\,
	datab => \c|Add0~4_combout\,
	datac => \c|LessThan0~3_combout\,
	datad => \c|Add0~0_combout\,
	combout => \c|process_0~3_combout\);

-- Location: LCCOMB_X68_Y47_N20
\c|process_0~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|process_0~4_combout\ = (\c|process_0~2_combout\ & ((\c|process_0~3_combout\) # ((\c|h_count~8_combout\) # (\c|h_count~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|process_0~3_combout\,
	datab => \c|h_count~8_combout\,
	datac => \c|h_count~4_combout\,
	datad => \c|process_0~2_combout\,
	combout => \c|process_0~4_combout\);

-- Location: LCCOMB_X66_Y47_N4
\c|process_0~5\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|process_0~5_combout\ = ((\c|h_count~5_combout\) # ((\c|h_count~6_combout\) # (\c|process_0~4_combout\))) # (!\c|h_count~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|h_count~0_combout\,
	datab => \c|h_count~5_combout\,
	datac => \c|h_count~6_combout\,
	datad => \c|process_0~4_combout\,
	combout => \c|process_0~5_combout\);

-- Location: LCCOMB_X68_Y47_N30
\c|process_0~6\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|process_0~6_combout\ = ((!\c|Add0~14_combout\ & ((!\c|Add0~8_combout\) # (!\c|Add0~6_combout\)))) # (!\c|LessThan0~3_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001111100111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|Add0~6_combout\,
	datab => \c|Add0~14_combout\,
	datac => \c|LessThan0~3_combout\,
	datad => \c|Add0~8_combout\,
	combout => \c|process_0~6_combout\);

-- Location: LCCOMB_X67_Y46_N14
\c|process_0~10\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|process_0~10_combout\ = (\c|Add1~24_combout\) # ((\c|Add1~23_combout\) # ((!\c|Add1~22_combout\) # (!\c|Add1~19_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|Add1~24_combout\,
	datab => \c|Add1~23_combout\,
	datac => \c|Add1~19_combout\,
	datad => \c|Add1~22_combout\,
	combout => \c|process_0~10_combout\);

-- Location: LCCOMB_X68_Y47_N10
\c|column[0]~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|column[0]~0_combout\ = !\c|h_count~7_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \c|h_count~7_combout\,
	combout => \c|column[0]~0_combout\);

-- Location: PIN_AD15,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\clk~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_clk,
	combout => \clk~combout\);

-- Location: PLL_4
\p|altpll_component|pll\ : cycloneii_pll
-- pragma translate_off
GENERIC MAP (
	bandwidth => 0,
	bandwidth_type => "low",
	c0_high => 5,
	c0_initial => 1,
	c0_low => 5,
	c0_mode => "even",
	c0_ph => 0,
	c1_mode => "bypass",
	c1_ph => 0,
	c2_mode => "bypass",
	c2_ph => 0,
	charge_pump_current => 80,
	clk0_counter => "c0",
	clk0_divide_by => 10,
	clk0_duty_cycle => 50,
	clk0_multiply_by => 13,
	clk0_phase_shift => "0",
	clk1_duty_cycle => 50,
	clk1_phase_shift => "0",
	clk2_duty_cycle => 50,
	clk2_phase_shift => "0",
	compensate_clock => "clk0",
	gate_lock_counter => 0,
	gate_lock_signal => "no",
	inclk0_input_frequency => 20000,
	inclk1_input_frequency => 20000,
	invalid_lock_multiplier => 5,
	loop_filter_c => 3,
	loop_filter_r => " 2.500000",
	m => 13,
	m_initial => 1,
	m_ph => 0,
	n => 1,
	operation_mode => "normal",
	pfd_max => 100000,
	pfd_min => 2484,
	pll_compensation_delay => 5633,
	self_reset_on_gated_loss_lock => "off",
	sim_gate_lock_device_behavior => "off",
	simulation_type => "timing",
	valid_lock_multiplier => 1,
	vco_center => 1333,
	vco_max => 2000,
	vco_min => 1000)
-- pragma translate_on
PORT MAP (
	areset => GND,
	inclk => \p|altpll_component|pll_INCLK_bus\,
	clk => \p|altpll_component|pll_CLK_bus\);

-- Location: CLKCTRL_G15
\p|altpll_component|_clk0~clkctrl\ : cycloneii_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \p|altpll_component|_clk0~clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \p|altpll_component|_clk0~clkctrl_outclk\);

-- Location: LCFF_X67_Y47_N5
\c|h_count[7]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	sdata => \c|h_count~1_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|h_count\(7));

-- Location: LCCOMB_X67_Y47_N8
\c|Add0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|Add0~0_combout\ = \c|h_count\(0) $ (VCC)
-- \c|Add0~1\ = CARRY(\c|h_count\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \c|h_count\(0),
	datad => VCC,
	combout => \c|Add0~0_combout\,
	cout => \c|Add0~1\);

-- Location: LCCOMB_X68_Y47_N18
\c|h_count~7\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|h_count~7_combout\ = (\c|LessThan0~3_combout\ & \c|Add0~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \c|LessThan0~3_combout\,
	datad => \c|Add0~0_combout\,
	combout => \c|h_count~7_combout\);

-- Location: LCFF_X68_Y47_N19
\c|h_count[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	datain => \c|h_count~7_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|h_count\(0));

-- Location: LCCOMB_X67_Y47_N10
\c|Add0~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|Add0~2_combout\ = (\c|h_count\(1) & (!\c|Add0~1\)) # (!\c|h_count\(1) & ((\c|Add0~1\) # (GND)))
-- \c|Add0~3\ = CARRY((!\c|Add0~1\) # (!\c|h_count\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \c|h_count\(1),
	datad => VCC,
	cin => \c|Add0~1\,
	combout => \c|Add0~2_combout\,
	cout => \c|Add0~3\);

-- Location: LCCOMB_X68_Y47_N8
\c|h_count~10\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|h_count~10_combout\ = (\c|LessThan0~3_combout\ & \c|Add0~2_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \c|LessThan0~3_combout\,
	datad => \c|Add0~2_combout\,
	combout => \c|h_count~10_combout\);

-- Location: LCFF_X67_Y47_N31
\c|h_count[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	sdata => \c|h_count~10_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|h_count\(1));

-- Location: LCCOMB_X67_Y47_N16
\c|Add0~8\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|Add0~8_combout\ = (\c|h_count\(4) & (\c|Add0~7\ $ (GND))) # (!\c|h_count\(4) & (!\c|Add0~7\ & VCC))
-- \c|Add0~9\ = CARRY((\c|h_count\(4) & !\c|Add0~7\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \c|h_count\(4),
	datad => VCC,
	cin => \c|Add0~7\,
	combout => \c|Add0~8_combout\,
	cout => \c|Add0~9\);

-- Location: LCCOMB_X67_Y47_N18
\c|Add0~10\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|Add0~10_combout\ = (\c|h_count\(5) & (!\c|Add0~9\)) # (!\c|h_count\(5) & ((\c|Add0~9\) # (GND)))
-- \c|Add0~11\ = CARRY((!\c|Add0~9\) # (!\c|h_count\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \c|h_count\(5),
	datad => VCC,
	cin => \c|Add0~9\,
	combout => \c|Add0~10_combout\,
	cout => \c|Add0~11\);

-- Location: LCCOMB_X66_Y47_N12
\c|h_count~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|h_count~3_combout\ = (\c|LessThan0~3_combout\ & \c|Add0~10_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \c|LessThan0~3_combout\,
	datad => \c|Add0~10_combout\,
	combout => \c|h_count~3_combout\);

-- Location: LCFF_X67_Y47_N19
\c|h_count[5]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	sdata => \c|h_count~3_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|h_count\(5));

-- Location: LCCOMB_X67_Y47_N20
\c|Add0~12\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|Add0~12_combout\ = (\c|h_count\(6) & (\c|Add0~11\ $ (GND))) # (!\c|h_count\(6) & (!\c|Add0~11\ & VCC))
-- \c|Add0~13\ = CARRY((\c|h_count\(6) & !\c|Add0~11\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \c|h_count\(6),
	datad => VCC,
	cin => \c|Add0~11\,
	combout => \c|Add0~12_combout\,
	cout => \c|Add0~13\);

-- Location: LCCOMB_X67_Y47_N22
\c|Add0~14\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|Add0~14_combout\ = (\c|h_count\(7) & (!\c|Add0~13\)) # (!\c|h_count\(7) & ((\c|Add0~13\) # (GND)))
-- \c|Add0~15\ = CARRY((!\c|Add0~13\) # (!\c|h_count\(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \c|h_count\(7),
	datad => VCC,
	cin => \c|Add0~13\,
	combout => \c|Add0~14_combout\,
	cout => \c|Add0~15\);

-- Location: LCCOMB_X67_Y47_N24
\c|Add0~16\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|Add0~16_combout\ = (\c|h_count\(8) & (\c|Add0~15\ $ (GND))) # (!\c|h_count\(8) & (!\c|Add0~15\ & VCC))
-- \c|Add0~17\ = CARRY((\c|h_count\(8) & !\c|Add0~15\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \c|h_count\(8),
	datad => VCC,
	cin => \c|Add0~15\,
	combout => \c|Add0~16_combout\,
	cout => \c|Add0~17\);

-- Location: LCCOMB_X67_Y47_N26
\c|Add0~18\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|Add0~18_combout\ = (\c|h_count\(9) & (!\c|Add0~17\)) # (!\c|h_count\(9) & ((\c|Add0~17\) # (GND)))
-- \c|Add0~19\ = CARRY((!\c|Add0~17\) # (!\c|h_count\(9)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \c|h_count\(9),
	datad => VCC,
	cin => \c|Add0~17\,
	combout => \c|Add0~18_combout\,
	cout => \c|Add0~19\);

-- Location: LCCOMB_X66_Y47_N18
\c|h_count~6\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|h_count~6_combout\ = (\c|LessThan0~3_combout\ & \c|Add0~18_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \c|LessThan0~3_combout\,
	datac => \c|Add0~18_combout\,
	combout => \c|h_count~6_combout\);

-- Location: LCFF_X66_Y47_N19
\c|h_count[9]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	datain => \c|h_count~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|h_count\(9));

-- Location: LCCOMB_X66_Y47_N30
\c|h_count~5\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|h_count~5_combout\ = (\c|LessThan0~3_combout\ & \c|Add0~16_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \c|LessThan0~3_combout\,
	datad => \c|Add0~16_combout\,
	combout => \c|h_count~5_combout\);

-- Location: LCFF_X67_Y47_N1
\c|h_count[8]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	sdata => \c|h_count~5_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|h_count\(8));

-- Location: LCCOMB_X67_Y47_N28
\c|Add0~20\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|Add0~20_combout\ = \c|Add0~19\ $ (!\c|h_count\(10))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000001111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => \c|h_count\(10),
	cin => \c|Add0~19\,
	combout => \c|Add0~20_combout\);

-- Location: LCCOMB_X67_Y47_N2
\c|h_count~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|h_count~0_combout\ = (\c|LessThan0~3_combout\ & \c|Add0~20_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \c|LessThan0~3_combout\,
	datad => \c|Add0~20_combout\,
	combout => \c|h_count~0_combout\);

-- Location: LCFF_X67_Y47_N3
\c|h_count[10]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	datain => \c|h_count~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|h_count\(10));

-- Location: LCCOMB_X67_Y47_N0
\c|LessThan0~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|LessThan0~3_combout\ = ((!\c|h_count\(9) & ((!\c|h_count\(8)) # (!\c|LessThan0~2_combout\)))) # (!\c|h_count\(10))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001001111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|LessThan0~2_combout\,
	datab => \c|h_count\(9),
	datac => \c|h_count\(8),
	datad => \c|h_count\(10),
	combout => \c|LessThan0~3_combout\);

-- Location: LCCOMB_X66_Y47_N24
\c|h_count~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|h_count~1_combout\ = (\c|LessThan0~3_combout\ & \c|Add0~14_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \c|LessThan0~3_combout\,
	datad => \c|Add0~14_combout\,
	combout => \c|h_count~1_combout\);

-- Location: LCFF_X66_Y47_N25
\c|column[7]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	datain => \c|h_count~1_combout\,
	ena => \c|ALT_INV_h_count~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|column\(7));

-- Location: LCFF_X66_Y47_N7
\c|column[9]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	sdata => \c|h_count~6_combout\,
	sload => VCC,
	ena => \c|ALT_INV_h_count~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|column\(9));

-- Location: LCCOMB_X66_Y47_N2
\ig|process_0~11\ : cycloneii_lcell_comb
-- Equation(s):
-- \ig|process_0~11_combout\ = (!\c|column\(7) & !\c|column\(9))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \c|column\(7),
	datad => \c|column\(9),
	combout => \ig|process_0~11_combout\);

-- Location: LCFF_X68_Y47_N29
\c|v_count[9]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	sdata => \c|Add1~22_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|v_count\(9));

-- Location: LCCOMB_X68_Y46_N2
\c|Add1~28\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|Add1~28_combout\ = (\c|Add1~4_combout\ & ((\c|Add1~18_combout\) # ((\c|v_count\(2) & \c|LessThan0~3_combout\)))) # (!\c|Add1~4_combout\ & (\c|v_count\(2) & ((\c|LessThan0~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|Add1~4_combout\,
	datab => \c|v_count\(2),
	datac => \c|Add1~18_combout\,
	datad => \c|LessThan0~3_combout\,
	combout => \c|Add1~28_combout\);

-- Location: LCFF_X68_Y46_N15
\c|v_count[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	sdata => \c|Add1~28_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|v_count\(2));

-- Location: LCCOMB_X68_Y46_N10
\c|Add1~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|Add1~0_combout\ = \c|v_count\(0) $ (VCC)
-- \c|Add1~1\ = CARRY(\c|v_count\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|v_count\(0),
	datad => VCC,
	combout => \c|Add1~0_combout\,
	cout => \c|Add1~1\);

-- Location: LCCOMB_X68_Y46_N16
\c|Add1~6\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|Add1~6_combout\ = (\c|v_count\(3) & (!\c|Add1~5\)) # (!\c|v_count\(3) & ((\c|Add1~5\) # (GND)))
-- \c|Add1~7\ = CARRY((!\c|Add1~5\) # (!\c|v_count\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \c|v_count\(3),
	datad => VCC,
	cin => \c|Add1~5\,
	combout => \c|Add1~6_combout\,
	cout => \c|Add1~7\);

-- Location: LCCOMB_X68_Y46_N18
\c|Add1~8\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|Add1~8_combout\ = (\c|v_count\(4) & (\c|Add1~7\ $ (GND))) # (!\c|v_count\(4) & (!\c|Add1~7\ & VCC))
-- \c|Add1~9\ = CARRY((\c|v_count\(4) & !\c|Add1~7\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \c|v_count\(4),
	datad => VCC,
	cin => \c|Add1~7\,
	combout => \c|Add1~8_combout\,
	cout => \c|Add1~9\);

-- Location: LCCOMB_X67_Y46_N26
\c|Add1~26\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|Add1~26_combout\ = (\c|Add1~18_combout\ & ((\c|Add1~8_combout\) # ((\c|v_count\(4) & \c|LessThan0~3_combout\)))) # (!\c|Add1~18_combout\ & (\c|v_count\(4) & ((\c|LessThan0~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|Add1~18_combout\,
	datab => \c|v_count\(4),
	datac => \c|Add1~8_combout\,
	datad => \c|LessThan0~3_combout\,
	combout => \c|Add1~26_combout\);

-- Location: LCFF_X68_Y46_N31
\c|v_count[4]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	sdata => \c|Add1~26_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|v_count\(4));

-- Location: LCCOMB_X68_Y46_N20
\c|Add1~10\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|Add1~10_combout\ = (\c|v_count\(5) & (!\c|Add1~9\)) # (!\c|v_count\(5) & ((\c|Add1~9\) # (GND)))
-- \c|Add1~11\ = CARRY((!\c|Add1~9\) # (!\c|v_count\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \c|v_count\(5),
	datad => VCC,
	cin => \c|Add1~9\,
	combout => \c|Add1~10_combout\,
	cout => \c|Add1~11\);

-- Location: LCCOMB_X67_Y46_N18
\c|Add1~25\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|Add1~25_combout\ = (\c|Add1~18_combout\ & ((\c|Add1~10_combout\) # ((\c|LessThan0~3_combout\ & \c|v_count\(5))))) # (!\c|Add1~18_combout\ & (\c|LessThan0~3_combout\ & (\c|v_count\(5))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|Add1~18_combout\,
	datab => \c|LessThan0~3_combout\,
	datac => \c|v_count\(5),
	datad => \c|Add1~10_combout\,
	combout => \c|Add1~25_combout\);

-- Location: LCFF_X67_Y46_N19
\c|v_count[5]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	datain => \c|Add1~25_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|v_count\(5));

-- Location: LCCOMB_X68_Y46_N24
\c|Add1~14\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|Add1~14_combout\ = (\c|v_count\(7) & (!\c|Add1~13\)) # (!\c|v_count\(7) & ((\c|Add1~13\) # (GND)))
-- \c|Add1~15\ = CARRY((!\c|Add1~13\) # (!\c|v_count\(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \c|v_count\(7),
	datad => VCC,
	cin => \c|Add1~13\,
	combout => \c|Add1~14_combout\,
	cout => \c|Add1~15\);

-- Location: LCCOMB_X67_Y46_N22
\c|Add1~23\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|Add1~23_combout\ = (\c|Add1~18_combout\ & ((\c|Add1~14_combout\) # ((\c|LessThan0~3_combout\ & \c|v_count\(7))))) # (!\c|Add1~18_combout\ & (\c|LessThan0~3_combout\ & (\c|v_count\(7))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|Add1~18_combout\,
	datab => \c|LessThan0~3_combout\,
	datac => \c|v_count\(7),
	datad => \c|Add1~14_combout\,
	combout => \c|Add1~23_combout\);

-- Location: LCFF_X67_Y46_N23
\c|v_count[7]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	datain => \c|Add1~23_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|v_count\(7));

-- Location: LCCOMB_X68_Y47_N28
\c|LessThan1~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|LessThan1~2_combout\ = ((!\c|v_count\(6) & (!\c|v_count\(5) & !\c|v_count\(7)))) # (!\c|v_count\(9))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|v_count\(6),
	datab => \c|v_count\(5),
	datac => \c|v_count\(9),
	datad => \c|v_count\(7),
	combout => \c|LessThan1~2_combout\);

-- Location: LCCOMB_X68_Y46_N8
\c|Add1~27\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|Add1~27_combout\ = (\c|v_count\(3) & ((\c|LessThan0~3_combout\) # ((\c|Add1~18_combout\ & \c|Add1~6_combout\)))) # (!\c|v_count\(3) & (((\c|Add1~18_combout\ & \c|Add1~6_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|v_count\(3),
	datab => \c|LessThan0~3_combout\,
	datac => \c|Add1~18_combout\,
	datad => \c|Add1~6_combout\,
	combout => \c|Add1~27_combout\);

-- Location: LCFF_X68_Y46_N17
\c|v_count[3]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	sdata => \c|Add1~27_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|v_count\(3));

-- Location: LCCOMB_X68_Y46_N0
\c|Add1~29\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|Add1~29_combout\ = (\c|Add1~2_combout\ & ((\c|Add1~18_combout\) # ((\c|v_count\(1) & \c|LessThan0~3_combout\)))) # (!\c|Add1~2_combout\ & (((\c|v_count\(1) & \c|LessThan0~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|Add1~2_combout\,
	datab => \c|Add1~18_combout\,
	datac => \c|v_count\(1),
	datad => \c|LessThan0~3_combout\,
	combout => \c|Add1~29_combout\);

-- Location: LCFF_X68_Y46_N1
\c|v_count[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	datain => \c|Add1~29_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|v_count\(1));

-- Location: LCCOMB_X68_Y46_N30
\c|LessThan1~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|LessThan1~0_combout\ = (!\c|v_count\(4) & (((!\c|v_count\(0) & !\c|v_count\(1))) # (!\c|v_count\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001100000111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|v_count\(0),
	datab => \c|v_count\(2),
	datac => \c|v_count\(4),
	datad => \c|v_count\(1),
	combout => \c|LessThan1~0_combout\);

-- Location: LCCOMB_X68_Y47_N26
\c|LessThan1~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|LessThan1~1_combout\ = (!\c|v_count\(6) & (!\c|v_count\(3) & (\c|LessThan1~0_combout\ & !\c|v_count\(7))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|v_count\(6),
	datab => \c|v_count\(3),
	datac => \c|LessThan1~0_combout\,
	datad => \c|v_count\(7),
	combout => \c|LessThan1~1_combout\);

-- Location: LCCOMB_X68_Y47_N22
\c|Add1~18\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|Add1~18_combout\ = (!\c|LessThan0~3_combout\ & (((\c|LessThan1~2_combout\) # (\c|LessThan1~1_combout\)) # (!\c|v_count\(8))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|v_count\(8),
	datab => \c|LessThan1~2_combout\,
	datac => \c|LessThan0~3_combout\,
	datad => \c|LessThan1~1_combout\,
	combout => \c|Add1~18_combout\);

-- Location: LCCOMB_X67_Y46_N4
\c|Add1~19\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|Add1~19_combout\ = (\c|Add1~16_combout\ & ((\c|Add1~18_combout\) # ((\c|LessThan0~3_combout\ & \c|v_count\(8))))) # (!\c|Add1~16_combout\ & (\c|LessThan0~3_combout\ & (\c|v_count\(8))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|Add1~16_combout\,
	datab => \c|LessThan0~3_combout\,
	datac => \c|v_count\(8),
	datad => \c|Add1~18_combout\,
	combout => \c|Add1~19_combout\);

-- Location: LCFF_X68_Y46_N27
\c|v_count[8]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	sdata => \c|Add1~19_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|v_count\(8));

-- Location: LCCOMB_X68_Y46_N28
\c|Add1~20\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|Add1~20_combout\ = \c|Add1~17\ $ (\c|v_count\(9))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => \c|v_count\(9),
	cin => \c|Add1~17\,
	combout => \c|Add1~20_combout\);

-- Location: LCCOMB_X67_Y46_N10
\c|Add1~22\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|Add1~22_combout\ = (\c|Add1~18_combout\ & ((\c|Add1~20_combout\) # ((\c|v_count\(9) & \c|LessThan0~3_combout\)))) # (!\c|Add1~18_combout\ & (((\c|v_count\(9) & \c|LessThan0~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|Add1~18_combout\,
	datab => \c|Add1~20_combout\,
	datac => \c|v_count\(9),
	datad => \c|LessThan0~3_combout\,
	combout => \c|Add1~22_combout\);

-- Location: LCCOMB_X67_Y46_N20
\c|LessThan7~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|LessThan7~0_combout\ = (!\c|Add1~22_combout\) # (!\c|Add1~19_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \c|Add1~19_combout\,
	datad => \c|Add1~22_combout\,
	combout => \c|LessThan7~0_combout\);

-- Location: LCFF_X67_Y46_N11
\c|row[9]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	datain => \c|Add1~22_combout\,
	ena => \c|LessThan7~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|row\(9));

-- Location: LCFF_X67_Y46_N5
\c|row[8]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	datain => \c|Add1~19_combout\,
	ena => \c|LessThan7~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|row\(8));

-- Location: LCCOMB_X66_Y47_N6
\ig|process_0~5\ : cycloneii_lcell_comb
-- Equation(s):
-- \ig|process_0~5_combout\ = (\c|row\(9) & ((\c|row\(8)) # (\c|column\(8) $ (!\c|column\(9))))) # (!\c|row\(9) & (\c|column\(8) $ ((!\c|column\(9)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110110100101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|column\(8),
	datab => \c|row\(9),
	datac => \c|column\(9),
	datad => \c|row\(8),
	combout => \ig|process_0~5_combout\);

-- Location: LCFF_X67_Y46_N25
\c|row[5]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	sdata => \c|Add1~25_combout\,
	sload => VCC,
	ena => \c|LessThan7~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|row\(5));

-- Location: LCFF_X68_Y46_N3
\c|row[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	datain => \c|Add1~28_combout\,
	ena => \c|LessThan7~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|row\(2));

-- Location: LCFF_X67_Y46_N13
\c|row[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	sdata => \c|Add1~29_combout\,
	sload => VCC,
	ena => \c|LessThan7~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|row\(1));

-- Location: LCFF_X67_Y46_N27
\c|row[4]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	datain => \c|Add1~26_combout\,
	ena => \c|LessThan7~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|row\(4));

-- Location: LCCOMB_X67_Y46_N12
\ig|process_0~7\ : cycloneii_lcell_comb
-- Equation(s):
-- \ig|process_0~7_combout\ = (!\c|row\(3) & (!\c|row\(2) & (!\c|row\(1) & !\c|row\(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|row\(3),
	datab => \c|row\(2),
	datac => \c|row\(1),
	datad => \c|row\(4),
	combout => \ig|process_0~7_combout\);

-- Location: LCCOMB_X67_Y46_N24
\ig|process_0~8\ : cycloneii_lcell_comb
-- Equation(s):
-- \ig|process_0~8_combout\ = (\ig|process_0~5_combout\) # ((\ig|process_0~6_combout\ & ((\ig|process_0~7_combout\) # (!\c|row\(5)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111011001110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ig|process_0~6_combout\,
	datab => \ig|process_0~5_combout\,
	datac => \c|row\(5),
	datad => \ig|process_0~7_combout\,
	combout => \ig|process_0~8_combout\);

-- Location: LCFF_X68_Y47_N17
\c|v_count[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	datain => \c|Add1~30_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|v_count\(0));

-- Location: LCCOMB_X68_Y47_N16
\c|Add1~30\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|Add1~30_combout\ = (\c|LessThan0~3_combout\ & ((\c|v_count\(0)) # ((\c|Add1~0_combout\ & \c|Add1~18_combout\)))) # (!\c|LessThan0~3_combout\ & (\c|Add1~0_combout\ & ((\c|Add1~18_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|LessThan0~3_combout\,
	datab => \c|Add1~0_combout\,
	datac => \c|v_count\(0),
	datad => \c|Add1~18_combout\,
	combout => \c|Add1~30_combout\);

-- Location: LCCOMB_X67_Y46_N0
\c|row[0]~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|row[0]~0_combout\ = !\c|Add1~30_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \c|Add1~30_combout\,
	combout => \c|row[0]~0_combout\);

-- Location: LCFF_X67_Y46_N1
\c|row[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	datain => \c|row[0]~0_combout\,
	ena => \c|LessThan7~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|row\(0));

-- Location: LCFF_X67_Y46_N29
\c|row[7]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	sdata => \c|Add1~23_combout\,
	sload => VCC,
	ena => \c|LessThan7~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|row\(7));

-- Location: LCFF_X67_Y46_N17
\c|v_count[6]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	datain => \c|Add1~24_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|v_count\(6));

-- Location: LCCOMB_X67_Y46_N16
\c|Add1~24\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|Add1~24_combout\ = (\c|Add1~12_combout\ & ((\c|Add1~18_combout\) # ((\c|LessThan0~3_combout\ & \c|v_count\(6))))) # (!\c|Add1~12_combout\ & (\c|LessThan0~3_combout\ & (\c|v_count\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|Add1~12_combout\,
	datab => \c|LessThan0~3_combout\,
	datac => \c|v_count\(6),
	datad => \c|Add1~18_combout\,
	combout => \c|Add1~24_combout\);

-- Location: LCFF_X67_Y46_N31
\c|row[6]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	sdata => \c|Add1~24_combout\,
	sload => VCC,
	ena => \c|LessThan7~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|row\(6));

-- Location: LCCOMB_X67_Y46_N28
\ig|process_0~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \ig|process_0~2_combout\ = (\c|row\(9) & (\c|row\(7) & \c|row\(6)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \c|row\(9),
	datac => \c|row\(7),
	datad => \c|row\(6),
	combout => \ig|process_0~2_combout\);

-- Location: LCCOMB_X67_Y46_N2
\ig|process_0~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \ig|process_0~4_combout\ = (\ig|process_0~2_combout\ & ((\c|row\(5)) # ((\ig|process_0~3_combout\ & !\c|row\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ig|process_0~3_combout\,
	datab => \c|row\(0),
	datac => \c|row\(5),
	datad => \ig|process_0~2_combout\,
	combout => \ig|process_0~4_combout\);

-- Location: LCCOMB_X66_Y47_N20
\ig|process_0~12\ : cycloneii_lcell_comb
-- Equation(s):
-- \ig|process_0~12_combout\ = (\ig|process_0~8_combout\) # ((\ig|process_0~4_combout\) # ((\ig|process_0~10_combout\ & \ig|process_0~11_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ig|process_0~10_combout\,
	datab => \ig|process_0~11_combout\,
	datac => \ig|process_0~8_combout\,
	datad => \ig|process_0~4_combout\,
	combout => \ig|process_0~12_combout\);

-- Location: LCCOMB_X66_Y46_N0
\c|row[31]~feeder\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|row[31]~feeder_combout\ = VCC

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	combout => \c|row[31]~feeder_combout\);

-- Location: LCFF_X66_Y46_N1
\c|row[31]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	datain => \c|row[31]~feeder_combout\,
	ena => \c|LessThan7~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|row\(31));

-- Location: LCCOMB_X68_Y47_N24
\c|h_count~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|h_count~4_combout\ = (\c|LessThan0~3_combout\ & \c|Add0~8_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \c|LessThan0~3_combout\,
	datad => \c|Add0~8_combout\,
	combout => \c|h_count~4_combout\);

-- Location: LCFF_X68_Y47_N25
\c|column[4]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	datain => \c|h_count~4_combout\,
	ena => \c|ALT_INV_h_count~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|column\(4));

-- Location: LCFF_X66_Y47_N31
\c|column[8]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	datain => \c|h_count~5_combout\,
	ena => \c|ALT_INV_h_count~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|column\(8));

-- Location: LCFF_X66_Y47_N13
\c|column[5]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	datain => \c|h_count~3_combout\,
	ena => \c|ALT_INV_h_count~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|column\(5));

-- Location: LCCOMB_X66_Y47_N8
\ig|process_0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \ig|process_0~0_combout\ = (!\c|column\(8) & ((\c|column\(6)) # ((\c|column\(4) & \c|column\(5)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|column\(6),
	datab => \c|column\(4),
	datac => \c|column\(8),
	datad => \c|column\(5),
	combout => \ig|process_0~0_combout\);

-- Location: LCCOMB_X66_Y47_N26
\c|column[31]~feeder\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|column[31]~feeder_combout\ = VCC

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	combout => \c|column[31]~feeder_combout\);

-- Location: LCFF_X66_Y47_N27
\c|column[31]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	datain => \c|column[31]~feeder_combout\,
	ena => \c|ALT_INV_h_count~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|column\(31));

-- Location: LCCOMB_X66_Y47_N28
\ig|process_0~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \ig|process_0~1_combout\ = (((\c|column\(7) & \ig|process_0~0_combout\)) # (!\c|column\(31))) # (!\c|row\(31))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011001111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|column\(7),
	datab => \c|row\(31),
	datac => \ig|process_0~0_combout\,
	datad => \c|column\(31),
	combout => \ig|process_0~1_combout\);

-- Location: LCCOMB_X67_Y46_N8
\c|process_0~12\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|process_0~12_combout\ = (\c|Add1~22_combout\ & (!\c|Add1~19_combout\ & ((!\c|LessThan0~3_combout\) # (!\c|Add0~20_combout\)))) # (!\c|Add1~22_combout\ & (((!\c|LessThan0~3_combout\) # (!\c|Add0~20_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000011101110111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|Add1~22_combout\,
	datab => \c|Add1~19_combout\,
	datac => \c|Add0~20_combout\,
	datad => \c|LessThan0~3_combout\,
	combout => \c|process_0~12_combout\);

-- Location: LCFF_X67_Y46_N9
\c|disp_ena\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	datain => \c|process_0~12_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|disp_ena~regout\);

-- Location: LCCOMB_X66_Y47_N22
\ig|blue[0]~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \ig|blue[0]~0_combout\ = (\c|disp_ena~regout\ & ((\ig|process_0~12_combout\) # (\ig|process_0~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ig|process_0~12_combout\,
	datab => \ig|process_0~1_combout\,
	datad => \c|disp_ena~regout\,
	combout => \ig|blue[0]~0_combout\);

-- Location: LCCOMB_X66_Y47_N14
\c|process_0~7\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|process_0~7_combout\ = (\c|process_0~6_combout\ & (((!\c|Add0~12_combout\ & !\c|Add0~10_combout\)) # (!\c|LessThan0~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101000101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|process_0~6_combout\,
	datab => \c|Add0~12_combout\,
	datac => \c|LessThan0~3_combout\,
	datad => \c|Add0~10_combout\,
	combout => \c|process_0~7_combout\);

-- Location: LCCOMB_X66_Y47_N0
\c|process_0~8\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|process_0~8_combout\ = (\c|process_0~5_combout\) # ((\c|process_0~7_combout\) # ((\c|Add0~14_combout\ & \c|Add0~12_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111011111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|process_0~5_combout\,
	datab => \c|Add0~14_combout\,
	datac => \c|process_0~7_combout\,
	datad => \c|Add0~12_combout\,
	combout => \c|process_0~8_combout\);

-- Location: LCFF_X66_Y47_N1
\c|h_sync\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	datain => \c|process_0~8_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|h_sync~regout\);

-- Location: LCCOMB_X68_Y46_N6
\c|process_0~9\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|process_0~9_combout\ = (\c|Add1~28_combout\ & (\c|Add1~27_combout\)) # (!\c|Add1~28_combout\ & ((\c|Add1~27_combout\ & ((\c|Add1~29_combout\))) # (!\c|Add1~27_combout\ & ((!\c|Add1~29_combout\) # (!\c|Add1~30_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110110011001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|Add1~28_combout\,
	datab => \c|Add1~27_combout\,
	datac => \c|Add1~30_combout\,
	datad => \c|Add1~29_combout\,
	combout => \c|process_0~9_combout\);

-- Location: LCCOMB_X68_Y46_N4
\c|process_0~11\ : cycloneii_lcell_comb
-- Equation(s):
-- \c|process_0~11_combout\ = (\c|process_0~10_combout\) # ((\c|Add1~25_combout\) # ((\c|Add1~26_combout\) # (\c|process_0~9_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|process_0~10_combout\,
	datab => \c|Add1~25_combout\,
	datac => \c|Add1~26_combout\,
	datad => \c|process_0~9_combout\,
	combout => \c|process_0~11_combout\);

-- Location: LCFF_X68_Y46_N5
\c|v_sync\ : cycloneii_lcell_ff
PORT MAP (
	clk => \p|altpll_component|_clk0~clkctrl_outclk\,
	datain => \c|process_0~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \c|v_sync~regout\);

-- Location: PIN_D24,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\pixel_clk~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \p|altpll_component|_clk0~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_pixel_clk);

-- Location: PIN_D23,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\red[0]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_red(0));

-- Location: PIN_E23,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\red[1]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_red(1));

-- Location: PIN_E22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\red[2]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_red(2));

-- Location: PIN_D22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\red[3]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_red(3));

-- Location: PIN_H21,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\red[4]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_red(4));

-- Location: PIN_G21,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\red[5]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_red(5));

-- Location: PIN_H20,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\red[6]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_red(6));

-- Location: PIN_F20,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\red[7]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_red(7));

-- Location: PIN_A10,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\green[0]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_green(0));

-- Location: PIN_B11,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\green[1]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_green(1));

-- Location: PIN_A11,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\green[2]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_green(2));

-- Location: PIN_C12,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\green[3]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_green(3));

-- Location: PIN_B12,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\green[4]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_green(4));

-- Location: PIN_A12,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\green[5]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_green(5));

-- Location: PIN_C13,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\green[6]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_green(6));

-- Location: PIN_B13,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\green[7]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_green(7));

-- Location: PIN_B16,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\blue[0]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \ig|blue[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_blue(0));

-- Location: PIN_C16,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\blue[1]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \ig|blue[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_blue(1));

-- Location: PIN_A17,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\blue[2]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \ig|blue[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_blue(2));

-- Location: PIN_B17,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\blue[3]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \ig|blue[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_blue(3));

-- Location: PIN_C18,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\blue[4]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \ig|blue[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_blue(4));

-- Location: PIN_B18,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\blue[5]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \ig|blue[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_blue(5));

-- Location: PIN_B19,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\blue[6]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \ig|blue[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_blue(6));

-- Location: PIN_A19,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\blue[7]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \ig|blue[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_blue(7));

-- Location: PIN_J19,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\h_sync~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \c|h_sync~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_h_sync);

-- Location: PIN_H19,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\v_sync~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \c|v_sync~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_v_sync);

-- Location: PIN_C15,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\n_blank~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_n_blank);

-- Location: PIN_B15,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\n_sync~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_n_sync);
END structure;


