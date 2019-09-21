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

ENTITY Mux32 IS
  PORT ( In_0, In_1, In_2, In_3,In_4,In_5,In_6,In_7,In_8,In_9,In_10,In_11,In_12,In_13,In_14,In_15,In_16,In_17,In_18,In_19,In_20,In_21,In_22,In_23,In_24,In_25,In_26,In_27,In_28,In_29,In_30,In_31 : IN std_ulogic_vector(31 DOWNTO 0);
         Q : OUT std_ulogic_vector(31 DOWNTO 0);
         Sel : IN std_ulogic_vector(31 DOWNTO 0));
END ENTITY Mux32;


ARCHITECTURE Behavior OF Mux32 IS

BEGIN 

  PROCESS(In_0, In_1, In_2, In_3,In_4,In_5,In_6,In_7,In_8,In_9,In_10,In_11,In_12,In_13,In_14,In_15,In_16,In_17,In_18,In_19,In_20,In_21,In_22,In_23,In_24,In_25,In_26,In_27,In_28,In_29,In_30,In_31,Sel)
  VARIABLE Qv : std_ulogic_vector(31 DOWNTO 0);
  BEGIN
    Qv := (others => '0');
    IF Sel(0) = '1' THEN
      Qv :=IN_0;
    END IF;
    IF Sel(1) = '1' THEN
      Qv :=IN_1;
    END IF;
    IF Sel(2) = '1' THEN
      Qv :=IN_2;
    END IF;
    IF Sel(3) = '1' THEN
      Qv :=IN_3;
    END IF;
    IF Sel(4) = '1' THEN
      Qv :=IN_4;
    END IF;
    IF Sel(5) = '1' THEN
      Qv :=IN_5;
    END IF;
    IF Sel(6) = '1' THEN
      Qv :=IN_6;
    END IF;
    IF Sel(7) = '1' THEN
      Qv :=IN_7;
    END IF;
    IF Sel(8) = '1' THEN
      Qv :=IN_8;
    END IF;
    IF Sel(9) = '1' THEN
      Qv :=IN_9;
    END IF;
    IF Sel(10) = '1' THEN
      Qv :=IN_10;
    END IF;
    IF Sel(11) = '1' THEN
      Qv :=IN_11;
    END IF;
    IF Sel(12) = '1' THEN
      Qv :=IN_12;
    END IF;
    IF Sel(13) = '1' THEN
      Qv :=IN_13;
    END IF;
    IF Sel(14) = '1' THEN
      Qv :=IN_14;
    END IF;
    IF Sel(15) = '1' THEN
      Qv :=IN_15;
    END IF;
    IF Sel(16) = '1' THEN
      Qv :=IN_16;
    END IF;
    IF Sel(17) = '1' THEN
      Qv :=IN_17;
    END IF;
    IF Sel(18) = '1' THEN
      Qv :=IN_18;
    END IF;
    IF Sel(19) = '1' THEN
      Qv :=IN_19;
    END IF;
    IF Sel(20) = '1' THEN
      Qv :=IN_20;
    END IF;
    IF Sel(21) = '1' THEN
      Qv :=IN_21;
    END IF;
    IF Sel(22) = '1' THEN
      Qv :=IN_22;
    END IF;
    IF Sel(23) = '1' THEN
      Qv :=IN_23;
    END IF;
    IF Sel(24) = '1' THEN
      Qv :=IN_24;
    END IF;
    IF Sel(25) = '1' THEN
      Qv :=IN_25;
    END IF;
    IF Sel(26) = '1' THEN
      Qv :=IN_26;
    END IF;
    IF Sel(27) = '1' THEN
      Qv :=IN_27;
    END IF;
    IF Sel(28) = '1' THEN
      Qv :=IN_28;
    END IF;
    IF Sel(29) = '1' THEN
      Qv :=IN_29;
    END IF;
    IF Sel(30) = '1' THEN
      Qv :=IN_30;
    END IF;
    IF Sel(31) = '1' THEN
      Qv :=IN_31;
    END IF;
    Q <= Qv;
  END PROCESS; 
END ARCHITECTURE Behavior;
