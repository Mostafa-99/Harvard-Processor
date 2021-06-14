library ieee;
use ieee.std_logic_1164.all;
entity ControlUnit is
    port (
        oppCode:in std_logic_vector(5 downto 0);
        reset: in std_logic;
        flush: in std_logic;
        controlSignals:out std_logic_vector(19 downto 0)
    );
end entity ControlUnit;
architecture ControlUnitArchitecture of ControlUnit is
    signal tempControlSignals: std_logic_vector(19 downto 0);
    begin
        with oppCode select
            tempControlSignals <=
                    "00000000000000000000" when "000000", --NOP
                    "00000000001100000100" when "000001", --SETC
                    "00000000010010000100" when "000010", --CLRC
                    "10000000011000000100" when "000011", --NOT
                    "10000000100000000100" when "000100", --INC
                    "10000000101000000100" when "000101", --DEC
                    "00000000110000100000" when "000110", --OUT
                    "10000000111001000000" when "000111", --IN
                    "10000001000000000000" when "001000", --MOV
                    "10000001001000000100" when "001001", --ADD
                    "10001101010000000100" when "101010", --IADD
                    "10000001011000000100" when "001011", --SUB
                    "10000001100000000100" when "001100", --AND
                    "10000001101000000100" when "001101", --OR
                    "10001101110000000100" when "101110", --SHL
                    "10001101111000000100" when "101111", --SHR
                    "00000010000000011000" when "010000", --PUSH
                    "10000010001000001000" when "010001", --POP
                    "11011110010000000000" when "110010", --LDM
                    "11011110011000000000" when "110011", --LDD
                    "00101110100000000000" when "110100", --STD
                    "00000011000000000000" when "011000", --JZ
                    "00000011001000000000" when "011001", --JN
                    "00000011010000000000" when "011010", --JC
                    "00000011011000000000" when "011011", --JMP
                    "00000011100000011010" when "011100", --CALL
                    "00000011101000001001" when "011101", --RET
                    "11111111111111111111" when others; --RET
        controlSignals <= "00000011110000000000" when reset='1' else tempControlSignals;
        controlSignals <= "00000000000000000000" when flush='1' else tempControlSignals;

end ControlUnitArchitecture;