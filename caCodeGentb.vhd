-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.04.2025 14:15:56
-- Design Name: 
-- Module Name: caCodeGentb - Behavioral
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
use IEEE.STD_LOGIC_TEXTIO.ALL;
use STD.TEXTIO.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity caCodeGentb is
--  Port ( );
end caCodeGentb;
architecture Behavioral of caCodeGentb is

    component caCodeGen
        port(
            clk : in std_logic;
            reset : in std_logic;
            prn : in integer range 1 to 32;
            caBit : out std_logic
            );
    end component;
    
    -- signals for test 
    signal clkTb : std_logic := '0';  
    signal resetTb : std_logic := '1';
    signal prnTb : integer range 1 to 32 := 1;
    signal caBitTb : std_logic;
    signal caCode : std_logic_vector(9 downto 0) := (others => '1');
    


begin

    clk_process : process
    begin 
        while true loop 
            clkTb <= '0';
            wait for 100 ns / 2;
            clkTb <= '1';
            wait for 100 ns / 2;
        end loop;
    end process;
    
    UT: caCodeGen
        port map (
            clk => clkTb,
            reset => resetTb,
            prn => prnTb,
            caBit => caBitTb
        );
    
    stim: process
    begin 
        wait for 100 ns;
        resetTb <= '0';
    
        for i in 0 to 9 loop
            wait until rising_edge(clkTb);
            wait for 1 ns;
            caCode(i) <= caBitTb;
        end loop;
        
        wait until rising_edge(clkTb);
        wait for 200 ns;  
        wait;
    
    end process;
    
end Behavioral;
