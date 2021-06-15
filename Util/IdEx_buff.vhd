library ieee;
use IEEE.numeric_std.all;
use ieee.std_logic_1164.all;

entity IdExBuff is
    port (
        clk, rst, enable : in std_logic;

        incrementedPCInp : in std_logic_vector(32 - 1 downto 0);
        --nonPickedAddressInp : in std_logic_vector(32 - 1 downto 0);
        readD1 : in std_logic_vector(32 - 1 downto 0);
        readD2 : in std_logic_vector(32 - 1 downto 0);
        opCode : in std_logic_vector(5 downto 0);
        iValSignExtended : in std_logic_vector(32 - 1 downto 0);
        rsAddr : in std_logic_vector(2 downto 0);
        rdAddr : in std_logic_vector(2 downto 0);
        input_port_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

        --control signalsss
        controlSigs : in std_logic_vector(20 - 1 downto 0);
        -------------------------------------- Output
        incrementedPCOut : out std_logic_vector(32 - 1 downto 0);
        --nonPickedAddressOut : out std_logic_vector(32 - 1 downto 0);
        readD1Out : out std_logic_vector(32 - 1 downto 0);
        readD2Out : out std_logic_vector(32 - 1 downto 0);
        opCodeOut : out std_logic_vector(5 downto 0);
        iValSignExtendedOut : out std_logic_vector(32 - 1 downto 0);
        rsAddrOut : out std_logic_vector(2 downto 0);
        rdAddrOut : out std_logic_vector(2 downto 0);
        input_port_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        --control signalsss
        controlSigsOut : out std_logic_vector(20 - 1 downto 0)


    );
end entity IdExBuff;

architecture IdExBuff1 of IdExBuff is

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
    b1 : IBuffer generic map(32) port map(clk, rst, enable, incrementedPCInp, incrementedPCOut);
    --b12 : IBuffer generic map(32) port map(clk, rst, pcWrite, nonPickedAddressInp, nonPickedAddressOut);
    b2 : IBuffer generic map(32) port map(clk, rst, enable, readD1, readD1Out);
    b3 : IBuffer generic map(32) port map(clk, rst, enable, readD2, readD2Out);
    b4 : IBuffer generic map(6) port map(clk, rst, enable, opCode, opCodeOut);
    b5 : IBuffer generic map(32) port map(clk, rst, enable, iValSignExtended, iValSignExtendedOut);
    b6 : IBuffer generic map(3) port map(clk, rst, enable, rsAddr, rsAddrOut);
    b7 : IBuffer generic map(3) port map(clk, rst, enable, rdAddr, rdAddrOut);
    b8 : IBuffer generic map(32) port map(clk, rst, enable, input_port_in, input_port_out);
    b9 : IBuffer generic map(20) port map(clk, rst, enable, controlSigs, controlSigsOut);

end architecture;