--
-- VHDL Entity cad_lib.Memory_stage.arch_name
--
-- Created:
--          by - 34679.UNKNOWN (DESKTOP-13EGCCO)
--          at - 20:17:40 2019/04/ 1
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE work.RV32I.all;

ENTITY Memory_stage IS
  PORT( Data,Data_m :IN  std_ulogic_vector(31 DOWNTO 0);
        Address :IN  std_ulogic_vector(31 DOWNTO 0);
        Reg_d :IN   std_ulogic_vector(4 DOWNTO 0);
        Add_out,Data_out :OUT  std_ulogic_vector(31 DOWNTO 0);
        Data_out2 :OUT std_ulogic_vector(31 DOWNTO  0);
        Reg_out :OUT  std_ulogic_vector(4 DOWNTO  0);
        Fun_out :OUT  RV32I_Op;
        Fun_IN  :IN   RV32I_Op;
        Read    :OUT   std_ulogic;
        Write   :OUT   std_ulogic;
        Delay   :IN    std_ulogic;
        stall   :OUT   std_ulogic;
        Me_ctrl :OUT   std_ulogic_vector(1 DOWNTO 0);
        Clk     :IN   std_ulogic);
END ENTITY Memory_stage;

ARCHITECTURE Structure OF Memory_stage IS
SIGNAL	D_O,A_O  :std_ulogic_vector(31 DOWNTO 0);
BEGIN
	R_D : ENTITY work.Reg(Behavior)
	GENERIC MAP(width => 32)
	PORT MAP ( D => Data, Q =>D_O, Clock => Clk, Enable => '1', Reset => '0');
	
	R_A : ENTITY work.Reg(Behavior)
	GENERIC MAP(width => 32)
	PORT MAP ( D => Address, Q =>A_O, Clock => Clk, Enable => '1', Reset => '0');
	
	R_rd : ENTITY work.Reg(Behavior)
	GENERIC MAP(width => 5)
	PORT MAP ( D => Reg_d, Q =>Reg_out, Clock => Clk, Enable => '1', Reset => '0');
	
	R_f : ENTITY work.Fun_reg(Behavior)
	PORT MAP ( D => Fun_IN, Q =>Fun_out, Clock => Clk, Reset => '0', Enable => '1');
	 
	Controller : ENTITY  work.Me_controller(Behavior)
	PORT MAP(Fun => Fun_out, Read => Read, Write => Write, stall => stall, Me_ctrl => Me_ctrl, Delay => Delay);
	 
  Mux1  : ENTITY  work.Mux2(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP( IN_0  =>  D_O,  IN_1  => Data_m, Q => Data_out2, Sel => Read);
    
  Mux2  : ENTITY  work.Mux2(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP( IN_0 => (others =>'0'), IN_1 => A_O, Sel => Read or Write, Q => Add_out);
  
  Mux3  : ENTITY  work.Mux2(Behavior)
  GENERIC MAP(width => 32)
  PORT MAP( IN_0 =>  (others => '0'), IN_1 => D_O, Sel => write, Q => Data_out);
  
END	ARCHITECTURE Structure;



