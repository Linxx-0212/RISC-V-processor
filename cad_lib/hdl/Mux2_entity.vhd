--
-- VHDL Entity cad_lib.Mux2.arch_name
--
-- Created:
--          by - 34679.UNKNOWN (DESKTOP-13EGCCO)
--          at - 15:17:03 2019/01/23
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.numeric_std.all;

ENTITY Mux2 IS
  GENERIC(width : NATURAL RANGE 1 to 64:=8);
  PORT ( In_0, In_1 : IN std_ulogic_vector(width - 1 DOWNTO 0);
         Q : OUT std_ulogic_vector(width - 1 DOWNTO 0);
         Sel : IN std_ulogic);
END ENTITY Mux2;


ARCHITECTURE Behavior OF Mux2 IS
BEGIN 
  PROCESS(In_0, In_1, Sel)
  BEGIN
    IF (Sel = '0') THEN       
      Q <= In_0;
    ELSIF (Sel = '1') THEN
      Q <= In_1;
    ELSE 
      Q <= (others=>'X');
    END IF;
  END PROCESS; 
END ARCHITECTURE Behavior;