LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY mux_1to2n IS
  generic (bit_size : integer := 8);
  port (sel0 : IN std_logic;
    in0, in1 : IN std_logic_vector(7 DOWNTO 0);
    y : OUT std_logic_vector(7 DOWNTO 0));
END mux_1to2n;

ARCHITECTURE struct OF mux_1to2n IS
BEGIN
  m : FOR i IN 7 DOWNTO 0 GENERATE
    mi : ENTITY work.mux_1to2(struct)
	   port map (sel0, in0(i), in1(i), y(i));
  END GENERATE m;
END struct;