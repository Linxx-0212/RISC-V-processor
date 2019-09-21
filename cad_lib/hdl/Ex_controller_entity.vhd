--
-- VHDL Entity cad_lib.Ex_controller.arch_name
--
-- Created:
--          by - 34679.UNKNOWN (DESKTOP-13EGCCO)
--          at - 02:43:22 2019/03/29
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE work.RV32I.all;

ENTITY Ex_controller IS
  PORT(Func: IN RV32I_Op;
      EQ : IN std_ulogic;
      GL_s : IN std_ulogic;
      GL_u : IN std_ulogic;
      Jmp_ctrl : OUT std_ulogic;
      Sel_Jad : OUT std_ulogic;
      Sel_data : OUT std_ulogic_vector(1 DOWNTO 0));
END ENTITY Ex_controller;

ARCHITECTURE behavior OF Ex_controller IS
BEGIN
  PROCESS(Func, EQ, GL_s, GL_u)
  VARIABLE Jmp_cv, Sel_Jadv: std_ulogic;
  VARIABLE Sel_datav : std_ulogic_vector(1 DOWNTO 0);
  BEGIN
    CASE Func IS
    WHEN JAL| JALR =>
      Jmp_cv :='1';
      Sel_Jadv := '1';
      Sel_datav :="00";
    WHEN BEQ =>
      IF EQ = '1' THEN
        Jmp_cv := '1';
      ELSE
        Jmp_cv :='0';
      END IF;
        Sel_Jadv := '0';
        Sel_datav := "01";
    WHEN BNE =>
      IF EQ = '0' THEN
        Jmp_cv :='1';
      ELSE
        Jmp_cv := '0';
      END IF;
        Sel_Jadv:='0';
        Sel_datav :="01";
    WHEN BLT =>
      IF GL_s = '1' THEN
        Jmp_cv :='1';
      ELSE
        Jmp_cv := '0';
      END IF;
        Sel_Jadv:='0';
        Sel_datav :="01";
    WHEN BLTU =>
      IF GL_u = '1' THEN
        Jmp_cv :='1';
      ELSE
        Jmp_cv := '0';
      END IF;
        Sel_Jadv:='0';
        Sel_datav :="01";
    WHEN BGE =>
      IF GL_s = '0' THEN
        Jmp_cv :='1';
      ELSE
        Jmp_cv := '0';
      END IF;
        Sel_Jadv:='0';
        Sel_datav :="01";
    WHEN BGEU =>
      IF GL_u = '0' THEN
        Jmp_cv :='1';
      ELSE
        Jmp_cv := '0';
      END IF;
        Sel_Jadv:='0';
        Sel_datav :="01";
    WHEN SLTI|SLTr =>
      IF GL_s = '1' THEN
        Sel_datav:="11";
      ELSE
        Sel_datav:="10";
      END IF;
        Sel_Jadv := '0';
        Jmp_cv :='0';
    WHEN SLTIU|SLTUr =>
      IF GL_u = '1' THEN 
        Sel_datav :="11";
      ELSE
        Sel_datav :="10";
      END IF;
        Sel_Jadv :='0';
        Jmp_cv :='0';
    WHEN SB|SH|SW|LUI|AUIPC =>
      Jmp_cv :='0';
      Sel_datav:="00";
    WHEN OTHERS =>
      Jmp_cv:='0';
      Sel_datav :="01";
    END CASE;
    Jmp_ctrl<=Jmp_cv;
    Sel_Jad <=Sel_Jadv;
    Sel_data<=Sel_datav;
  END PROCESS;
END ARCHITECTURE behavior;