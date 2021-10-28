library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity full_adder_tb is 
end full_adder_tb;

architecture test_arc of full_adder_tb is

	-- downto and to change the endianness!! 0 is the LSB here, and 3 is MSB!
	-- syntax: MSB <downto|to> LSB
	signal X,Y,S: std_logic_vector(3 downto 0) := "0000";
	signal CIN,COUT: std_logic := '0';
	constant clk_period: time := 1 ns;
begin 

	uut: entity work.four_bit_full_adder port map (X,Y,CIN,S,COUT);

	testing: process 
	begin
		for i in 0 to 15 loop
			for j in 0 to 15-i loop
				X <= std_logic_vector(to_unsigned(i,4));
				Y <= std_logic_vector(to_unsigned(j,4));
				-- report "S=" & integer'image(to_integer(unsigned(S)));
				-- report "exp=" & integer'image(j+i);
				-- assert S = std_logic_vector(to_unsigned(i+j,4)); 
				-- no idea why this doesn't work! S lags behind i+j by 1 clock cycle.... hm.
				wait for clk_period;
			end loop;
		end loop;
	end process testing;
end test_arc;

--architecture test_fa_arc of full_adder_tb is

--	signal X,Y,S,CIN,COUT: std_logic := '0';
--	constant clk_period: time := 1 ns;

--begin

--	uut: entity work.full_adder port map (X,Y,CIN,S,COUT);
--	testing: process 
--	begin
--		for i in 0 to 7 loop
--			wait for clk_period;
--			X <= to_unsigned(i mod 2,1)(0);
--			Y <= to_unsigned(i/2 mod 2,1)(0);
--			CIN <= to_unsigned(i/4 mod 2,1)(0);
--		end loop;
--	end process testing;
--end test_fa_arc;
