--
-- VHDL Entity my_project1_lib.Fetch_new.arch_name
--
-- Created:
--          by - Xiaoxi Lin.UNKNOWN (DESKTOP-A0VSQRS)
--          at - 13:22:24 2019/02/ 5
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY Fetch_new IS
    PORT( Jaddr, Mdata : IN std_ulogic_vector(31 DOWNTO 0);
          Address, Inst : OUT std_ulogic_vector(31 DOWNTO 0);
          Clock, Jmp, Reset, Delay,Stall : IN std_ulogic;
          Read : OUT std_ulogic);
END ENTITY Fetch_new;

ARCHITECTURE Structure OF Fetch_new IS
Signal Regout,Mux0out,Mux1out,Incout : std_ulogic_vector(31 DOWNTO 0);
BEGIN

  Mux0 : ENTITY work.Mux2(Behavior)
    GENERIC MAP(width => 32)
    PORT MAP(In_0 => Jaddr,In_1 => "00000000000000000000000000000000",Q => Mux0out,Sel => reset);
  Mux1 : ENTITY work.Mux2(Behavior)
    GENERIC MAP(width => 32)
    PORT MAP(In_0 => Regout ,In_1 => Mux0out, Q => Mux1out, Sel => (Jmp OR Reset));
  Reg : ENTITY work.Reg(Behavior)
    GENERIC MAP(width => 32)
    PORT MAP(D => Incout,Q => Regout,Clock => Clock,Enable => NOT(Delay) or NOT(Reset) or NOT(Stall),reset => '0');
  Increment : ENTITY work.Increment(Behavior)
    GENERIC MAP(width => 32)
    PORT MAP(D => Mux1out,Q => Incout,Inc(1) => not(Reset or Jmp or Delay or Stall),Inc(0) => not(Reset or Jmp or Delay or Stall));
  Read <= NOT(Reset );
  Mux2 : ENTITY work.Mux2(Behavior)
    GENERIC MAP(width => 32)
    PORT MAP(In_0 => "00000000000000000000000000010011", In_1 => Mdata, Q => Inst, Sel => NOT(RESET or Jmp or Delay));
  Address <= Mux1out;
  
END ARCHITECTURE Structure;