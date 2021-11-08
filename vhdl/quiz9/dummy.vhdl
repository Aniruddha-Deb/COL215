library ieee;
use ieee.std_logic_1164.all;

entity dummy is 
	port (
		clk: in std_logic;
		sum: out integer := 0
	);
end dummy;

architecture sig of dummy is
signal sig1: integer := 1;
signal sig2: integer := 2;
signal sig3: integer := 0; 
-- clk and sum are defined in the entity declaration as input bit and output integer, respectively.
begin 
  process (clk)
  begin
    if (rising_edge(clk)) then              
      sig1 <= sig2;
      sig2 <= sig3;
      sig3 <= sig1 + sig2;
      sum <= sig3;
    end if;
  end process;
end sig;
