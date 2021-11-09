library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity comparator_tb is 
end comparator_tb;

architecture comparator_tb_bvr of comparator_tb is
	
	signal x, y: bit_vector(15 downto 0) := to_bitvector(std_logic_vector(to_unsigned(0,16)));
	signal gt, eq: bit := '0';

	signal clk: bit := '0';

begin
	
	uut: entity work.comparator port map (x, y, gt, eq);

	test: process
	begin
		for i in 0 to 15 loop
			x <= to_bitvector(std_logic_vector(to_unsigned(i,16)));
			for j in 0 to 15 loop
				y <= to_bitvector(std_logic_vector(to_unsigned(j,16)));
				wait for 5 ns;
			end loop;
		end loop;
	end process test;

end comparator_tb_bvr;

entity pipo_register_tb is
end pipo_register_tb;

architecture pipo_register_tb_bvr of pipo_register_tb is
	
	signal din, dout: bit_vector(15 downto 0) := x"0000";
	signal clk, load, rst: bit := '0';

	constant clk_freq : time := 10 ns;

begin
	
	uut: entity work.pipo_register port map (din, dout, clk, load, rst);

	clk <= not clk after clk_freq/2;

	din <= x"5FD6", x"C543" after 12 ns, x"9583" after 21 ns, x"3320" after 30 ns;
	load <= '1', '0' after 10 ns, '1' after 14 ns, '0' after 24 ns;

end pipo_register_tb_bvr;

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity compute_max_tb is
end compute_max_tb;

architecture compute_max_tb_bvr of compute_max_tb is
	
	signal din, dout: bit_vector(15 downto 0) := x"0000";
	signal clk, st_blk: bit := '0';

	constant clk_freq : time := 1 ns;

begin
	
	uut: entity work.compute_max port map (din, dout, clk, st_blk);

	clk <= not clk after clk_freq/2;

	test: process(clk)
		variable i : integer := 0;
	begin
		if (i < 600 and clk = '1') then
			din <= to_bitvector(std_logic_vector(to_unsigned(i,16)));
			i := i+1;
			if (i mod 256 = 0) then
				st_blk <= '1';
			else
				st_blk <= '0';
			end if;
		end if;
	end process test;
end compute_max_tb_bvr;
