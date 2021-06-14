LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY RegisterFile IS
    GENERIC (n : INTEGER := 32);
    PORT (
        write_data : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0); --Data to be written
        write_enable, clk, rst : IN STD_LOGIC; --Enable for writing, the clock, and reset
        read_address1, read_address2, write_address : IN STD_LOGIC_VECTOR(2 DOWNTO 0); --The address for decoding R1, R2, and to write in
        decoded_output1, decoded_output2 : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0) --The decoded output
    );
END RegisterFile;

ARCHITECTURE RegisterFile1 OF RegisterFile IS
    --Components needed--

    COMPONENT Decoder3x8 IS
        PORT (
            enable : IN STD_LOGIC;
            selection : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
    END COMPONENT;

    COMPONENT DataRegister IS
        GENERIC (n : INTEGER := 32);
        PORT (
            clk, rst, enable : IN STD_LOGIC;
            d : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            q : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0));
    END COMPONENT;

    --Signals needed--
    SIGNAL write_decoder_output : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL register_0_data : STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
    SIGNAL register_1_data : STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
    SIGNAL register_2_data : STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
    SIGNAL register_3_data : STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
    SIGNAL register_4_data : STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
    SIGNAL register_5_data : STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
    SIGNAL register_6_data : STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
    SIGNAL register_7_data : STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
BEGIN
    --Instantiating the decoders--
    write_decoder1 : Decoder3x8 PORT MAP(write_enable, write_address, write_decoder_output);
    --Instantiating the registers for writing--
    r0 : DataRegister GENERIC MAP(n) PORT MAP(clk, rst, write_decoder_output(0), write_data, register_0_data);
    r1 : DataRegister GENERIC MAP(n) PORT MAP(clk, rst, write_decoder_output(1), write_data, register_1_data);
    r2 : DataRegister GENERIC MAP(n) PORT MAP(clk, rst, write_decoder_output(2), write_data, register_2_data);
    r3 : DataRegister GENERIC MAP(n) PORT MAP(clk, rst, write_decoder_output(3), write_data, register_3_data);
    r4 : DataRegister GENERIC MAP(n) PORT MAP(clk, rst, write_decoder_output(4), write_data, register_4_data);
    r5 : DataRegister GENERIC MAP(n) PORT MAP(clk, rst, write_decoder_output(5), write_data, register_5_data);
    r6 : DataRegister GENERIC MAP(n) PORT MAP(clk, rst, write_decoder_output(6), write_data, register_6_data);
    r7 : DataRegister GENERIC MAP(n) PORT MAP(clk, rst, write_decoder_output(7), write_data, register_7_data);

    --Decoding the output
    WITH read_address1 SELECT
        decoded_output1 <= register_0_data WHEN "000",
        register_1_data WHEN "001",
        register_2_data WHEN "010",
        register_3_data WHEN "011",
        register_4_data WHEN "100",
        register_5_data WHEN "101",
        register_6_data WHEN "110",
        register_7_data WHEN OTHERS;

    WITH read_address2 SELECT
        decoded_output2 <= register_0_data WHEN "000",
        register_1_data WHEN "001",
        register_2_data WHEN "010",
        register_3_data WHEN "011",
        register_4_data WHEN "100",
        register_5_data WHEN "101",
        register_6_data WHEN "110",
        register_7_data WHEN OTHERS;
END RegisterFile1;