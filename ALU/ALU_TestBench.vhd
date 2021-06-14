
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY ALU_testbench IS
    GENERIC (n : INTEGER := 32);
END ALU_testbench;

ARCHITECTURE ALU_testbench1 OF ALU_testbench IS
    COMPONENT ALU IS
        GENERIC (n : INTEGER := 32);
        PORT (
            inp1, inp2 : IN STD_LOGIC_VECTOR (n - 1 DOWNTO 0); --Inputs
            opr : IN STD_LOGIC_VECTOR (4 DOWNTO 0); --Operation to be done, take only 4 bits (2->5)
            result_output : OUT STD_LOGIC_VECTOR (n - 1 DOWNTO 0); --Result of operation
            zero_flag, negative_flag, carry_flag : OUT STD_LOGIC); --Flags
    END COMPONENT;

    SIGNAL t_inp1, t_inp2, t_result_output : STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
    SIGNAL t_opr: STD_LOGIC_VECTOR(4 downto 0);
    SIGNAL t_z_f, t_n_f, t_c_f : STD_LOGIC;

BEGIN
    PROCESS BEGIN
        --SETC
        t_inp1 <= "00000000000000000000000000000000";
        t_inp2 <= "00000000000000000000000000000000";
        t_opr <= "00001";
        WAIT FOR 100 ps;
        ASSERT(t_c_f = '1') REPORT "An error happened with SETC" SEVERITY error;
        --CLRC
        t_opr <= "00010";
        WAIT FOR 100 ps;
        ASSERT(t_c_f = '0') REPORT "An error happened with CLRC" SEVERITY error;
        --NOT
        t_inp1 <= "10000000000101000000000000000001";
        t_opr <= "00011";
        WAIT FOR 100 ps;
        ASSERT(t_result_output = "01111111111010111111111111111110") REPORT "An error happened with NOT" SEVERITY error;
        --INC
        t_inp1 <= x"0000000F";
        t_opr <= "00100";
        WAIT FOR 100 ps;
        ASSERT(t_result_output = x"00000010") REPORT "An error happened with INC 0F" SEVERITY error;
        t_inp1 <= "01111111111111111111111111111111";
        t_opr <= "00100";
        WAIT FOR 100 ps;
        ASSERT(t_n_f = '1' and t_result_output = "10000000000000000000000000000000") REPORT "An error happened with INC 0FFFFFFF" SEVERITY error;
        t_inp1 <= x"FFFFFFFF";
        t_opr <= "00100";
        WAIT FOR 100 ps;
        ASSERT(t_z_f = '1' and t_n_f ='0' and t_result_output = x"00000000") REPORT "An error happened with INC FFFFFFFF" SEVERITY error;
        --DEC
        t_inp1 <= x"0000000F";
        t_opr <= "00101";
        WAIT FOR 100 ps;
        ASSERT(t_result_output = x"0000000E") REPORT "An error happened with DEC 0F" SEVERITY error;
        t_inp1 <= "01111111111111111111111111111111";
        t_opr <= "00101";
        WAIT FOR 100 ps;
        ASSERT(t_n_f = '0' and t_result_output = "01111111111111111111111111111110") REPORT "An error happened with DEC 0FFFFFFF" SEVERITY error;
        t_inp1 <= x"FFFFFFFF";
        t_opr <= "00101";
        WAIT FOR 100 ps;
        ASSERT(t_z_f = '0' and t_n_f ='1' and t_result_output = x"FFFFFFFE") REPORT "An error happened with DEC FFFFFFFF" SEVERITY error;
        t_inp1 <= x"00000000";
        t_opr <= "00101";
        WAIT FOR 100 ps;
        ASSERT(t_z_f = '0' and t_n_f ='1' and t_result_output = x"FFFFFFFF") REPORT "An error happened with DEC 0" SEVERITY error;
        --MOV
        t_inp1 <= x"000AB000";
        t_opr <= "01000";
        WAIT FOR 100 ps;
        ASSERT(t_result_output = x"000AB000") REPORT "An error happened with MOV" SEVERITY error;
        --OUT
        t_inp2 <= x"000AD000";
        t_opr <= "00110";
        WAIT FOR 100 ps;
        ASSERT(t_result_output = x"000AD000") REPORT "An error happened with OUT" SEVERITY error;
        --IN
        t_inp2 <= x"001AD000";
        t_opr <= "00111";
        WAIT FOR 100 ps;
        ASSERT(t_result_output = x"001AD000") REPORT "An error happened with IN" SEVERITY error;
        
        --X+Y
        t_inp1 <= x"001AD000";
        t_inp2 <= x"001AD100";
        t_opr <= "01001";
        WAIT FOR 100 ps;
        ASSERT(t_c_f = '0' and t_z_f = '0' and t_n_f = '0' and t_result_output = x"0035A100") REPORT "An error happened with ADD CASE 1" SEVERITY error;
        t_inp1 <= x"0F1AD000";
        t_inp2 <= x"011AD100";
        t_opr <= "01001";
        WAIT FOR 100 ps;
        ASSERT(t_c_f = '0' and t_z_f = '0' and t_n_f = '0' and t_result_output = x"1035A100") REPORT "An error happened with ADD CASE 2" SEVERITY error;
        t_inp1 <= x"0F1AD000";
        t_inp2 <= x"F11AD100";
        t_opr <= "01001";
        WAIT FOR 100 ps;
        ASSERT(t_c_f = '1' and t_z_f = '0' and t_n_f = '0' and t_result_output = x"0035A100") REPORT "An error happened with ADD CASE 3" SEVERITY error;
        t_inp1 <= x"FFFFFF56";
        t_inp2 <= x"000000BA";
        t_opr <= "01010";
        WAIT FOR 100 ps;
        ASSERT(t_c_f = '1' and t_z_f = '0' and t_n_f = '0' and t_result_output = x"00000010") REPORT "An error happened with ADD CASE 4" SEVERITY error;
        t_inp1 <= x"FFFFFFF6";
        t_inp2 <= x"0000000A";
        t_opr <= "01010";
        WAIT FOR 100 ps;
        ASSERT(t_c_f = '1' and t_z_f = '1' and t_n_f = '0' and t_result_output = x"00000000") REPORT "An error happened with ADD CASE 5" SEVERITY error;
        t_inp1 <= x"FFFFFFF6";
        t_inp2 <= x"00000001";
        t_opr <= "01010";
        WAIT FOR 100 ps;
        ASSERT(t_c_f = '0' and t_z_f = '0' and t_n_f = '1' and t_result_output = x"FFFFFFF7") REPORT "An error happened with ADD CASE 6" SEVERITY error;
        
        --X-Y
        t_inp1 <= x"001AD000";
        t_inp2 <= x"001AD100";
        t_opr <= "01011";
        WAIT FOR 100 ps;
        ASSERT(t_c_f = '1' and t_z_f = '0' and t_n_f = '1' and t_result_output = x"FFFFFF00") REPORT "An error happened with SUB CASE 1" SEVERITY error;
        t_inp1 <= x"0F1AD000";
        t_inp2 <= x"011AD100";
        t_opr <= "01011";
        WAIT FOR 100 ps;
        ASSERT(t_c_f = '0' and t_z_f = '0' and t_n_f = '0' and t_result_output = x"0DFFFF00") REPORT "An error happened with SUB CASE 2" SEVERITY error;
        t_inp1 <= x"0F1AD000";
        t_inp2 <= x"F11AD100";
        t_opr <= "01011";
        WAIT FOR 100 ps;
        ASSERT(t_c_f = '1' and t_z_f = '0' and t_n_f = '0' and t_result_output = x"1DFFFF00") REPORT "An error happened with SUB CASE 3" SEVERITY error;
        t_inp1 <= x"0000FF56";
        t_inp2 <= x"000001BA";
        t_opr <= "01011";
        WAIT FOR 100 ps;
        ASSERT(t_c_f = '0' and t_z_f = '0' and t_n_f = '0' and t_result_output = x"0000FD9C") REPORT "An error happened with SUB CASE 4" SEVERITY error;
        t_inp1 <= x"0000FF56";
        t_inp2 <= x"0000FF56";
        t_opr <= "01011";
        WAIT FOR 100 ps;
        ASSERT(t_c_f = '0' and t_z_f = '1' and t_n_f = '0' and t_result_output = x"00000000") REPORT "An error happened with SUB CASE 5" SEVERITY error;
        
        
        --AND
        t_inp1 <= x"00000000";
        t_inp2 <= x"0000FF56";
        t_opr <= "01100";
        WAIT FOR 100 ps;
        ASSERT(t_c_f = '0' and t_z_f = '1' and t_n_f = '0' and t_result_output = x"00000000") REPORT "An error happened with AND CASE 1" SEVERITY error;
        t_inp1 <= x"000000F0";
        t_inp2 <= x"0000FF56";
        t_opr <= "01100";
        WAIT FOR 100 ps;
        ASSERT(t_c_f = '0' and t_z_f = '0' and t_n_f = '0' and t_result_output = x"00000050") REPORT "An error happened with AND CASE 2" SEVERITY error;

        --OR
        t_inp1 <= x"00000000";
        t_inp2 <= x"00000000";
        t_opr <= "01101";
        WAIT FOR 100 ps;
        ASSERT(t_c_f = '0' and t_z_f = '1' and t_n_f = '0' and t_result_output = x"00000000") REPORT "An error happened with OR CASE 1" SEVERITY error;
        t_inp1 <= x"0E0000F0";
        t_inp2 <= x"0000FF56";
        t_opr <= "01101";
        WAIT FOR 100 ps;
        ASSERT(t_c_f = '0' and t_z_f = '0' and t_n_f = '0' and t_result_output = x"0E00FFF6") REPORT "An error happened with OR CASE 2" SEVERITY error;

        --SHL
        t_inp1 <= "01111111111111111111111111111111";
        t_inp2 <= "00000000000000000000000000000001";
        t_opr <= "01110";
        WAIT FOR 100 ps;
        ASSERT(t_c_f = '0' and t_result_output = "11111111111111111111111111111110") REPORT "An error happened with SHL CASE 1" SEVERITY error;
        t_inp1 <= "01111111111111111111111111111111";
        t_inp2 <= "00000000000000000000000000000010";
        t_opr <= "01110";
        WAIT FOR 100 ps;
        ASSERT(t_c_f = '1' and t_result_output = "11111111111111111111111111111100") REPORT "An error happened with SHL CASE 2" SEVERITY error;
        t_inp1 <= "01111011111111111111111111111111";
        t_inp2 <= "00000000000000000000000000000101";
        t_opr <= "01110";
        WAIT FOR 100 ps;
        ASSERT(t_c_f = '1' and t_result_output = "01111111111111111111111111100000") REPORT "An error happened with SHL CASE 3" SEVERITY error;
        
        --SHR
        t_inp1 <= "11111111111111111111111111111110";
        t_inp2 <= "00000000000000000000000000000001";
        t_opr <= "01111";
        WAIT FOR 100 ps;
        ASSERT(t_c_f = '0' and t_result_output = "11111111111111111111111111111111") REPORT "An error happened with SHR CASE 1" SEVERITY error;
        t_inp1 <= "01111111111111111111111111111110";
        t_inp2 <= "00000000000000000000000000000010";
        t_opr <= "01111";
        WAIT FOR 100 ps;
        ASSERT(t_c_f = '1' and t_result_output = "00011111111111111111111111111111") REPORT "An error happened with SHR CASE 2" SEVERITY error;
        t_inp1 <= "01111011111111111111111101111111";
        t_inp2 <= "00000000000000000000000000001000";
        t_opr <= "01111";
        WAIT FOR 100 ps;
        ASSERT(t_c_f = '0' and t_result_output = "00000000011110111111111111111111") REPORT "An error happened with SHR CASE 3" SEVERITY error;
        t_inp1 <= "11111011111111111111111101111111";
        t_inp2 <= "00000000000000000000000000000111";
        t_opr <= "01111";
        WAIT FOR 100 ps;
        ASSERT(t_c_f = '1' and t_result_output = "11111111111101111111111111111110") REPORT "An error happened with SHR CASE 4" SEVERITY error;
        WAIT;
    END PROCESS;

    tb : ALU PORT MAP(t_inp1, t_inp2, t_opr, t_result_output, t_z_f, t_n_f, t_c_f);
END ALU_testbench1;