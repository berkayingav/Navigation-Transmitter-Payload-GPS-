----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.04.2025 18:01:27
-- Design Name: 
-- Module Name: bpskModulatortb - Behavioral
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

entity bpskModulatortb is
--  Port ( );
end bpskModulatortb;

architecture Behavioral of bpskModulatortb is

    component bpskModulator
        port(
            clk : in std_logic; 
            reset : in std_logic; 
            data_in : in std_logic; 
            clkData : out std_logic; 
            data_out : out std_logic_vector(11 downto 0)
            );
    end component; 

    signal clk : std_logic := '0';
    signal reset : std_logic := '1';
    signal data_in : std_logic := '0';  
    signal clkData : std_logic; 
    signal data_out: std_logic_vector(11 downto 0);
    
begin

    UT : bpskModulator
        port map(
            clk => clk,
            reset => reset,
            data_in => data_in,
            clkData => clkData,
            data_out => data_out
        );
        
    clkProcess : process 
    begin 
        while true loop 
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process;
    
    stim : process
    begin 
        wait for 20 ns;
        reset <= '0';
        wait for 100 ns;
        
        
        data_in <='1';
        wait until rising_edge(clkData);
        data_in <='1';
        wait until rising_edge(clkData);
        data_in <= '0';
        wait until rising_edge(clkData);
        data_in <= '1';
        wait until rising_edge(clkData);
        data_in <= '1';
        wait until rising_edge(clkData);
        
        wait;
    
    end process;

end Behavioral;
