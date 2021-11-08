library ieee;
use ieee.std_logic_1164.all;

entity dff_tb is 
end dff_tb;

architecture test_arc of dff_tb is

	signal CLK: std_logic := '0';
	constant clk_period: time := 10 ns;

begin 

	uut: entity work.dummy port map (CLK);

	CLK <= not CLK after clk_period/2;
end test_arc;
