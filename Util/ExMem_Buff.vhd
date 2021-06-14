library ieee;
use IEEE.numeric_std.all;
use ieee.std_logic_1164.all;

entity ExMemBuff is
    port (
        clk, rst, enable : in std_logic;
        instructionInp : in std_logic_vector(32 - 1 downto 0);
        incrementedPCInp : in std_logic_vector(32 - 1 downto 0);
        --nonPickedAddressInp : in std_logic_vector(32 - 1 downto 0);
        instructionOut : out std_logic_vector(32 - 1 downto 0);
        incrementedPCOut : out std_logic_vector(32 - 1 downto 0)
        --nonPickedAddressOut : out std_logic_vector(32 - 1 downto 0)

    );
end entity ExMemBuff;

architecture ExMemBuff1 of ExMemBuff is

    component IBuffer is
        generic (n : integer := 32);
        port (
            clk, rst, enable : in std_logic;
            data_in : in std_logic_vector(n - 1 downto 0);
            data_out : out std_logic_vector(n - 1 downto 0)
        );
    end component;
    --signal bufferInp : std_logic_vector(64-1 downto 0);
begin
    b1 : IBuffer generic map(32) port map(clk, rst, enable, instructionInp, instructionOut);
    b2 : IBuffer generic map(32) port map(clk, rst, enable, incrementedPCInp, incrementedPCOut);
    --b3 : IBuffer generic map(32) port map(clk, rst, pcWrite, nonPickedAddressInp, nonPickedAddressOut);

end architecture;