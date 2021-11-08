entity delay_tb is
end delay_tb;

architecture delay_tb_bhv of delay_tb is
	
	signal a: bit;
	signal t1, t2, t3, t4, t5: bit := '0';
	signal i1, i2, i3, i4, i5: bit := '0';
	signal r12, r23, r34, r45: bit := '0';

	signal b: integer := 1;
	signal c: integer := 2;
	signal d: integer := 3;

	signal t, i, r: integer := 0;

begin
	
	-- uut : entity work.delay port map (a, b, c, d, e, o);

	-- b <= '1';
	-- c <= '1';
	a <= 
	'0' after 0 ns, 
	'1' after 1 ns, 
	'0' after 2 ns, 
	'1' after 3 ns, 
	'0' after 5 ns, 
	'1' after 6 ns, 
	'0' after 9 ns,
	'1' after 10 ns, 
	'0' after 14 ns, 
	'1' after 15 ns, 
	'0' after 20 ns,
	'1' after 30 ns, 
	'0' after 31 ns, 
	'1' after 32 ns, 
	'0' after 33 ns, 
	'1' after 35 ns, 
	'0' after 36 ns, 
	'1' after 39 ns,
	'0' after 40 ns, 
	'1' after 44 ns, 
	'0' after 45 ns, 
	'1' after 50 ns,
	'0' after 60 ns,
	'1' after 70 ns, 
	'0' after 71 ns,
	'1' after 80 ns, 
	'0' after 82 ns,
	'1' after 90 ns, 
	'0' after 93 ns,
	'1' after 100 ns, 
	'0' after 104 ns,
	'1' after 110 ns, 
	'0' after 115 ns;

	t1 <= transport a after 1 ns;
	t2 <= transport a after 2 ns;
	t3 <= transport a after 3 ns;
	t4 <= transport a after 4 ns;
	t5 <= transport a after 5 ns;

	i1 <= a after 1 ns;
	i2 <= a after 2 ns;
	i3 <= a after 3 ns;
	i4 <= a after 4 ns;
	i5 <= a after 5 ns;

	r12 <= reject 1 ns inertial a after 2 ns;
	r23 <= reject 2 ns inertial a after 3 ns;
	r34 <= reject 3 ns inertial a after 4 ns;
	r45 <= reject 4 ns inertial a after 5 ns;

	c <= 11 after 15 ns;
	t <= transport b after 0 ns, c after 4 ns, d after 8 ns, c after 11 ns;
	i <= b, c after 4 ns, d after 8 ns, c after 11 ns;

end delay_tb_bhv;
