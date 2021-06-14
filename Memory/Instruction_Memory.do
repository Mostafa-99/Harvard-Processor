vsim -gui work.instructionmemory
mem load -i {./output.mem} /instructionmemory/instruction_memory
add wave -position insertpoint  \
sim:/instructionmemory/address
add wave -position insertpoint  \
sim:/instructionmemory/data_out
force -freeze sim:/instructionmemory/address 16#00000010 0
run
force -freeze sim:/instructionmemory/address 16#00000050 0
run
force -freeze sim:/instructionmemory/address 16#00000101 0
run
force -freeze sim:/instructionmemory/address 16#00000201 0
run
force -freeze sim:/instructionmemory/address 16#00000002 0
run
force -freeze sim:/instructionmemory/address 16#00000001 0
run
force -freeze sim:/instructionmemory/address 16#11110000 0
run
force -freeze sim:/instructionmemory/address 16#00000006 0
run
run
run