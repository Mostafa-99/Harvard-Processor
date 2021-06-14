vsim -gui work.ibuffer
quietly WaveActivateNextPane {} 0
add wave -noupdate /ibuffer/clk
add wave -noupdate /ibuffer/rst
add wave -noupdate -radix hexadecimal /ibuffer/data_in
add wave -noupdate -radix hexadecimal /ibuffer/data_out
force -freeze sim:/ibuffer/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/ibuffer/rst 1 0
run
force -freeze sim:/ibuffer/rst 0 0
force -freeze sim:/ibuffer/data_in 16#0000000500000005
run
run