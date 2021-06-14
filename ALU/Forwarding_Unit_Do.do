vsim work.fu_testbench
# vsim work.fu_testbench 
# Start time: 13:43:26 on Jun 14,2021
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.fu_testbench(fu_testbench1)
# Loading ieee.numeric_std(body)
# Loading work.forwardingunit(forwardingunit1)
add wave -position insertpoint  \
sim:/fu_testbench/t_ExMem_Rd \
sim:/fu_testbench/t_ExMem_WB \
sim:/fu_testbench/t_IdEx_Rd \
sim:/fu_testbench/t_IdEx_Rs \
sim:/fu_testbench/t_MemWB_Rd \
sim:/fu_testbench/t_MemWB_WB \
sim:/fu_testbench/t_R1_signal \
sim:/fu_testbench/t_R2_signal
run