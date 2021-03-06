library ieee;
use IEEE.numeric_std.all;
use ieee.std_logic_1164.all;

entity FetchStage is
    port (
        clk, rst, pcWrite : in std_logic;
        instructionOut : out std_logic_vector(32 - 1 downto 0);
        incrementedPCOut : out std_logic_vector(32 - 1 downto 0)
        --nonPickedAddressOut : out std_logic_vector(32 - 1 downto 0);

    );
end entity FetchStage;

architecture FetchStage1 of FetchStage is

    component IBuffer is
        generic (n : integer := 32);
        port (
            clk, rst, enable : in std_logic;
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

    component PCAdder is
        port (
            inc4 : in std_logic;
            PC_in : in std_logic_vector(32 - 1 downto 0);
            PC_out : out std_logic_vector(32 - 1 downto 0)
        );
    end component;
    signal iMemOutput : std_logic_vector(31 downto 0);
    signal PCinput : std_logic_vector(31 downto 0);
    signal PCoutput : std_logic_vector(31 downto 0);
    signal zeros : std_logic_vector(31 downto 0);
    signal iMemInput : std_logic_vector(31 downto 0);
    signal pcIncremented : std_logic_vector(31 downto 0);
begin
    pcRstMux : MUX2 generic map(32) port map(rst, pcIncremented, iMemOutput, PCinput);
    pc : IBuffer generic map(32) port map(clk, zeros(0), pcWrite, PCinput, PCoutput);
    memInputRstMux : MUX2 generic map(32) port map(rst, PCoutput, zeros, iMemInput);
    iMem : InstructionMemory generic map(32, 20) port map(iMemInput, iMemOutput);
    pcAdd : PCAdder port map(iMemOutput(31), PCoutput, pcIncremented);
    zeros <= (others => '0');
    instructionOut <= iMemOutput when rst = '0'
        else
        (others => 'Z');
    incrementedPCOut <= pcIncremented;
    --nonPickedAddressOut <=

end FetchStage1;