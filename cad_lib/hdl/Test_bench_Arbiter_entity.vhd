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

ENTITY Test_bench_Arbiter IS
END ENTITY Test_bench_Arbiter;

ARCHITECTURE Testbench of Test_bench_Arbiter IS
  FILE test_vectors : text OPEN read_mode IS "D:\CAD\Arbiter_vec.txt";
  

  SIGNAL Clock : std_ulogic;
  SIGNAL vecno : NATURAL := 0;
  SIGNAL mdelay,mdelayv,delay,delayv,we,wev,re,rev :  std_ulogic;
  SIGNAL del,rd,write,fetch : std_ulogic;
  SIGNAL Add,Add2,Addout,Addv : std_ulogic_vector(31 DOWNTO 0);
BEGIN
  Arbiter : ENTITY work.Arbiter(Behavior)
  PORT MAP(mdelay => mdelay, delay=> delay, we =>write,re => rd,del=>del, Add=>Add, Add2=>Add2,Addout=>Addout,read=>re,write => we,fetch => fetch);

  Stim : PROCESS
  VARIABLE L : LINE;
  VARIABLE md,delv,readv,w,fetchv,dv,rdv,wrv : std_ulogic;
  VARIABLE Ad,Ad2,Addr : std_ulogic_vector(31 DOWNTO 0);
  BEGIN
    Clock<='0';
    wait for 40 ns;
    readline(test_vectors, L);
    WHILE NOT endfile(test_vectors) LOOP
      readline(test_vectors, L);
      read(L,delv);
      del<=delv;   
      read(L,Ad);
      Add<=Ad;
      read(L,Ad2);
      Add2<=Ad2;
      read(L,readv);
      rd<=readv;
      read(L,w);
      write<=w;
      read(L,fetchv);
      fetch<=fetchv;
      read(L,md);
      mdelayv<=md;
      read(L,dv);
      delayv<=dv;
      read(L,rdv);
      rev<=rdv;
      read(L,wrv);
      wev<=wrv;
      read(L,Addr);
      Addv<=Addr;
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
      ASSERT Addout=Addv
        REPORT"ERROR Address " & to_string(vecno)
        SEVERITY WARNING;
      ASSERT mdelay=mdelayv
        REPORT"ERROR mdelay " & to_string(vecno)
        SEVERITY WARNING;
      ASSERT delay=delayv
        REPORT"ERROR fdelay " & to_string(vecno)
        SEVERITY WARNING;
      vecno <= vecno+1;
    END IF;
  END PROCESS;
END ARCHITECTURE Testbench;  
