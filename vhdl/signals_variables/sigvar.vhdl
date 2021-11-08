entity sigvar is 
end sigvar;

architecture sigvar_bvr of sigvar is
	
	signal clk: bit := '0';
	constant clk_period: time := 10 ns;
	signal sig1: integer := 1;
	signal sig2: integer := 2;
	signal sig3: integer := 3;
	signal var_sig1: integer := 1;
	signal var_sig2: integer := 2;
	signal var_sig3: integer := 3;

begin

	clk <= not clk after clk_period/2;

	sig_proc: process
	begin
		wait until clk = '1';
		sig1 <= sig2;
		wait for 0 ns;
		sig2 <= sig3;
		wait for 0 ns;
		sig3 <= sig1 + sig2;
		wait for 0 ns;
	end process sig_proc;
		
	var_proc: process(clk)
		variable var1: integer := 1;
		variable var2: integer := 2;
		variable var3: integer := 3;
	begin
		if (clk = '1') then
			var1 := var2;
			var2 := var3;
			var3 := var1 + var2;

			var_sig1 <= var1;
			var_sig2 <= var2;
			var_sig3 <= var3;
		end if;
	end process var_proc;
	
end sigvar_bvr;
