entity and_gate is 
	port (a,b: in bit;
		    c: out bit);
end and_gate;

architecture arch of and_gate is
begin
	c <= a and b after 1 ns;
end arch;
