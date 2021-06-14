LIBRARY ieee;
USE IEEE.numeric_std.ALL;
USE ieee.std_logic_1164.ALL;

ENTITY ExecutionStage IS
    PORT (
        clk, rst, alu_source : IN STD_LOGIC; --Clock, Reset, ALU Source for R2(1 means immediate value)
        opcode : IN STD_LOGIC_VECTOR(5 DOWNTO 0); --Opcode of the operation
        register1_decoded, register2_decoded, immediate_value : IN STD_LOGIC_VECTOR(31 DOWNTO 0); --The value decoded from Rs, Rd, and the immediate value coming from sign extend
        IdEx_Rs, IdEx_Rd, ExMem_Rd, MemWB_Rd : IN STD_LOGIC_VECTOR (2 DOWNTO 0); --Register values used for forwarding
        ExMem_WB, MemWB_WB : IN STD_LOGIC; --Write back signal
        ExMem_Val, MemWB_Val : IN STD_LOGIC_VECTOR(31 downto 0); --The forwarded values from the next stages 
        zero_flag, negative_flag, carry_flag : OUT STD_LOGIC; --The flag register outputs
        alu_result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) --The final output of the ALU execution
    );
END ENTITY ExecutionStage;

ARCHITECTURE ExecutionStage1 OF ExecutionStage IS

    COMPONENT ALU IS
        GENERIC (n : INTEGER := 32);
        PORT (
            inp1, inp2 : IN STD_LOGIC_VECTOR (n - 1 DOWNTO 0); --Inputs
            opr : IN STD_LOGIC_VECTOR (4 DOWNTO 0); --Operation to be done, take only 4 bits (2->5)
            result_output : OUT STD_LOGIC_VECTOR (n - 1 DOWNTO 0); --Result of operation
            zero_flag, negative_flag, carry_flag : OUT STD_LOGIC; --Flags
            flags_enable : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)); --Flags Enable, 0->Zero, 1->Neg, 2->Carry
    END COMPONENT;

    COMPONENT FlagRegister IS
        GENERIC (n : INTEGER := 3);
        PORT (
            clk, rst : IN STD_LOGIC;
            d, enable : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0); -- enable(0) -> Zero, enable(1) -> negative, enable(2) -> carry
            q : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0));
    END COMPONENT;

    COMPONENT ForwardingUnit IS
        PORT (
            IdEx_Rs, IdEx_Rd, ExMem_Rd, MemWB_Rd : IN STD_LOGIC_VECTOR (2 DOWNTO 0); --Register values
            ExMem_WB, MemWB_WB : IN STD_LOGIC; --Write back signal
            R1_signal, R2_signal : OUT STD_LOGIC_VECTOR (1 DOWNTO 0)); --Signal for mux for both inputs of the ALU
    END COMPONENT;

    COMPONENT MUX4 IS
        GENERIC (n : INTEGER := 32);
        PORT (
            s : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            data_in1 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            data_in2 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            data_in3 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            data_in4 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            data_out : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0));
    END COMPONENT;

    signal forwarding_unit_signal1, forwarding_unit_signal2 : STD_LOGIC_VECTOR(1 downto 0);
    signal alu_input1, alu_input2_tmp, alu_input2 : STD_LOGIC_VECTOR(31 downto 0);
    signal alu_flags_output : STD_LOGIC_VECTOR(2 downto 0); --The output of flags for current operation, 0-> zero, 1->neg, 2->carry
    signal alu_flags_enable : STD_LOGIC_VECTOR(2 downto 0); --The output of flags for current operation, 0-> zero, 1->neg, 2->carry
    signal flag_final_value : STD_LOGIC_VECTOR(2 downto 0); --The value of the flag registers
BEGIN


    --Instantiate the MUXes and the correct input for ALU
    m1: MUX4 generic map(32) port map(forwarding_unit_signal1, register1_decoded, ExMem_Val, MemWB_Val, MemWB_Val, alu_input1 );
    m2: MUX4 generic map(32) port map(forwarding_unit_signal2, register2_decoded, ExMem_Val, MemWB_Val, MemWB_Val, alu_input2_tmp ); --We use a tmp register for alu inp2 as we still have to make a condition for immediate values
    alu_input2 <= alu_input2_tmp when alu_source = '0' else immediate_value;
    --Instantiate the ALU unit
    alu1: ALU generic map(32) port map(alu_input1, alu_input2, opcode(4 downto 0), alu_result, alu_flags_output(0), alu_flags_output(1), alu_flags_output(2), alu_flags_enable);
    --Instantiate the ALU Flags register
    ccr1: FlagRegister generic map (3) port map(clk, rst, alu_flags_output, alu_flags_enable, flag_final_value); 
    --Instantiate the Forwarding Unit
    fu1: ForwardingUnit port map(IdEx_Rs, IdEx_Rd, ExMem_Rd, MemWB_Rd, ExMem_WB, MemWB_WB, forwarding_unit_signal1, forwarding_unit_signal2);

    zero_flag <= flag_final_value(0);
    negative_flag <= flag_final_value(1);
    carry_flag <= flag_final_value(2);

END ExecutionStage1;