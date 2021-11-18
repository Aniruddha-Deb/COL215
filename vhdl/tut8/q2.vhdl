library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram is
	port (
		addr: in bit_vector(5 downto 0);
		rw: in bit;
		data_in: in bit_vector(15 downto 0);
		data_out: out bit_vector(15 downto 0)
	);
end ram;

architecture ram_bvr of ram is
	
	type table is array(63 downto 0) of bit_vector(15 downto 0);
	signal reg: table;

begin

	read: process(addr, rw)
	begin
		if (rw = '0') then
			data_out <= reg(to_integer(unsigned(to_stdlogicvector(addr))));
		end if;
	end process read;

	write: process(addr, rw)
	begin
		if (rw = '1') then
			reg(to_integer(unsigned(to_stdlogicvector(addr)))) <= data_in;
		end if;
	end process write;

end ram_bvr;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bubble_sort is
	port (
		data_in: in bit_vector(15 downto 0);
		data_out: out bit_vector(15 downto 0);
		sort_sig: in bit := '0';
		load_clk: in bit;
		sorted: out bit := '0'
	);
end bubble_sort;

architecture bubble_sort_bvr of bubble_sort is
	
	type table is array(63 downto 0) of bit_vector(15 downto 0);
	signal reg: table;
	signal gt, eq: bit;
	signal rw: bit;
	signal addr: bit_vector(5 downto 0);
	signal temp, vj, vjp1: bit_vector(15 downto 0);
	signal din, dout: bit_vector(15 downto 0);

begin
	
	mem: entity work.ram port map (addr, rw, din, dout); 
	cmp: entity work.comparator port map (vj, vjp1, gt, eq);

	sort: process
	begin
		wait until sort_sig = '1';
			for i in 0 to 63 loop
				for j in 0 to 62-i loop
					addr <= to_bitvector(std_logic_vector(to_unsigned(j,6)));
					rw <= '0';
					vj <= dout;
					temp <= dout;
					wait for 1 ns;
	
					addr <= to_bitvector(std_logic_vector(to_unsigned(j+1,6)));
					rw <= '0';
					vjp1 <= dout;
					wait for 1 ns;
	
					if gt = '1' then
						-- swap numbers 
						addr <= to_bitvector(std_logic_vector(to_unsigned(j,6)));
						din <= vjp1;
						rw <= '1';
						wait for 1 ns;
	
						addr <= to_bitvector(std_logic_vector(to_unsigned(j+1,6)));
						din <= temp;
						rw <= '1';
						wait for 1 ns;
					end if;
				end loop;
			end loop;
		sorted <= '1';
	end process sort;

	load: process
		variable pos: integer := 0;
	begin
		wait until load_clk = '1';
		if pos < 64 then
			din <= data_in;
			wait for 0 ns;
			addr <= to_bitvector(std_logic_vector(to_unsigned(pos,6)));
			pos := pos + 1;
			rw <= '1';
		end if;
	end process load;
			
end bubble_sort_bvr;
					

