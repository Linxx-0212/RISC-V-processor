--
-- VHDL Entity cad_lib.Arbiter.arch_name
--
-- Created:
--          by - Xiaoxi Lin.UNKNOWN (DESKTOP-A0VSQRS)
--          at - 15:04:52 2019/04/ 4
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY Arbiter IS
  PORT( mdelay : OUT std_ulogic;
        delay  : OUT std_ulogic;
        write    : OUT std_ulogic;
        read    : OUT std_ulogic;
        del   : IN  std_ulogic;
        Add   : IN  std_ulogic_vector(31 DOWNTO 0);
        Add2  : IN  std_ulogic_vector(31 DOWNTO 0);
        Addout: OUT  std_ulogic_vector(31 DOWNTO 0);
        re  : IN  std_ulogic;
        we : IN  std_ulogic;
        fetch : IN  std_ulogic
        );
END ENTITY Arbiter;

ARCHITECTURE  Behavior of Arbiter IS
BEGIN
  PROCESS(re, we, fetch,Add,Add2,del)
  BEGIN
    IF(re = '1' or we = '1') and fetch = '1' THEN
      write <= we;
      read  <= re;
      Addout   <= Add;
      mdelay <= '1';
      delay <= del;
    ELSIF re = '1' or we = '1' THEN
      write <= we;
      read  <= re;
      Addout   <= Add;
      mdelay <= del;
      delay <= del;
    ELSIF fetch = '1' THEN
      write <= '0';
      read <= '1';
      Addout <= Add2;
      mdelay <= del;
      delay <= del;
    ELSE
      write <= '0';
      read <= '0';
      Addout <= (others => '0');
      mdelay <= del;
      delay <=del;
    END IF;
  END PROCESS;
END ARCHITECTURE Behavior;