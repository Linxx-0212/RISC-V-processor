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

ENTITY Test_bench_memory IS
END ENTITY Test_bench_memory;

ARCHITECTURE Testbench of Test_bench_memory IS
  FILE test_vectors : text OPEN read_mode IS "D:\CAD\Me_vec.txt";
  
  SIGNAL Funct,Func,Funv : RV32I_Op;
  SIGNAL RD,Rd_o,Rdv: std_ulogic_vector(4 DOWNTO 0);
  SIGNAL mData,Data : std_ulogic_vector(31 DOWNTO 0);
  SIGNAL Add  : std_ulogic_vector(31 DOWNTO 0);
  SIGNAL Data_o,Addout,Datav,Addressv : std_ulogic_vector(31 DOWNTO 0);
  SIGNAL Data_o2,Data2v : std_ulogic_vector(31 DOWNTO 0);
  SIGNAL Stall,Stallv : std_ulogic;
  SIGNAL Delay : std_ulogic;
  SIGNAL Clock : std_ulogic;
  SIGNAL Reado, Write, Readv, Writev : std_ulogic;
  SIGNAL Me_ctrl, Mev : std_ulogic_vector(1 DOWNTO 0);
  
  SIGNAL vecno : NATURAL := 0;
BEGIN
  Memory : ENTITY work.Memory_stage(structure)
  PORT MAP(Data=>Data, Reg_d =>RD,Fun_IN => Func, Address=>add,Add_out => Addout,Data_out => Data_o, Data_m=>mData, Data_out2 =>Data_o2, Reg_out=>RD_o, Fun_out=>Funct,stall => Stall, Read => Reado, Write => Write, Delay => Delay,Me_ctrl => Me_ctrl,Clk=>Clock);

  Stim : PROCESS
  VARIABLE L : LINE;
  VARIABLE Fun,Funo : String(1 TO 5);
  VARIABLE D,D_o: std_ulogic_vector(4 DOWNTO 0);
  VARIABLE Adv,Dav,Datain,Addo,memData,wrData: std_ulogic_vector(31 DOWNTO 0);
  VARIABLE meread,mewrite,sta,dev : std_ulogic;
  VARIABLE word: std_ulogic_vector(1 DOWNTO 0);
  BEGIN
    Clock<='0';
    wait for 40 ns;
    readline(test_vectors, L);
    WHILE NOT endfile(test_vectors) LOOP
      readline(test_vectors, L);
      read(L,Fun);
      Func<=Ftype(Fun);    
      read(L,Dav);
      Data<=Dav;
      read(L,Adv);
      Add<=Adv;
      read(L,D);
      RD<=D;
      read(L,Datain);
      mData<=Datain;
      read(L,dev);
      Delay<=dev;
      read(L,Addo);
      Addressv<=Addo;
      read(L,memData);
      Datav<=memData;
      read(L,word);
      Mev<=word;
      read(L,meread);
      Readv<=meread;
      read(L,mewrite);
      Writev<=mewrite;
      read(L,wrData);
      Data2v<=wrData;
      read(L,D_o);
      Rdv<=D_o;
      read(L,sta);
      Stallv<=sta;

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
      ASSERT Addout=Addressv
        REPORT"ERROR Address " & to_string(vecno)
        SEVERITY WARNING;
      ASSERT Me_ctrl=Mev
        REPORT"ERROR Word Size " & to_string(vecno)
        SEVERITY WARNING;
      ASSERT Reado=Readv
        REPORT"ERROR Read " & to_string(vecno)
        SEVERITY WARNING;
      ASSERT Write = Writev
        REPORT"ERROR Write " & to_string(vecno)
        SEVERITY WARNING;
      ASSERT Rd_o = Rdv
        REPORT"ERROR Rd " & to_string(vecno)
        SEVERITY WARNING;
      ASSERT Stall = Stallv
        REPORT"ERROR Stall " & to_string(vecno)
        SEVERITY WARNING;
      ASSERT Data_o2 = Data2v
        REPORT"ERROR writeData " & to_string(vecno)
        SEVERITY WARNING;
      vecno <= vecno+1;
    END IF;
  END PROCESS;
END ARCHITECTURE Testbench;  
