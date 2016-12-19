library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity blocktype_to_7seg is
port (clk : in std_logic;
      block_type : in std_logic_vector(2 downto 0);
      segment7_left : out std_logic_vector(0 to 7);  -- 8 bit decoded output. (7 segment + dot)
		segment7_right : out std_logic_vector(0 to 7);
		sgmt_block_number : out std_logic_vector(0 to 7) -- display that will show the number of the block
     );
end blocktype_to_7seg;

architecture Behavioral of blocktype_to_7seg is

begin
process (clk,block_type)
BEGIN
	if (rising_edge(clk)) then
		case  block_type is
			when "000"=> -- I
				segment7_left <="11111111"; 
				segment7_right <="11110011"; 
				sgmt_block_number <="00000011"; 
			when "001"=> -- Inverted L
				segment7_left <="11100110";  
				segment7_right <="11101111";
				sgmt_block_number <="10011111"; 
			when "010"=> -- L
				segment7_left <="11101110"; 
				segment7_right <="11001111"; 
				sgmt_block_number <="00100101"; 
			when "011"=> -- Square
				segment7_left <="01100011"; 
				segment7_right <="00001111"; 
				sgmt_block_number <="00001101"; 
			when "100"=> -- S 
				segment7_left <="11001111"; 
				segment7_right <="11111101"; 
				sgmt_block_number <="10011001"; 
			when "101"=> -- T
				segment7_left <="11001110"; 
				segment7_right <="11101111"; 
				sgmt_block_number <="01001001"; 
			when "110"=> -- Z
				segment7_left <="11011100";  
				segment7_right <="11101111";
				sgmt_block_number <="01000001"; 
			 --nothing is displayed when a number greater than 6 is given as input. 
			when others=> 
				segment7_left <="11111111";  
				segment7_right <="11111111";
				sgmt_block_number <="00011111"; 
		end case;
	end if;
end process;

end Behavioral;