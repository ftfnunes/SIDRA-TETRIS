library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity side_moves is
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
end entity;

architecture behavior of side_moves is
signal timer_collision: std_logic := '0';
signal t: integer range 0 to 5;
begin

r_s <= t;
coll <= T_Collision;
set_timer_col: process(clk) begin
	if(rising_edge(clk) and t_collision = '1') then
		timer_collision <= '1';
	elsif(rising_edge(clk) and control_clk = '1') then
		timer_collision <= '0';
	end if;
end process;

	move: process(clk)
	variable sideCollide : STD_logic;
	variable check_sideL, check_sideR : integer range 0 to 5;
	begin
	if(start = '1' or (rMove = '0' and lMove = '0' and check_sideL = 0 and check_sideR = 0)) then
		left_moveBlock <= '0';
		right_moveBlock <= '0';
		working <= '0';
		check_sideL := 0;
		check_sideR:= 0;
		sideCollide := '0';
	elsif(rising_edge(clk) and lMove = '1' and timer_collision = '0' and t_collision = '0' and check_sideL = 0 and check_sideR = 0) then
		sideCollide := '0';
		working <= '1';
		check_sideL := 1;
		check_sideR:= 0;
		i <= i1;
		j <= j1 - 1;
	elsif(rising_edge(clk) and check_sideL = 1) then
		
		if((j1) = 0 ) then
			sideCollide := '1';
		else
			if(isFilled = '1') then
				sideCollide := '1';
			end if;
		end if;
			check_sideL := 2;
			i <= i2;
			j <= j2 - 1;
	elsif(rising_edge(clk) and check_sideL = 2) then
		if(j2 = 0) then
			sideCollide := '1';
		else
			if(isFilled = '1') then
				sideCollide := '1';
			end if;
		end if;
			check_sideL := 3;
			i <= i3;
			j <= j3 - 1;
	elsif(rising_edge(clk) and check_sideL = 3) then
		if(j3 = 0) then
			sideCollide := '1';
		else
			if(isFilled = '1') then
				sideCollide := '1';
			end if;
		end if;
			check_sideL := 4;
			i <= i4;
			j <= j4 - 1;
	elsif(rising_edge(clk) and check_sideL = 4) then
		if(j4 = 0) then
			sideCollide := '1';
		else
			if(isFilled = '1') then
				sideCollide := '1';
			end if;
		end if;
			
			if(sideCollide = '0') then
				left_moveBlock <= '1';
			end if;
			check_sideL := 5;
	elsif(rising_edge(clk) and check_sideL = 5) then
		left_moveBlock <= '0';
		working <= '0';
		check_sideL := 0;
		sideCollide := '0';
	elsif(rising_edge(clk) and timer_collision = '0' and rMove = '1' and t_collision = '0' and check_sideL = 0 and check_sideR = 0) then
		working <= '1';
		sideCollide := '0';
		check_sideR:= 1;
		check_sideL := 0;
		i <= i1;
		j <= j1 + 1;
	elsif(rising_edge(clk) and check_sideR = 1) then
		if(j1 = 9) then
			sideCollide := '1';
		else
			if(isFilled = '1') then
				sideCollide := '1';
			end if;
		end if;
			check_sideR:= 2;
			i <= i2;
			j <= j2 + 1;
	elsif(rising_edge(clk) and check_sideR = 2) then
		if(j2 = 9) then
			sideCollide := '1';
		else
			if(isFilled = '1') then
				sideCollide := '1';
			end if;
		end if;
			check_sideR:= 3;
			i <= i3;
			j <= j3 + 1;
	elsif(rising_edge(clk) and check_sideR = 3) then
		if(j3 = 9) then
			sideCollide := '1';
		else
			if(isFilled = '1') then
				sideCollide := '1';
			end if;
		end if;
			check_sideR:= 4;
			i <= i4;
			j <= j4 + 1;
	elsif(rising_edge(clk) and check_sideR = 4) then
		if(j4 = 9) then
			sideCollide := '1';
		else
			if(isFilled = '1') then
				sideCollide := '1';
			end if;
		end if;
		if(sideCollide = '0') then
			right_moveBlock <= '1';
		end if;
		check_sideR:= 5;
	elsif(rising_edge(clk) and check_sideR = 5) then
		right_moveBlock <= '0';
		working <= '0';
		check_sideR:= 0;
		sideCollide := '0';
	elsif (rising_edge(clk)) then
		left_moveBlock <= '0';
		right_moveBlock <= '0';
		working <= '0';
		check_sideL := 0;
		check_sideR:= 0;
		sideCollide := '0';
	end if;	

	end process;
end behavior;