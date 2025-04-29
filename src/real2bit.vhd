----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.04.2025 02:17:24
-- Design Name: 
-- Module Name: real2bit - Behavioral
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
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.MATH_REAL.all;

package real2bit is 
	constant nbits : positive := 12;
	constant ndec : positive := 10;
	subtype double is signed(2*nbits-1 downto 0);
	function truncate (a: real; numdec : natural := ndec) return
signed;
		function extract (a: double; numdec : natural := ndec) return 
signed; 
	constant M : positive := 32;
	constant Pi : real := 3.1415927;
	constant delta_phi : real := 2.0*Pi/real(M);
	subtype word is signed(nbits-1 downto 0);
	type table is array (M-1 downto 0) of word;
	function initialize_table return table; 
	constant table_wave : table := initialize_table;
end real2bit; 

package body real2bit is 
	function truncate (a: real; numdec : natural := ndec)
	return signed is 
		variable result: signed(nbits-1 downto 0);
		variable tmp, comp : real := 0.0;
		variable comp_int, sign : integer := 0;
	begin 
		tmp := abs(a*(2.0**numdec));  --fixed point representation   
		if a < 0.0 then 
			sign:= -1;
		else
			sign:= 1;
		end if;
		for I in nbits-2 downto 0 loop 
			comp := comp + 2.0**I; 
			comp_int := comp_int + 2**I;
			if tmp < comp then 
				comp := comp - 2.0**I;
				comp_int := comp_int - 2**I;
			end if;
		end loop; 
		result := conv_signed(comp_int*sign,nbits);
		return result;
	end truncate;
	
	function extract (a: double; numdec : natural := ndec) 
	return signed is
		variable result : signed(nbits-1 downto 0);
	begin 
		result := signed(a(numdec+nbits-1 downto numdec));
		return result; 
	end extract; 
		
	function initialize_table 
	return table is 
	variable result : table;
	begin  
		for I in 0 to M-1 loop 
			result (I) := truncate(2.0*sin(delta_phi*real(I)));
		end loop; 
		return result;
	end initialize_table;
end real2bit;
