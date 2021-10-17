-------ALU-------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is port (
A : in  STD_LOGIC_VECTOR(3 downto 0); --Se declara la entrada de la señal de reloj
B : in  STD_LOGIC_VECTOR(3 downto 0); --Se declara la entrada de la señal de reloj
sel: in STD_LOGIC_VECTOR(2 downto 0);
C : inout  STD_LOGIC_VECTOR(7 downto 0)); --Se declara señal de salida a anodos
end ALU;

architecture Behavioral of ALU is 
signal aux: STD_LOGIC_VECTOR(3 downto 0);
signal auxc: STD_LOGIC_VECTOR(7 downto 0);
begin
process(sel,A,B,aux,c) begin
	
	case (sel) is
		--Operaciones Aritméticas
		when "000" => C <= A + B + "00000000";
		when "001" => 
			if A < B then
				C <= A - B + "00010000";
			else
				C <= A - B + "00000000";
			end if;
		when "010" => C <= A * B + "00000000";
		when "011" => 
			if B = "0000" then
				C <= "00000000";
			else
				aux <= A;
				for k in 0 to 15 loop
					if aux >= B then
						aux <= aux - B;
						C <= C + 1 + "00000000";
					end if;
				end loop;
			end if;
		
		--Operaciones Lógicas
		when "100" => C <= not A + "00000000";
		when "101" => C <= A and B + "00000000";
		when "110" => C <= A or B + "00000000";
		when "111" => C <= A xor B + "00000000";
		when others => null;
	end case;

end process;

end Behavioral;
