LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY jk_countern_sync IS
  generic(bit_size : integer := 8);
  port(  En, Clk, Clear_not : IN std_logic; 
     Q, Q_not : OUT std_logic_vector(bit_size-1 DOWNTO 0);
	  V : OUT std_logic);
END jk_countern_sync;

ARCHITECTURE struct OF jk_countern_sync IS
  SIGNAL vcc : std_logic := '1';
  SIGNAL gnd : std_logic := '0';
  SIGNAL int_and, int_Q, int_JK : std_logic_vector(bit_size-1 DOWNTO 0);
BEGIN
  int_and(0) <= vcc;
  m0 : ENTITY work.mux_1to2(struct)
	 port map (En, gnd, int_and(0), int_JK(0)); 
  c0 : ENTITY work.jk_flipflop(struct)
	 port map (vcc, int_JK(0), int_JK(0), Clk, Clear_not, int_Q(0), Q_not(0));
  Q(0) <= int_Q(0);
  
  c : FOR i IN 1 TO bit_size-1 GENERATE
    int_and(i) <= int_and(i-1) and int_Q(i-1);
	 mi : ENTITY work.mux_1to2(struct)
	   port map (En, gnd, int_and(i), int_JK(i)); 
	 ci : ENTITY work.jk_flipflop(struct)
	   port map (vcc, int_JK(i), int_JK(i), Clk, Clear_not, int_Q(i), Q_not(i));
    Q(i) <= int_Q(i);
  END GENERATE c;
  V <= int_Q(bit_size-1) and int_and(bit_size-1);
END struct;