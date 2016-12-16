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
    ff_mat_status 	:	IN STD_LOGIC;
	 red      			:  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');  --red magnitude output to DAC
    green    			:  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');  --green magnitude output to DAC
    blue     			:	OUT  STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0'); --blue magnitude output to DAC
	 i 					: 	OUT INTEGER range -2 to 19;
	 j 					: 	OUT INTEGER range 0 to 9);
END image_generator;

ARCHITECTURE behavior OF image_generator IS
BEGIN
	
	p0: process(column) 
	begin
		if((column > 337) AND (column < 372)) then
			j <= 0;
		elsif ((column > 372) and (column < 407)) then
			j <= 1;
		elsif ((column > 407) and (column < 442)) then
			j <= 2;
		elsif ((column > 442) and (column < 477)) then
			j <= 3;
		elsif ((column > 477) and (column < 512)) then
			j <= 4;
		elsif ((column > 512) and (column < 547)) then
			j <= 5;
		elsif ((column > 547) and (column < 582)) then
			j <= 6;
		elsif ((column > 582) and (column < 617)) then
			j <= 7;
		elsif ((column > 617) and (column < 652)) then
			j <= 8;
		elsif ((column > 652) and (column < 687)) then
			j <= 9;
		else
			j <= 0;
		end if;
	end process;
	
	
	p1: process(row) 
	begin
	  if((row > 34) and (row < 69)) then
			i <= 0;
	  elsif ((row > 69) and (row < 104)) then
			i <= 1;
	  elsif ((row > 104) and (row < 139)) then
			i <= 2;
	  elsif ((row > 139) and (row < 174)) then
			i <= 3;
	  elsif ((row > 174) and (row < 209)) then
			i <= 4;
	  elsif ((row > 209) and (row < 244)) then
			i <= 5;
	  elsif ((row > 244) and (row < 279)) then
			i <= 6;
	  elsif ((row > 279) and (row < 314)) then
			i <= 7;
	  elsif ((row > 314) and (row < 349)) then
			i <= 8;
	  elsif ((row > 349) and (row < 384)) then
			i <= 9;
	  elsif ((row > 384) and (row < 419)) then
			i <= 10;
	  elsif ((row > 419) and (row < 454)) then
			i <= 11;
	  elsif ((row > 454) and (row < 489)) then
			i <= 12;
	  elsif ((row > 489) and (row < 524)) then
			i <= 13;
	  elsif ((row > 524) and (row < 559)) then
			i <= 14;
	  elsif ((row > 559) and (row < 594)) then
			i <= 15;
	  elsif ((row > 594) and (row < 629)) then
			i <= 16;
	  elsif ((row > 629) and (row < 664)) then
			i <= 17;
	  elsif ((row > 664) and (row < 699)) then
			i <= 18;
	  elsif ((row > 699) and (row < 734)) then
			i <= 19;
	  else
			i <= 0;
	  end if;
	end process;
 
  PROCESS(disp_ena, row, column, ff_mat_status)
  BEGIN
    IF(disp_ena = '1') THEN        --display time
      IF(column < left_deadzone OR column > right_deadzone OR row < top_deadzone or row > bottom_deadzone) THEN -- se nao esta nos limites do campo
        red <= (OTHERS => '0');
		  green <= (OTHERS => '0');
		  blue <= (OTHERS => '1');
      ELSE -- imprime bloco
			IF (ff_mat_status = '0') THEN
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
