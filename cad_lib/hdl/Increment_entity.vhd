--
-- VHDL Entity cad_lib.Increment.arch_name
--
-- Created:
--          by - 34679.UNKNOWN (DESKTOP-13EGCCO)
--          at - 19:39:57 2019/01/28
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY Increment IS
  GENERIC(width : Natural Range 2 TO 64 := 8);
  PORT( D : IN std_ulogic_vector(width - 1 DOWNTO 0);
        Q : OUT std_ulogic_vector(width - 1 DOWNTO 0);
        Inc : IN std_ulogic_vector(1 DOWNTO 0));
END ENTITY Increment;

ARCHITECTURE Behavior OF Increment IS
BEGIN
  PROCESS(D,Inc)
    VARIABLE SUM : UNSIGNED(width - 1 DOWNTO 0);
  BEGIN
    IF (Inc = "00") THEN
      SUM := UNSIGNED(D);
    ELSIF (Inc = "01") THEN
      SUM := UNSIGNED(D) + 1;
    ELSIF (Inc = "10") THEN
      SUM := UNSIGNED(D) + 2;
    ELSIF (Inc = "11") THEN
      SUM := UNSIGNED(D) + 4;
    END IF;
    Q <= std_ulogic_vector(SUM);
  END PROCESS;
END ARCHITECTURE Behavior;