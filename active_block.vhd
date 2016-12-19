library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity active_block is
	port(
		clk, control_clk, start, collision, wren, right_move, left_move: in std_logic;
		block_type: in std_logic_vector(2 downto 0);
		i1, i2 , i3, i4: in integer range -2 to 19;
		j1, j2, j3, j4: in integer range 0 to 9;
		i1out, i2out , i3out, i4out: out integer range -2 to 19;
		j1out, j2out, j3out, j4out: out integer range 0 to 9
	);
end entity;

architecture t of active_block is

signal i1buf, i2buf , i3buf, i4buf: integer range -2 to 19 := 0;
signal j1buf, j2buf , j3buf, j4buf: integer range -2 to 19 := 0; 

begin
-- Os pulsos collision, start, wren, control_clk so podem ficar igual 
-- a '1' durante um rising_edge de clk.
-- CLK Ã© o clock rÃ¡pido que controla todo o sistema.
init: process(clk)
-- In every rising edge of the signal collision, a new type is received 
-- and a new block is placed on the screen. The signal collision means that
-- the previous block was placed and has no more movement.
begin
	if(rising_edge(clk)) then
		if(start = '1' or collision = '1') then
			case block_type is
				when "000" => 
			-- 		The type 0 is the bar: (i1-j1)(i2-j2)(i3-j3)(i4-j4)
						i1out <= -1; i2out <= -1; i3out <= -1; i4out <= -1;
						i1buf <= -1; i2buf <= -1; i3buf <= -1; i4buf <= -1;
						j1out <= 3; j2out <= 4; j3out <= 5; j4out <= 6;
						j1buf <= 3; j2buf <= 4; j3buf <= 5; j4buf <= 6;
				when "001" =>
			--			The type 1 is: 		(i1-j1)
			--										(i2-j2)(i3-j3)(i4-j4)
						i1out <= -2; i2out <= -1; i3out <= -1; i4out <= -1;
						i1buf <= -2; i2buf <= -1; i3buf <= -1; i4buf <= -1;					
						j1out <= 4; j2out <= 4; j3out <= 5; j4out <= 6;
						j1buf <= 4; j2buf <= 4; j3buf <= 5; j4buf <= 6;
				when "010" =>
			--			The type 2 is: 				 		  (i1-j1)
			--										(i2-j2)(i3-j3)(i4-j4)
						i1out <= -2; i2out <= -1; i3out <= -1; i4out <= -1;
						i1buf <= -2; i2buf <= -1; i3buf <= -1; i4buf <= -1;
						j1out <= 6; j2out <= 4; j3out <= 5; j4out <= 6;
						j1buf <= 6; j2buf <= 4; j3buf <= 5; j4buf <= 6;
				when "011" =>
			--			The type 3 is:		 	(i1-j1)(i2-j2)
			--										(i3-j3)(i4-j4)
						i1out <= -2; i2out <= -2; i3out <= -1; i4out <= -1;
						i1buf <= -2; i2buf <= -2; i3buf <= -1; i4buf <= -1;
						j1out <= 4; j2out <= 5; j3out <= 4; j4out <= 5;
						j1buf <= 4; j2buf <= 5; j3buf <= 4; j4buf <= 5;
				when "100" =>
			--			The type 4 is:        	 	 (i1-j1)(i2-j2)
			--										(i3-j3)(i4-j4)			
						i1out <= -2; i2out <= -2; i3out <= -1; i4out <= -1;
						i1buf <= -2; i2buf <= -2; i3buf <= -1; i4buf <= -1;
						j1out <= 6; j2out <= 7; j3out <= 5; j4out <= 6;
						j1buf <= 6; j2buf <= 7; j3buf <= 5; j4buf <= 6;
				when "101" =>
			--			The type 5 is:     		    (i1-j1)
			--										(i2-j2)(i3-j3)(i4-j4)
						i1out <= -2; i2out <= -1; i3out <= -1; i4out <= -1;
						i1buf <= -2; i2buf <= -1; i3buf <= -1; i4buf <= -1;
						j1out <= 5; j2out <= 4; j3out <= 5; j4out <= 6;
						j1buf <= 5; j2buf <= 4; j3buf <= 5; j4buf <= 6;
				when "110" =>
			--			The type 6 is: (i1-j1)(i2-j2)
			--										 (i3-j3)(i4-j4)
						i1out <= -2; i2out <= -2; i3out <= -1; i4out <= -1;
						i1buf <= -2; i2buf <= -2; i3buf <= -1; i4buf <= -1;
						j1out <= 4; j2out <= 5; j3out <= 5; j4out <= 6;
						j1buf <= 4; j2buf <= 5; j3buf <= 5; j4buf <= 6;
				when others =>
			-- 		The type is expected to never be reached
						i1out <= -2; i2out <= -2; i3out <= -2; i4out <= -2;
						i1buf <= -2; i2buf <= -2; i3buf <= -2; i4buf <= -2;
						j1out <= 4; j2out <= 4; j3out <= 4; j4out <= 4;
						j1buf <= 4; j2buf <= 4; j3buf <= 4; j4buf <= 4;
			end case;
		end if;
		
		if(control_clk = '1') then
				i1out <= i1buf + 1; i2out <= i2buf + 1; i3out <= i3buf + 1; i4out <= i4buf + 1;
				i1buf <= i1buf + 1; i2buf <= i2buf + 1; i3buf <= i3buf + 1; i4buf <= i4buf + 1;		
		end if;
		
		if(wren = '1') then 
			i1out <= i1; i2out <= i2; i3out <= i3; i4out <= i4;
			i1buf <= i1; i2buf <= i2; i3buf <= i3; i4buf <= i4;
			j1out <= j1; j2out <= j2; j3out <= j3; j4out <= j4;
			j1buf <= j1; j2buf <= j2; j3buf <= j3; j4buf <= j4;
		end if;
		
		if(right_move = '1') then
			j1out <= j1buf + 1; j2out <= j2buf + 1; j3out <= j3buf + 1; j4out <= j4buf + 1;
			j1buf <= j1buf + 1; j2buf <= j2buf + 1; j3buf <= j3buf + 1; j4buf <= j4buf + 1;	
		end if;
		
		if(left_move = '1') then
			j1out <= j1buf - 1; j2out <= j2buf - 1; j3out <= j3buf - 1; j4out <= j4buf - 1;
			j1buf <= j1buf - 1; j2buf <= j2buf - 1; j3buf <= j3buf - 1; j4buf <= j4buf - 1;	
		end if;
	end if;
end process;

end t;