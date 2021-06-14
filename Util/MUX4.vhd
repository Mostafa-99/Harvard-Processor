library ieee;
use ieee.std_logic_1164.all;

entity MUX4 is
    generic (n : integer := 32);
    port (

        s : in std_logic_vector(1 downto 0);
        data_in1 : in std_logic_vector(n - 1 downto 0);
        data_in2 : in std_logic_vector(n - 1 downto 0);
        data_in3 : in std_logic_vector(n - 1 downto 0);
        data_in4 : in std_logic_vector(n - 1 downto 0);
        data_out : out std_logic_vector(n - 1 downto 0));

end entity;

architecture mux4 of MUX4 is
begin
    data_out <= data_in1 when S(0) = '0' and S(1) = '0'
        else
        data_in2 when S(0) = '1' and S(1) = '0'
        else
        data_in3 when S(0) = '0' and S(1) = '1'
        else
        data_in4;
end architecture;