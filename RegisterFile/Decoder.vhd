
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Decoder3x8 IS
    PORT (
        enable : IN STD_LOGIC;
        selection : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END Decoder3x8;

ARCHITECTURE Decoder3x81 OF Decoder3x8 IS
BEGIN
    q <= "00000000" WHEN enable = '0'
        ELSE
        "00000001" WHEN enable = '1' AND selection = "000"
        ELSE
        "00000010" WHEN enable = '1' AND selection = "001"
        ELSE
        "00000100" WHEN enable = '1' AND selection = "010"
        ELSE
        "00001000" WHEN enable = '1' AND selection = "011"
        ELSE
        "00010000" WHEN enable = '1' AND selection = "100"
        ELSE
        "00100000" WHEN enable = '1' AND selection = "101"
        ELSE
        "01000000" WHEN enable = '1' AND selection = "110"
        ELSE
        "10000100";

END Decoder3x81;