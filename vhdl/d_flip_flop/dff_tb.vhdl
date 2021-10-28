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

	testing: process 
	begin
		D <= '0';
		wait for 2 ns;
		D <= '1';
		wait for 5 ns;
		D <= '0';
		wait for 8 ns;
		D <= '1';
		wait for 4 ns;
		D <= '0';
		wait for 2 ns;
	end process testing;
end test_arc;