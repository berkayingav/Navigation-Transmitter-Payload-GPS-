----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.04.2025 16:01:30
-- Design Name: 
-- Module Name: navMessageGenTb - Behavioral
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

entity navMessageGenTb is
--  Port ( );
end navMessageGenTb;

architecture Behavioral of navMessageGenTb is
    component navMessageGen
        port(
            clk50Hz : in std_logic;
            reset : in std_logic;
            navOut : out std_logic 
            );
    end component;
    
    signal clk50HzTb : std_logic := '0'; 
    signal resetTb : std_logic := '0';
    signal navOutTb : std_logic;

begin

    UT: navMessageGen 
        port map (
            clk50Hz => clk50HzTb,
            reset => resetTb, 
            navOut => navOutTb
        );

    clk : process
    begin
        while true loop
            clk50HzTb <= '0';
            wait for 20 ms / 2;
            clk50HzTb <= '1';
            wait for 20 ms / 2;
        end loop;
    end process;

    stim: process
    begin
        wait for 5 ms;
        resetTb <= '1';
        for i in 0 to 1499 loop  
            wait until rising_edge(clk50HzTb);
        end loop;
        
        wait;
    end process;

end Behavioral;
