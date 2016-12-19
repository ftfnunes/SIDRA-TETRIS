library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity timer is
	port ( clk, speedup, start : in std_logic;
			 control_clk, collision_clk : out std_logic := '0');
end timer;

architecture behavior of timer is
	signal counter : integer range 0 to 40000001 := 0;
	signal base_time : integer range 5000000 to 40000000 := 40000000;
	signal en : std_logic;
begin
	process(start) begin		
		if(start = '1') then
			en <= '1';
		end if;
	end process;
	
	process(clk) -- process que controla todos os clocks secundarios e a velocidade deles, baseado no speedup
	begin
		if(rising_edge(clk) and speedup = '1') then
			if(base_time > 5000000) then
				base_time <= base_time - 5000000;
			end if;
		end if;
		if(rising_edge(clk) and en = '1') then 
			if(counter = base_time - 1000) then 
				collision_clk <= '1';
				counter <= counter + 1;
			elsif(counter = base_time - 999) then
				collision_clk <= '0';
				counter <= counter + 1;
			elsif(counter = base_time) then
				control_clk <= '1';
				counter <= counter + 1;
			elsif(counter = base_time + 1) then
				control_clk <= '0';
				counter <= 0;
			else 
				counter <= counter + 1;
			end if;
		end if;
	end process;

end behavior;