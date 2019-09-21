--
-- VHDL Entity cad_lib.Test_bench_decoder.arch_name
--
-- Created:
--          by - 34679.UNKNOWN (DESKTOP-13EGCCO)
--          at - 14:49:17 2019/02/24
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE std.textio.all;
USE work.RV32I.all;

ENTITY Test_bench_decoder IS
END ENTITY Test_bench_decoder;

ARCHITECTURE Testbench of Test_bench_decoder IS
  FILE test_vectors : text OPEN read_mode IS "D:\CAD\Decoder_vec.txt";
  
  SIGNAL instruction : std_ulogic_vector(31 DOWNTO 0);
  SIGNAL Funct,Funv : RV32I_Op;
  SIGNAL RS1, RS2,RD,R1a,R2a,Rda: std_ulogic_vector(4 DOWNTO 0);
  SIGNAL RS1v,RS2v,RDv,Re1v,Re2v,ReDv: std_ulogic;
  SIGNAL Imme,Immev : std_ulogic_vector(31 DOWNTO 0);
  SIGNAL Clock : std_ulogic;
  
  SIGNAL vecno : NATURAL := 0;
BEGIN
  Decoder : ENTITY work.Decoder(Behavior)
  PORT MAP(instruction => instruction, Funct=> Funct, RS1 => RS1, RS2 =>RS2,RD => RD,RS1v=>RS1v, RS2v=>RS2v, RDv=>RDv,Immediate=>Imme);

  Stim : PROCESS
  VARIABLE L : LINE;
  VARIABLE instval : std_ulogic_vector(31 DOWNTO 0);
  VARIABLE Fun : String(1 TO 5);
  VARIABLE R1v, R2v, Dv: std_ulogic;
  VARIABLE R1,R2,D: std_ulogic_vector(4 DOWNTO 0);
  VARIABLE Imv : std_ulogic_vector(31 DOWNTO 0);
  BEGIN
    Clock<='0';
    wait for 40 ns;
    readline(test_vectors, L);
    WHILE NOT endfile(test_vectors) LOOP
      readline(test_vectors, L);
      read(L,Fun);
      Funv<=Ftype(Fun);    
      read(L,instval);
      instruction<=instval;
      read(L,R1);
      R1a<=R1;
      read(L,R2);
      R2a<=R2;
      read(L,D);
      Rda<=D;
      read(L,R1v);
      Re1v<=R1v;
      read(L,R2v);
      Re2v<=R2v;
      read(L,Dv);
      ReDv<=Dv;
      read(L,Imv);
      Immev<=Imv;
      wait for 10 ns;
      Clock<='1';
      wait for 50 ns;
      Clock<='0';
      wait for 40 ns;
    END LOOP;
    report "END of Testbench.";
  END PROCESS;
  Check : PROCESS(Clock)
  BEGIN
    IF (falling_edge(Clock)) THEN
      ASSERT Funct=Funv
        REPORT"ERROR Func " & to_string(vecno)
        SEVERITY WARNING;
      ASSERT RS1v=Re1v
        REPORT"ERROR RS1v " & to_string(vecno)
        SEVERITY WARNING;
      ASSERT RS2v=Re2v
        REPORT"ERROR RS2v " & to_string(vecno)
        SEVERITY WARNING;
      ASSERT RDv=ReDv
        REPORT"ERROR RDv " & to_string(vecno)
        SEVERITY WARNING;
      ASSERT RS1=R1a
        REPORT"ERROR RS1 " & to_string(vecno)
        SEVERITY WARNING;
      ASSERT RS2=R2a
        REPORT"ERROR RS2 " & to_string(vecno)
        SEVERITY WARNING;
      ASSERT RD=Rda
        REPORT"ERROR RD " & to_string(vecno)
        SEVERITY WARNING;
      ASSERT Imme=Immev
        REPORT"ERROR immediate " & to_string(vecno)
        SEVERITY WARNING;
      vecno <= vecno+1;
    END IF;
  END PROCESS;
END ARCHITECTURE Testbench;  