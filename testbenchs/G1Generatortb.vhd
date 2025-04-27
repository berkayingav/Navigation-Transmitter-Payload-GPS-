----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.04.2025 19:56:52
-- Design Name: 
-- Module Name: G1Generatortb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity G1Generatortb is
--  Port ( );
end G1Generatortb;

architecture Behavioral of G1Generatortb is
    signal clk : std_logic := '0';
    signal reset : std_logic := '1';
    signal G1Out : std_logic_vector(9 downto 0);
    
    component G1Generator
        port (
            clk : in std_logic;
            reset : in std_logic;
            G1Out : out std_logic_vector(9 downto 0)
            );
     end component;
    
begin
    uut: G1Generator 
        port map (
            clk => clk,
            reset => reset,
            G1Out => G1Out
        );

    clk_process : process
    begin
            for i in 0 to 99 loop
            clk <= '0'; wait for 5 ns;
            clk <= '1'; wait for 5 ns;
        end loop;
        wait;
    end process;
    
    stim_proc: process
    begin
        wait for 10 ns;
        reset <= '0';  -- reset býrakýlýr
        wait for 200 ns;
        reset <= '1';  -- reset tekrar aktif edilir
        wait for 20 ns;
        reset <= '0';
        wait;
    end process;
end Behavioral;
