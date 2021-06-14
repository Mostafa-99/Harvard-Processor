vsim -gui work.datamemeory
add wave -position insertpoint  \
sim:/datamemeory/address
add wave -position insertpoint  \
sim:/datamemeory/data_in
add wave -position insertpoint  \
sim:/datamemeory/data_out
add wave -position insertpoint  \
sim:/datamemeory/we
add wave -position insertpoint  \
sim:/datamemeory/rst
add wave -position insertpoint  \
sim:/datamemeory/clk
force -freeze sim:/datamemeory/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/datamemeory/rst 1 0
run
force -freeze sim:/datamemeory/rst 0 0
force -freeze sim:/datamemeory/address 16#00000000 0
force -freeze sim:/datamemeory/data_in 16#00001111 0
force -freeze sim:/datamemeory/we 1 0
run
force -freeze sim:/datamemeory/address 16#00000008 0
run
force -freeze sim:/datamemeory/we 0 0
force -freeze sim:/datamemeory/data_in 16#00000001 0
run
run
force -freeze sim:/datamemeory/we 1 0
run
force -freeze sim:/datamemeory/we 0 0
run
force -freeze sim:/datamemeory/address 16#00000000 0
run

