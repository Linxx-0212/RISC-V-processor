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

ENTITY Test_bench_execute IS
END ENTITY Test_bench_execute;

ARCHITECTURE Testbench of Test_bench_execute IS
  FILE test_vectors : text OPEN read_mode IS "D:\CAD\Ex_vec.txt";
  
  SIGNAL Funct,Func,Funv : RV32I_Op;
  SIGNAL RD,Rd_o,Rdv: std_ulogic_vector(4 DOWNTO 0);
  SIGNAL LEFT,RIGHT,EXTRA : std_ulogic_vector(31 DOWNTO 0);
  SIGNAL Data,Address,Datav,Addressv : std_ulogic_vector(31 DOWNTO 0);
  SIGNAL Jump,Jmpv,stall : std_ulogic;
  SIGNAL Jaddr,Jaddrv : std_ulogic_vector(31 DOWNTO 0);
  SIGNAL Clock : std_ulogic;
  
  SIGNAL vecno : NATURAL := 0;
BEGIN
  Decoder : ENTITY work.Execute_stage(structure)
  PORT MAP(LEFT => LEFT, RIGHT=> RIGHT, EXTRA=>EXTRA, RD =>RD,Func => Func,Jaddr => Jaddr, Address=>Address, DATA=>Data, Dreg=>RD_o, Func_out2=>Funct,Jump => Jump,stall => stall,Clk=>Clock);

  Stim : PROCESS
  VARIABLE L : LINE;
  VARIABLE Lv,Rv,Ev,Jav : std_ulogic_vector(31 DOWNTO 0);
  VARIABLE Fun,Funo : String(1 TO 5);
  VARIABLE D,D_o: std_ulogic_vector(4 DOWNTO 0);
  VARIABLE Adv,Dav: std_ulogic_vector(31 DOWNTO 0);
  VARIABLE Jmv ,stallv: std_ulogic;
  BEGIN
    Clock<='0';
    wait for 40 ns;
    readline(test_vectors, L);
    WHILE NOT endfile(test_vectors) LOOP
      readline(test_vectors, L);
      read(L,Fun);
      Func<=Ftype(Fun);    
      read(L,Lv);
      LEFT<=Lv;
      read(L,Rv);
      RIGHT<=Rv;
      read(L,Ev);
      EXTRA<=Ev;
      read(L,D);
      RD<=D;
      read(L,Dav);
      Datav<=Dav;
      read(L,Adv);
      Addressv<=Adv;
      read(L,Jmv);
      Jmpv<=Jmv;
      read(L,Jav);
      Jaddrv<=Jav;
      read(L,D_o);
      Rdv<=D_o;
      read(L,stallv);
      stall<=stallv;
      read(L,Funo);
      Funv<=Ftype(Funo);
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
      ASSERT Func=Funct
        REPORT"ERROR Fun " & to_string(vecno)
        SEVERITY WARNING;
      ASSERT Data=Datav
        REPORT"ERROR Data " & to_string(vecno)
        SEVERITY WARNING;
      ASSERT Address=Addressv
        REPORT"ERROR Address " & to_string(vecno)
        SEVERITY WARNING;
      ASSERT Jump=Jmpv
        REPORT"ERROR Jump " & to_string(vecno)
        SEVERITY WARNING;
      ASSERT Jaddrv=Jaddr
        REPORT"ERROR Jaddr " & to_string(vecno)
        SEVERITY WARNING;
      ASSERT Rd_o = Rdv
        REPORT"ERROR Rd " & to_string(vecno)
        SEVERITY WARNING;
      vecno <= vecno+1;
    END IF;
  END PROCESS;
END ARCHITECTURE Testbench;  
