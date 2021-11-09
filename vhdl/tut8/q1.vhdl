entity comparator is
	port (
		x: in bit_vector(15 downto 0) := x"0000";
		y: in bit_vector(15 downto 0) := x"0000";
		gt: out bit := '0';
		eq: out bit := '0'
	);
end comparator;

architecture comparator_bvr of comparator is
begin
	compare: process (x,y)
		variable equal: boolean; 
	begin
		equal := true;
		-- report "x and y changed. Comparing";
		for i in 15 downto 0 loop
			if x(i) > y(i) then
				gt <= '1';
				eq <= '0';
				equal := false;
				exit;
			elsif x(i) < y(i) then
				equal := false;
				gt <= '0';
				eq <= '0';
				equal := false;
				exit;
			end if;
		end loop;

		if equal then
			eq <= '1';
		end if;
	end process compare;

end comparator_bvr;

-- pipo = parallel in parallel out
entity pipo_register is
	-- rst | load | clk | din | dout
	--  0  |   0  | up  |  X  |  Q 
	--  0  |   1  | up  |  X  |  X
	--  1  |   X  | X   |  X  |  0
	-- (up - rising edge, Q - previous data)
	port (
		din: in bit_vector(15 downto 0);
		dout: out bit_vector(15 downto 0);
		clk: in bit;
		load: in bit;
		rst: in bit
	);
end pipo_register;

architecture pipo_register_bvr of pipo_register is
begin
	data_load: process(clk)
	begin
		if (clk = '1' and rst = '1') then
			dout <= x"0000";
		elsif (clk = '1' and load = '1') then
			dout <= din;
		end if;
	end process data_load;

end pipo_register_bvr;

entity compute_max_data is
	port (
		din: in bit_vector(15 downto 0) := x"0000";
		dout: out bit_vector(15 downto 0) := x"0000";
		gt, eq: out bit := '0';
		clk, final_load, load, rst: in bit := '0'
	);
end compute_max_data;

architecture compute_max_data_struct of compute_max_data is
	signal cmp_y : bit_vector (15 downto 0);
	signal temp: bit := '0';
begin
	cmp: entity work.comparator port map (din, cmp_y, gt, eq); 
	reg_1: entity work.pipo_register port map (din, cmp_y, clk, load, rst);
	reg_2: entity work.pipo_register port map (cmp_y, dout, clk, final_load, temp);

end compute_max_data_struct;

entity compute_max_sm is
	port (
		gt, eq, st_blk: in bit := '0';
		load, rst, final_load: out bit := '0'
	);
end compute_max_sm;

architecture compute_max_sm_bvr of compute_max_sm is
begin
	sm: process(st_blk, gt, eq)
	begin
		if (st_blk = '1') then
			rst <= '1';
			final_load <= '1';
		else
			rst <= '0';
			final_load <= '0';
			if (gt = '1' and eq = '0') then
				load <= '1';
			elsif (gt = '0') then
				load <= '0';
			end if;
		end if;
	end process sm;
end compute_max_sm_bvr;

entity compute_max is
	port (
		din: in bit_vector(15 downto 0) := x"0000";
		dout: out bit_vector(15 downto 0) := x"0000";
		clk, st_blk: in bit := '0'
	);
end compute_max;

architecture compute_max_struct of compute_max is
	signal gt, eq, load, clkinv, final_load, rst: bit;
begin
	clkinv <= not clk;
	data: entity work.compute_max_data port map (din, dout, gt, eq, clkinv, final_load, load, rst);
	sm: entity work.compute_max_sm port map (gt, eq, st_blk, load, rst, final_load);
end compute_max_struct;

