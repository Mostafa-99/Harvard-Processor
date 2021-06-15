vsim work.processor
mem load -i {./Memory/Memory.mem} /processor/fetchingStage/iMem/instruction_memory
add wave -position insertpoint  \
sim:/processor/clk
add wave -position insertpoint  \
sim:/processor/rst
add wave -position insertpoint  \
sim:/processor/IfId_instruction_out
add wave -position insertpoint  \
sim:/processor/d_read_d1_out
add wave -position insertpoint  \
sim:/processor/d_read_d2_out
add wave -position insertpoint  \
sim:/processor/e_alu_result_out
add wave -position insertpoint  \
sim:/processor/e_read_d1_in
add wave -position insertpoint  \
sim:/processor/e_read_d2_in
add wave -position insertpoint  \
sim:/processor/e_carry_flag_out
add wave -position insertpoint  \
sim:/processor/e_zero_flag_out
add wave -position insertpoint  \
sim:/processor/e_negative_flag_out
add wave -position insertpoint  \
sim:/processor/input_port
add wave -position insertpoint  \
sim:/processor/output_port
add wave -position insertpoint \
sim:/processor/executingStage/alu1/*
add wave -position insertpoint \
sim:/processor/executingStage/fu1/*
add wave -position insertpoint \
sim:/processor/MemWB/*
add wave -position insertpoint \
sim:/processor/writeBackStage/*
add wave -position insertpoint \
sim:/processor/ExMem/*
add wave -position insertpoint \
sim:/processor/stack_pointer_address
add wave -position insertpoint  \
sim:/processor/memoryStageUnit/*
add wave -position insertpoint \
sim:/processor/memoryStageUnit/data_mem/*
add wave -position insertpoint \
sim:/processor/m_control_signals_out
add wave -position insertpoint  \
sim:/processor/decodingStage/register_file_1/register_0_data \
sim:/processor/decodingStage/register_file_1/register_1_data \
sim:/processor/decodingStage/register_file_1/register_2_data \
sim:/processor/decodingStage/register_file_1/register_3_data \
sim:/processor/decodingStage/register_file_1/register_4_data \
sim:/processor/decodingStage/register_file_1/register_5_data \
sim:/processor/decodingStage/register_file_1/register_6_data \
sim:/processor/decodingStage/register_file_1/register_7_data 

force -freeze sim:/processor/rst 1 0
force -freeze sim:/processor/clk 0 0, 1 {50 ps} -r 100
run
force -freeze sim:/processor/rst 0 0
force -freeze sim:/processor/input_port 16#19 0
run
force -freeze sim:/processor/input_port 16#FFFF 0
run
force -freeze sim:/processor/input_port 16#F320 0
run
run
run
run
run
run
run
run
run
run
run