--
-- VHDL Entity cad_lib.De_Control.arch_name
--
-- Created:
--          by - Xiaoxi Lin.UNKNOWN (DESKTOP-A0VSQRS)
--          at - 10:55:03 2019/03/ 4
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.RV32I.all;

ENTITY De_Control IS
  PORT( Funct : IN RV32I_Op;
        Con_out1 : OUT std_ulogic;
        Con_out2 : OUT std_ulogic;
        stall : IN std_ulogic;
        Functout : OUT RV32I_Op);
END ENTITY De_Control;

ARCHITECTURE Behavior of De_Control IS
BEGIN
  PROCESS(Funct,stall)
  BEGIN
    IF stall = '1' THEN
      Functout <= NOP;
    ELSE
      Functout <= Funct;
    CASE Funct IS
      WHEN SLLI | SRLI | SRAI | ADDI | SLTI | SLTIU | XORI | ORI | ANDI | JALR | LB | LH | LW | LBU | LHU =>
        Con_out1 <= '0';--rs2 0
        Con_out2 <= '0';--imm
      WHEN SB | SH | SW =>
        Con_out1 <= '0';--rs2
        Con_out2 <= '0';--imm
      WHEN LUI | AUIPC | JAL =>
        Con_out1 <= '1';--imm
        Con_out2 <= '1';--0
      WHEN Others =>
        Con_out1 <= '1';--imm
        Con_out2 <= '1';--rs2
      END CASE;
    END IF;
  END PROCESS;
END Behavior;