vsim -gui work.instructionmemory
mem load -filltype value -filldata 0000111100001111 -fillradix symbolic /instructionmemory/instruction_memory(6)
mem load -filltype value -filldata 1111000011110000 -fillradix symbolic /instructionmemory/instruction_memory(7)
add wave -position insertpoint  \
sim:/instructionmemory/address
add wave -position insertpoint  \
sim:/instructionmemory/data_out
force -freeze sim:/instructionmemory/address 16#00000006 0
run
force -freeze sim:/instructionmemory/address 16#00000005 0
run
force -freeze sim:/instructionmemory/address 16#00000004 0
run
force -freeze sim:/instructionmemory/address 16#00000003 0
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