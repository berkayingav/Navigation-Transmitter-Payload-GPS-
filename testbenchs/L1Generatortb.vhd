----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.04.2025 20:37:00
-- Design Name: 
-- Module Name: L1Generatortb - Behavioral
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

entity L1Generatortb is
end L1Generatortb;

architecture Behavioral of L1Generatortb is

    component L1Generator
        Port (
            clk : in std_logic;
            clk1023MHz : in std_logic;
            clk50Hz : in std_logic;    
            reset : in std_logic; 
            prn : in integer;
            bpskOut : out std_logic_vector(11 downto 0);
            clkDataOut : out std_logic
            );
    end component;
    
    signal clktb : std_logic := '0';
    signal clk1023MHztb : std_logic := '0';
    signal clk50Hztb : std_logic := '0';
    signal resettb : std_logic := '1';
    signal prntb : integer := 1;
    signal bpskOuttb : std_logic_vector(11 downto 0);
    signal clkDataOuttb : std_logic;
    
begin

    UT : L1Generator
        Port map(
            clk => clktb,
            clk1023MHz => clk1023MHztb,
            clk50Hz => clk50Hztb,
            reset => resettb,
            prn => prntb,
            bpskOut => bpskOuttb,
            clkDataOut => clkDataOuttb
            );
        
     clkProcess : process
     begin
        while true loop
            clktb <= '0';
            wait for 5 ns;
            clktb <= '1';
            wait for 5 ns;
        end loop;
     end process;
     
     clk1023Process : process
     begin 
        while true loop
            clk1023MHztb <= '0';
            wait for 488 ns;
            clk1023MHztb <= '1';
            wait for 488 ns;
        end loop; 
     end process;
     
     clk50Process : process
     begin 
        while true loop 
            clk50Hztb <= '0';
            wait for 10 ms;
            clk50Hztb <= '1';
            wait for 10 ms;
        end loop;
     end process;
     
     stim : process
     begin
        wait for 20 ns;
        resettb <= '0';
        
        wait for 100 ms;
        wait;
     end process;
end Behavioral;
