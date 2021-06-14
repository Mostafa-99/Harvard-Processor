library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity IBuffer is
    generic (n : integer := 64);
    port (
        clk, rst : in std_logic;
        data_in : in std_logic_vector(n - 1 downto 0);
        data_out : out std_logic_vector(n - 1 downto 0)
    );
end entity;

architecture IBuffer1 of IBuffer is

    signal data : std_logic_vector(n - 1 downto 0);

begin
    process (clk)
    begin
        if rst = '1' then
            data <= (others => '0');
        elsif rising_edge(clk) then --TODO: make sure this is what's desired
            data <= data_in;
        end if;
    end process;
    data_out <= data;
end architecture;