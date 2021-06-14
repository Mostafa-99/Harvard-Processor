library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PCAdder is
    port (
        PC_in : in std_logic_vector(16 - 1 downto 0);
        PC_out : out std_logic_vector(16 - 1 downto 0)
    );
end entity;

architecture pcAdder of PCAdder is
begin
    PC_out <= STD_LOGIC_VECTOR(unsigned(PC_in) + to_unsigned(4,16-1));
end architecture;