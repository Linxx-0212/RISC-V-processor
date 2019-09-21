--
-- VHDL Entity cad_lib.Test_bench.arch_name
--
-- Created:
--          by - Xiaoxi Lin.UNKNOWN (DESKTOP-A0VSQRS)
--          at - 00:55:42 2019/02/15
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE std.textio.all;

ENTITY Test_bench IS
END ENTITY Test_bench;

ARCHITECTURE Testbench of Test_bench IS
  FILE test_vectors : text OPEN read_mode IS "D:\CAD\Fetch-vec.txt";
  
  SIGNAL Reset, Jmp, Delay,Clock,Readd,Readv : std_ulogic;
  SIGNAL Jaddr, Mdata, Address,Inst,Addv,Insv : std_ulogic_vector(31 DOWNTO 0);
  
  SIGNAL vecno : NATURAL := 0;
BEGIN
  Fetch : ENTITY work.Fetch_new(Structure)
  PORT MAP(Reset => Reset, Jmp=> Jmp, Delay => Delay, Clock =>Clock,Jaddr => Jaddr,Mdata=>Mdata, Address=>Address, Inst=>Inst,Read=>Readd);
    
  Stim : PROCESS
  VARIABLE L : LINE;
  VARIABLE Rval,Jval,Dval : std_ulogic;
  VARIABLE Jadval, Mdval, Addval, Insval : std_ulogic_vector(31 DOWNTO 0);
  VARIABLE Reval : std_ulogic;
  BEGIN
    Clock<='0';
    wait for 80 ns;
    readline(test_vectors, L);
    WHILE NOT endfile(test_vectors) LOOP
      readline(test_vectors, L);
      read(L,Rval);
      Reset<=Rval;
      read(L,Jval);
      Jmp<=Jval;
      read(L,Dval);
      Delay<=Dval;
      read(L,Jadval);
      Jaddr<=Jadval;
      read(L,Mdval);
      Mdata<=Mdval;
      read(L,Addval);
      Addv<=Addval;
      read(L,Insval);
      Insv<=Insval;
      read(L,Reval);
      Readv<=Reval;
      wait for 20 ns;
      Clock<='1';
      wait for 100 ns;
      Clock<='0';
      wait for 80 ns;
    END LOOP;
    report "END of Testbench.";
  END PROCESS;
  Check : PROCESS(Clock)
  BEGIN
    IF (falling_edge(Clock)) THEN
      ASSERT Address=Addv
        REPORT"ERROR Addrss " & to_string(vecno)
        SEVERITY WARNING;
      ASSERT Inst=Insv
        REPORT"ERROR Instrction " & to_string(vecno)
        SEVERITY WARNING;
      ASSERT Readd=Readv
        REPORT"ERROR Read " & to_string(vecno)
        SEVERITY WARNING;
  
      vecno <= vecno+1;
    END IF;
  END PROCESS;
END ARCHITECTURE Testbench;  