--
-- VHDL Entity cad_lib.Counter.arch_name
--
-- Created:
--          by - 34679.UNKNOWN (DESKTOP-13EGCCO)
--          at - 21:46:19 2019/01/28
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY Counter IS
  GENERIC(width : NATURAL RANGE 1 TO 64:=8 );
  PORT( Cin : IN std_ulogic_vector(width - 1 DOWNTO 0);
        Cout : OUT std_ulogic_vector(width - 1 DOWNTO 0);
        Clock, enable, reset : IN std_ulogic);
END ENTITY Counter;

ARCHITECTURE Structure OF Counter IS
Signal Regout,Muxout,Incout : std_ulogic_vector(width -1 DOWNTO 0);

BEGIN
  Mux : ENTITY work.Mux2(Behavior)
    GENERIC MAP(width=>width)
    PORT MAP(In_0=>Regout,In_1=>Cin,Q=>Muxout,Sel=>reset);
  Reg : ENTITY work.Reg(Behavior)
    GENERIC MAP(width=>width)
    PORT MAP(D=>Incout,Q=>Regout,Clock=>Clock,Enable=>'1',reset=>'0');
  Increment : ENTITY work.Increment(Behavior)
    GENERIC MAP(width=>width)
    PORT MAP(D=>Muxout,Q=>Incout,Inc(1)=>enable,Inc(0)=>enable);
  Cout<=Muxout;
END ARCHITECTURE Structure;