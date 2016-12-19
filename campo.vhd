library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity campo is
	port ( w_en, clk, rst_geral, collision: in std_logic;
			 i_vga : in integer range 0 to 19;
			 j_vga : in integer range 0 to 9;
			 i_write : in integer range 0 to 19;
			 j_write : in integer range 0 to 9; 
			 i_read : in integer range 0 to 19; 
			 j_read : in integer range 0 to 9; 
			 data_in : in std_logic;
			 data_out_vga : out std_logic := '0';
			 data_out_read : out std_logic := '0';
			 speedup : buffer std_logic := '0';
			 score3, score2, score1, score0 : buffer integer range 0 to 9 := 0);
end campo;

architecture behavior of campo is
	TYPE Matriz is array (0 to 19, 0 to 9) of std_logic;
	signal Matriz_Campo : Matriz;
	signal Matriz_Temporaria : Matriz;
	signal Matriz_WEnables: Matriz;
	--signal aux: Matriz;
	signal MT_Preenchida : std_logic := '0';
	signal lc0, mtp1 : std_logic;
	signal line_kill_counter : integer range 0 to 10 := 0;
	
	
	component ffd
		port ( w_en, clk, rst : in std_logic;
				 data_in : in std_logic;
				 data_out : out std_logic := '0');
	end component ffd;
begin		

	FFD_GEN_Y: for y in 0 to 19 generate
		FFD_GEN_X: for x in 0 to 9 generate
			Matriz_WEnables(y,x) <= '1' when ((y = i_write and x = j_write and w_en = '1') or (MT_Preenchida = '1')) else '0'; --se a matriz temporaria estiver preenchida, todos wenables sao ativados
	
			--aux(y,x) <= ((data_in and not(MT_Preenchida)) or (Matriz_Temporaria(y,x) and MT_Preenchida));
	
			FFDS: ffd port map 
				--se a matriz temporaria estiver totalmente preenchida, ela toda serve de entrada pra matriz principal. Caso contrario, cada FF recebe como entrada o data_in normalmente
				(w_en => Matriz_WEnables(y,x), clk => clk, rst => rst_geral, data_in => ((data_in and not(MT_Preenchida)) or (Matriz_Temporaria(y,x) and MT_Preenchida)), data_out => Matriz_Campo(y,x));
				--(w_en => Matriz_WEnables(y,x), clk => clk, rst => rst_geral, data_in => aux(y,x), data_out => Matriz_Campo(y,x));
		end generate FFD_GEN_X;
   end generate FFD_GEN_Y;
	
	data_out_vga <= Matriz_Campo(i_vga, j_vga);
	data_out_read <= Matriz_Campo(i_read, j_read);
	
	-------------------------------- TESTE
--	MT_Preenchida <= '1';
		
		
		
--	FFD_TEMP_Y: for y in 0 to 19 generate
--		FFD_TEMP_X: for x in 0 to 9 generate
--			PREENCHE1: if (x > 2 and x < 7 and y > 5 and y < 14) generate
--				Matriz_Temporaria(y,x) <= '1';
--			end generate PREENCHE1;
--			PREENCHE0: if (x < 2 and x > 7 and y < 5 and y > 14) generate
--				Matriz_Temporaria(y,x) <= '0';
--			end generate PREENCHE0;
--		end generate FFD_TEMP_X;
--   end generate FFD_TEMP_Y;
	
	--------------------------------------
	
	CHECK_LINES: process(collision, clk, rst_geral) --Process que checa se alguma linha foi completamente preenchida
		variable full : std_logic := '1';
		variable contador_de_linha : integer := 19;
	begin
		if(rst_geral = '1') then
			score3 <= 0;
			score2 <= 0;
			score1 <= 0;
			score0 <= 0;
		elsif(collision = '1' and MT_preenchida = '0' and rising_edge(clk)) then --se houver colisÃ£o, entao...
			contador_de_linha := 19;
			-- Loop para, primeiramente, zerar a Matriz temporaria
			for M in 19 downto 0 loop
				for N in 0 to 9 loop
					Matriz_Temporaria(M, N) <= '0';
				end loop;
			end loop;			
		
			-- Loop para identificar as linhas cheias e eliminÃ¡-las, colocando somente as nÃ£o-cheias na Matriz temporaria
			for a in 19 downto 0 loop
				full := Matriz_Campo(a,0) and Matriz_Campo(a,1) and Matriz_Campo(a,2) and Matriz_Campo(a,3) and Matriz_Campo(a,4) and Matriz_Campo(a,5) and Matriz_Campo(a,6) and Matriz_Campo(a,7) and Matriz_Campo(a,8) and Matriz_Campo(a,9);
				
				if full = '0' then -- se a linha atual nao estiver completa, passa ela pra matriz temp. e decrementa o contador de linhas da matriz temporaria
					for b in 0 to 9 loop
						Matriz_Temporaria(contador_de_linha, b) <= Matriz_Campo(a, b);
					end loop;
					contador_de_linha := contador_de_linha - 1;
				
				else -- caso esteja, aumenta os pontos do jogador e incrementa a quantidade de linhas eliminadas (sendo o maximo de contagem de 10 linhas)
					if(score0 = 9) then -- ifs aninhados que atualizam cada um dos bcds 
						score0 <= 0;
						if(score1 = 9) then 
							score1 <= 0;
							if(score2 = 9) then 
								score2 <= 0;
								score3 <= score3 + 1;
							else 
								score2 <= score2 + 1;
							end if;
						else 
							score1 <= score1 + 1;
						end if;
					else	
						score0 <= score0 + 1;
					end if;
					
					if(line_kill_counter < 10) then 
						line_kill_counter <= line_kill_counter + 1;
					elsif(line_kill_counter = 10) then
						line_kill_counter <= 1; -- considerando o valor max sendo 10, ao chegar nele, volta pra 1.
					end if;
				
				end if;
			end loop;
			
			MT_preenchida <= '1';
		elsif(rising_edge(clk) and MT_preenchida = '1') then
			MT_preenchida <= '0';
		end if;
	end process;
	
	SPEEDUP_PROCESS: process(line_kill_counter, clk) -- processo que cuida de ligar e desligar o sinal que indica que o temporizador deve acelerar
	begin
		if(rising_edge(clk) and (line_kill_counter = 10) and (speedup = '0')) then -- de 10 em 10 linhas eliminadas, aumena a velocidade
			speedup <= '1';
		elsif(rising_edge(clk) and (speedup /= '0')) then
			speedup <= '0';
		end if;
	end process;
	
end behavior;