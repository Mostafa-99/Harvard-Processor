vsim work.alu_testbench
# vsim work.alu_testbench 
# Start time: 21:25:28 on Jun 13,2021
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.alu_testbench(alu_testbench1)
# Loading ieee.numeric_std(body)
# Loading work.alu(arch1)
# vsim work.alu_testbench 
# Start time: 21:17:05 on Jun 13,2021
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.alu_testbench(alu_testbench1)
# Loading ieee.numeric_std(body)
# Loading work.alu(arch1)
add wave -position insertpoint  \
sim:/alu_testbench/n \
sim:/alu_testbench/t_c_f \
sim:/alu_testbench/t_inp1 \
sim:/alu_testbench/t_inp2 \
sim:/alu_testbench/t_n_f \
sim:/alu_testbench/t_opr \
sim:/alu_testbench/t_result_output \
sim:/alu_testbench/t_z_f
# ** Warning: (vsim-WLF-5000) WLF file currently in use: vsim.wlf
#           File in use by: DELL  Hostname: MOSTAFA  ProcessID: 16608
#           Attempting to use alternate WLF file "./wlft1b8qgb".
# ** Warning: (vsim-WLF-5001) Could not open WLF file: vsim.wlf
#           Using alternate file: ./wlft1b8qgb
add wave -position insertpoint  \
sim:/alu_testbench/tb/result
run