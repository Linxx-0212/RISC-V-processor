--
-- VHDL Entity cad_lib.Alu_control.arch_name
--
-- Created:
--          by - 34679.UNKNOWN (DESKTOP-13EGCCO)
--          at - 20:32:21 2019/03/28
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE work.RV32I.all;
USE work.Alu_op.all;
USE ieee.numeric_std.all;

ENTITY Alu_control IS
   PORT(
        Func : IN   RV32I_op;
        Alu_c: OUT  ALU_op);
END ENTITY Alu_control;


ARCHITECTURE behavior OF Alu_control IS
BEGIN
  PROCESS(Func)
  VARIABLE  ctrl_v: ALU_Op;
  BEGIN
	CASE  Func IS
    WHEN LB|LH|LW|LBU|LHU|ADDI|ADDr|SB|SH|SW|LUI|AUIPC|JAL|JALR|SLTI|SLTIU|BEQ|BNE|BLT|BGE|BLTU|BGEU|SLTr|SLTUr =>
      ctrl_v := aADD;
    WHEN SUBr =>
      ctrl_v := aSUB;
	WHEN ANDr|ANDI =>
	  ctrl_v := aAND;
	WHEN ORr|ORI =>
	  ctrl_v := aOR;
	WHEN XORr|XORI =>
	  ctrl_v := aXOR;
	WHEN SLLr|SLLI =>
	  ctrl_v := aSL;
	WHEN SRLr|SRLI =>
	  ctrl_v := aSRL;
	WHEN SRAr|SRAI =>
	  ctrl_v := aSRA;
	WHEN others => NULL;
	END CASE;
  Alu_c <= ctrl_v;
  END PROCESS;
END ARCHITECTURE behavior;
