----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.04.2025 17:04:14
-- Design Name: 
-- Module Name: bpskModulator - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
library work;
use work.real2bit.all;


entity bpskModulator is
  Port (
        clk : in std_logic;
        reset : in std_logic;
        data_in : in std_logic;  
        clkData : out std_logic; 
        data_out : out std_logic_vector(11 downto 0)
        );
end bpskModulator;

architecture Behavioral of bpskModulator is
    signal pointer : natural range 0 to (M-1) := M-1; 
    signal value : word := (others => '0');
    signal clkBpsk : std_logic := '0';
    begin
    process(reset,clk,clkBpsk)
    variable count : natural range 0 to (64*M-1) := 0;
    begin 
        if reset = '1' then
            clkBpsk <= '0';
            clkData <= '0';
            count := 0;
        elsif rising_edge(clk) then
            if count = 0 then 
                clkBpsk <= '1';
                clkData <= '1';
            elsif count mod 64 = 0 then
                clkBpsk <= '1';
            else 
                clkBpsk <= '0';
                clkData <= '0';
            end if;
            count :=  (count + 1) mod (64*M);  
         end if;
     end process;
         
     process(reset,clkBpsk)
     begin   
        if reset = '1' then 
            pointer <= M-1;  
        elsif rising_edge(clkBpsk) then
            pointer <= (pointer + 1) mod M;
        end if;
     end process;
     
     value <= -table_wave(pointer) when data_in = '1' else
     table_wave(pointer);  
     data_out <= std_logic_vector(value);
end Behavioral;
