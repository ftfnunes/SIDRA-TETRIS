library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity random_uniform is
    generic (OUT_WIDTH : integer := 3);
    Port ( clk : in  STD_LOGIC;
           random :  out  std_logic_vector(OUT_WIDTH-1 downto 0);
            SEED : in STD_LOGIC_VECTOR(30 downto 0);
			  reset : in  STD_LOGIC);
end random_uniform;

architecture Behavioral of random_uniform is

signal rand : std_logic_vector(30 downto 0) := SEED;
signal feedback : std_logic;

begin

feedback <= not((rand(0) xor rand(3)));

process(clk,reset)
begin
if reset = '1' then
    rand <= SEED;
elsif rising_edge(clk) then
    rand <= feedback&rand(30 downto 1);
end if;
end process;

process (rand) begin
	random <= rand(OUT_WIDTH-1 downto 0);
	if (rand(OUT_WIDTH-1 downto 0) = "111") then
		random <= "110";
	end if;
end process;
end Behavioral;