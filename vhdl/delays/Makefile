all:
	ghdl -a delay.vhdl
	ghdl -a delay_tb.vhdl
	ghdl -r delay_tb --stop-time=20ns --wave=delay.ghw
