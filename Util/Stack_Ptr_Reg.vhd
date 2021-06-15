library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity StackPtrReg is
    port (
        pushPop, Clk, En, Rst : in std_logic;
        addressOut : out std_logic_vector(31 downto 0));
end entity;

architecture stackPtrReg of StackPtrReg is
    signal address : std_logic_vector(31 downto 0);
begin
    process (Clk)
    begin
        if Rst = '1' then
            address <= "00000000000011111111111111111110";
        elsif rising_edge(Clk) and En = '1' then --TODO: make sure this is correct clk
            if pushPop = '1'  then --push
                address <= STD_LOGIC_VECTOR(unsigned(address) - to_unsigned(2,32-1));
            else -- pop
                address <= STD_LOGIC_VECTOR(unsigned(address) + to_unsigned(2,32-1));
            end if;
        end if;
    end process;
    addressOut <= address;
end architecture;