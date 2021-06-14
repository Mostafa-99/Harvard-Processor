LIBRARY ieee;
USE IEEE.numeric_std.ALL;
USE ieee.std_logic_1164.ALL;

ENTITY ForwardingUnit IS
    PORT (
        IdEx_Rs, IdEx_Rd, ExMem_Rd, MemWB_Rd : IN STD_LOGIC_VECTOR (7 DOWNTO 0); --Register values
        ExMem_WB, MemWB_WB : IN STD_LOGIC; --Write back signal
        R1_signal, R2_signal : OUT STD_LOGIC_VECTOR (1 DOWNTO 0)); --Signal for mux for both inputs of the ALU
END ENTITY ForwardingUnit;

ARCHITECTURE ForwardingUnit1 OF ForwardingUnit IS
BEGIN
    PROCESS (IdEx_Rs, IdEx_Rd, ExMem_Rd, MemWB_Rd, ExMem_WB, MemWB_WB)
    BEGIN
        R1_signal <= "00";
        R2_signal <= "00";
        IF (MemWB_WB = '1') THEN --If the instruction before the last writes to memory
            IF (IdEx_Rs = MemWB_Rd) THEN --If the first input for ALU should be forwarded
                R1_signal <= "10";
            END IF;
            IF (IdEx_Rd = MemWB_Rd) THEN --If the second input for the ALU should be forwarded
                R2_signal <= "10";
            END IF;
        END IF;
        IF (ExMem_WB = '1') THEN --If the previous operation writes to the memory 
            IF (IdEx_Rs = ExMem_Rd) THEN --If the first input for ALU should be forwarded
                R1_signal <= "01";
            END IF;
            IF (IdEx_Rd = ExMem_Rd) THEN --If the second input for the ALU should be forwarded
                R2_signal <= "01";
            END IF;
        END IF;
    END PROCESS; -- 
END ForwardingUnit1;