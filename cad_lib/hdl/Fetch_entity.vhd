--
-- VHDL Entity cad_lib.Fetch.arch_name
--
-- Created:
--          by - 34679.UNKNOWN (DESKTOP-13EGCCO)
--          at - 23:45:22 2019/02/ 2
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY Fetch_new IS
  PORT( Jaddr, Mdata  : IN std_ulogic_vector(31 DOWNTO 0);
        Address, Inst : OUT std_ulogic_vector(31 DOWNTO 0);
        Clock,  Jmp,  Reset,  Delay : IN std_ulogic;
        Read  : OUT std_ulogic);
END ENTITY Fetch_new;

ARCHITECTURE Behavior OF Fetch_new IS
  
SIGNAL PC : std_ulogic_vector(31 DOWNTO 0);

BEGIN
  PROCESS(Clock,Delay)
  BEGIN
    IF Delay = '0' THEN
      IF (rising_edge(Clock) AND Reset = '1') THEN
        PC <= (others => '0');
        Inst <= "00000000000000000000000000010011";
        Address <=PC;
        Read <= '0';
      ELSIF (rising_edge(Clock) AND Jmp = '1') THEN
        Address <= Jaddr;
        Inst <= "00000000000000000000000000010011";
        PC <= Jaddr;
        Read <= '0';
      ElSIF (rising_edge(Clock)) THEN
        Read <= '1';
        Inst <= Mdata;
        Address <= PC;
        PC <= std_ulogic_vector(UNSIGNED(PC)+4);
      END IF;
    ELSE
      Inst <= "00000000000000000000000000010011";
      Read <= '1';
      IF (rising_edge(Clock) AND Reset = '1') THEN
        PC <= (others => '0');
        Address <= PC;
        Read <= '0';
      END IF;
      IF (rising_edge(Clock) AND Jmp = '1') THEN
        Address <= Jaddr;
        PC <= Jaddr;
        Read <= '0';
      END IF;
    END IF;
  END PROCESS;
END Behavior;