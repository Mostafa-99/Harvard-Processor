
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY FU_testbench IS
END FU_testbench;

ARCHITECTURE FU_testbench1 OF FU_testbench IS
    COMPONENT ForwardingUnit IS
        PORT (
            IdEx_Rs, IdEx_Rd, ExMem_Rd, MemWB_Rd : IN STD_LOGIC_VECTOR (7 DOWNTO 0); --Register values
            ExMem_WB, MemWB_WB : IN STD_LOGIC; --Write back signal
            R1_signal, R2_signal : OUT STD_LOGIC_VECTOR (1 DOWNTO 0)); --Signal for mux for both inputs of the ALU
    END COMPONENT;

    SIGNAL t_IdEx_Rs, t_IdEx_Rd, t_ExMem_Rd, t_MemWB_Rd : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL t_ExMem_WB, t_MemWB_WB : STD_LOGIC;
    SIGNAL t_R1_signal, t_R2_signal : STD_LOGIC_VECTOR(1 DOWNTO 0);

BEGIN
    PROCESS BEGIN
        t_IdEx_Rs <= "00000000";
        t_IdEx_Rd <= "00000000";
        t_ExMem_Rd <= "00000000";
        t_MemWB_Rd <= "00000000";

        t_ExMem_WB <= '0';
        t_MemWB_WB <= '0';
        WAIT FOR 100 ps;
        ASSERT(t_R1_signal = "00" and t_R2_signal = "00") REPORT "An error happened with case 1" SEVERITY error;

        t_IdEx_Rs <= "00000000";
        t_IdEx_Rd <= "00000000";
        t_ExMem_Rd <= "00000000";
        t_MemWB_Rd <= "00000000";

        t_ExMem_WB <= '1';
        t_MemWB_WB <= '1';
        WAIT FOR 100 ps;
        ASSERT(t_R1_signal = "01" and t_R2_signal = "01") REPORT "An error happened with case 1" SEVERITY error;

        t_IdEx_Rs <= "00001000";
        t_IdEx_Rd <= "00000000";
        t_ExMem_Rd <= "00000000";
        t_MemWB_Rd <= "00000000";

        t_ExMem_WB <= '1';
        t_MemWB_WB <= '0';
        WAIT FOR 100 ps;
        ASSERT(t_R1_signal = "00" and t_R2_signal = "01") REPORT "An error happened with case 1" SEVERITY error;

        t_IdEx_Rs <= "00000000";
        t_IdEx_Rd <= "00000000";
        t_ExMem_Rd <= "00000000";
        t_MemWB_Rd <= "00000000";

        t_ExMem_WB <= '0';
        t_MemWB_WB <= '1';
        WAIT FOR 100 ps;
        ASSERT(t_R1_signal = "10" and t_R2_signal = "10") REPORT "An error happened with case 1" SEVERITY error;

        
        t_IdEx_Rs <= "00001000";
        t_IdEx_Rd <= "00010000";
        t_ExMem_Rd <= "00001000";
        t_MemWB_Rd <= "00000010";

        t_ExMem_WB <= '1';
        t_MemWB_WB <= '1';
        WAIT FOR 100 ps;
        ASSERT(t_R1_signal = "01" and t_R2_signal = "00") REPORT "An error happened with case 1" SEVERITY error;

        t_IdEx_Rs <= "00001000";
        t_IdEx_Rd <= "00000010";
        t_ExMem_Rd <= "00001000";
        t_MemWB_Rd <= "00000010";

        t_ExMem_WB <= '1';
        t_MemWB_WB <= '1';
        WAIT FOR 100 ps;
        ASSERT(t_R1_signal = "01" and t_R2_signal = "10") REPORT "An error happened with case 1" SEVERITY error;


        WAIT;
    END PROCESS;

    tb : ForwardingUnit PORT MAP(t_IdEx_Rs, t_IdEx_Rd, t_ExMem_Rd, t_MemWB_Rd, t_ExMem_WB, t_MemWB_WB, t_R1_signal, t_R2_signal);
END FU_testbench1;