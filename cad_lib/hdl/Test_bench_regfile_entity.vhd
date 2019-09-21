LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE std.textio.all;
USE work.RV32I.all;

ENTITY Test_bench_regfile IS
END ENTITY Test_bench_regfile;

ARCHITECTURE Testbench of Test_bench_regfile IS
  FILE test_vectors : text OPEN read_mode IS "D:\CAD\regfile_vec.txt";
  

  SIGNAL Clock : std_ulogic;
  SIGNAL vecno : NATURAL := 0;
  SIGNAL  Load,Read1,Read2:  std_ulogic;
  SIGNAL  ReadSel,ReadSel2,WriteSel: std_ulogic_vector(4 DOWNTO 0);
  SIGNAL  D,Qr,Qr2,Qrv,Qr2v : std_ulogic_vector(31 DOWNTO 0);
BEGIN
  Regfile : ENTITY work.RegisterFile(Structure)
  PORT MAP(D => D, Qr=> Qr, Qr2 =>Qr2,ReadSel => ReadSel,ReadSel2=>ReadSel2, WriteSel=>WriteSel, Clock=>Clock,Load=>Load,Read1=>Read1,Read2=>Read2);

  Stim : PROCESS
  VARIABLE L : LINE;
  VARIABLE Lv,R1v,R2v : std_ulogic;
  VARIABLE Readv,Read2v,Writev : std_ulogic_vector(4 DOWNTO 0);
  VARIABLE Dv,Qv,Q2v : std_ulogic_vector(31 DOWNTO 0);
  BEGIN
    Clock<='0';
    wait for 40 ns;
    readline(test_vectors, L);
    WHILE NOT endfile(test_vectors) LOOP
      readline(test_vectors, L);
      read(L,Dv);
      D<=Dv;   
      read(L,Qv);
      Qrv<=Qv;
      read(L,Q2v);
      Qr2v<=Q2v;
      read(L,Readv);
      ReadSel<=Readv;
      read(L,Read2v);
      ReadSel2<=Read2v;
      read(L,Writev);
      WriteSel<=Writev;
      read(L,Lv);
      Load<=Lv;
      read(L,R1v);
      Read1<=R1v;
      read(L,R2v);
      Read2<=R2v;
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
      ASSERT Qr=Qrv
        REPORT"ERROR Read1v " & to_string(vecno)
        SEVERITY WARNING;
      ASSERT Qr2=Qr2v
        REPORT"ERROR Read1v2 " & to_string(vecno)
        SEVERITY WARNING;
      vecno <= vecno+1;
    END IF;
  END PROCESS;
END ARCHITECTURE Testbench;  
