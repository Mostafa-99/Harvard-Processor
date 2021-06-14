LIBRARY ieee;
USE IEEE.numeric_std.ALL;
USE ieee.std_logic_1164.ALL;

ENTITY ExecutionStage IS

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
            IdEx_Rs, IdEx_Rd, ExMem_Rd, MemWB_Rd : IN STD_LOGIC_VECTOR (7 DOWNTO 0); --Register values
            ExMem_WB, MemWB_WB : IN STD_LOGIC; --Write back signal
            R1_signal, R2_signal : OUT STD_LOGIC_VECTOR (1 DOWNTO 0)); --Signal for mux for both inputs of the ALU
    END COMPONENT;


BEGIN

END ExecutionStage1;