--
-- VHDL Entity cad_lib.Execute_stage.arch_name
--
-- Created:
--          by - Xiaoxi Lin.UNKNOWN (DESKTOP-A0VSQRS)
--          at - 15:51:54 2019/03/28
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.RV32I.all;
USE work.Alu_op.all;


ENTITY Execute_stage IS
  PORT (  LEFT,RIGHT,EXTRA  :IN   std_ulogic_vector(31 DOWNTO 0);
          RD                :IN   std_ulogic_vector(4 DOWNTO 0);
          PC                :IN   std_ulogic_vector(31 DOWNTO 0);
          Func              :IN   RV32I_Op;
          Jaddr             :OUT  std_ulogic_vector(31 DOWNTO 0);
          Address,DATA      :OUT  std_ulogic_vector(31 DOWNTO 0);
          Dreg              :OUT  std_ulogic_vector(4 DOWNTO 0);
          Func_out          :OUT  RV32I_Op;
          Jump              :OUT  std_ulogic;
          Clk,stall               :IN   std_ulogic);
END ENTITY Execute_stage;

ARCHITECTURE  Structure OF Execute_stage IS
SIGNAL L_O,R_O,E_O,ALU_rst : std_ulogic_vector(31 DOWNTO 0);
SIGNAL ALU_c : ALU_Op;
SIGNAL cmp_EQ, cmp_s,cmp_u,Sel_m2 : std_ulogic;
SIGNAL Sel_m4 : std_ulogic_vector(1 DOWNTO 0);
SIGNAL Jaddr0,PC1 : std_ulogic_vector(31 DOWNTO 0);


BEGIN
  R_L : ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP ( D => LEFT, Q =>L_O, Clock => Clk, Enable => NOT stall, Reset => '0');
    
  R_R : ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP ( D => RIGHT, Q =>R_O, Clock => Clk, Reset => '0', Enable => NOT stall);
    
  R_E : ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP ( D => EXTRA, Q =>E_O, Clock => Clk, Reset => '0', Enable => NOT stall);
    
  R_D : ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 5)
  PORT MAP ( D => RD, Q =>Dreg, Clock => Clk, Reset => '0', Enable => NOT stall);
    
  R_f : ENTITY work.Fun_reg(Behavior)
  PORT MAP ( D => Func, Q =>Func_out, Clock => Clk, Reset => '0', Enable => NOT stall);
  
  R_p : ENTITY work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP ( D =>PC, Q=>PC1,Clock => Clk, Reset =>'0', Enable => NOT stall);
    
  ALU_ctrl : ENTITY work.Alu_control(Behavior)
  PORT MAP(Func => Func_out,ALU_c =>ALU_c);
    
  ALU: ENTITY work.ALU(Behavior)
  PORT MAP(operation => ALU_c,
          x => L_O,
          y => R_O,
          RESULT =>ALU_rst);
  Compare : ENTITY work.Compare(Behavior)
  PORT MAP(Left => L_O, Right => R_O, EQ => cmp_EQ, GL_s => cmp_s, GL_u => cmp_u);
    
  Controller : ENTITY work.Ex_controller(Behavior)
  PORT MAP(Func => Func_out, EQ => cmp_EQ, GL_s => cmp_s, GL_u => cmp_u,Jmp_ctrl =>Jump,Sel_Jad =>Sel_m2,Sel_data => Sel_m4);
    
  Mux2 : ENTITY work.Mux2(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(IN_0 => E_O,IN_1 => ALU_rst,Sel =>Sel_m2,Q=>Jaddr0);
    
  ALU2 : ENTITY work.ALU(Behavior)
  PORT MAP(operation => aADD,
          x => PC1,
          y => Jaddr0,
          RESULT => Jaddr);
    
  Mux4 : ENTITY work.Mux4(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(IN_0=>E_O,
           IN_1=>ALU_rst,
           IN_2=>"00000000000000000000000000000000",
           IN_3=>"00000000000000000000000000000001",
           Sel1=>Sel_m4(1),
           Sel2=>Sel_m4(0),
         Q=>Data);
  Address <= Alu_rst;
END ARCHITECTURE Structure;