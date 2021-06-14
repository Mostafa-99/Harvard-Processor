vsim -gui work.memorystage
add wave -position insertpoint  \
sim:/memorystage/ExMem_address \
sim:/memorystage/ExMem_pc \
sim:/memorystage/ExMem_read_data2 \
sim:/memorystage/MemWb_data_in \
sim:/memorystage/call_ctrl \
sim:/memorystage/clk \
sim:/memorystage/memory_address_in \
sim:/memorystage/memory_data_in \
sim:/memorystage/rst \
sim:/memorystage/sp_address \
sim:/memorystage/sp_ctrl \
sim:/memorystage/we
force -freeze sim:/memorystage/rst 1 0
run
force -freeze sim:/memorystage/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/memorystage/ExMem_address 16#00000000 0
force -freeze sim:/memorystage/ExMem_read_data2 16#00001111 0
force -freeze sim:/memorystage/sp_ctrl 0 0
force -freeze sim:/memorystage/we 1 0
force -freeze sim:/memorystage/rst 0 0
force -freeze sim:/memorystage/call_ctrl 0 0
run
force -freeze sim:/memorystage/sp_address 16#00000004 0
force -freeze sim:/memorystage/ExMem_pc 16#00001100 0
force -freeze sim:/memorystage/we 1 0
force -freeze sim:/memorystage/call_ctrl 1 0
force -freeze sim:/memorystage/sp_ctrl 1 0
run
force -freeze sim:/memorystage/we 0 0
run
run