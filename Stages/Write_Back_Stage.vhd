LIBRARY ieee;
USE IEEE.numeric_std.ALL;
USE ieee.std_logic_1164.ALL;

ENTITY WriteBackStage IS
    PORT (
        clk, rst : IN STD_LOGIC; --Clock, Reset
        MemWB_data : IN STD_LOGIC_VECTOR(31 DOWNTO 0); --Value read from data memory
        MemWB_ALU_result : IN STD_LOGIC_VECTOR(31 DOWNTO 0); --Value from of the result of the ALU
        MemWB_mem_to_reg : IN STD_LOGIC; --Flag to indicate if store instruction or not
        input_port : IN STD_LOGIC_VECTOR(31 DOWNTO 0); --Value of the input port
        input_port_enable : IN STD_LOGIC; --Enable for input port
        write_back_value : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) --Value used to write back
    );
END ENTITY WriteBackStage;

ARCHITECTURE WriteBackStage1 OF WriteBackStage IS

    COMPONENT MUX2 IS
        GENERIC (n : INTEGER := 32);
        PORT (

            s : IN STD_LOGIC;
            data_in1 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            data_in2 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            data_out : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0));

    END COMPONENT;

SIGNAL mux1_output : STD_LOGIC_VECTOR(31 downto 0);

BEGIN
    --Instantiate the first MUX (to choose between alu result and loaded value)
    m1: MUX2 generic map(32) port map(MemWB_mem_to_reg, MemWB_data, MemWB_ALU_result, mux1_output);
    --Instantiate the second MUX (to choose between result of the first alu and the input port)
    m2: MUX2 generic map(32) port map(input_port_enable, input_port, mux1_output, write_back_value);

END WriteBackStage1;