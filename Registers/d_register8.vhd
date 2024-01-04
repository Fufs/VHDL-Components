LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY d_register8 IS
  port( Preset_not : IN STD_LOGIC; 
    D : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    ld, shl, shr, Clk, Clear_not : IN STD_LOGIC;
    Q, Q_not : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END d_register8;

ARCHITECTURE struct OF d_register8 IS
  SIGNAL int_Q : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL gnd : STD_LOGIC := '0';
BEGIN
  r7 : ENTITY work.d_register1(struct)
    port map(Preset_not, D(7), int_Q(6), gnd, ld, shl, shr, Clk, Clear_not, int_Q(7), Q_not(7));
  r_loop : FOR i IN 6 DOWNTO 1 GENERATE
    ri : ENTITY work.d_register1(struct)
	   port map(Preset_not, D(i), int_Q(i-1), int_Q(i+1), ld, shl, shr, Clk, Clear_not, int_Q(i), Q_not(i));
  END GENERATE r_loop;
  r0 : ENTITY work.d_register1(struct)
    port map(Preset_not, D(0), gnd, int_Q(1), ld, shl, shr, Clk, Clear_not, int_Q(0), Q_not(0));
  Q <= int_Q;
END struct;
