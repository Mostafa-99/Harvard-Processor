LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY InstructionMemory IS
    GENERIC (
        n : INTEGER := 32;
        address_n : INTEGER := 20
    );
    PORT (
        address : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0); -- need only right address_n bits (to be sliced)
        data_out : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0) -- same for data out need to take two memory addresses and merge them to the output
    );
END ENTITY;

ARCHITECTURE InstructionMemory1 OF InstructionMemory
    IS
    TYPE instruction_memory_type IS ARRAY(0 TO 2 ** address_n - 1) OF STD_LOGIC_VECTOR(n/2 - 1 DOWNTO 0); --1MB memory -> 2**20 - 1
    SIGNAL instruction_memory : instruction_memory_type;
BEGIN
    data_out <= instruction_memory(to_integer(unsigned(address(address_n - 1 DOWNTO 0))) + 1) & instruction_memory(to_integer(unsigned(address(address_n - 1 DOWNTO 0))));
END ARCHITECTURE;