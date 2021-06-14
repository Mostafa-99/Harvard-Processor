library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SignExtend is
    port (
        data_in : in std_logic_vector(16 - 1 downto 0);
        data_out : out std_logic_vector(32 - 1 downto 0)
    );
end entity;

architecture signExtend of SignExtend is
begin
    data_out <= std_logic_vector(resize(signed(data_in), data_out'length));
end architecture;