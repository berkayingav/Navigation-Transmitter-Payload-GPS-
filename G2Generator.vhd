----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.04.2025 20:10:16
-- Design Name: 
-- Module Name: G2Generator - Behavioral
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

entity G2Generator is
  Port (
    clk : in std_logic;
    reset : in std_logic;
    G2Out : out std_logic_vector(9 downto 0)
   );
end G2Generator;

architecture Behavioral of G2Generator is
    signal G2 : std_logic_vector(0 to 9) := (others => '1');
begin
    process(clk,reset)
    begin
        if reset = '0' then
            G2 <= (others => '1');
        elsif rising_edge(clk) then
            G2 <= (G2(1) xor G2(2) xor G2(5) xor G2(7) xor G2(8) xor G2(9)) & G2(0 to 8);
        end if;
    end process;
        G2Out <= G2;
end Behavioral;
