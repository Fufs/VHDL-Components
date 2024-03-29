LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY cla4 IS
  port( A, B : IN std_logic_vector(3 DOWNTO 0);
    Cin : IN std_logic;  
    S : OUT std_logic_vector(3 DOWNTO 0);
	 Cout, V, PG, GG : OUT std_logic);
END cla4;
 
ARCHITECTURE rippled OF cla4 IS
  SIGNAL C : std_logic_vector(4 DOWNTO 0);
  SIGNAL G, P : std_logic_vector(3 DOWNTO 0);
BEGIN
  C(0) <= Cin;
  fa : FOR i IN 1 TO 3 GENERATE
	 fai : ENTITY work.full_adder(struct)
	   port map (A(i),B(i),C(i),S(i),open);
	 G(i) <= A(i) and B(i);
    P(i) <= A(i) or B(i);
	 C(i+1) <= G(i) or (P(i) and C(i));
  END GENERATE fa;
  
  Cout <= C(4);
  V <= C(4) xor C(3);
  PG <= P(0) and P(1) and P(2) and P(3);
  GG <= G(3) or (G(2) and P(3)) or (G(1) and P(3) and P(2)) or (G(0) and P(3) and P(2) and P(1));
END rippled;

ARCHITECTURE struct OF cla4 IS
  SIGNAL C : std_logic_vector(4 DOWNTO 0);
  SIGNAL G, P : std_logic_vector(3 DOWNTO 0);
BEGIN
  C(0) <= Cin;
  fa : FOR i IN 0 TO 3 GENERATE
	 fai : ENTITY work.full_adder(struct)
	   port map (A(i), B(i), C(i), S(i), open);
	 G(i) <= A(i) and B(i);
    P(i) <= A(i) or B(i);
  END GENERATE fa;
  
  C(1) <= G(0) or (P(0) and C(0));
  C(2) <= G(1) or (G(0) and P(1)) or (C(0) and P(0) and P(1));
  C(3) <= G(2) or (G(1) and P(2)) or (G(0) and P(1) and P(2)) or (C(0) and P(0) and P(1) and P(2));
  C(4) <= G(3) or (G(2) and P(3)) or (G(1) and P(2) and P(3)) or (G(0) and P(1) and P(2) and P(3)) or (C(0) and P(0) and P(1) and P(2) and P(3));
  
  Cout <= C(4);
  V <= C(4) xor C(3);
  PG <= P(0) and P(1) and P(2) and P(3);
  GG <= G(3) or (G(2) and P(3)) or (G(1) and P(3) and P(2)) or (G(0) and P(3) and P(2) and P(1));
END struct;