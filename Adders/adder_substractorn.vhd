LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY adder_substractorn IS
  generic( bit_size : integer := 8);
  port( X, Y : IN std_logic_vector(bit_size-1 DOWNTO 0);
    Mode : IN std_logic;
    Result : OUT std_logic_vector(bit_size-1 DOWNTO 0);
	 Cout, V : OUT std_logic);
END adder_substractorn;

ARCHITECTURE rca OF adder_substractorn IS
  SIGNAL y_xor, C : std_logic_vector(bit_size-1 DOWNTO 0);
BEGIN
  y_xor(0) <= Y(0) xor Mode;
  fa0 : ENTITY work.full_adder(struct)
    port map (X(0), y_xor(0), Mode, Result(0), C(0));
  fa : FOR i IN 1 TO bit_size-1 GENERATE
    y_xor(i) <= Y(i) xor Mode;
	 fai : ENTITY work.full_adder(struct)
	   port map (X(i), y_xor(i), C(i-1), Result(i), C(i));
  END GENERATE fa;
  Cout <= C(bit_size-1);
  V <= C(bit_size-1) xor C(bit_size-2);
END rca;