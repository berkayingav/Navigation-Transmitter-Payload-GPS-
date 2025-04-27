----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.04.2025 21:22:01
-- Design Name: 
-- Module Name: prnGeneratortb - Behavioral
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

entity prnGeneratortb is
--  Port ( );
end prnGeneratortb;

architecture Behavioral of prnGeneratortb is
    
    component prnGenerator 
        port(
            clk1023MHz : in std_logic;   
            clk50Hz : in std_logic;
            reset : in std_logic;    
            prn : in integer;
            navCaOut : out std_logic    
            );
        end component;
        
     signal clk1023MHztb : std_logic := '0'; 
     signal clk50Hztb : std_logic := '0';
     signal resettb : std_logic := '0';
     signal prntb : integer range 1 to 32 := 1; 
     signal navCaOuttb : std_logic;
begin
    
    PG : prnGenerator
        port map (
            clk1023MHz => clk1023MHztb, 
            clk50Hz => clk50Hztb,
            reset => resettb,
            prn => prntb,
            navCaOut => navCaOuttb
            );
    
    clk_1023_process : process
    begin 
        while true loop 
            clk1023MHztb <= '0';
            wait for 977.5 ns / 2;
            clk1023MHztb <= '1';
            wait for 977.5 ns / 2;
        end loop;
    end process;    

    clk_50_process : process 
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
        resettb <= '0';
        wait for 5 ms;
        resettb <= '1';
        
        prntb <= 1;
        wait for 30 sec;
        
        prntb <= 2;
        wait for 30 sec;
        
        prntb <= 3;
        wait for 30 sec;
        
        wait;

    end process;
    
end Behavioral;
