LIBRARY ieee;
USE IEEE.numeric_std.ALL;
USE ieee.std_logic_1164.ALL;

ENTITY ALU IS
	GENERIC (n : INTEGER := 32);
	PORT (
		inp1, inp2 : IN STD_LOGIC_VECTOR (n - 1 DOWNTO 0); --Inputs
		opr : IN STD_LOGIC_VECTOR (4 DOWNTO 0); --Operation to be done, take only 4 bits (2->5)
		result_output : OUT STD_LOGIC_VECTOR (n - 1 DOWNTO 0); --Result of operation
		zero_flag, negative_flag, carry_flag : OUT STD_LOGIC); --Flags
END ENTITY ALU;

ARCHITECTURE arch1 OF ALU IS
	SIGNAL result : STD_LOGIC_VECTOR(n DOWNTO 0); --The output of the operation
	SIGNAL carry_add, carry_sub : STD_LOGIC; --Carry resulted from add/sub operation
BEGIN

	--Update carry value
	WITH opr SELECT
		carry_flag <= '1' WHEN "00001", --SETC
		'0' WHEN "00010", --CLRC
		result(0) WHEN "01111" , --SHR
		result(n) WHEN OTHERS; --SHL/ADD/IADD/SUB
	--Update results based on operation
	WITH opr SELECT
		result <= '0' & NOT inp1 WHEN "00011", --NOT
		STD_LOGIC_VECTOR('0'& unsigned(inp1) + to_unsigned(1,n+1)) WHEN "00100", --INC
		STD_LOGIC_VECTOR('0'& unsigned(inp1) - to_unsigned(1, n+1)) WHEN "00101", --DEC
		'0' & inp1 WHEN "01000", --MOV
		'0' & inp2 WHEN "00110" | "00111", --IN/OUT
		STD_LOGIC_VECTOR(('0'&unsigned(inp1)) + ('0'&unsigned(inp2))) WHEN "01001" | "01010", --ADD/IADD
		STD_LOGIC_VECTOR(('0'&unsigned(inp1)) - ('0'&unsigned(inp2))) WHEN "01011", --SUB
		'0' & (inp1 AND inp2) WHEN "01100", --AND
		'0' & (inp1 OR inp2) WHEN "01101", --OR
		STD_LOGIC_VECTOR(shift_left(signed('0' & inp1), to_integer(unsigned(inp2)))) WHEN "01110", --SHL
		STD_LOGIC_VECTOR(shift_right(signed(inp1 & inp1(0)), to_integer(unsigned(inp2)))) WHEN "01111", --SHR
		'0' & inp1 WHEN OTHERS;
	--Update zero flag
	zero_flag <= '1' WHEN unsigned(result(n-1 downto 0)) = to_unsigned(0, 32) ELSE '0';
	--Update negative flag
	negative_flag <= '1' WHEN result(n - 1) = '1' ELSE '0';

	result_output <= result(n downto 1) when opr = "01111" else result(n-1 downto 0);

END arch1;