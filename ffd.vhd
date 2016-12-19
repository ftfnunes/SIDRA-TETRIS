library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ffd is
	port ( w_en, clk, rst : in std_logic;
			 data_in : in std_logic;
			 data_out : out std_logic := '0');
end ffd;

architecture behavior of ffd is
begin		
	process(clk, rst)
	begin
		if(rst = '1') then 
			data_out <= '0';
		elsif(rising_edge(clk) and w_en = '1') then
			data_out <= data_in;
		end if;
	end process;
end behavior;