library ieee;
use IEEE.numeric_std.all;
use ieee.std_logic_1164.all;

entity FetchStage is
    port (
        clk, rst : in std_logic;
    );
end entity FetchStage;

architecture FetchStage1 of FetchStage is

    component IBuffer is
        generic (n : integer := 32);
        port (
            clk, rst : in std_logic;
            data_in : in std_logic_vector(n - 1 downto 0);
            data_out : out std_logic_vector(n - 1 downto 0)
        );
    end component;
    component InstructionMemory is
        generic (
            n : integer := 32;
            address_n : integer := 20
        );
        port (
            address : in std_logic_vector(n - 1 downto 0); -- need only right address_n bits (to be sliced)
            data_out : out std_logic_vector(n - 1 downto 0) -- same for data out need to take two memory addresses and merge them to the output
        );
    end component;
    component MUX2 is
        generic (n : integer := 32);
        port (
    
            s : in std_logic;
            data_in1 : in std_logic_vector(n - 1 downto 0);
            data_in2 : in std_logic_vector(n - 1 downto 0);
            data_out : out std_logic_vector(n - 1 downto 0));
    
    end component;

    signal addressAfterInc : std_logic_vector(31 downto 0);
    signal instructionMemOut : std_logic_vector(31 downto 0);

begin
    pcRstMux : MUX2 generic map(32) port map(rst,address);

end FetchStage1;