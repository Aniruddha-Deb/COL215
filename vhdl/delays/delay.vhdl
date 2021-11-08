entity delay is
	port (
		a, b, c, d, e: in bit;
		o: out bit
	);
end delay;

architecture delay_bhv of delay is
	signal ab, abc, de: bit := '0'; 
	signal a_tsp, a_rej,
begin
	ab <= reject 2 ns (a and b) after 1 ns;
	abc <= ab and c after 1 ns;
	de <= d and e after 1 ns;
	o <= abc or de after 1 ns;
end delay_bhv;
	
