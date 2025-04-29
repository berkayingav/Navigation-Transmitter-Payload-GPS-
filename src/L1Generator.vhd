----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.04.2025 20:27:29
-- Design Name: 
-- Module Name: L1Generator - Behavioral
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

entity L1Generator is
    Port (
        clk : in std_logic;
        clk1023MHz : in std_logic;
        clk50Hz : in std_logic;
        reset : in std_logic;
        prn : in integer;
        bpskOut : out std_logic_vector(11 downto 0);
        clkDataOut : out std_logic
         );
end L1Generator;

architecture Behavioral of L1Generator is

    component prnGenerator 
        Port(
            clk1023MHz : in std_logic;
            clk50Hz : in std_logic;
            reset : in std_logic;
            prn : in integer;
            navCaOut : out std_logic
            );
    end component;
    
    component bpskModulator 
        Port(
            clk : in std_logic;
            reset : in std_logic;   
            data_in : in std_logic;
            clkData : out std_logic;
            data_out : out std_logic_vector(11 downto 0)
            );
    end component;
    
    signal navCaBit : std_logic;
    signal clkDataInt : std_logic;

begin
    
    prnGeneratorIns : prnGenerator
        Port map (
            clk1023MHz => clk1023MHz, 
            clk50Hz => clk50Hz,
            reset => reset,
            prn => prn,
            navCaOut => navCaBit 
            );
    
    bpskModulatorIns : bpskModulator
        Port map ( 
            clk => clk,
            reset => reset, 
            data_in => navCaBit,
            clkData => clkDataInt, 
            data_out => bpskOut
            );
    
    clkDataOut <= clkDataInt;
    
end Behavioral;
