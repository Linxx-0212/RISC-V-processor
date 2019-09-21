--
-- VHDL Entity cad_lib.Decoder_stage.arch_name
--
-- Created:
--          by - 34679.UNKNOWN (DESKTOP-13EGCCO)
--          at - 23:18:31 2019/03/ 5
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.RV32I.all;

ENTITY Decoder_stage IS
  PORT( instruction : IN std_ulogic_vector(31 DOWNTO 0);
        Functout : OUT RV32I_Op;
        RS1, RS2, RD : OUT std_ulogic_vector(4 DOWNTO 0);
        RS1D,RS2D : IN std_ulogic_vector(31 DOWNTO 0);
        LEFT,RIGHT,EXTRA : OUT std_ulogic_vector(31 DOWNTO 0);
		    RS1v,RS2v,RDv :	OUT std_ulogic;
		    stall : IN std_ulogic);
        
END ENTITY Decoder_stage;

ARCHITECTURE STRUCTURE of Decoder_stage IS
SIGNAL Imme : std_ulogic_vector(31 DOWNTO 0);
SIGNAL Con_2,Con_3 : std_ulogic;
SIGNAL MUX1OUT : std_ulogic_vector(31 DOWNTO 0);
SIGNAL Funct : RV32I_Op;
BEGIN
  Decoder : ENTITY work.decoder(Behavior)
  PORT MAP(instruction => instruction, Funct => Funct, RS1 => RS1, RS2 => RS2, RD => RD, RS1v => RS1v, RS2v=> RS2v, RDv=>RDv,Immediate =>Imme);
  
  Control : ENTITY work.De_control(Behavior)
  PORT MAP(Funct => Funct,Con_out1 => Con_2,Con_out2 => Con_3,stall => stall,Functout => Functout);
    
  MUX0 : ENTITY work.Mux2(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(IN_0 => (others=>'0'),IN_1 => RS1D,Q => RIGHT,Sel=>RS1v);
    
  MUX1 : ENTITY work.Mux2(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(IN_0 => (others=>'0'),IN_1 => RS2D,Q => MUX1OUT,Sel=>RS2v);
  
  MUX2 : ENTITY work.Mux2(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(IN_0 => MUX1OUT,IN_1 => Imme,Q=>EXTRA,Sel=>Con_2);
  
  MUX3 : ENTITY work.Mux2(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(IN_0 => Imme,IN_1 => MUX1OUT,Q=>LEFT,Sel=>Con_3);
    
  
END ARCHITECTURE Structure;