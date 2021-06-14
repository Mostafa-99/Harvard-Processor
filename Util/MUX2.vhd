library ieee;
use ieee.std_logic_1164.all;

entity MUX2 is
    generic (n : integer := 32);
    port (

        s : in std_logic;
        data_in1 : in std_logic_vector(n - 1 downto 0);
        data_in2 : in std_logic_vector(n - 1 downto 0);
        data_out : out std_logic_vector(n - 1 downto 0));

end entity;

architecture mux2 of MUX2 is
begin
    data_out <= data_in1 when s = '0'
        else
        data_in2;
end architecture;