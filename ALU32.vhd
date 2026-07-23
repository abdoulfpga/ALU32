LIBRARY ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

-- LIBRARIES
-- Types de base (std_logic, std_logic_vector)
-- Opérations numériques (unsigned, signed)


 -- ENTITY interface du composant
 
 entity alu_32bit is 
	
	port( 
	
		  clk       : in  std_logic;   --clk principale 
        reset     : in  std_logic;   -- reset 
        operand_a : in  std_logic_vector(31 downto 0); -- A data
        operand_b : in  std_logic_vector(31 downto 0); -- B data 
        operation : in  std_logic_vector(3 downto 0);
		  shift_amt : in  std_logic_vector(4 downto 0);
        result    : out std_logic_vector(31 downto 0);
        flags     : out std_logic_vector(3 downto 0)
    );
end entity alu_32bit;

			

--Architecture (implémentation ) 

architecture rtl of alu_32bit is 

    signal result_comb : std_logic_vector(32 downto 0);
    
    constant OP_ADD : std_logic_vector(3 downto 0) := "0000";
    constant OP_SUB : std_logic_vector(3 downto 0) := "0001";
    constant OP_AND : std_logic_vector(3 downto 0) := "0010";
    constant OP_OR : std_logic_vector(3 downto 0) := "0011";
    constant OP_XOR : std_logic_vector(3 downto 0) := "0100";
    constant OP_NOT : std_logic_vector(3 downto 0) := "0101";
    constant OP_SHL : std_logic_vector(3 downto 0) := "0110";
    constant OP_SHR : std_logic_vector(3 downto 0) := "0111";
    constant OP_SAR : std_logic_vector(3 downto 0) := "1000";

begin 
		process (clk,reset) is
		begin 
		
		--structure 
		
				if reset = '1' then 
				
							result<= (others=>'0'); 
							flags <=(others=>'0'); 
				elsif rising_edge(clk) then 
				
						case operation is  
						
								when OP_ADD =>
								
										result_comb<= ('0' & operand_a) + ('0' & operand_b);
										
										
										
								when OP_SUB =>
								
										result_comb<= ('0' & operand_a) - ('0' & operand_b);
										
										
								when OP_AND =>
								
										result_comb(31 downto 0) <= operand_a AND operand_b;
										result_comb(32) <= '0';
										
										
									 
								when OP_OR =>
								
										result_comb(31 downto 0) <= operand_a OR operand_b;
										result_comb(32) <= '0';
										
										
									 
								when OP_XOR =>
								
										result_comb(31 downto 0) <= operand_a XOR operand_b;
										result_comb(32) <= '0';
										
										
										
									 
								when OP_NOT =>
								
										result_comb(31 downto 0) <= NOT operand_a;
										result_comb(32) <= '0';
										
										

								when OP_SHL =>
								
										result_comb(31 downto 0) <= std_logic_vector(shift_left(unsigned(operand_a), to_integer(unsigned(shift_amt))));result_comb(32) <= '0';
								
								
								when OP_SHR =>
								
										result_comb(31 downto 0) <=std_logic_vector(shift_right(unsigned(operand_a), to_integer(unsigned(shift_amt))));result_comb(32) <= '0';
								
								
								
								when OP_SAR =>
								
										result_comb(31 downto 0) <=std_logic_vector(shift_right(signed(operand_a), to_integer(unsigned(shift_amt))));result_comb(32) <= '0';

								
								
								
								
								
								
								when others =>
								
										result_comb <=(others => '0'); 
						
						
						end case ; 
						
						
						
						result <= result_comb(31 downto 0 ); 
						
						flags(0) <= '1' when result_comb(31 downto 0) = 0 else '0' ; --Zero 
						
						flags(1) <= result_comb(32); -- Carry flag
						
						flags(2) <= (operand_a(31) XNOR operand_b(31))  and  (operand_a(31) XOR result_comb(31));-- overflow 
						
						flags(3) <= result_comb(31); 
				
				
				
				end if; 
							
							
							
		
		
		
		
		
		
		
		end process ; 
end architecture rtl ; 
