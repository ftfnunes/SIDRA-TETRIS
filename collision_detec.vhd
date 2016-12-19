library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity collision_detec is
	port(
		clk, t_collision, isFilled, lMove, rMove, rotates, control_clk: in std_logic;
		i1, i2, i3, i4: in integer range -2 to 19;
		j1, j2, j3, j4: in integer range 0 to 9;
		current_block_type: in integer range 0 to 6;
		wrenBlock, collisionBlock, left_moveBlock, right_moveBlock: out std_logic;
		wrenField, gameOver: out std_logic;
		i, iWrite, i1out, i2out, i3out, i4out: out integer range 0 to 19;
		j, jWrite, j1out, j2out, j3out, j4out: out integer range 0 to 9
	);
end entity;

architecture t of collision_detec is

signal writeBlock, sideMove, timer_collision, leftMove, rightMove, sideCollide, wBlock: std_logic := '0';
signal count: integer range 0 to 11 := 0;
signal side_moving: integer range 0 to 2 := 0;
signal check_sideL, check_sideR: integer range 0 to 5 := 0;
signal working_now : integer range 0 to 2;

begin

set_timer_col: process(clk) begin
	if(rising_edge(clk) and t_collision = '1') then
		timer_collision <= '1';
	elsif(rising_edge(clk) and control_clk = '1') then
		timer_collision <= '0';
	end if;
end process;

collsion: process(clk)
begin
if(rising_edge(clk) and timer_collision = '1' and working_now = 0) then
	timer_collision <= '1';
	count <= 0;
	writeBlock <= '0';
	i <= i1 + 1;
	j <= j1;
elsif(rising_edge(clk) and count = 0 and timer_collision = '1') then
	if(isFilled = '1') then
		writeBlock <= '1';
		if((i1 < 0) or (i2 < 0) or (i3 < 0) or (i4 < 0)) then
			gameOver <= '1';
			writeBlock <= '0';
		end if;
	end if;
	count <= 1;
	i <= i2 + 1;
	j <= j2;
elsif(rising_edge(clk) and count = 1  and timer_collision = '1') then
	if(isFilled = '1') then
		writeBlock <= '1';
		if((i1 < 0 ) or (i2 < 0) or (i3 < 0) or (i4 < 0)) then
			gameOver <= '1';
			writeBlock <= '0';
		end if;
	end if;
	count <= 2;
	i <= i3 + 1;
	j <= j3;
elsif(rising_edge(clk) and count = 2 and timer_collision = '1') then
	if(isFilled = '1') then
		writeBlock <= '1';
		if((i1 < 0 ) or (i2 < 0) or (i3 < 0) or (i4 < 0)) then
			gameOver <= '1';
			writeBlock <= '0';
		end if;
	end if;
	count <= 3;
	i <= i4 + 1;
	j <= j4;
elsif(rising_edge(clk) and count = 3 and timer_collision = '1') then
		if(isFilled = '1') then
			writeBlock <= '1';
			if((i1 < 0 ) or (i2 < 0) or (i3 < 0) or (i4 < 0)) then
				gameOver <= '1';
				writeBlock <= '0';
			end if;
		end if;
		count <= 5;
elsif(rising_edge(clk) and count = 5 and writeBlock = '1') then
	wrenField <= '1';
	iWrite <= i1;
	jWrite <= j1;
	count <= 6;
elsif(rising_edge(clk) and count = 6 and writeBlock = '1') then
	iWrite <= i2;
	jWrite <= j2;
	count <= 7;
elsif(rising_edge(clk) and count = 7 and writeBlock = '1') then
	iWrite <= i3;
	jWrite <= j3;
	count <= 8;
elsif(rising_edge(clk) and count = 8 and writeBlock = '1') then
	iWrite <= i4;
	jWrite <= j4;
	count <= 9;
elsif(rising_edge(clk) and count = 9 and writeBlock = '1') then
	wrenField <= '0';
	collisionBlock <= '1';
	count <= 10;
elsif(rising_edge(clk) and count = 10 and writeBlock = '1') then
	collisionBlock <= '0';
	count <= 11;
	writeBlock <= '0';
elsif(rising_edge(clk) and count = 11 and control_clk = '1') then
	count <= 0;
end if;
end process;




side_moves: process(clk)
begin
	if(rising_edge(clk) and lMove = '1' and timer_collision = '0' and t_collision = '0' and working_now = 0) then
		leftMove <= '1';
		rightMove <= '0';
		working_now <= 1;
		check_sideL <= 1;
		check_sideR <= 0;
		sideCollide <= '0';
			i <= i1;
			j <= j1 - 1;
	elsif(rising_edge(clk) and rMove = '1' and timer_collision = '0' and t_collision = '0' and working_now = 0) then
		rightMove <= '1';
		leftMove <= '0';
		working_now <= 1;
		check_sideR <= 1;
		check_sideL <= 0;
		sideCollide <= '0';
		i <= i1;
		j <= j1 + 1;
	elsif(rising_edge(clk) and leftMove = '1' and check_sideL = 1) then
		
		if((j1 - 1) < 0 ) then
			sideCollide <= '1';
		else
			if(isFilled = '1') then
				sideCollide <= '1';
			end if;
		end if;
			check_sideL <= 2;
			i <= i2;
			j <= j2 - 1;
	elsif(rising_edge(clk) and leftMove = '1' and check_sideL = 2) then
		if((j2 - 1) < 0) then
			sideCollide <= '1';
		else
			if(isFilled = '1') then
				sideCollide <= '1';
			end if;
		end if;
			check_sideL <= 3;
			i <= i3;
			j <= j3 - 1;
	elsif(rising_edge(clk) and leftMove = '1' and check_sideL = 3) then
		if((j3 - 1) < 0) then
			sideCollide <= '1';
		else
			if(isFilled = '1') then
				sideCollide <= '1';
			end if;
		end if;
			check_sideL <= 4;
			i <= i4;
			j <= j4 - 1;
	elsif(rising_edge(clk) and leftMove = '1' and check_sideL = 4) then
		if((j4 - 1) < 0) then
			sideCollide <= '1';
		else
			if(isFilled = '1') then
				sideCollide <= '1';
			end if;
		end if;
			
			if(sideCollide = '0') then
				left_moveBlock <= '1';
			end if;
			check_sideL <= 5;
	elsif(rising_edge(clk) and leftMove = '1' and check_sideL = 5) then
		leftMove <= '0';
		left_moveBlock <= '0';
		working_now <= 0;
		check_sideL <= 0;
		sideCollide <= '0';
	elsif(rising_edge(clk) and rightMove = '1' and check_sideR = 1) then
		if((j1 + 1) > 9) then
			sideCollide <= '1';
		else
			if(isFilled = '1') then
				sideCollide <= '1';
			end if;
		end if;
			check_sideR <= 2;
			i <= i2;
			j <= j2 + 1;
	elsif(rising_edge(clk) and rightMove = '1' and check_sideR = 2) then
		if((j2 + 1) > 9) then
			sideCollide <= '1';
		else
			if(isFilled = '1') then
				sideCollide <= '1';
			end if;
		end if;
			check_sideR <= 3;
			i <= i3;
			j <= j3 + 1;
	elsif(rising_edge(clk) and rightMove = '1' and check_sideR = 3) then
		if((j3 + 1) > 9) then
			sideCollide <= '1';
		else
			if(isFilled = '1') then
				sideCollide <= '1';
			end if;
		end if;
			i <= i4;
			j <= j4 + 1;
			check_sideR <= 4;
	elsif(rising_edge(clk) and rightMove = '1' and check_sideR = 4) then
		if((j4 + 1) > 9) then
			sideCollide <= '1';
		else
			if(isFilled = '1') then
				sideCollide <= '1';
			end if;
		end if;
			check_sideR <= 5;
			
			if(sideCollide = '0') then
				right_moveBlock <= '1';
			end if;
	elsif(rising_edge(clk) and rightMove = '1' and check_sideR = 5) then
		rightMove <= '0';
		right_moveBlock <= '0';
		working_now <= 0;
		check_sideR <= 0;
		sideCollide <= '0';
	end if;	
	
end process;


--rotate: process(clk)
--begin
--if( rising_edge(clk) and working = '0') then 
--		
--	end if;
--end if;
--end process;



end architecture;