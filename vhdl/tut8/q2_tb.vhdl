library ieee;
use ieee.std_logic_1164.all;

entity ram_tb is
end ram_tb;

architecture ram_tb_bvr of ram_tb is
	
	signal addr: bit_vector(5 downto 0);
	signal data_in, data_out: bit_vector(15 downto 0);
	signal rw: bit;

begin
	
	uut: entity work.ram port map(addr, rw, data_in, data_out);

	test: process
	begin
		addr <= "000000";
		data_in <= x"BABA";
		rw <= '1';

		wait for 5 ns;

		addr <= "000101";
		data_in <= x"DEBA";
		rw <= '1';

		wait for 5 ns;
		
		addr <= "000000";
		rw <= '0';

		wait for 5 ns;

		addr <= "000101";
		rw <= '0';

		wait for 5 ns;
	end process test;
end ram_tb_bvr;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library std;
use std.env.all;

entity bubble_sort_tb is
end bubble_sort_tb;

architecture bubble_sort_tb_bvr of bubble_sort_tb is

	signal data_in, data_out: bit_vector(15 downto 0);
	signal sort_sig, load_clk, sorted: bit := '0';

	constant load_clk_period: time := 1 ns;
	signal to_load: boolean := true;

begin

	uut: entity work.bubble_sort port map (data_in, data_out, sort_sig, load_clk, sorted);

	load: process
	begin
		wait until to_load;
		for i in 62 downto 1 loop
			data_in <= to_bitvector(std_logic_vector(to_unsigned(i,16)));
			load_clk <= '1';
			wait for load_clk_period/2;
			load_clk <= '0';
			wait for load_clk_period/2;
		end loop;
		to_load <= false;
	end process load;

	sort: process
	begin
		wait until not to_load;
		sort_sig <= '1';
		wait until sorted = '1';
		stop;
	end process sort;
end bubble_sort_tb_bvr;
			
