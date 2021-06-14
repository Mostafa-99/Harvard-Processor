vsim work.registerfile
# vsim work.registerfile 
# Start time: 19:37:57 on Jun 14,2021
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.registerfile(registerfile1)
# Loading work.decoder3x8(decoder3x81)
# Loading work.dataregister(register1)
add wave -position insertpoint  \
sim:/registerfile/clk \
sim:/registerfile/decoded_output1 \
sim:/registerfile/decoded_output2 \
sim:/registerfile/n \
sim:/registerfile/read_address1 \
sim:/registerfile/read_address2 \
sim:/registerfile/register_0_data \
sim:/registerfile/register_1_data \
sim:/registerfile/register_2_data \
sim:/registerfile/register_3_data \
sim:/registerfile/register_4_data \
sim:/registerfile/register_5_data \
sim:/registerfile/register_6_data \
sim:/registerfile/register_7_data \
sim:/registerfile/rst \
sim:/registerfile/write_address \
sim:/registerfile/write_data \
sim:/registerfile/write_decoder_output \
sim:/registerfile/write_enable
force -freeze sim:/registerfile/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/registerfile/rst 1 0
force -freeze sim:/registerfile/write_address 001 0
force -freeze sim:/registerfile/write_data 16#ABCDEF10 0
force -freeze sim:/registerfile/write_enable 0 0
force -freeze sim:/registerfile/read_address1 101 0
force -freeze sim:/registerfile/read_address2 001 0
run
force -freeze sim:/registerfile/rst 0 0
force -freeze sim:/registerfile/write_enable 1 0
run