LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE ieee.numeric_std_unsigned.ALL;

ENTITY testbench IS
	-- empty
END testbench;

ARCHITECTURE tb OF testbench IS

	-- DUT component
	COMPONENT addsub IS
		PORT 
		(
			A, B      : IN std_logic_vector(0 TO 7);
			operation : IN std_logic;
			S         : OUT std_logic_vector(0 TO 7)
		);
	END COMPONENT;

	SIGNAL op_in             : std_logic;
	SIGNAL a_in, b_in, s_out : std_logic_vector(0 TO 7);

BEGIN
	-- Connect DUT
	DUT : addsub
	PORT MAP(a_in, b_in, op_in, s_out);

	PROCESS
	BEGIN
		-- adds
		a_in  <= "00000001";
		b_in  <= "00000001";
		op_in <= '0';
		WAIT FOR 1 ns;
 
		ASSERT(s_out = "00000010") REPORT "Fail 1+1=2" SEVERITY failure;
		a_in  <= "00010001";
		b_in  <= "00010001";
		op_in <= '0';
		WAIT FOR 1 ns;
		ASSERT(s_out = "0100010") REPORT "Fail 17+17=2" SEVERITY failure;
 
		a_in  <= "00110000";
		b_in  <= "10110001";
		op_in <= '0';
		WAIT FOR 1 ns;
		ASSERT(s_out = "011100001") REPORT "Fail 48+177=225" SEVERITY failure;
 
		-- subs
		a_in  <= "10110001";
		b_in  <= "00110000";
		op_in <= '1';
		WAIT FOR 1 ns;
		ASSERT(s_out = "10000001") REPORT "Fail 177-48=129" SEVERITY failure;
 
		a_in  <= "11110011";
		b_in  <= "00000001";
		op_in <= '1';
		WAIT FOR 1 ns;
		ASSERT(s_out = "11110010") REPORT "Fail 243-1=242" SEVERITY failure;
 
		a_in  <= "00000001";
		b_in  <= "00000001";
		op_in <= '1';
		WAIT FOR 1 ns;
		ASSERT(s_out = "000000000") REPORT "Fail 1-1=0" SEVERITY failure;
 
		WAIT;
	END PROCESS;
END tb;