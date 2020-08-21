----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:04:04 03/23/2018 
-- Design Name: 
-- Module Name:    three_ip_MAC - Behavioral 
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
entity three_ip_MAC is
	Port (
	mr, md : in std_logic_vector ( 6 downto 0 );
	clk : in std_logic;
	enable : in std_logic;
	reset : in std_logic;
	done : out std_logic;
	mac_result : out std_logic_vector ( 13 downto 0)
	);
end three_ip_MAC;
architecture fsm of three_ip_MAC is
	type states is (init, add_sub, shift, accumulate);
	signal mply_state : states;
	signal count : std_logic_vector (2 downto 0);
	signal tmp_result : std_logic_vector ( 13 downto 0);
	begin
	process (clk, enable, reset)
		variable done_var : std_logic := '0';
		variable temp_md : std_logic_vector (7 downto 0) := "00000000";
		variable temp_out : std_logic_vector ( 14 downto 0 ) :="000000000000000";
		variable temp_result : std_logic_vector ( 13 downto 0):="00000000000000";
begin
	if (reset = '1') then
	mac_result <= "00000000000000";
	temp_result := "00000000000000";
	tmp_result <= "00000000000000";
	else
	if(enable = '1') then
	if (clk'event and clk = '1') then
	case mply_state is
	when init =>
	if (done_var = '0') then
	temp_out (6 downto 0) := mr;
	temp_md (6 downto 0) := md;
	temp_md (7) := md(6);
	mply_state <= add_sub;
	else
	null;
	end if;
	when add_sub =>
	if (temp_out(0) = '1') then
	if (count = "110") then
	temp_out ( 14 downto 7 ) := temp_out ( 14 downto 7 ) - temp_md ( 7 downto 0);
	else
	temp_out ( 14 downto 7 ) := temp_out ( 14 downto 7 ) + temp_md ( 7 downto 0);
	end if;
	else
	null;
	end if;
	mply_state <= shift;
when shift =>
temp_out (13 downto 0) := temp_out (14 downto 1);
tmp_result (13 downto 0) <= temp_out (13 downto 0);
if (count = "110") then
mply_state <= accumulate;
done <= '1';
done_var := '1';
temp_out (14 downto 0) :=
"000000000000000";
count <= "000";
else
mply_state <= add_sub;
count <= count + 1;
end if;
when accumulate =>
temp_result := temp_result + tmp_result;
mac_result <= temp_result;
mply_state <= init;
end case;
end if;
else
mply_state <= init;
tmp_result <= "00000000000000";
temp_out (14 downto 0) := "000000000000000";
done_var := '0';
done <= '0';
count <= "000";
end if;
end if;
end process;
end fsm;

