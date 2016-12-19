library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity collision_detec is
	port(
		clk, start, t_collision, isFilled1, control_clk: in std_logic;
		i1, i2, i3, i4: in integer range -2 to 19;
		j1, j2, j3, j4: in integer range 0 to 9;
		collisionBlock: out std_logic;
		wrenField, gameOver: out std_logic;
		i1_r, iWrite: out integer range 0 to 19;
		j1_r, jWrite: out integer range 0 to 9
	);
end entity;

architecture t of collision_detec is

signal writeBlock, timer_collision: std_logic := '0';
signal count: integer range 0 to 11 := 0;

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
if(start = '1' or control_clk = '1') then
	count <= 0;
	gameOver <= '0';
	wrenField <= '0';
	collisionBlock <= '0';
elsif(rising_edge(clk) and timer_collision = '1' and count = 0) then
	count <= 1;
	i1_r <= i1 + 1;
	j1_r <= j1;
elsif(rising_edge(clk) and count = 1 and timer_collision = '1') then
	if(isFilled1 = '1' or i1 = 19 or i2 = 19 or i3 = 19 or i4 = 19) then
		writeBlock <= '1';
		if((i1 < 0) or (i2 < 0) or (i3 < 0) or (i4 < 0)) then
			gameOver <= '1';
			writeBlock <= '0';
		end if;
	end if;
	count <= 2;
	i1_r <= i2 + 1;
	j1_r <= j2;
elsif(rising_edge(clk) and count = 2  and timer_collision = '1') then
	if(isFilled1 = '1' or i1 = 19 or i2 = 19 or i3 = 19 or i4 = 19) then
		writeBlock <= '1';
		if((i1 < 0 ) or (i2 < 0) or (i3 < 0) or (i4 < 0)) then
			gameOver <= '1';
			writeBlock <= '0';
		end if;
	end if;
	count <= 3;
	i1_r <= i3 + 1;
	j1_r <= j3;
elsif(rising_edge(clk) and count = 3 and timer_collision = '1') then
	if(isFilled1 = '1' or i1 = 19 or i2 = 19 or i3 = 19 or i4 = 19) then
		writeBlock <= '1';
		if((i1 < 0 ) or (i2 < 0) or (i3 < 0) or (i4 < 0)) then
			gameOver <= '1';
			writeBlock <= '0';
		end if;
	end if;
	count <= 4;
	i1_r <= i4 + 1;
	j1_r <= j4;
elsif(rising_edge(clk) and count = 4 and timer_collision = '1') then
		if(isFilled1 = '1' or i1 = 19 or i2 = 19 or i3 = 19 or i4 = 19) then
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
elsif(rising_edge(clk) and control_clk = '1') then
	count <= 0;
	gameOver <= '0';
	wrenField <= '0';
	collisionBlock <= '0';
end if;
end process;



end architecture;