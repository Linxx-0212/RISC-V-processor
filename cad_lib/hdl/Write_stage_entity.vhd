--
-- VHDL Entity cad_lib.Write_stage.arch_name
--
-- Created:
--          by - Xiaoxi Lin.UNKNOWN (DESKTOP-A0VSQRS)
--          at - 13:54:16 2019/04/ 4
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.RV32I.all;

ENTITY Write_stage IS
  PORT( Data  :IN   std_ulogic_vector(31 DOWNTO 0);
        Rd    :IN   std_ulogic_vector(4  DOWNTO 0);
        Fun   :IN   RV32I_Op;
        Data_out  :OUT  std_ulogic_vector(31 DOWNTO 0);
        Rd_out    :OUT  std_ulogic_vector(4 DOWNTO 0);
        write   :OUT    std_ulogic;
        Clk     :IN     std_ulogic);
        
END ENTITY Write_stage;


ARCHITECTURE Structure OF Write_stage IS
SIGNAL Func_out : RV32I_Op;  
SIGNAL Rd_out1 : std_ulogic_vector(4 DOWNTO 0);
BEGIN
  
  R_D : ENTITY  work.Reg(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP(D => Data, Q => Data_out,Clock => Clk,Reset => '0',Enable => '1');
  
  R_R : ENTITY  work.Reg(Behavior)
  GENERIC MAP(width => 5)
  PORT MAP(D => Rd, Q => Rd_out1, Clock => Clk, Reset => '0', Enable => '1');
  
  R_f : ENTITY work.Fun_reg(Behavior)
  PORT MAP( D => Fun, Q =>Func_out, Clock => Clk, Reset => '0', Enable => '1');
  
    
  controller : ENTITY work.We_controller(Behavior)
  PORT MAP( Fun => Func_out,Rd => Rd_out1,Rdout => Rd_out, write=> write);
  
END ARCHITECTURE Structure;
