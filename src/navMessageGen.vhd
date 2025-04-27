----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.04.2025 15:24:54
-- Design Name: 
-- Module Name: navMessageGen - Behavioral
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

entity navMessageGen is
     port (
        clk50Hz : in std_logic;
        reset : in std_logic;
        navOut : out std_logic
      );
end navMessageGen;

architecture Behavioral of navMessageGen is
    signal lfsr : std_logic_vector(7 downto 0) := (others => '1');

begin

    process(clk50Hz,reset)
    begin
        if reset ='0' then 
            lfsr <= "11111111";
        elsif rising_edge(clk50Hz) then
            lfsr <= lfsr(6 downto 0) & (lfsr(3) xor lfsr(4) xor lfsr(5) xor lfsr(7));
        end if;
    end process;
    
    navOut <= lfsr(0);

end Behavioral;
