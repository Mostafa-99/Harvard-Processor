LIBRARY ieee;
USE IEEE.numeric_std.ALL;
USE ieee.std_logic_1164.ALL;

ENTITY MemoryStage IS
    GENERIC (
        n : INTEGER := 32
    );
    PORT (
        ExMem_address : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);    -- Address coming from EX/MEM buffer
        sp_address : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);       -- Stack Pointer address
        ExMem_read_data2 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0); -- Read Data 2 from EX/MEM buffer
        ExMem_pc : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);         -- Program Counter from EX/MEM buffer
        we, re, clk, sp_ctrl, call_ctrl, rst : IN STD_LOGIC;        -- Control signals
        MemWb_data_in : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)    -- Output to MEM/WB buffer
    );
END ENTITY MemoryStage;

ARCHITECTURE MemoryStage1 OF MemoryStage IS

    COMPONENT DataMemeory IS
        GENERIC (
            n : INTEGER := 32;
            address_n : INTEGER := 20
        );
        PORT (
            clk, we, re, rst : IN STD_LOGIC;
            address : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            data_in : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            data_out : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT MUX2 IS
        GENERIC (n : INTEGER := 32);
        PORT (

            s : IN STD_LOGIC;
            data_in1 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            data_in2 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            data_out : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0));
    END COMPONENT;
    SIGNAL memory_address_in : STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
    SIGNAL memory_data_in : STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
BEGIN
    address_MUX : MUX2 PORT MAP(sp_ctrl, ExMem_address, sp_address, memory_address_in); -- Select between Address and Stack pointer address
    data_in_MUX : MUX2 PORT MAP(call_ctrl, ExMem_read_data2, ExMem_pc, memory_data_in); -- Select between Read Data 2 and Program Counter
    data_mem : DataMemeory PORT MAP(clk, we, re, rst, memory_address_in, memory_data_in, MemWb_data_in); -- Data memory component
END MemoryStage1;