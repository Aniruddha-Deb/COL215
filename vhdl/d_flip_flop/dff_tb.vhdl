entity dff_tb is 
end dff_tb;

architecture test_arc of dff_tb is

	signal D, Q, QN: bit;
	signal CLK: bit := '0';
	signal finished: bit := '0';
	constant clk_period: time := 10 ns;

begin 

	uut: entity work.dff port map (D => D, Q => Q, QN => QN, CLK => CLK);

	CLK <= not CLK after clk_period/2 when finished /= '1' else '0';

	D <= '0', '1' after 4 ns, '0' after 14 ns, '1' after 20 ns, '0' after 24 ns;
	finished <= '1' after 30 ns;		

	assert finished = '0';
end test_arc;