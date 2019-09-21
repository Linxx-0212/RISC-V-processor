--
-- VHDL Entity cad_lib.Me_controller.arch_name
--
-- Created:
--          by - Xiaoxi Lin.UNKNOWN (DESKTOP-A0VSQRS)
--          at - 11:01:45 2019/04/ 4
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.RV32I.all;

ENTITY Me_controller IS
  PORT( Fun : IN  RV32I_Op;
        Delay : IN std_ulogic;
        Me_ctrl : OUT std_ulogic_vector(1 DOWNTO 0);
        Read :OUT std_ulogic;
        Write :OUT std_ulogic;
        stall    :OUT std_ulogic);
END ENTITY Me_controller;

ARCHITECTURE  Behavior  OF  Me_controller IS
BEGIN
  
  PROCESS(Fun)
  BEGIN
    IF  Delay = '1' THEN
      Stall <= '1';
    ELSE
      Stall <= '0';
    END IF;
    CASE Fun IS
      WHEN  SB =>
        Me_ctrl <= "00";
        Read <= '0';
        Write <= '1';
      WHEN  SH =>
        Me_ctrl <= "01";
        Read <= '0';
        Write <= '1';
      WHEN  SW =>
        Me_ctrl <= "10";
        Read <= '0';
        Write <= '1';
      WHEN  LB => 
        Me_ctrl <= "00";
        Read <= '1';
        Write <= '0';
      WHEN  LH =>
        Me_ctrl <= "01";
        Read <= '1';
        Write <= '0';
      WHEN  LW =>
        Me_ctrl <= "10";
        Read <= '1';
        Write <= '0';
      WHEN  LBU =>
        Me_ctrl <= "00";
        Read <= '1';
        Write <= '0';
      WHEN  LHU =>
        Me_ctrl <= "01";
        Read <= '1';
        Write <= '0';
      WHEN  OTHERS =>
        Me_ctrl <= "11";
        Read <= '0';
        Write <= '0';
    END CASE;
  END PROCESS;
END ARCHITECTURE Behavior;