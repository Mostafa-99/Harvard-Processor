library ieee;
use ieee.std_logic_1164.all;
entity HazardDetectionUnit is
    port (
        fdRsAddress:in std_logic_vector(2 downto 0);
        fdRdAddress:in std_logic_vector(2 downto 0);
        deRdAddress:in std_logic_vector(2 downto 0);
        deMemoryRead:in std_logic;
        fdWrite:out std_logic;
        controlMuxSelection:out std_logic;
        pcWrite:out std_logic
    );
end entity HazardDetectionUnit;
architecture HazardDetectionUnitArchitecture of HazardDetectionUnit is
    begin
        fdWrite<='0' when deMemoryRead='1' and ((deRdAddress=fdRsAddress)or(deRdAddress=fdRdAddress)) else '1';
        controlMuxSelection<='1' when deMemoryRead='1' and ((deRdAddress=fdRsAddress)or(deRdAddress=fdRdAddress)) else '0';
        pcWrite<='0' when deMemoryRead='1' and ((deRdAddress=fdRsAddress)or(deRdAddress=fdRdAddress)) else '1';    
end HazardDetectionUnitArchitecture;