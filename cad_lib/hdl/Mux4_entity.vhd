--
-- VHDL Entity cad_lib.Mux4.arch_name
--
-- Created:
--          by - 34679.UNKNOWN (DESKTOP-13EGCCO)
--          at - 19:37:36 2019/01/28
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.numeric_std.all;

ENTITY Mux4 IS
  GENERIC(width : NATURAL RANGE 1 to 64:=8);
  PORT ( In_0, In_1, In_2, In_3 : IN std_ulogic_vector(width - 1 DOWNTO 0);
         Q : OUT std_ulogic_vector(width - 1 DOWNTO 0);
         Sel1, Sel2 : IN std_ulogic);
END ENTITY Mux4;


ARCHITECTURE Behavior OF Mux4 IS
BEGIN 
  PROCESS(In_0, In_1, Sel1, Sel2,In_2,In_3)
  BEGIN
    IF (Sel1 = '0' and Sel2 = '0') THEN       
      Q <= In_0;
    ELSIF (Sel1 = '0' and Sel2 = '1') THEN
      Q <= In_1;
    ELSIF (Sel1 = '1' and Sel2 = '0') THEN
      Q <= In_2;
    ELSIF (Sel1 = '1' and Sel2 = '1') THEN
      Q <= In_3;
    ELSE 
      Q <= (others => 'X');
    END IF;
  END PROCESS; 
END ARCHITECTURE Behavior;

