vsim -gui work.signextend
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /signextend/data_in
add wave -noupdate -radix hexadecimal /signextend/data_out

force -freeze sim:/signextend/data_in 16#9001 0
run
force -freeze sim:/signextend/data_in 16#0005 0
run