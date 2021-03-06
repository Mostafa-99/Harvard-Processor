library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PCAdder is
    port (
        inc4 : in std_logic;
        PC_in : in std_logic_vector(32 - 1 downto 0);
        PC_out : out std_logic_vector(32 - 1 downto 0)
    );
end entity;

architecture pcAdder of PCAdder is
begin
    PC_out <= std_logic_vector(unsigned(PC_in) + to_unsigned(1, 32 - 1)) when inc4 = '0'
        else
        std_logic_vector(unsigned(PC_in) + to_unsigned(2, 32 - 1));
end architecture;