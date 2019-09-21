--
-- VHDL Entity cad_lib.RegisterFile.arch_name
--
-- Created:
--          by - Xiaoxi Lin.UNKNOWN (DESKTOP-A0VSQRS)
--          at - 15:46:47 2019/04/11
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY RegisterFile IS
  PORT( D : IN std_ulogic_vector(31 DOWNTO 0);    
        Qr,Qr2 : OUT std_logic_vector(31 DOWNTO 0);   
        ReadSel, ReadSel2, WriteSel : IN std_ulogic_vector(4 DOWNTO 0);   
        Clock, Load,Read1,Read2 : IN std_ulogic); 
END ENTITY RegisterFile;

ARCHITECTURE Structure OF RegisterFile IS
SIGNAL WriteDC,ReadDC,ReadDC2,mQr,mQr2 : std_ulogic_vector(31 DOWNTO 0);  
SIGNAL Q0,Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,Q10,Q11,Q12,Q13,Q14,Q15,Q16,Q17,Q18,Q19,Q20,Q21,Q22,Q23,Q24,Q25,Q26,Q27,Q28,Q29,Q30,Q31 :std_ulogic_vector(31 DOWNTO 0);

BEGIN

  Decoder : ENTITY work.Reg_dec(Behavior)
  PORT MAP(sel=>WriteSel, OneHot=>WriteDC, enable=>Load);
  Decoder1 : ENTITY work.Reg_dec(Behavior)
  PORT MAP(sel=>ReadSel, OneHot=>ReadDC, enable=>'1');  
  Decoder2 : ENTITY work.Reg_dec(Behavior)
  PORT MAP(sel=>ReadSel2, OneHot=>ReadDC2, enable=>'1');    
  
  Reg0: ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(D => D , Q =>Q0,Clock => Clock, Reset=> '1', Enable =>'0');
  
  Reg1: ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(D => D , Q =>Q1,Clock => Clock, Reset=> '0', Enable =>WriteDC(1));
  
  Reg2: ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(D => D , Q =>Q2,Clock => Clock, Reset=> '0', Enable =>WriteDC(2));
  
  Reg3: ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(D => D , Q =>Q3,Clock => Clock, Reset=> '0', Enable =>WriteDC(3));
  
  Reg4: ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(D => D , Q =>Q4,Clock => Clock, Reset=> '0', Enable =>WriteDC(4));
    
  Reg5: ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(D => D , Q =>Q5,Clock => Clock, Reset=> '0', Enable =>WriteDC(5));
    
  Reg6: ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(D => D , Q =>Q6,Clock => Clock, Reset=> '0', Enable =>WriteDC(6));
    
  Reg7: ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(D => D , Q =>Q7,Clock => Clock, Reset=> '0', Enable =>WriteDC(7));
    
  Reg8: ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(D => D , Q =>Q8,Clock => Clock, Reset=> '0', Enable =>WriteDC(8));
    
  Reg9: ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(D => D , Q =>Q9,Clock => Clock, Reset=> '0', Enable =>WriteDC(9));
    
  Reg10: ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(D => D , Q =>Q10,Clock => Clock, Reset=> '0', Enable =>WriteDC(10));
    
  Reg11: ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(D => D , Q =>Q11,Clock => Clock, Reset=> '0', Enable =>WriteDC(11));
    
  Reg12: ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(D => D , Q =>Q12,Clock => Clock, Reset=> '0', Enable =>WriteDC(12));
    
  Reg13: ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(D => D , Q =>Q13,Clock => Clock, Reset=> '0', Enable =>WriteDC(13));
    
  Reg14: ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(D => D , Q =>Q14,Clock => Clock, Reset=> '0', Enable =>WriteDC(14));
    
  Reg15: ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(D => D , Q =>Q15,Clock => Clock, Reset=> '0', Enable =>WriteDC(15));
    
  Reg16: ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(D => D , Q =>Q16,Clock => Clock, Reset=> '0', Enable =>WriteDC(16));
    
  Reg17: ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(D => D , Q =>Q17,Clock => Clock, Reset=> '0', Enable =>WriteDC(17));
    
  Reg18: ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(D => D , Q =>Q18,Clock => Clock, Reset=> '0', Enable =>WriteDC(18));
    
  Reg19: ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(D => D , Q =>Q19,Clock => Clock, Reset=> '0', Enable =>WriteDC(19));
    
  Reg20: ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(D => D , Q =>Q20,Clock => Clock, Reset=> '0', Enable =>WriteDC(20));
    
  Reg21: ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(D => D , Q =>Q21,Clock => Clock, Reset=> '0', Enable =>WriteDC(21));
    
  Reg22: ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(D => D , Q =>Q22,Clock => Clock, Reset=> '0', Enable =>WriteDC(22));
    
  Reg23: ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(D => D , Q =>Q23,Clock => Clock, Reset=> '0', Enable =>WriteDC(23));
    
  Reg24: ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(D => D , Q =>Q24,Clock => Clock, Reset=> '0', Enable =>WriteDC(24));
    
  Reg25: ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(D => D , Q =>Q25,Clock => Clock, Reset=> '0', Enable =>WriteDC(25));
    
  Reg26: ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(D => D , Q =>Q26,Clock => Clock, Reset=> '0', Enable =>WriteDC(26));
    
  Reg27: ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(D => D , Q =>Q27,Clock => Clock, Reset=> '0', Enable =>WriteDC(27));
    
  Reg28: ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(D => D , Q =>Q28,Clock => Clock, Reset=> '0', Enable =>WriteDC(28));
    
  Reg29: ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(D => D , Q =>Q29,Clock => Clock, Reset=> '0', Enable =>WriteDC(29));
    
  Reg30: ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(D => D , Q =>Q30,Clock => Clock, Reset=> '0', Enable =>WriteDC(30));
    
  Reg31: ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(D => D , Q =>Q31,Clock => Clock, Reset=> '0', Enable =>WriteDC(31));
    
  MUX1: ENTITY work.Mux32(Behavior)
  PORT MAP(IN_0=> Q0, IN_1 => Q1, IN_2=> Q2,IN_3 => Q3, IN_4 => Q4, IN_5 => Q5, IN_6 => Q6, IN_7 => Q7,IN_8 => Q8,IN_9 => Q9,IN_10 => Q10,IN_11 => Q11,IN_12 => Q12,IN_13 => Q13,IN_14 => Q14,IN_15 => Q15,IN_16 => Q16,IN_17 => Q17,
    IN_18 => Q18,IN_19 => Q19,IN_20 => Q20,IN_21 => Q21,IN_22 => Q22,IN_23 => Q23,IN_24 => Q24,IN_25 => Q25,IN_26 => Q26,IN_27 => Q27,IN_28 => Q28,IN_29 => Q29,IN_30 => Q30,IN_31 => Q31,Sel => ReadDC, Q=> mQr);
    
  MUX2: ENTITY work.Mux32(Behavior)
  PORT MAP(IN_0=> Q0, IN_1 => Q1, IN_2=> Q2,IN_3 => Q3, IN_4 => Q4, IN_5 => Q5, IN_6 => Q6, IN_7 => Q7,IN_8 => Q8,IN_9 => Q9,IN_10 => Q10,IN_11 => Q11,IN_12 => Q12,IN_13 => Q13,IN_14 => Q14,IN_15 => Q15,IN_16 => Q16,IN_17 => Q17,
    IN_18 => Q18,IN_19 => Q19,IN_20 => Q20,IN_21 => Q21,IN_22 => Q22,IN_23 => Q23,IN_24 => Q24,IN_25 => Q25,IN_26 => Q26,IN_27 => Q27,IN_28 => Q28,IN_29 => Q29,IN_30 => Q30,IN_31 => Q31,Sel => ReadDC2, Q=> mQr2);
  
  MUX3: ENTITY work.Mux2(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(IN_0 => (others=>'Z'),IN_1 => mQr,Sel=>read1,Q=>Qr);
  
  MUX4: ENTITY work.Mux2(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(IN_0 => (others=>'Z'),IN_1 => mQr2,Sel=>read2,Q=>Qr2);
  
END ARCHITECTURE STRUCTURE;