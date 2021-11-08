-- Provide a VHDL behavioral model of the D flip-flop shown on the right. The S 
-- and R inputs are an active low asynchronous preset and clear. Assume both 
-- the S and R inputs will never be asserted simultaneously.

library ieee;
use ieee.std_logic_1164.all;

entity dff_ex1 is 
	port (
		CLK, D, S, R: in std_logic;
		Q, QN: out std_logic
	);
end dff_ex1;

architecture dff_ex1_bhv of dff_ex1 is 
begin
	process(CLK, S, R)
	begin
		if (S = '0') then
			Q <= '1';
			QN <= '0';
		elsif (R = '0') then
			Q <= '0';
			QN <= '1';
		elsif rising_edge(CLK) then
			Q <= D;
			QN <= not D;
		end if;
	end process;
end dff_ex1_bhv;
	
