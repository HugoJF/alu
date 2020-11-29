------------
-- ADDSUB --
------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY addsub IS
	GENERIC 
	(
		N : NATURAL := 8
	);
	PORT 
	(
		A, B      : IN std_logic_vector(N - 1 DOWNTO 0);
		operation : IN std_logic;
		S         : OUT std_logic_vector(N - 1 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE behavioral OF addsub IS
BEGIN
	PROCESS (A, B, operation)
	BEGIN
		IF operation = '0' THEN
			S <= std_logic_vector(unsigned(A) + unsigned(B));
		ELSE
			S <= std_logic_vector(unsigned(A) - unsigned(B));
		END IF;
	END PROCESS;

END ARCHITECTURE;

------------
-- MUX2x1 --
------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY mux IS
	GENERIC 
	(
		N : NATURAL := 8
	);
	PORT 
	(
		input0, input1 : IN std_logic_vector(N - 1 DOWNTO 0);
		sel            : IN std_logic;
		output         : OUT std_logic_vector(N - 1 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE behavioral OF mux IS
BEGIN
	PROCESS (input0, input1, sel)
	BEGIN
		IF sel = '0' THEN
			output <= input0;
		ELSE
			output <= input1;
		END IF;
	END PROCESS;

END ARCHITECTURE;

-----------
-- ANDOR --
-----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY andor IS
	GENERIC 
	(
		N : NATURAL := 8
	);
	PORT 
	(
		A, B      : IN std_logic_vector(0 TO N - 1);
		operation : IN std_logic;
		S         : OUT std_logic_vector(0 TO N - 1)
	);
END ENTITY;

ARCHITECTURE behavioral OF andor IS
BEGIN
	PROCESS (A, B, operation)
	BEGIN
		IF operation = '0' THEN
			S <= A AND B;
		ELSE
			S <= A OR B;
		END IF;
	END PROCESS;

END ARCHITECTURE;

---------
-- ALU --
---------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY alu IS
	GENERIC 
	(
		N : NATURAL := 8
	);
	PORT 
	(
		A, B : IN std_logic_vector(N - 1 DOWNTO 0);
		C    : IN std_logic_vector(2 DOWNTO 0);
		S    : OUT std_logic_vector(N - 1 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE structural OF alu IS
	SIGNAL s0, s1 : std_logic_vector(0 TO N - 1);
BEGIN
	O : ENTITY work.mux(behavioral)
		PORT MAP(input0 => s0, input1 => s1, sel => C(0), output => S);

	andor : ENTITY work.andor(behavioral)
		PORT MAP(A => A, B => B, operation => C(1), S => s0);

	addsub : ENTITY work.addsub(behavioral)
		PORT MAP(A => A, B => B, operation => C(2), S => s1);

END ARCHITECTURE;