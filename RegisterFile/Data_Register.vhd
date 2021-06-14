LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY DataRegister IS
    GENERIC (n : INTEGER := 32);
    PORT (
        clk, rst, enable : IN STD_LOGIC;
        d : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
        q : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0));
END DataRegister;

ARCHITECTURE DataRegister1 OF DataRegister IS
    SIGNAL q_data : STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
BEGIN
    PROCESS (clk, rst, enable)
    BEGIN
        IF (Rst = '1') THEN
            q_data <= (OTHERS => '0');
        ELSIF falling_edge(Clk) AND enable = '1' THEN
            q_data <= d;
        END IF;
    END PROCESS;
    q <= q_data;
END DataRegister1;