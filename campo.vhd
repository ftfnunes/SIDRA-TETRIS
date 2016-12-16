library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity campo is
	port ( w_en, clk, rst_geral, collision: in std_logic;
			 i : in integer range 0 to 19;
			 j : in integer range 0 to 9;
			 data_in : in std_logic;
			 data_out, linhas_checadas : out std_logic := '0');
end campo;

architecture behavior of campo is
	TYPE Matriz is array (0 to 19, 0 to 9) of std_logic;
	signal Matriz_Campo : Matriz;
	signal Matriz_Temporaria : Matriz;
	signal Matriz_WEnables: Matriz;
	signal MT_Preenchida : std_logic := '0';
	
	component ffd
		port ( w_en, clk, rst : in std_logic;
				 data_in : in std_logic;
				 data_out : out std_logic := '0');
	end component ffd;
begin		
	
	FFD_GEN_Y: for y in 0 to 19 generate
		FFD_GEN_X: for x in 0 to 9 generate
			Matriz_WEnables(y,x) <= '1' when ((y = i and x = j and w_en = '1') or (MT_Preenchida = '1')) else '0'; --se a matriz temporaria estiver preenchida, todos wenables sao ativados
	
			FFDS: ffd port map 
				--se a matriz temporaria estiver totalmente preenchida, ela toda serve de entrada pra matriz principal. Caso contrario, cada FF recebe como entrada o data_in normalmente
				(w_en => Matriz_WEnables(y,x), clk => clk, rst => rst_geral, data_in => ((data_in and not(MT_Preenchida)) or (Matriz_Temporaria(y,x) and MT_Preenchida)), data_out => Matriz_Campo(y,x));
		end generate FFD_GEN_X;
   end generate FFD_GEN_Y;
	
	-------------------------------- TESTE
	MT_Preenchida <= '1';
	
	FFD_TEMP_Y: for y in 0 to 19 generate
		FFD_TEMP_X: for x in 0 to 9 generate
			PREENCHE1: if (x > 2 and x < 7 and y > 5 and y < 14) generate
				Matriz_Temporaria(y,x) <= '1';
			end generate PREENCHE1;
			PREENCHE0: if (x < 2 and x > 7 and y < 5 and y > 14) generate
				Matriz_Temporaria(y,x) <= '0';
			end generate PREENCHE0;
		end generate FFD_TEMP_X;
   end generate FFD_TEMP_Y;
	
	--------------------------------------
	
	
	CHECK_LINES: process(collision) --Process que checa se alguma linha foi completamente preenchida
		variable full : std_logic := '1';
		variable contador_de_linha : integer := 19;
	begin
		linhas_checadas <= '0';
		if(rising_edge(collision)) then --se houver colisão, entao...
			
			-- Loop para, primeiramente, zerar a Matriz temporaria
			for M in 19 downto 0 loop
				for N in 0 to 9 loop
					Matriz_Temporaria(M, N) <= '0';
				end loop;
			end loop;			
		
			-- Loop para identificar as linhas cheias e eliminá-las, colocando somente as não-cheias na Matriz temporaria
			for a in 19 downto 0 loop
				full := Matriz_Campo(a,0) and Matriz_Campo(a,1) and Matriz_Campo(a,2) and Matriz_Campo(a,3) and Matriz_Campo(a,4) and Matriz_Campo(a,5) and Matriz_Campo(a,6) and Matriz_Campo(a,7) and Matriz_Campo(a,8) and Matriz_Campo(a,9);
				
				if full = '0' then -- se a linha atual nao estiver completa, passa ela pra matriz temp. e decrementa o contador de linhas da matriz temporaria
					for b in 0 to 9 loop
						Matriz_Temporaria(contador_de_linha, b) <= Matriz_Campo(a, b);
					end loop;
					contador_de_linha := contador_de_linha - 1;
				end if;
			end loop;
			
			MT_Preenchida <= '1'; -- aciona a flag dizendo que a matriz temporaria foi completamente preenchida
			
			wait until rising_edge(clk);
			
			linhas_checadas <= '1';
			
			MT_Preenchida <= '0';
			
		end if;
	end process;
end behavior;