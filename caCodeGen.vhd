----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.04.2025 13:00:34
-- Design Name: 
-- Module Name: caCodeGen - Behavioral
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

entity caCodeGen is
  Port ( 
       clk : in std_logic;
       reset : in std_logic;
       prn : in integer range 1 to 32;
       caBit : out std_logic
       );
end caCodeGen;

architecture Behavioral of caCodeGen is
    type tapArr is array(1 to 32,1 to 2) of integer range 1 to 10;
    constant prnTaps : tapArr := (
        (2,6),(3,7),(4,8),(5,9),(1,9),
        (2,10),(1,8),(2,9),(3,10),(2,3),
        (3,4),(5,6),(6,7),(7,8),(8,9),
        (9,10),(1,4),(2,5),(3,6),(4,7),
        (5,8),(6,9),(1,3),(4,6),(5,7),
        (6,8),(7,9),(8,10),(1,6),(2,7),
        (3,8),(4,9)
    );
    
    component G1Generator
        port (
            clk : in std_logic;
            reset : in std_logic;
            G1Out : out std_logic_vector(9 downto 0)
            );
    end component;
    
    component G2Generator 
        port (
            clk : in std_logic;  
            reset: in std_logic;
            G2Out : out std_logic_vector(9 downto 0)
        );
     end component;
     
     signal g1_out : std_logic_vector(0 to 9) := (others => '1');
     signal g2_out : std_logic_vector(0 to 9) := (others => '1');
     signal cabitint : std_logic;
begin

    g1Include : G1Generator 
        port map (
            clk => clk,
            reset => reset,
            G1Out => g1_out
        );
    g2Include : G2Generator
        port map (
            clk => clk,
            reset => reset,
            G2Out => g2_out
        );

        process(clk)
        variable tap1,tap2 : integer;
        begin
            if rising_edge(clk) then
                tap1 := prnTaps(prn,1);
                tap2 := prnTaps(prn,2);
                caBit <= g1_out(9) xor (g2_out(tap1 - 1) xor g2_out(tap2-1)); 
            end if;
        end process;
end Behavioral;
