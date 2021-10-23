library ieee;
use ieee.std_logic_1164.all;

entity and_gate_tb is
end and_gate_tb;

architecture tb of and_gate_tb is
	signal a, b, c: bit;
begin
	UUT: entity work.and_gate port map (a,b,c);

	a <= '0', '1' after 20 ns, '0' after 40 ns, '1' after 60 ns, '0' after 80 ns;
	b <= '0', '1' after 40 ns, '0' after 80 ns;
end tb;
