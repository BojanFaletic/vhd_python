library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is port (
    clk, rst : in std_logic := '0';
    a, b     : in std_logic_vector(7 downto 0);
    sum      : out std_logic_vector(7 downto 0));
end adder;

architecture behav of adder is
begin
    process(clk) begin
        if rising_edge(clk) then
          sum <= std_logic_vector(unsigned(a) + unsigned(b));
        end if;
    end process;
end behav;
