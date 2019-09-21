LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE std.textio.all;
USE work.RV32I.all;

ENTITY Test_bench_tracker IS
END ENTITY Test_bench_tracker;

ARCHITECTURE Testbench of Test_bench_tracker IS
  FILE test_vectors : text OPEN read_mode IS "G:\CAD\tracker_vec.txt";
  

  SIGNAL Clock : std_ulogic;
  SIGNAL vecno : NATURAL := 0;
  SIGNAL reserve,free,read_A,read_B,stall,stallv :  std_ulogic;
  SIGNAL RFRA_A,RFRA_B,RFWA,RFWA2 : std_ulogic_vector(4 DOWNTO 0);
BEGIN
  tracker : ENTITY work.Reg_tracker(Behavior)
  PORT MAP(RS1 => RFRA_A, RS2=> RFRA_B, RD_D =>RFWA,RD_WB => RFWA2,reserve=>reserve, free=>free, readA=>read_A,readB=>read_B,stall=>stall,Clock=>Clock);

  Stim : PROCESS
  VARIABLE L : LINE;
  VARIABLE rv,fv,rav,rbv,stv : std_ulogic;
  VARIABLE rfra,rfrb,rfw,rfw2 : std_ulogic_vector(4 DOWNTO 0);
  BEGIN
    Clock<='0';
    wait for 40 ns;
    readline(test_vectors, L);
    WHILE NOT endfile(test_vectors) LOOP
      readline(test_vectors, L);
      read(L,rfra);
      RFRA_A<=rfra;   
      read(L,rfrb);
      RFRA_B<=rfrb;
      read(L,rfw);
      RFWA<=rfw;
      read(L,rfw2);
      RFWA2<=rfw2;
      read(L,rv);
      reserve<=rv;
      read(L,fv);
      free<=fv;
      read(L,rav);
      read_A<=rav;
      read(L,rbv);
      read_B<=rbv;
      read(L,stv);
      stallv<=stv;
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
      ASSERT stall=stallv
        REPORT"ERROR stall " & to_string(vecno)
        SEVERITY WARNING;
      vecno <= vecno+1;
    END IF;
  END PROCESS;
END ARCHITECTURE Testbench;  