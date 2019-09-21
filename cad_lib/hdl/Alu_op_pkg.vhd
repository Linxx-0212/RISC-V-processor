--
-- VHDL Package Header cad_lib.Alu_op
--
-- Created:
--          by - 34679.UNKNOWN (DESKTOP-13EGCCO)
--          at - 14:33:20 2019/03/18
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE std.textio.all;
PACKAGE Alu_op IS
ATTRIBUTE enum_encoding : string;

TYPE ALU_Op IS (aADD, aSUB, aAND, aOR, aXOR, aSL, aSRL, aSRA, BAD);
-- note that the shifts are parameterized to shift different numbers of bits
ATTRIBUTE enum_encoding OF ALU_Op : type is "0000 0001 0010 0011 0100 0101 0110 0111 1000";

SUBTYPE Func_Name IS STRING(5 DOWNTO 1);
FUNCTION Atype(Func : Func_Name) RETURN ALU_Op;
END Alu_op;

PACKAGE BODY Alu_Op IS
  FUNCTION Atype(Func : Func_NAME) RETURN ALU_Op IS
    VARIABLE ret : ALU_Op;
  BEGIN
    CASE Func IS
      WHEN "aADD-" =>
        ret := aADD;
      WHEN "aSUB-" =>
        ret := aSUB;
      WHEN "aAND-" =>
        ret := aAND;
      WHEN "aOR--" =>
        ret := aOR;
      WHEN "aXOR-" =>
        ret := aXOR;
      WHEN "aSL--" =>
        ret := aSL;
      WHEN "aSRL-" =>
        ret := aSRL;
      WHEN "aSRA-" =>
        ret := aSRA;
      WHEN OTHERS =>
        ret := BAD;
    END CASE;
    RETURN ret;
  END;
END Alu_Op;
