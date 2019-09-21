--
-- VHDL Entity cad_lib.We_controller.arch_name
--
-- Created:
--          by - Xiaoxi Lin.UNKNOWN (DESKTOP-A0VSQRS)
--          at - 14:25:41 2019/04/ 4
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.RV32I.all;

ENTITY We_controller IS
  PORT( write : OUT std_ulogic;
		Rd 	  : IN 	std_ulogic_vector(4 DOWNTO 0);
		Rdout : OUT std_ulogic_vector(4 DOWNTO 0);
        Fun   : IN  RV32I_Op);
  
END ENTITY We_controller;

ARCHITECTURE Behavior OF We_controller IS
BEGIN
  
  PROCESS(Fun,Rd)
  BEGIN
    
    CASE Fun IS
      WHEN SB|SH|SW|BEQ|BNE|BLT|BGE|BLTU|BGEU|NOP =>
        write <= '0';
        Rdout <= "00000";
      WHEN others =>
		IF Rd = "00000" THEN
			write <= '0';
			Rdout <="00000";
		ELSE
			write <= '1';
			Rdout <= Rd;
		END IF;
    END CASE;  
  END PROCESS;
END ARCHITECTURE Behavior;