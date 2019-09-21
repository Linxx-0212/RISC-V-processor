--
-- VHDL Entity cad_lib.Reg_dec.arch_name
--
-- Created:
--          by - 34679.UNKNOWN (DESKTOP-13EGCCO)
--          at - 09:38:04 2019/04/12
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY Reg_dec IS
  PORT(sel : IN std_ulogic_vector(4 DOWNTO 0);
  OneHot : OUT std_ulogic_vector(31 DOWNTO 0);
  enable : IN std_ulogic);
END ENTITY Reg_dec;

ARCHITECTURE Behavior OF Reg_dec IS
BEGIN
 PROCESS(sel, enable)
 VARIABLE selection : NATURAL RANGE 0 TO 31;
 VARIABLE result : std_logic_vector(31 DOWNTO 0);
 CONSTANT zero : std_logic_vector(31 DOWNTO 0) := (others=>'0');
 BEGIN
 result := zero;
 IF(enable = '1') THEN
 selection := To_Integer(unsigned(sel));
 result(selection) := '1';
 END IF;
 OneHot <= result;
 END PROCESS;
END ARCHITECTURE Behavior;