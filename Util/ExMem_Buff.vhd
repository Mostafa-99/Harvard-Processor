library ieee;
use IEEE.numeric_std.all;
use ieee.std_logic_1164.all;


entity ExMemBuff is
    port (
        clk, rst, enable : in std_logic;
        incrementedPCInp : in std_logic_vector(32 - 1 downto 0);
        --nonPickedAddressInp : in std_logic_vector(32 - 1 downto 0);
        --nonPickedAddressOut : out std_logic_vector(32 - 1 downto 0)
        aluResult : in std_logic_vector(32 - 1 downto 0);
        readD2 : in std_logic_vector(32 - 1 downto 0);
        rdAddr : in std_logic_vector(2 downto 0);
        
        --control signalsss
        controlSigs : in std_logic_vector(20 - 1 downto 0);

        ----------------Output
        incrementedPCOut : out std_logic_vector(32 - 1 downto 0);
        aluResultOut : out std_logic_vector(32 - 1 downto 0);
        readD2Out : out std_logic_vector(32 - 1 downto 0);
        rdAddrOut : out std_logic_vector(2 downto 0);
        --control signalsss
        controlSigsOut : out std_logic_vector(20 - 1 downto 0)

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
    b1:  IBuffer generic map(32) port map(clk, rst, enable, incrementedPCInp, incrementedPCOut);
    b2 : IBuffer generic map(32) port map(clk, rst, enable, aluResult, aluResultOut);
    b3 : IBuffer generic map(32) port map(clk, rst, enable, readD2, readD2Out);
    b4 : IBuffer generic map(3) port map(clk, rst, enable, rdAddr, rdAddrOut);
    b5 : IBuffer generic map(20) port map(clk, rst, enable, controlSigs, controlSigsOut);
    --b3 : IBuffer generic map(32) port map(clk, rst, pcWrite, nonPickedAddressInp, nonPickedAddressOut);

end architecture;
