LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

ENTITY Reg_tracker IS
  GENERIC(RegSel : POSITIVE := 5);
  PORT(Clock, Free : IN std_logic;
      RS1, RS2, RD_D, RD_WB: IN std_logic_vector(RegSel-1 DOWNTO 0);
      ReadA, ReadB, Reserve: IN std_logic;
      STALL,STALL_1,STALL_2,STALL3: OUT std_logic
      );
END ENTITY Reg_tracker;

--
ARCHITECTURE Behavior OF Reg_tracker IS
  TYPE RegNum IS ARRAY(0 TO (2**RegSel-1)) OF std_logic;
  SIGNAL RegNumber : RegNum ;
  --:= ('U', 'U', 'U', 'U', 'U','U', 'U', 'U', 'U', 'U', 'U', 'U', 'U','U', 'U', 'U',
  --'U', 'U', 'U', 'U', 'U','U', 'U', 'U','U', 'U', 'U', 'U', 'U','U', 'U', 'U');
  SIGNAL STALL_s : std_logic:='0';
BEGIN
  PROCESS(RS1, RS2, ReadA, ReadB, RD_D, Reserve, free)
  VARIABLE RS1_ID : NATURAL;
  VARIABLE RS2_ID : NATURAL;
  VARIABLE RD_ID : NATURAL;
  VARIABLE Flag1 : std_logic;
  VARIABLE Flag2 : std_logic;
  VARIABLE Flag_D : std_logic;
  VARIABLE STALL1, STALL2, STALL_D :std_logic;
  BEGIN
  STALL1 :='0';
  STALL2 :='0';
  STALL_D :='0';
  IF (ReadA = '1') THEN
    RS1_ID := To_Integer(unsigned(RS1));
    Flag1 := RegNumber(RS1_ID);
    IF (Flag1 = '1') THEN
      STALL1 := '1';
    END IF;
  ELSE
    STALL1 := '0';
  END IF;
  IF (ReadB = '1') THEN
    RS2_ID := To_Integer(unsigned(RS2));
    Flag2 := RegNumber(RS2_ID);
    IF (Flag2 = '1') THEN
      STALL2 := '1';
    END IF;
  ELSE
    STALL2 := '0';
  END IF;
  IF (Reserve = '1') THEN
    RD_ID := To_Integer(unsigned(RD_D));
    Flag_D := RegNumber(RD_ID);
    IF (Flag_D = '1') THEN
    STALL_D := '1';
    END IF;
  ELSE
    STALL_D := '0';
  END IF;
  STALL <= STALL1 OR STALL2 OR STALL_D;
  STALL_s <= STALL1 OR STALL2 OR STALL_D;
  STALL_1 <= STALl1;
  STALL_2 <= STALL2;
  STALL3 <= STALL_D;
  END PROCESS;

  PROCESS(Clock,reserve,free)
  VARIABLE InSelect : NATURAL;
  BEGIN
  IF (rising_edge(Clock) AND Reserve = '1') THEN
    IF (To_Integer(unsigned(RD_D)) /=0) THEN
      IF (STALL_s /= '1') THEN
      InSelect := To_Integer(unsigned(RD_D));
      RegNumber(InSelect) <= '1';
      END IF;
    END IF;
  END IF;
  
  IF (rising_edge(Clock) AND Free = '1') THEN
    InSelect := To_Integer(unsigned(RD_WB));
    RegNumber(InSelect) <= '0';
  END IF;
END PROCESS;
END ARCHITECTURE Behavior;

