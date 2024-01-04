LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY demux_2to1 IS
  port( sel0, x : IN std_logic; 
     out0, out1 : OUT std_logic);
END demux_2to1;

ARCHITECTURE struct OF demux_2to1 IS
BEGIN
  out0 <= not sel0 and x;
  out1 <= sel0 and x;
END struct;