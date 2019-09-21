--
-- VHDL Entity cad_lib.Reg.arch_name
--
-- Created:
--          by - 34679.UNKNOWN (DESKTOP-13EGCCO)
--          at - 20:11:42 2019/01/28
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY Reg IS
  GENERIC(width : NATURAL RANGE 1 TO 64 := 8);
  PORT( D : IN std_ulogic_vector(width - 1 DOWNTO 0);
        Q : OUT std_ulogic_vector(width - 1 DOWNTO 0);
        Clock, Enable, reset : IN std_ulogic);
END ENTITY Reg;

ARCHITECTURE Behavior OF Reg is
BEGIN
  PROCESS(Clock)
  BEGIN
    IF (rising_edge(Clock) AND Enable = '1') THEN
      Q <= D;
    END IF;
    IF (rising_edge(Clock) AND reset = '1') THEN
      Q <= (others => '0');
    END IF;
  END PROCESS;
END ARCHITECTURE Behavior;
