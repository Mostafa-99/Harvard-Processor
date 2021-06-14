LIBRARY ieee;
USE IEEE.numeric_std.ALL;
USE ieee.std_logic_1164.ALL;

ENTITY DecodeStage IS
    PORT (
        clk, rst : IN STD_LOGIC; --Clock, Reset
        register1, register2 : IN STD_LOGIC_VECTOR(2 DOWNTO 0); --The registers to be decoded
        immediate_value_non_extended : IN STD_LOGIC_VECTOR(15 DOWNTO 0); --The immediate value before sign extending it
        MemWB_WB : IN STD_LOGIC; --Write back signal
        MemWB_Rd : IN STD_LOGIC_VECTOR (2 DOWNTO 0); --Register destination address used for write back
        MemWB_Val : IN STD_LOGIC_VECTOR(31 DOWNTO 0); --The data to be written in write back 
        register1_decoded, register2_decoded : OUT STD_LOGIC_VECTOR(31 DOWNTO 0); --The value after decoding the register
        immediate_value_sign_extended : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) --The value of the immediate value after sign extending
    );
END ENTITY DecodeStage;

ARCHITECTURE DecodeStage1 OF DecodeStage IS

    COMPONENT RegisterFile IS
        GENERIC (n : INTEGER := 32);
        PORT (
            write_data : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0); --Data to be written
            write_enable, clk, rst : IN STD_LOGIC; --Enable for writing, the clock, and reset
            read_address1, read_address2, write_address : IN STD_LOGIC_VECTOR(2 DOWNTO 0); --The address for decoding R1, R2, and to write in
            decoded_output1, decoded_output2 : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0) --The decoded output
        );
    END COMPONENT;

    COMPONENT SignExtend IS
        PORT (
            data_in : IN STD_LOGIC_VECTOR(16 - 1 DOWNTO 0);
            data_out : OUT STD_LOGIC_VECTOR(32 - 1 DOWNTO 0)
        );
    END COMPONENT;

BEGIN
    --Instantiate the register file
    register_file_1 : RegisterFile GENERIC MAP(32) PORT MAP(MemWB_Val, MemWB_WB, clk, rst, register1, register2, MemWB_Rd, register1_decoded, register2_decoded);
    --Instantiate the sign extender
    sign_extender_1 : SignExtend PORT MAP(immediate_value_non_extended, immediate_value_sign_extended);

END DecodeStage1;