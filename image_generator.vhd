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
	 i 					: 	OUT UNSIGNED(4 DOWNTO 0);
	 j 					: 	OUT UNSIGNED(3 DOWNTO 0));
END image_generator;

ARCHITECTURE behavior OF image_generator IS
BEGIN
  	
  PROCESS(disp_ena, row, column)
  BEGIN
    IF(disp_ena = '1') THEN        --display time
      IF(column < left_deadzone OR column > right_deadzone OR row < top_deadzone or row > bottom_deadzone) THEN
        red <= (OTHERS => '0');
		  green <= (OTHERS => '0');
		  blue <= (OTHERS => '1');
      ELSE
        red <= (OTHERS => '0');
		  green <= (OTHERS => '0');
		  blue <= (OTHERS => '0');
      END IF;
    ELSE                           --blanking time
      red <= (OTHERS => '0');
	  green <= (OTHERS => '0');
	  blue <= (OTHERS => '0');
    END IF;
  
  END PROCESS;
END behavior;
