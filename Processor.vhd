LIBRARY ieee;
USE IEEE.numeric_std.ALL;
USE ieee.std_logic_1164.ALL;

ENTITY Processor IS
    PORT (
        clk, rst : IN STD_LOGIC;
        input_port : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        output_port : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ENTITY Processor;

ARCHITECTURE processor1 OF Processor IS
    --Fetch Stage sig
    SIGNAL f_pc_write_in : STD_LOGIC;
    SIGNAL f_instruction_out : STD_LOGIC_VECTOR(32 - 1 DOWNTO 0);
    SIGNAL f_incremented_pc_out : STD_LOGIC_VECTOR(32 - 1 DOWNTO 0);
    SIGNAL IfId_en_in : STD_LOGIC;
    SIGNAL IfId_instruction_out : STD_LOGIC_VECTOR(32 - 1 DOWNTO 0);
    SIGNAL IfId_incremented_pc_out : STD_LOGIC_VECTOR(32 - 1 DOWNTO 0);
    --Decode Stage sig
    SIGNAL d_read_d1_out : STD_LOGIC_VECTOR(32 - 1 DOWNTO 0);
    SIGNAL d_read_d2_out : STD_LOGIC_VECTOR(32 - 1 DOWNTO 0);
    SIGNAL d_imm_val_sign_extended_out : STD_LOGIC_VECTOR(32 - 1 DOWNTO 0);
    SIGNAL cu_control_signals_out : STD_LOGIC_VECTOR(20 - 1 DOWNTO 0);
    SIGNAL d_control_signals_out : STD_LOGIC_VECTOR(20 - 1 DOWNTO 0);
    SIGNAL IdEx_en_in : STD_LOGIC;
    SIGNAL IdEx_incremented_pc_out : STD_LOGIC_VECTOR(32 - 1 DOWNTO 0);
    SIGNAL IdEx_Rs_out : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL IdEx_Rd_out : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL IdEx_opcode_out : STD_LOGIC_VECTOR(5 DOWNTO 0);
    --Hazard detection signals
    SIGNAL cu_control_nop_mux_in : STD_LOGIC;

    --Execute Stage signals
    SIGNAL e_read_d1_in : STD_LOGIC_VECTOR(32 - 1 DOWNTO 0);
    SIGNAL e_read_d2_in : STD_LOGIC_VECTOR(32 - 1 DOWNTO 0);
    SIGNAL e_imm_val_sign_extended_in : STD_LOGIC_VECTOR(32 - 1 DOWNTO 0);
    SIGNAL e_control_signals_in : STD_LOGIC_VECTOR(20 - 1 DOWNTO 0);
    SIGNAL e_control_signals_out : STD_LOGIC_VECTOR(20 - 1 DOWNTO 0);
    SIGNAL e_zero_flag_out : STD_LOGIC;
    SIGNAL e_negative_flag_out : STD_LOGIC;
    SIGNAL e_carry_flag_out : STD_LOGIC;
    SIGNAL e_alu_result_out : STD_LOGIC_VECTOR(31 DOWNTO 0);

    --Memory Stage Signals
    SIGNAL ExMem_en_in : STD_LOGIC;
    SIGNAL ExMem_incremented_pc_out : STD_LOGIC_VECTOR(32 - 1 DOWNTO 0);
    SIGNAL m_alu_result_in : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL m_read_data2_in : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL ExMem_Rd_out : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL m_control_signals_out : STD_LOGIC_VECTOR(20 - 1 DOWNTO 0);
    SIGNAL m_read_data_out : STD_LOGIC_VECTOR(31 DOWNTO 0);

    --Write Back Stage Signals
    SIGNAL MemWB_en_in : STD_LOGIC;
    SIGNAL MemWB_wb_out : STD_LOGIC; --Write back signal
    SIGNAL MemWB_data_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL MemWB_ALU_result_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL MemWB_Rd_out : STD_LOGIC_VECTOR (2 DOWNTO 0);
    SIGNAL MemWB_val_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL w_control_signals_out : STD_LOGIC_VECTOR(20 - 1 DOWNTO 0);
    --Stack
    SIGNAL stack_pointer_address : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN
    --TODO: HANDLE THIS SIGNAL
    IdEx_en_in <= '1';
    ExMem_en_in <= '1';
    MemWB_en_in <= '1';
    --Fetch <-> Decode
    fetchingStage : ENTITY work.FetchStage PORT MAP(clk, rst, f_pc_write_in, f_instruction_out, f_incremented_pc_out);
    IfId : ENTITY work.IfIdBuff PORT MAP(clk, rst, IfId_en_in, f_instruction_out, f_incremented_pc_out, IfId_instruction_out, IfId_incremented_pc_out);
    decodingStage : ENTITY work.DecodeStage PORT MAP(clk, rst, IfId_instruction_out(25 DOWNTO 23), IfId_instruction_out(22 DOWNTO 20), IfId_instruction_out(15 DOWNTO 0), MemWB_wb_out, MemWB_Rd_out, MemWB_val_out, d_read_d1_out, d_read_d2_out, d_imm_val_sign_extended_out);

    d_control_signals_out <= (OTHERS => '0') WHEN cu_control_nop_mux_in = '1' ELSE
        cu_control_signals_out;
    cu : ENTITY work.ControlUnit PORT MAP(IfId_instruction_out(31 DOWNTO 26), rst, cu_control_signals_out);
    hdu : ENTITY work.HazardDetectionUnit PORT MAP(IfId_instruction_out(25 DOWNTO 23), IfId_instruction_out(22 DOWNTO 20), IdEx_Rd_out, e_control_signals_in(16), IfId_en_in, cu_control_nop_mux_in, f_pc_write_in);

    --Decode <-> Execute
    IdEx : ENTITY work.IdExBuff PORT MAP(clk, rst, IdEx_en_in, IfId_incremented_pc_out, d_read_d1_out, d_read_d2_out, IfId_instruction_out(31 DOWNTO 26), d_imm_val_sign_extended_out, IfId_instruction_out(25 DOWNTO 23), IfId_instruction_out(22 DOWNTO 20), d_control_signals_out, IdEx_incremented_pc_out, e_read_d1_in, e_read_d2_in, IdEx_opcode_out, e_imm_val_sign_extended_in, IdEx_Rs_out, IdEx_Rd_out, e_control_signals_in);
    executingStage : ENTITY work.ExecutionStage PORT MAP(clk, rst, e_control_signals_in(15), IdEx_opcode_out, e_read_d1_in, e_read_d2_in, e_imm_val_sign_extended_in, input_port, IdEx_Rs_out, IdEx_Rd_out, ExMem_Rd_out, MemWB_Rd_out, m_control_signals_out(19), MemWB_wb_out, e_control_signals_out(6),m_alu_result_in, MemWB_val_out, e_zero_flag_out, e_negative_flag_out, e_carry_flag_out, e_alu_result_out);

    --Execute <-> Memory
    e_control_signals_out <= e_control_signals_in;
    ExMem : ENTITY work.ExMemBuff PORT MAP (clk, rst, ExMem_en_in, IdEx_incremented_pc_out, e_alu_result_out, e_read_d2_in, IdEx_Rd_out, e_control_signals_in, ExMem_incremented_pc_out, m_alu_result_in, m_read_data2_in, ExMem_Rd_out, m_control_signals_out);
    memoryStageUnit : ENTITY work.MemoryStage GENERIC MAP(32) PORT MAP(m_alu_result_in, stack_pointer_address, m_read_data2_in, ExMem_incremented_pc_out, m_control_signals_out(17), m_control_signals_out(16), clk, m_control_signals_out(4), m_control_signals_out(1), rst, m_read_data_out);

    --Memory <-> Write Back
    MemWB : ENTITY work.MemWBBuff PORT MAP (clk, rst, MemWB_en_in, m_read_data_out, m_alu_result_in, ExMem_Rd_out, m_control_signals_out, MemWB_data_out, MemWB_ALU_result_out, MemWB_Rd_out, w_control_signals_out);
    MemWB_wb_out <= w_control_signals_out(19);
    writeBackStage : ENTITY work.WriteBackStage PORT MAP(clk, rst, MemWB_data_out, MemWB_ALU_result_out, w_control_signals_out(18), input_port, w_control_signals_out(6), MemWB_val_out);

    --Output port
    PROCESS (rst, clk) BEGIN
        IF (e_control_signals_in(5) = '1') THEN
            output_port <= e_alu_result_out;
        END IF;
        IF (rst = '1') THEN
            output_port <= (OTHERS => 'Z');
        END IF;
    END PROCESS;
END ARCHITECTURE;