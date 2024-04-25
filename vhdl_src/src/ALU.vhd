--32 bit integer SIMD ALU

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

-- mode posible values
-- add    : "0000"
-- sll    : "0001"
-- slt    : "0010"
-- sltu   : "0011"
-- xor    : "0100"
-- srl    : "0101"
-- or     : "0110"
-- and    : "0111"
-- sra    : "1000"
-- sub    : "1001"


-- len posible values
-- 32 bit operations: "00"
-- 16 bit operations: "01"
-- 8 bit operations:  "10"

entity ALU_RISC is 
port (
	op1     : in std_logic_vector(31 downto 0);
	op2     : in std_logic_vector(31 downto 0);
	mode    : in std_logic_vector(3 downto 0);
	len     : in std_logic_vector(1 downto 0);
	res     : out std_logic_vector(31 downto 0));
end ALU_RISC;

architecture behavioral of ALU_RISC is


	signal slt_8_0, slt_8_1, slt_8_2, slt_8_3 : std_logic_vector(7 downto 0);
	signal sltu_8_0, sltu_8_1, sltu_8_2, sltu_8_3 : std_logic_vector(7 downto 0);

	signal slt_16_0, slt_16_1 : std_logic_vector(15 downto 0);
	signal sltu_16_0, sltu_16_1 : std_logic_vector(15 downto 0);

	signal slt_32, sltu_32 : std_logic_vector(31 downto 0);

	signal op1_16_0, op1_16_1 : std_logic_vector(15 downto 0);
	signal op2_16_0, op2_16_1 : std_logic_vector(15 downto 0);
	
	signal res8_0, res8_1, res8_2, res8_3 : std_logic_vector(7 downto 0);
	signal res16_0, res16_1 : std_logic_vector(15 downto 0);

	signal op1_8_0, op1_8_1, op1_8_2, op1_8_3 : std_logic_vector(7 downto 0);
	signal op2_8_0, op2_8_1, op2_8_2, op2_8_3 : std_logic_vector(7 downto 0);

	signal res_8_0, res_8_1, res_8_2, res_8_3 : std_logic_vector(7 downto 0);

	signal res32, res8 : std_logic_vector(31 downto 0);

begin


	-- 8 bit operands

	op1_8_0 <= op1(7 downto 0);
	op1_8_1 <= op1(15 downto 8);
	op1_8_2 <= op1(23 downto 16);
	op1_8_3 <= op1(31 downto 24);

	op2_8_0 <= op2(7 downto 0);
	op2_8_1 <= op2(15 downto 8);
	op2_8_2 <= op2(23 downto 16);
	op2_8_3 <= op2(31 downto 24);

	-- 16 bit operands

	op1_16_0 <= op1(15 downto 0);
	op1_16_1 <= op1(31 downto 16);

	op2_16_0 <= op2(15 downto 0);
	op2_16_1 <= op2(31 downto 16);

	-- 8 bit slt y sltu

	slt_8_0 <= (others => '1') when signed(op1_8_0) < signed(op2_8_0)
				else (others => '0');
	slt_8_1 <= (others => '1') when signed(op1_8_1) < signed(op2_8_1)
				else (others => '0');
	slt_8_2 <= (others => '1') when signed(op1_8_2) < signed(op2_8_2)
				else (others => '0');
	slt_8_3 <= (others => '1') when signed(op1_8_3) < signed(op2_8_3)
				else (others => '0');
	
	sltu_8_0 <= (others => '1') when unsigned(op1_8_0) < unsigned(op2_8_0)
				else (others => '0');
	sltu_8_1 <= (others => '1') when unsigned(op1_8_1) < unsigned(op2_8_1)
				else (others => '0');
	sltu_8_2 <= (others => '1') when unsigned(op1_8_2) < unsigned(op2_8_2)
				else (others => '0');
	sltu_8_3 <= (others => '1') when unsigned(op1_8_3) < unsigned(op2_8_3)
				else (others => '0');

	-- 16 bit slt y sltu

	slt_16_0 <= (others => '1') when signed(op1_16_0) < signed(op2_16_0)
				else (others => '0');
	slt_16_1 <= (others => '1') when signed(op1_16_1) < signed(op2_16_1)
				else (others => '0');
	
	sltu_16_0 <= (others => '1') when unsigned(op1_16_0) < unsigned(op2_16_0)
				else (others => '0');
	sltu_16_1 <= (others => '1') when unsigned(op1_16_1) < unsigned(op2_16_1)
				else (others => '0');

	slt_32 <= 	(0 => '1', others => '0') when signed(op1) < signed(op2)
		else (others => '0');

	sltu_32 <= (0 => '1', others => '0') when unsigned(op1) < unsigned(op2)
		else (others => '0');

	
	-- 8 bit results

	res8_0 <= std_logic_vector(signed(op1_8_0) + signed(op2_8_0)) when mode = "0000"
	else 	std_logic_vector(shift_left(unsigned(op1_8_0), to_integer(unsigned(op2(2 downto 0))))) when mode = "0001"
	else	slt_8_0 when mode = "0010"
	else	sltu_8_0 when mode = "0011"
	else 	std_logic_vector(shift_right(unsigned(op1_8_0), to_integer(unsigned(op2(2 downto 0))))) when mode = "0101"
	else	std_logic_vector(shift_right(signed(op1_8_0), to_integer(unsigned(op2(2 downto 0))))) when mode = "1000"
	else	std_logic_vector(signed(op1_8_0) - signed(op2_8_0)) when mode = "1001"
	else	(others => '0');

	res8_1 <= std_logic_vector(signed(op1_8_1) + signed(op2_8_1)) when mode = "0000"
	else 	std_logic_vector(shift_left(unsigned(op1_8_1), to_integer(unsigned(op2(2 downto 0))))) when mode = "0001"
	else	slt_8_1 when mode = "0010"
	else	sltu_8_1 when mode = "0011"
	else 	std_logic_vector(shift_right(unsigned(op1_8_1), to_integer(unsigned(op2(2 downto 0))))) when mode = "0101"
	else	std_logic_vector(shift_right(signed(op1_8_1), to_integer(unsigned(op2(2 downto 0))))) when mode = "1000"
	else	std_logic_vector(signed(op1_8_1) - signed(op2_8_1)) when mode = "1001"
	else	(others => '0');

	res8_2 <= std_logic_vector(signed(op1_8_2) + signed(op2_8_2)) when mode = "0000"
	else 	std_logic_vector(shift_left(unsigned(op1_8_2), to_integer(unsigned(op2(2 downto 0))))) when mode = "0001"
	else	slt_8_2 when mode = "0010"
	else	sltu_8_2 when mode = "0011"
	else 	std_logic_vector(shift_right(unsigned(op1_8_2), to_integer(unsigned(op2(2 downto 0))))) when mode = "0101"
	else	std_logic_vector(shift_right(signed(op1_8_2), to_integer(unsigned(op2(2 downto 0))))) when mode = "1000"
	else	std_logic_vector(signed(op1_8_2) - signed(op2_8_2)) when mode = "1001"
	else	(others => '0');

	res8_3 <= std_logic_vector(signed(op1_8_3) + signed(op2_8_3)) when mode = "0000"
	else 	std_logic_vector(shift_left(unsigned(op1_8_3), to_integer(unsigned(op2(2 downto 0))))) when mode = "0001"
	else	slt_8_3 when mode = "0010"
	else	sltu_8_3 when mode = "0011"
	else 	std_logic_vector(shift_right(unsigned(op1_8_3), to_integer(unsigned(op2(2 downto 0))))) when mode = "0101"
	else	std_logic_vector(shift_right(signed(op1_8_3), to_integer(unsigned(op2(2 downto 0))))) when mode = "1000"
	else	std_logic_vector(signed(op1_8_3) - signed(op2_8_3)) when mode = "1001"
	else	(others => '0');

	-- 16 bit results

	res16_0 <= std_logic_vector(signed(op1_16_0) + signed(op2_16_0)) when mode = "0000"
	else 	std_logic_vector(shift_left(unsigned(op1_16_0), to_integer(unsigned(op2(3 downto 0))))) when mode = "0001"
	else	slt_16_0 when mode = "0010"
	else	sltu_16_0 when mode = "0011"
	else 	std_logic_vector(shift_right(unsigned(op1_16_0), to_integer(unsigned(op2(3 downto 0))))) when mode = "0101"
	else	std_logic_vector(shift_right(signed(op1_16_0), to_integer(unsigned(op2(3 downto 0))))) when mode = "1000"
	else	std_logic_vector(signed(op1_16_0) - signed(op2_16_0)) when mode = "1001"
	else	(others => '0');

	res16_1 <= std_logic_vector(signed(op1_16_1) + signed(op2_16_1)) when mode = "0000"
	else 	std_logic_vector(shift_left(unsigned(op1_16_1), to_integer(unsigned(op2(3 downto 0))))) when mode = "0001"
	else	slt_16_1 when mode = "0010"
	else	sltu_16_1 when mode = "0011"
	else 	std_logic_vector(shift_right(unsigned(op1_16_1), to_integer(unsigned(op2(3 downto 0))))) when mode = "0101"
	else	std_logic_vector(shift_right(signed(op1_16_1), to_integer(unsigned(op2(3 downto 0))))) when mode = "1000"
	else	std_logic_vector(signed(op1_16_1) - signed(op2_16_1)) when mode = "1001"
	else	(others => '0');
	
	-- 32 bit results

	res32 <= std_logic_vector(signed(op1) + signed(op2)) when mode = "0000"
	else 	std_logic_vector(shift_left(unsigned(op1), to_integer(unsigned(op2(4 downto 0))))) when mode = "0001"
	else	slt_32 when mode = "0010"
	else	sltu_32 when mode = "0011"
	else	op1 xor op2 when mode = "0100"
	else 	std_logic_vector(shift_right(unsigned(op1), to_integer(unsigned(op2(4 downto 0))))) when mode = "0101"
	else 	op1 or op2 when mode = "0110"
	else 	op1 and op2 when mode = "0111"
	else	std_logic_vector(shift_right(signed(op1), to_integer(unsigned(op2(4 downto 0))))) when mode = "1000"
	else	std_logic_vector(signed(op1) - signed(op2)) when mode = "1001"
	else	(others => '0');

	-- result selection

	res <= res32 when (len = "00" or mode = "0100" or mode = "0110" or mode = "0111")
	else res16_1 & res16_0 when len = "01"
	else res8_3 & res8_2 & res8_1 & res8_0 when len = "10"
	else (others => '0');
	
	

end behavioral ; -- arch