--
-- VHDL Entity cad_lib.Decoder.arch_name
--
-- Created:
--          by - Xiaoxi Lin.UNKNOWN (DESKTOP-A0VSQRS)
--          at - 00:53:21 2019/02/19
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.RV32I.all;

ENTITY Decoder IS
  PORT( instruction : IN std_ulogic_vector(31 DOWNTO 0);
        Funct : OUT RV32I_Op;
        RS1, RS2, RD : OUT std_ulogic_vector(4 DOWNTO 0);
        RS1v, RS2v, RDv : OUT std_ulogic;
        Immediate : OUT std_ulogic_vector(31 DOWNTO 0));
END ENTITY Decoder;

ARCHITECTURE Behavior of Decoder IS

BEGIN
  PROCESS(instruction)
  VARIABLE Func : RV32I_Op; 
  BEGIN
    Func :=NOP;
    Funct<= NOP;
    RS1v<='0';
    RS2v<='0';
    RDv<='0';
    RS1<=(others => '0');
    RS2 <= (others =>'0');
    Rd <= (others =>'0');
    Immediate<=(others=>'0');
    IF (instruction = NOP_inst) THEN
      Func := NOP;
      RS1 <= (others =>'0');
      RS2 <= (others =>'0');
      Rd <= (others =>'0');
      RS1v <= '0';
      RS2v <= '0';
      RDv <='0';
      Immediate<=(others=>'0');
    ELSIF (instruction(1 DOWNTO 0) ="11") THEN
      Case instruction(6 DOWNTO 2) IS
        WHEN RV32I_OP_ALU =>
          IF (instruction(31 DOWNTO 25) = RV32I_FN7_ALU) THEN
            CASE instruction(14 DOWNTO 12) IS
              WHEN RV32I_FN3_ALU_ADD =>
                Func := ADDr;
              WHEN RV32I_FN3_ALU_SLT =>
                Func := SLTr;
              WHEN RV32I_FN3_ALU_SLTU =>
                Func := SLTUr;
              WHEN RV32I_FN3_ALU_XOR =>
                Func := XORr;
              WHEN RV32I_FN3_ALU_OR =>
                Func := ORr;
              WHEN RV32I_FN3_ALU_AND =>
                Func := ANDr;
              WHEN RV32I_FN3_ALU_SLL =>
                Func := SLLr;
              WHEN RV32I_FN3_ALU_SRL =>
                Func := SRLr;
              WHEN  OTHERS =>
                Func := BAD;
            END CASE;
          ELSIF (instruction(31 DOWNTO 25) = RV32I_FN7_ALU_SA) THEN
            IF (instruction(14 DOWNTO 12) = RV32I_FN3_ALU_SRA) THEN
              Func := SRAr;
            ELSIF (instruction(14 DOWNTO 12) = RV32I_FN3_ALU_SUB) THEN
              Func := SUBr;
            ELSE
              Func := BAD;
            END IF;
          END IF;
          IF (Func /= BAD) THEN
            RS1 <= instruction(19 DOWNTO 15);
            RS2 <= instruction(24 DOWNTO 20);
            RD <= instruction(11 DOWNTO 7);
            Immediate <= (others=>'0');
            RS1v <= '1';
            RS2v <= '1';
            RDv <= '1';
          END IF;
        WHEN RV32I_OP_AUIPC =>
          Func := AUIPC;
          immediate(31 DOWNTO 12) <= instruction(31 DOWNTO 12);
          immediate(11 DOWNTO 0) <=(others=>instruction(31));
          RD <= instruction(11 DOWNTO 7);
          RS1 <= instruction(19 DOWNTO 15);
          RS2 <= instruction(24 DOWNTO 20);
          RDv <= '1';
          RS1v <='0';
          RS2v <='0';
        WHEN RV32I_OP_JAL =>
          Func := JAL;
          immediate(20) <= instruction(31);
          immediate(10 DOWNTO 1) <= instruction(30 DOWNTO 21);
          immediate(11) <= instruction(20);
          immediate(19 DOWNTO 12) <= instruction(19 DOWNTO 12);
          immediate(31 DOWNTO 21) <= (others=>instruction(31));
          RS1 <= instruction(19 DOWNTO 15);
          RS2 <= instruction(24 DOWNTO 20);
          RD <= instruction(11 DOWNTO 7);
          RS1v<='0';
          RS2v<='0';
          RDv<='1';
        WHEN RV32I_OP_JALR =>
          Func := JALR;
          immediate(11 DOWNTO 0) <= instruction(31 DOWNTO 20);
          immediate(31 DOWNTO 12)<= (others=>instruction(31));
          RS1 <= instruction(19 DOWNTO 15);
          RS2 <= instruction(24 DOWNTO 20);
          RD <= instruction(11 DOWNTO 7);
          RS1v <= '1';
          RS2v <= '0';
          RDv <= '1';
        WHEN RV32I_OP_BRANCH =>
          CASE instruction(14 DOWNTO 12) IS
            WHEN RV32I_FN3_BRANCH_EQ =>
              Func := BEQ;
            WHEN RV32I_FN3_BRANCH_NE =>
              Func := BNE;
            WHEN RV32I_FN3_BRANCH_LT =>
              Func := BLT;
            WHEN RV32I_FN3_BRANCH_GE =>
              Func := BGE;
            WHEN RV32I_FN3_BRANCH_LTU =>
              Func := BLTU;
            WHEN RV32I_FN3_BRANCH_GEU =>
              Func := BGEU;
            WHEN  OTHERS =>
              Func := BAD;
          END CASE;
          IF (Func /= BAD) THEN
            immediate(12) <= instruction(31);
            immediate(10 DOWNTO 5) <= instruction(30 DOWNTO 25);
            immediate(4 DOWNTO 1) <= instruction(11 DOWNTO 8);
            immediate(11) <= instruction(7);
            immediate(31 DOWNTO 13)<=(others=>instruction(31));
            RS1 <= instruction(19 DOWNTO 15);
            RS2 <= instruction(24 DOWNTO 20);
            RD <=(others =>  '0');
            RS1v <= '1';
            RS2v <= '1';
            Rdv <= '0';
          END IF;
        WHEN RV32I_OP_LOAD =>
          CASE instruction(14 DOWNTO 12) IS
            WHEN RV32I_FN3_LOAD_B =>
              Func := LB;
            WHEN RV32I_FN3_LOAD_H =>
              Func := LH;
            WHEN RV32I_FN3_LOAD_W =>
              Func := LW;
            WHEN RV32I_FN3_LOAD_BU =>
              Func := LBU;
            WHEN RV32I_FN3_LOAD_HU =>
              Func := LHU;
            WHEN  OTHERS =>
              Func := BAD;
            END CASE;
            IF (Func /= BAD) THEN
              immediate(11 DOWNTO 0) <= instruction(31 DOWNTO 20);
              immediate(31 DOWNTO 12) <= (others=>instruction(31));
              RS1 <= instruction(19 DOWNTO 15);
              RS2 <= instruction(24 DOWNTO 20);
              RD <= instruction(11 DOWNTO 7);
              RS1v <= '1';
              RS2v <= '0';
              RDv <= '1';
            END IF;
        WHEN RV32I_OP_STORE =>
          CASE instruction(14 DOWNTO 12) IS
            WHEN RV32I_FN3_STORE_B =>
              Func := SB;
            WHEN RV32I_FN3_STORE_H =>
              Func := SH;
            WHEN RV32I_FN3_STORE_W =>
              Func := SW;
            WHEN  OTHERS =>
              Func := BAD;
          END CASE;
          IF (Func /= BAD) THEN
            immediate(11 DOWNTO 5) <= instruction(31 DOWNTO 25);
            immediate(4 DOWNTO 0) <= instruction(11 DOWNTO 7);
            immediate(31 DOWNTO 12) <= (others=>instruction(31));
            RS1 <= instruction(19 DOWNTO 15);
            RS2 <= instruction(24 DOWNTO 20);
            RD <=(others =>  '0');
            RS1v <= '1';
            RS2v <= '1';
            RDv <= '0';
          END IF;
        WHEN RV32I_OP_ALUI =>
          CASE instruction(14 DOWNTO 12) IS
            WHEN RV32I_FN3_ALU_ADD =>
              Func := ADDI;
            WHEN RV32I_FN3_ALU_SLT =>
              Func := SLTI;
            WHEN RV32I_FN3_ALU_SLTU =>
              Func := SLTIU;
            WHEN RV32I_FN3_ALU_XOR =>
              Func := XORI;
            WHEN RV32I_FN3_ALU_OR =>
              Func := ORI;
            WHEN RV32I_FN3_ALU_AND =>
              Func := ANDI;
            WHEN RV32I_FN3_ALU_SLL =>
              IF(instruction(31 DOWNTO 25) = RV32I_FN7_ALU) THEN
                Func := SLLI;
              ELSE
                Func := BAD;
              END IF;
            WHEN RV32I_FN3_ALU_SRL =>
              IF(instruction(31 DOWNTO 25) = RV32I_FN7_ALU) THEN
                Func := SRLI;
              ELSIF (instruction(31 DOWNTO 25) = RV32I_FN7_ALU_SA) THEN
                Func := SRAI;
              ELSE
                Func := BAD;
              END IF;
            WHEN  OTHERS =>
              Func := BAD;
            END CASE;
            IF (Func = SLLI or Func = SRLI or Func = SRAI) THEN
              immediate(31 DOWNTO 5) <=(others=>'0');
              immediate(4 DOWNTO 0) <= instruction(24 DOWNTO 20);
              RD <= instruction(11 DOWNTO 7);
              RS1 <= instruction(19 DOWNTO 15);
              RS2 <= instruction(24 DOWNTO 20);
              RS1v <= '1';
              RS2v <= '0';
              RDv <= '1';
            ELSIF (Func /= BAD) THEN
              immediate(11 DOWNTO 0) <= instruction(31 DOWNTO 20);
              immediate(31 DOWNTO 12) <= (others=>instruction(31));
              RS1 <= instruction(19 DOWNTO 15);
              RS2 <= instruction(24 DOWNTO 20);
              RD <= instruction(11 DOWNTO 7);
              RS1v <= '1';
              RS2v <= '0';
              RDv <= '1';
            END IF;
          
        WHEN RV32I_OP_LUI=>
          immediate(31 DOWNTO 12) <= instruction(31 DOWNTO 12);
          immediate(11 DOWNTO 0) <= "000000000000";
          RD <= instruction(11 DOWNTO 7);
          RS1 <= instruction(19 DOWNTO 15);
          RS2 <= instruction(24 DOWNTO 20);
          RS1v <= '0';
          RS2v <= '0';
          RDv <= '1';
          Func := LUI;
        WHEN  OTHERS =>
          Func := BAD;
      END Case;
    ELSE
      Func := BAD;
    END IF;
    IF (Func = BAD) THEN
      immediate(31 DOWNTO 0) <=(others=>'0');
      Funct <= BAD;
      RS1 <= instruction(19 DOWNTO 15);
      RS2 <= instruction(24 DOWNTO 20);
      RD <= instruction(11 DOWNTO 7);
      RS1v <= '0';
      RS2v <= '0';
      RDv <='0';
    ELSE
      Funct <= Func;
    END IF;
  END PROCESS;
END Behavior;