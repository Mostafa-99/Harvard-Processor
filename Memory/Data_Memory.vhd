LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY DataMemeory IS
    GENERIC (
        n : INTEGER := 32;
        address_n : INTEGER := 20
    );
    PORT (
        clk, we, re, rst : IN STD_LOGIC;
        address : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0); -- need only right address_n bits (to be sliced)
        data_in : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0); -- data in is 2 words and one memory address is 1 word (to be divided into two parts)
        data_out : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0) -- same for data out need to take two memory addresses and merge them to the output
    );
END ENTITY;

ARCHITECTURE DataMemeory1 OF DataMemeory
    IS
    TYPE data_memory_type IS ARRAY(0 TO 2 ** address_n - 1) OF STD_LOGIC_VECTOR(n/2 - 1 DOWNTO 0); --2MB memory -> 2**20 - 1
    -- SIGNAL data_memory : data_memory_type;
    SIGNAL data_memory : data_memory_type := (others=>(others=>'0'));

BEGIN
    PROCESS (clk)
    BEGIN
        IF rst = '1' THEN
            data_memory <= (OTHERS => (OTHERS => '0'));
        ELSIF falling_edge(clk) AND we = '1' THEN
            data_memory(to_integer(unsigned(address(address_n - 1 DOWNTO 0))) + 1) <= data_in(n/2 - 1 DOWNTO 0);
            data_memory(to_integer(unsigned(address(address_n - 1 DOWNTO 0)))) <= data_in(n - 1 DOWNTO n/2);
        END IF;
        END PROCESS;
        data_out <= data_memory(to_integer(unsigned(address(address_n - 1 DOWNTO 0)))) & data_memory(to_integer(unsigned(address(address_n - 1 DOWNTO 0))) + 1) when re = '1' else (others => 'Z') ;
END ARCHITECTURE;