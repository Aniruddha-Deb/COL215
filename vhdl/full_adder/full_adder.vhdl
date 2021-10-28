library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity full_adder is
	port (
		X,Y  : in std_logic := '0';
		CIN  : in std_logic := '0';
		S    : out std_logic := '0';
		COUT : out std_logic := '0'
	);
end full_adder;

architecture dataflow of full_adder is
begin
	S <= X xor Y xor CIN;
	COUT <= ((X and Y) or (X and CIN) or (Y and CIN));
end dataflow;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity four_bit_full_adder is
	port (
		X,Y  : in std_logic_vector(3 downto 0) := "0000";
		CIN  : in std_logic := '0';
		S    : out std_logic_vector(3 downto 0) := "0000";
		COUT : out std_logic := '0'
	);
	signal C : std_logic_vector(3 downto 0) := "0000";
end four_bit_full_adder;

architecture structure of four_bit_full_adder is
begin
	FA0: entity work.full_adder(dataflow) port map (X(0),Y(0),CIN,S(0),C(1));
	FA1: entity work.full_adder(dataflow) port map (X(1),Y(1),C(1),S(1),C(2));
	FA2: entity work.full_adder(dataflow) port map (X(2),Y(2),C(2),S(2),C(3));
	FA3: entity work.full_adder(dataflow) port map (X(3),Y(3),C(3),S(3),COUT);
end structure;