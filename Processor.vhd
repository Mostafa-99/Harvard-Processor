library ieee;
use IEEE.numeric_std.all;
use ieee.std_logic_1164.all;

entity Processor is
    port (
        clk, rst : in std_logic
    );
end entity Processor;

architecture processor1 of Processor is
    component FetchStage is
        port (
            clk, rst, pcWrite : in std_logic;
            instructionOut : out std_logic_vector(32 - 1 downto 0);
            incrementedPCOut : out std_logic_vector(32 - 1 downto 0)
            --nonPickedAddressOut : out std_logic_vector(32 - 1 downto 0);
        );
    end component;

    component IfIdBuff is
        port (
            clk, rst, enable : in std_logic;
            instructionInp : in std_logic_vector(32 - 1 downto 0);
            incrementedPCInp : in std_logic_vector(32 - 1 downto 0);
            --nonPickedAddressInp : in std_logic_vector(32 - 1 downto 0);
            instructionOut : out std_logic_vector(32 - 1 downto 0);
            incrementedPCOut : out std_logic_vector(32 - 1 downto 0)
            --nonPickedAddressOut : out std_logic_vector(32 - 1 downto 0);

        );
    end component;

    component DecodeStage is
        port (
            clk, rst : in std_logic; --Clock, Reset
            register1, register2 : in std_logic_vector(2 downto 0); --The registers to be decoded
            immediate_value_non_extended : in std_logic_vector(15 downto 0); --The immediate value before sign extending it
            MemWB_WB : in std_logic; --Write back signal
            MemWB_Rd : in std_logic_vector (2 downto 0); --Register destination address used for write back
            MemWB_Val : in std_logic_vector(31 downto 0); --The data to be written in write back 
            register1_decoded, register2_decoded : out std_logic_vector(31 downto 0); --The value after decoding the register
            immediate_value_sign_extended : out std_logic_vector(31 downto 0) --The value of the immediate value after sign extending
        );
    end component;

    component ControlUnit is
        port (
            opCode : in std_logic_vector(5 downto 0);
            reset : in std_logic;
            controlSignals : out std_logic_vector(19 downto 0)
        );
    end component ControlUnit;

    component IdExBuff is
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
            --control signalsss
            controlSigsOut : out std_logic_vector(20 - 1 downto 0)
        );
    end component;

    component HazardDetectionUnit is
        port (
            fdRsAddress : in std_logic_vector(2 downto 0);
            fdRdAddress : in std_logic_vector(2 downto 0);
            deRdAddress : in std_logic_vector(2 downto 0);
            deMemoryRead : in std_logic;
            fdWrite : out std_logic;
            controlMuxSelection : out std_logic;
            pcWrite : out std_logic
        );
    end component;

    --Fetch Stage sig
    signal pcWrite : std_logic;
    signal instructionOutF : std_logic_vector(32 - 1 downto 0);
    signal incrementedPCOutF : std_logic_vector(32 - 1 downto 0);
    signal IfId_En : std_logic;
    signal IfId_instruction : std_logic_vector(32 - 1 downto 0);
    signal IfId_incrementedPC : std_logic_vector(32 - 1 downto 0);
    --Decode Stage sig
    signal readD1 : std_logic_vector(32 - 1 downto 0);
    signal readD2 : std_logic_vector(32 - 1 downto 0);
    signal iValSignExtended : std_logic_vector(32 - 1 downto 0);
    signal controlSigs : std_logic_vector(20 - 1 downto 0);
    --
    --TODO: assign after adding last buffer
    signal MemWB_WB : std_logic; --Write back signal
    signal MemWB_Rd : std_logic_vector (2 downto 0);
    signal MemWB_Val : std_logic_vector(31 downto 0);
begin
    pcWrite <= '1'; --input from hazard detect
    IfId_En <= '1'; --input hazard detection
    fetchingUnit : FetchStage port map(clk, rst, pcWrite, instructionOutF, incrementedPCOutF);
    IfId : IfIdBuff port map(clk, rst, IfId_En, instructionOutF, incrementedPCOutF, IfId_instruction, IfId_incrementedPC);
    decodingUnit : DecodeStage port map(clk, rst, IfId_instruction(25 downto 23), IfId_instruction(22 downto 20), IfId_instruction(15 downto 0), MemWB_WB, MemWB_Rd, MemWB_Val, readD1, readD2, iValSignExtended);
    cu : ControlUnit port map(IfId_instruction(31 downto 26), rst, controlSigs);

    --work in progress: IdEx
    --IdEx : IdExBuff port map(clk, rst, );
end architecture;