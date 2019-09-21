--
-- VHDL Entity cad_lib.Test_bench_alu.arch_name
--
-- Created:
--          by - 34679.UNKNOWN (DESKTOP-13EGCCO)
--          at - 14:11:54 2019/03/18
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE std.textio.all;
USE work.Alu_op.all;

ENTITY Test_bench_alu IS
END ENTITY Test_bench_alu;

ARCHITECTURE Testbench of Test_bench_alu IS
  FILE test_vectors : text OPEN read_mode IS "D:\CAD\Alu-vec.txt";
  
  SIGNAL x, y, result, rltv : std_ulogic_vector(31 DOWNTO 0);
  SIGNAL operation : ALU_Op;
  SIGNAL Clock : std_ulogic;
  SIGNAL status,stav : std_ulogic;
  
  SIGNAL vecno : NATURAL := 0;
BEGIN
  Fetch : ENTITY work.ALU(behavior)
  PORT MAP(x => x, Y => y, operation => operation, result => result,Status => Status);
    
  Stim : PROCESS
  VARIABLE L : LINE;
  VARIABLE Xval, Yval, Reval : std_ulogic_vector(31 DOWNTO 0);
  VARIABLE Stval : std_ulogic;
  VARIABLE op : STRING(5 DOWNTO 1);
  BEGIN
    Clock<='0';
    wait for 80 ns;
    readline(test_vectors, L);
    WHILE NOT endfile(test_vectors) LOOP
      readline(test_vectors, L);
      read(L,op);
      operation<=Atype(op);
      read(L,Xval);
      x<=Xval;
      read(L,Yval);
      y<=Yval;
      read(L,Reval);
      rltv<=Reval;
      read(L,Stval);
      stav<=Stval;

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
      ASSERT result=rltv
        REPORT"ERROR RESULT " & to_string(vecno)
        SEVERITY WARNING;
      ASSERT status=stav
        REPORT"ERROR STATUS " & to_string(vecno)
        SEVERITY WARNING;
      vecno <= vecno+1;
    END IF;
  END PROCESS;
END ARCHITECTURE Testbench;  