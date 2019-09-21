--
-- VHDL Entity cad_lib.Test_bench_Des.arch_name
--
-- Created:
--          by - 34679.UNKNOWN (DESKTOP-13EGCCO)
--          at - 00:07:16 2019/03/ 6
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE std.textio.all;
USE work.RV32I.all;

ENTITY Test_bench_Des IS
END ENTITY Test_bench_Des;

ARCHITECTURE Testbench of Test_bench_Des IS
  FILE test_vectors : text OPEN read_mode IS "D:\CAD\Decoder_stage_vec.txt";
  
  SIGNAL instruction : std_ulogic_vector(31 DOWNTO 0);
  SIGNAL RS1D,RS2D : std_ulogic_vector(31 DOWNTO 0);
  SIGNAL Funct,Funv : RV32I_Op;
  SIGNAL RS1,RS2,RD,R1a,R2a,Rda: std_ulogic_vector(4 DOWNTO 0);
  SIGNAL LEFT,RIGHT,EXTRA,LEFTv,RIGHTv,EXTRAv : std_ulogic_vector(31 DOWNTO 0);
  SIGNAL Clock : std_ulogic;
  
  SIGNAL vecno : NATURAL := 0;
BEGIN
  Decoder : ENTITY work.Decoder_stage(structure)
  PORT MAP(instruction => instruction, Funct=> Funct, RS1 => RS1, RS2 =>RS2,RD => RD,RS1D => RS1D, RS2D=>RS2D, LEFT=>LEFT, RIGHT=>RIGHT, EXTRA=>EXTRA);

  Stim : PROCESS
  VARIABLE L : LINE;
  VARIABLE instval : std_ulogic_vector(31 DOWNTO 0);
  VARIABLE Fun : String(1 TO 5);
  VARIABLE R1,R2,D: std_ulogic_vector(4 DOWNTO 0);
  VARIABLE RFD1,RFD2: std_ulogic_vector(31 DOWNTO 0);
  VARIABLE LEFT0,RIGHT0,EXTRA0: std_ulogic_vector(31 DOWNTO 0);
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
      read(L,LEFT0);
      LEFTv<=LEFT0;
      read(L,RIGHT0);
      RIGHTv<=RIGHT0;
      read(L,EXTRA0);
      EXTRAv<=EXTRA0;
      read(L,RFD1);
      RS1D<=RFD1;
      read(L,RFD2);
      RS2D<=RFD2;
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
      ASSERT LEFT=LEFTv
        REPORT"ERROR LEFT " & to_string(vecno)
        SEVERITY WARNING;
      ASSERT RIGHT=RIGHTv
        REPORT"ERROR RIGHT " & to_string(vecno)
        SEVERITY WARNING;
      ASSERT EXTRA=EXTRAv
        REPORT"ERROR EXTRA " & to_string(vecno)
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
      vecno <= vecno+1;
    END IF;
  END PROCESS;
END ARCHITECTURE Testbench;  
