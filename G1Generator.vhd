----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.04.2025 16:51:19
-- Design Name: 
-- Module Name: wallacetree - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity G1Generator is
    port (
        clk : in std_logic;
        reset : in std_logic;
        G1Out : out std_logic_vector(9 downto 0)
        );
--  Port ( );
end G1Generator;

architecture Behavioral of G1Generator is
    signal G1 : std_logic_vector(0 to 9) := (others => '1');
begin
    process(clk,reset)
    begin
        if reset = '1' then
            G1 <= (others => '1');
        elsif rising_edge(clk) then
            G1 <= (G1(2) xor G1(9)) & G1(0 to 8);
        end if;
     end process;
     G1Out <= G1;

end Behavioral;
