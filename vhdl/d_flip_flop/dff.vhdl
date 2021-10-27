entity dff is
	port (
		D, CLK : in bit;
		Q : out bit;
		QN: out bit := '1'
	);
end dff;

architecture dff_beh of dff is
begin 
	upd : process(CLK) 
	begin
		if (CLK='1') then
			Q <= D after 0.1 ns;
			QN <= not D after 0.1 ns;
		end if;
	end process upd;
end dff_beh;