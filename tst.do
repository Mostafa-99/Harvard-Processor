onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /processor/clk
add wave -noupdate -radix hexadecimal /processor/rst
add wave -noupdate -radix hexadecimal /processor/IfId_instruction_out
add wave -noupdate -radix hexadecimal /processor/d_read_d1_out
add wave -noupdate -radix hexadecimal /processor/d_read_d2_out
add wave -noupdate -radix hexadecimal /processor/e_alu_result_out
add wave -noupdate -radix hexadecimal /processor/e_read_d1_in
add wave -noupdate -radix hexadecimal /processor/e_read_d2_in
add wave -noupdate -radix hexadecimal /processor/e_carry_flag_out
add wave -noupdate -radix hexadecimal /processor/e_zero_flag_out
add wave -noupdate -radix hexadecimal /processor/e_negative_flag_out
add wave -noupdate -radix hexadecimal /processor/input_port
add wave -noupdate -radix hexadecimal /processor/output_port
add wave -noupdate -radix hexadecimal /processor/executingStage/alu1/inp1
add wave -noupdate -radix hexadecimal /processor/executingStage/alu1/inp2
add wave -noupdate -radix binary /processor/executingStage/alu1/opr
add wave -noupdate -radix hexadecimal /processor/executingStage/alu1/result_output
add wave -noupdate -radix hexadecimal /processor/executingStage/alu1/zero_flag
add wave -noupdate -radix hexadecimal /processor/executingStage/alu1/negative_flag
add wave -noupdate -radix hexadecimal /processor/executingStage/alu1/carry_flag
add wave -noupdate -radix hexadecimal /processor/executingStage/alu1/flags_enable
add wave -noupdate -radix hexadecimal /processor/executingStage/alu1/result
add wave -noupdate -radix hexadecimal /processor/executingStage/alu1/carry_add
add wave -noupdate -radix hexadecimal /processor/executingStage/alu1/carry_sub
add wave -noupdate -radix hexadecimal /processor/executingStage/fu1/IdEx_Rs
add wave -noupdate -radix hexadecimal /processor/executingStage/fu1/IdEx_Rd
add wave -noupdate -radix hexadecimal /processor/executingStage/fu1/ExMem_Rd
add wave -noupdate -radix hexadecimal /processor/executingStage/fu1/MemWB_Rd
add wave -noupdate -radix hexadecimal /processor/executingStage/fu1/ExMem_WB
add wave -noupdate -radix hexadecimal /processor/executingStage/fu1/MemWB_WB
add wave -noupdate -radix hexadecimal /processor/executingStage/fu1/R1_signal
add wave -noupdate -radix hexadecimal /processor/executingStage/fu1/R2_signal
add wave -noupdate -radix hexadecimal /processor/MemWB/clk
add wave -noupdate -radix hexadecimal /processor/MemWB/rst
add wave -noupdate -radix hexadecimal /processor/MemWB/enable
add wave -noupdate -radix hexadecimal /processor/MemWB/memoryData
add wave -noupdate -radix hexadecimal /processor/MemWB/aluResult
add wave -noupdate -radix hexadecimal /processor/MemWB/rdAddr
add wave -noupdate -radix hexadecimal /processor/MemWB/controlSigs
add wave -noupdate -radix hexadecimal /processor/MemWB/memoryDataOut
add wave -noupdate -radix hexadecimal /processor/MemWB/aluResultOut
add wave -noupdate -radix hexadecimal /processor/MemWB/rdAddrOut
add wave -noupdate -radix hexadecimal /processor/MemWB/controlSigsOut
add wave -noupdate -radix hexadecimal /processor/writeBackStage/clk
add wave -noupdate -radix hexadecimal /processor/writeBackStage/rst
add wave -noupdate -radix hexadecimal /processor/writeBackStage/MemWB_data
add wave -noupdate -radix hexadecimal /processor/writeBackStage/MemWB_ALU_result
add wave -noupdate -radix hexadecimal /processor/writeBackStage/MemWB_mem_to_reg
add wave -noupdate -radix hexadecimal /processor/writeBackStage/input_port
add wave -noupdate -radix hexadecimal /processor/writeBackStage/input_port_enable
add wave -noupdate -radix hexadecimal /processor/writeBackStage/write_back_value
add wave -noupdate -radix hexadecimal /processor/writeBackStage/mux1_output
add wave -noupdate -radix hexadecimal /processor/ExMem/clk
add wave -noupdate -radix hexadecimal /processor/ExMem/rst
add wave -noupdate -radix hexadecimal /processor/ExMem/enable
add wave -noupdate -radix hexadecimal /processor/ExMem/incrementedPCInp
add wave -noupdate -radix hexadecimal /processor/ExMem/aluResult
add wave -noupdate -radix hexadecimal /processor/ExMem/readD2
add wave -noupdate -radix hexadecimal /processor/ExMem/rdAddr
add wave -noupdate -radix hexadecimal /processor/ExMem/controlSigs
add wave -noupdate -radix hexadecimal /processor/ExMem/incrementedPCOut
add wave -noupdate -radix hexadecimal /processor/ExMem/aluResultOut
add wave -noupdate -radix hexadecimal /processor/ExMem/readD2Out
add wave -noupdate -radix hexadecimal /processor/ExMem/rdAddrOut
add wave -noupdate -radix hexadecimal /processor/ExMem/controlSigsOut
add wave -noupdate -radix hexadecimal /processor/stack_pointer_address
add wave -noupdate -radix hexadecimal /processor/memoryStageUnit/ExMem_address
add wave -noupdate -radix hexadecimal /processor/memoryStageUnit/sp_address
add wave -noupdate -radix hexadecimal /processor/memoryStageUnit/ExMem_read_data2
add wave -noupdate -radix hexadecimal /processor/memoryStageUnit/ExMem_pc
add wave -noupdate -radix hexadecimal /processor/memoryStageUnit/we
add wave -noupdate -radix hexadecimal /processor/memoryStageUnit/re
add wave -noupdate -radix hexadecimal /processor/memoryStageUnit/clk
add wave -noupdate -radix hexadecimal /processor/memoryStageUnit/sp_ctrl
add wave -noupdate -radix hexadecimal /processor/memoryStageUnit/call_ctrl
add wave -noupdate -radix hexadecimal /processor/memoryStageUnit/rst
add wave -noupdate -radix hexadecimal /processor/memoryStageUnit/MemWb_data_in
add wave -noupdate -radix hexadecimal /processor/memoryStageUnit/memory_address_in
add wave -noupdate -radix hexadecimal /processor/memoryStageUnit/memory_data_in
add wave -noupdate -radix hexadecimal /processor/memoryStageUnit/data_mem/clk
add wave -noupdate -radix hexadecimal /processor/memoryStageUnit/data_mem/we
add wave -noupdate -radix hexadecimal /processor/memoryStageUnit/data_mem/re
add wave -noupdate -radix hexadecimal /processor/memoryStageUnit/data_mem/rst
add wave -noupdate -radix hexadecimal /processor/memoryStageUnit/data_mem/address
add wave -noupdate -radix hexadecimal /processor/memoryStageUnit/data_mem/data_in
add wave -noupdate -radix hexadecimal /processor/memoryStageUnit/data_mem/data_out
add wave -noupdate -radix hexadecimal /processor/m_control_signals_out
add wave -noupdate -radix hexadecimal /processor/decodingStage/register_file_1/register_0_data
add wave -noupdate -radix hexadecimal /processor/decodingStage/register_file_1/register_1_data
add wave -noupdate -radix hexadecimal /processor/decodingStage/register_file_1/register_2_data
add wave -noupdate -radix hexadecimal /processor/decodingStage/register_file_1/register_3_data
add wave -noupdate -radix hexadecimal /processor/decodingStage/register_file_1/register_4_data
add wave -noupdate -radix hexadecimal /processor/decodingStage/register_file_1/register_5_data
add wave -noupdate -radix hexadecimal /processor/decodingStage/register_file_1/register_6_data
add wave -noupdate -radix hexadecimal /processor/decodingStage/register_file_1/register_7_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {101 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 458
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {899 ps}
