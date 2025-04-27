----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.04.2025 18:40:35
-- Design Name: 
-- Module Name: prnGenerator - Behavioral
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
use IEEE.NUMERIC_STD.ALL;


entity prnGenerator is
 Port (
    clk1023MHz : in std_logic;   
    clk50Hz : in std_logic;
    reset : in std_logic;    
    prn : in integer;
    navCaOut : out std_logic
 
  );
end prnGenerator;

architecture Behavioral of prnGenerator is

    component caCodeGen 
        port(
           clk : in std_logic;
           reset : in std_logic;
           prn : in integer range 1 to 32;
           caBit : out std_logic
            );
    end component; 
    
    component navMessageGen 
        port(
            clk50Hz : in std_logic;
            reset : in std_logic;
            navOut : out std_logic
            );
    end component;
    signal caCodeBit : std_logic;
    signal navMessageBit : std_logic;  
    signal counter20460 : unsigned(14 downto 0) :=(others => '0');
    signal counter1500 : unsigned(10 downto 0) :=(others => '0');

begin
    
    caCode : caCodeGen
        port map(
        clk => clk1023Mhz,
        reset => reset,
        prn => prn,
        caBit => caCodeBit
        );
    
    navMessage : navMessageGen
        port map(
        clk50Hz => clk50Hz,
        reset => reset,
        navOut => navMessageBit
        );
  
        
        process(clk1023Mhz)
        begin 
            if rising_edge(clk1023Mhz) then 
                navCaOut <= caCodeBit xor navMessageBit;
            end if;
        end process;
    

end Behavioral;
