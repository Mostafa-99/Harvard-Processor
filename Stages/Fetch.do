vsim -gui work.fetchstage
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /fetchstage/clk
add wave -noupdate -radix hexadecimal /fetchstage/rst
add wave -noupdate -radix hexadecimal /fetchstage/pcWrite
add wave -noupdate -radix hexadecimal /fetchstage/iMemOutput
add wave -noupdate -radix hexadecimal /fetchstage/PCinput
add wave -noupdate -radix hexadecimal /fetchstage/PCoutput
add wave -noupdate -radix hexadecimal /fetchstage/zeros
add wave -noupdate -radix hexadecimal /fetchstage/iMemInput
add wave -noupdate -radix hexadecimal /fetchstage/pcIncremented
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {86 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 230
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
WaveRestoreZoom {0 ps} {955 ps}


mem load -i {./Memory/output.mem} /fetchstage/iMem/instruction_memory
force -freeze sim:/fetchstage/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/fetchstage/rst 1 0
force -freeze sim:/fetchstage/pcWrite 1 0

run
force -freeze sim:/fetchstage/rst 0 0
run
