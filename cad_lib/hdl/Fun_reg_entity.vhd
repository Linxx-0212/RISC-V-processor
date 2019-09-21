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
USE work.RV32I.all;

ENTITY Fun_reg IS
  PORT( D : IN RV32I_op;
        Q : OUT RV32I_op;
        Clock, Enable, reset : IN std_ulogic);
END ENTITY Fun_reg;

ARCHITECTURE Behavior OF Fun_reg is
BEGIN
  PROCESS(Clock)
  BEGIN
    IF (rising_edge(Clock) AND Enable = '1') THEN
      Q <= D;
    END IF;
    IF (rising_edge(Clock) AND reset = '1') THEN
      Q <= NOP;
    END IF;
  END PROCESS;
END ARCHITECTURE Behavior;
