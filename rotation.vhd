library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rotation is
	port(
		clk, roda, isFilled: in std_logic;
		block_type: in integer range 0 to 6;
		i1, i2, i3, i4: in integer range 0 to 19;
		j1, j2, j3, j4: in integer range 0 to 9;
		makeRotation, rotating: out std_logic;
		i: buffer integer range 0 to 19;
		j: buffer integer range 0 to 9;
		i1out, i2out, i3out, i4out: out integer range 0 to 19;
		j1out, j2out, j3out, j4out: out integer range 0 to 9
	);
end entity;

architecture rotate of rotation is

signal block0count, block1count, block2count, block3count, block4count, block5count, block6count: integer range 0 to 10 := 0;
signal naoRoda: std_logic := '0';

begin

block0: process(clk)
begin
	if(rising_edge(clk) and block_type = 0 and roda = '1') then
		rotating <= '1';
		block0count <= 1;
		block1count <= 0;
		block2count <= 0;
		block3count <= 0;
		block4count <= 0;
		block5count <= 0;
		block6count <= 0;
		naoRoda <= '0';
		
		
		i <= i1;
		j <= j1;
		
		if(j1 > 6 and j1 = j2) then
		j <= 6;
		end if;
		
		block0count <= 1;
		
	elsif(rising_edge(clk) and block_type = 0 and block0count = 1) then
		if(isFilled = '1') then
			naoRoda <= '1';
		else
			i1out <= i;
			j1out <= j;
		end if;
		
		if(i1 = i2) then
			i <= i1 + 1;
			j <= j1;
		elsif(j1 > 6 and j1 = j2) then
			i <= i1;
			j <= 7;
		else
			i <= i1;
			j <= j1 + 1;
		end if;
		
		block0count <= 2;
	elsif(rising_edge(clk) and block_type = 0 and block0count = 2) then
		if(isFilled = '1') then
			naoRoda <= '1';
		else
			i2out <= i;
			j2out <= j;
		end if;
		
		if(i1 = i3) then
			i <= i1 + 2;
			j <= j1;
		elsif(j1 > 6 and j1 = j2) then
			i <= i1;
			j <= 8;
		else
			i <= i1;
			j <= j1 + 2;
		end if;
		
		block0count <= 3;
		
	elsif(rising_edge(clk) and block_type = 0 and block0count = 3) then
		if(isFilled = '1') then
			naoRoda <= '1';
		else
			i3out <= i;
			j3out <= j;
		end if;
		
		if(i1 = i4) then
			i <= i1 + 3;
			j <= j1;
		elsif(j1 > 6 and j1 = j2) then
			i <= i1;
			j <= 9;
		else
			i <= i1;
			j <= j1 + 3;
		end if;		
		
		
		block0count <= 4;
	elsif(rising_edge(clk) and block_type = 0 and block0count = 4) then
		if(isFilled = '1') then
			naoRoda <= '1';
		else
			i4out <= i;
			j4out <= j;
		end if;
	
		if(naoRoda = '0') then
			makeRotation <= '1';
		end if;
		
		block0count <= 5;
	elsif(rising_edge(clk) and block_type = 0 and block0count = 5) then
		makeRotation <= '0';
		block0count <= 0;
		rotating <= '0';
		
		
		
--	elsif(rising_edge(clk) and block_type = 1 and roda = '1') then
--		rotating <= '1';
--		block0count <= 0;
--		block1count <= 1;
--		block2count <= 0;
--		block3count <= 0;
--		block4count <= 0;
--		block5count <= 0;
--		block6count <= 0;
--		naoRoda <= '0';
--		i1out <= i1;
--		j1out <= j1;
--		
--		if(i1 = i2) then
--			i <= i1 + 1;
--			j <= j1;
--		else
--			i <= i1;
--			j <= j1 + 1;
--		end if;
--		
--		block1count <= 1;


elsif(rising_edge(clk) and block_type = 4 and roda = '1') then
	rotating <= '1';
		block0count <= 0;
		block1count <= 0;
		block2count <= 0;
		block3count <= 0;
		block4count <= 1;
		block5count <= 0;
		block6count <= 0;
		naoRoda <= '0';
		
		if(i1 = i2) then
		i <= i1;
		j <= j1;
		elsif(j3 = j4 and j4 = 9) then
		i <= i1;
		j <= 8;
		else
		i <= i1;
		j <= j1;
		end if;
		
		block4count <= 1;
		
		
elsif(rising_edge(clk) and block_type = 4 and block4count = 1) then
	if(isFilled = '1') then
		naoRoda <= '1';
	else
		i1out <= i;
		j1out <= j;
	end if;
	
	if(i1 = i2) then
		i <= i2 + 1;
		j <= j2 - 1;
	elsif(j3 = j4 and j4 = 9) then
		i <= i2 - 1;
		j <= 9;
	else
		i <= i2 - 1;
		j <= j2 + 1;
	end if;
		
	block4count <= 2;

elsif(rising_edge(clk) and block_type = 4 and block4count = 2) then
	if(isFilled = '1') then
		naoRoda <= '1';
	else
		i2out <= i;
		j2out <= j;
	end if;
	
	if(i1 = i2) then
		i <= i3;
		j <= j3 + 2;
	elsif(j3 = j4 and j4 = 9) then
		i <= i3;
		j <= 7;
	else
		i <= i3;
		j <= j3 - 2;
	end if;
		
	block4count <= 3;

elsif(rising_edge(clk) and block_type = 4 and block4count = 3) then
	if(isFilled = '1') then
		naoRoda <= '1';
	else
		i3out <= i;
		j3out <= j;
	end if;
	
	if(i1 = i2) then
		i <= i4 + 1;
		j <= j4 + 1;
	elsif(j3 = j4 and j4 = 9) then
		i <= i4 - 1;
		j <= 8;
	else
		i <= i4 - 1;
		j <= j4 - 1;
	end if;
		
	block4count <= 4;

elsif(rising_edge(clk) and block_type = 4 and block4count = 4) then
	if(isFilled = '1') then
		naoRoda <= '1';
	else
		i4out <= i;
		j4out <= j;
	end if;
	
	if(naoRoda = '0') then
		makeRotation <= '1';
	end if;
		
	block4count <= 5;

elsif(rising_edge(clk) and block_type = 4 and block4count = 5) then
		makeRotation <= '0';
		block4count <= 0;
		rotating <= '0';
		
elsif(rising_edge(clk) and block_type = 6 and roda = '1') then
		rotating <= '1';
		block0count <= 0;
		block1count <= 0;
		block2count <= 0;
		block3count <= 0;
		block4count <= 0;
		block5count <= 0;
		block6count <= 1;
		naoRoda <= '0';
		
		
		if(i1 = i2) then
			i <= i1;
			j <= j1 + 2;
		elsif(j1 = j3 and j1 = 9) then
			i <= i1;
			j <= 7;
		else
			i <= i1;
			j <= j1 - 2;
		end if;
			
		block6count <= 1;
	elsif(rising_edge(clk) and block_type = 6 and block6count = 1) then
		if(isFilled = '1') then
			naoRoda <= '1';
		else
			i1out <= i;
			j1out <= j;
		end if;
		
		if(i1 = i2) then
			i <= i2 + 1;
			j <= j2;
		elsif(j1 = j3 and j1 = 9) then
			i <= i2 - 1;
			j <= 8;
		else
			i <= i2 - 1;
			j <= j2;
		end if;
		
		block6count <= 2;
	elsif(rising_edge(clk) and block_type = 6 and block6count = 2) then
		if(isFilled = '1') then
			naoRoda <= '1';
		else
			i2out <= i;
			j2out <= j;
		end if;
	
		
		if(i1 = i2) then
			i <= i3;
			j <= j3 + 1;
		elsif(j3 = j1 and j1 = 9) then
			i <= i3;
			j <= 8;
		else
			i <= i3;
			j <= j3 - 1;
		end if;
		
		block6count <= 3;
		
	elsif(rising_edge(clk) and block_type = 6 and block6count = 3) then
		if(isFilled = '1') then
			naoRoda <= '1';
		else
			i3out <= i;
			j3out <= j;
		end if;
		
		if(i1 = i2) then
			i <= i4 + 1;
			j <= j4 - 1;
		elsif(j1 = j3 and j1 = 9) then
			i <= i4 - 1;
			j <= 9;
		else
			i <= i4 - 1;
			j <= j4 + 1;
		end if;
		
		block6count <= 4;
	elsif(rising_edge(clk) and block_type = 6 and block6count = 4) then
		if(isFilled = '1') then
			naoRoda <= '1';
		else
			i4out <= i;
			j4out <= j;
		end if;
		
		if(naoRoda = '0') then
			makeRotation <= '1';
		end if;
		
		block6count <= 5;
	elsif(rising_edge(clk) and block_type = 6 and block6count = 5) then
		makeRotation <= '0';
		block6count <= 0;
		rotating <= '0';
	end if;
end process;

end rotate;