LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY MUX2 IS
    GENERIC (n : INTEGER := 32);
    PORT (

        s : IN STD_LOGIC;
        data_in1 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
        data_in2 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
        data_out : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0));

END ENTITY;

ARCHITECTURE mux2 OF MUX2 IS
BEGIN
    data_out <= data_in1 WHEN s = '0'
        ELSE
        data_in2;
END ARCHITECTURE;