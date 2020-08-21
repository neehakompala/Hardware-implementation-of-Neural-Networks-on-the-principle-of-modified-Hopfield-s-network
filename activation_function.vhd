----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:05:10 03/23/2018 
-- Design Name: 
-- Module Name:    activation_function - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_SIGNED.ALL;
entity activation_function is
	Port ( input : in std_logic_vector(13 downto 0);
	output : out std_logic_vector(6 downto 0);
	enable : in std_logic;
	clk : in std_logic
	);
end activation_function;
architecture Behavioral of activation_function is
begin
process ( clk)
begin
	if (clk'event and clk = '1') then
	if (enable = '1') then
	if (input < 0) then
	output <= "0000000";
	else
	output <= "0010000";
	end if;
	end if;
	end if;
end process;
end Behavioral;

