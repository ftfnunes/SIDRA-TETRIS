--------------------------------------------------------------------------------
--
--   FileName:         hw_image_generator.vhd
--   Dependencies:     none
--   Design Software:  Quartus II 64-bit Version 12.1 Build 177 SJ Full Version
--
--   HDL CODE IS PROVIDED "AS IS."  DIGI-KEY EXPRESSLY DISCLAIMS ANY
--   WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING BUT NOT
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
--   PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL DIGI-KEY
--   BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR CONSEQUENTIAL
--   DAMAGES, LOST PROFITS OR LOST DATA, HARM TO YOUR EQUIPMENT, COST OF
--   PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
--   BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF),
--   ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER SIMILAR COSTS.
--
--   Version History
--   Version 1.0 05/10/2013 Scott Larson
--     Initial Public Release
--    
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY image_generator IS
  GENERIC(
    left_deadzone 	:  INTEGER := 337;   --row that first color will persist until
    right_deadzone 	:  INTEGER := 687;
	 top_deadzone 		:	INTEGER := 34;
	 bottom_deadzone 	: 	INTEGER := 734);  --column that first color will persist until
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
END image_generator;

ARCHITECTURE behavior OF image_generator IS
signal bord_x, bord_y : std_logic := '0';
signal i_temp : INTEGER range -2 to 19; 
signal j_temp : INTEGER range 0 to 9;
BEGIN
	
	p0: process(column) 
	begin
		bord_x <= '0';
		if((column > 337) AND (column < 372)) then
			j <= 0;
			j_temp <= 0;
		elsif ((column > 372) and (column < 407)) then
			j <= 1;
			j_temp <= 1;
		elsif ((column > 407) and (column < 442)) then
			j <= 2;
			j_temp <= 2;
		elsif ((column > 442) and (column < 477)) then
			j <= 3;
			j_temp <= 3;
		elsif ((column > 477) and (column < 512)) then
			j <= 4;
			j_temp <= 4;
		elsif ((column > 512) and (column < 547)) then
			j <= 5;
			j_temp <= 5;
		elsif ((column > 547) and (column < 582)) then
			j <= 6;
			j_temp <= 6;
		elsif ((column > 582) and (column < 617)) then
			j <= 7;
			j_temp <= 7;
		elsif ((column > 617) and (column < 652)) then
			j <= 8;
			j_temp <= 8;
		elsif ((column > 652) and (column < 687)) then
			j <= 9;
			j_temp <= 9;
		else
			j <= 0;
			j_temp <= 0;
			bord_x <= '1';
		end if;
	end process;
	
	
	p1: process(row) 
	begin
		bord_y <= '0';
	  if((row > 34) and (row < 69)) then
			i <= 0;
			i_temp <= 0;
	  elsif ((row > 69) and (row < 104)) then
			i <= 1;
			i_temp <= 1;
	  elsif ((row > 104) and (row < 139)) then
			i <= 2;
			i_temp <= 2;
	  elsif ((row > 139) and (row < 174)) then
			i <= 3;
			i_temp <= 3;
	  elsif ((row > 174) and (row < 209)) then
			i <= 4;
			i_temp <= 4;
	  elsif ((row > 209) and (row < 244)) then
			i <= 5;
			i_temp <= 5;
	  elsif ((row > 244) and (row < 279)) then
			i <= 6;
			i_temp <= 6;
	  elsif ((row > 279) and (row < 314)) then
			i <= 7;
			i_temp <= 7;
	  elsif ((row > 314) and (row < 349)) then
			i <= 8;
			i_temp <= 8;
	  elsif ((row > 349) and (row < 384)) then
			i <= 9;
			i_temp <= 9;
	  elsif ((row > 384) and (row < 419)) then
			i <= 10;
			i_temp <= 10;
	  elsif ((row > 419) and (row < 454)) then
			i <= 11;
			i_temp <= 11;
	  elsif ((row > 454) and (row < 489)) then
			i <= 12;
			i_temp <= 12;
	  elsif ((row > 489) and (row < 524)) then
			i <= 13;
			i_temp <= 13;
	  elsif ((row > 524) and (row < 559)) then
			i <= 14;
			i_temp <= 14;
	  elsif ((row > 559) and (row < 594)) then
			i <= 15;
			i_temp <= 15;
	  elsif ((row > 594) and (row < 629)) then
			i <= 16;
			i_temp <= 16;
	  elsif ((row > 629) and (row < 664)) then
			i <= 17;
			i_temp <= 17;
	  elsif ((row > 664) and (row < 699)) then
			i <= 18;
			i_temp <= 18;
	  elsif ((row > 699) and (row < 734)) then
			i <= 19;
			i_temp <= 19;
	  else
			i <= 0;
			i_temp <= 0;
			bord_y <= '1';
	  end if;
	end process;
 
  PROCESS(disp_ena, row, column, ff_mat_status)
  BEGIN
    IF(disp_ena = '1') THEN        --display time
      IF(column < left_deadzone OR column > right_deadzone OR row < top_deadzone or row > bottom_deadzone) THEN -- se nao esta nos limites do campo
        red <= (OTHERS => '0');
		  green <= (OTHERS => '0');
		  blue <= (OTHERS => '1');
		elsif((j_temp = j1_active and i_temp = i1_active) or (j_temp = j2_active and i_temp = i2_active) or (j_temp = j3_active and i_temp = i3_active) or (j_temp = j4_active and i_temp = i4_active)) then
			IF (bord_x = '1' or bord_y = '1') THEN
			  red <= (OTHERS => '0');
			  green <= (OTHERS => '0');
			  blue <= (OTHERS => '0');
			ELSE
			  red <= (OTHERS => '1');
			  green <= (OTHERS => '1');
			  blue <= (OTHERS => '0');
			end if;
		ELSE -- imprime bloco
			IF (ff_mat_status = '0' or bord_x = '1' or bord_y = '1') THEN
			  red <= (OTHERS => '0');
			  green <= (OTHERS => '0');
			  blue <= (OTHERS => '0');
			ELSE
			  red <= (OTHERS => '1');
			  green <= (OTHERS => '1');
			  blue <= (OTHERS => '0');
			END IF;
		END IF;
    ELSE                           --blanking time
      red <= (OTHERS => '0');
	  green <= (OTHERS => '0');
	  blue <= (OTHERS => '0');
    END IF;
  
  END PROCESS;
END behavior;
