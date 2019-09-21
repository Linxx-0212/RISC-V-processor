--
-- VHDL Entity cad_lib.ALU.arch_name
--
-- Created:
--          by - 34679.UNKNOWN (DESKTOP-13EGCCO)
--          at - 13:30:43 2019/03/18
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.Alu_op.all;

ENTITY ALU IS
  PORT(   x,y       : IN  std_ulogic_vector(31 DOWNTO 0);
          result    : OUT std_ulogic_vector(31 DOWNTO 0);
          operation : IN ALU_Op;
          status : OUT std_ulogic);
END ENTITY ALU;




ARCHITECTURE behavior of ALU IS

BEGIN
    PROCESS(x, y, operation)
    Variable res : std_logic_vector(31 DOWNTO 0);
    BEGIN
      CASE operation is
        WHEN aADD =>
          res := std_logic_vector(unsigned(x) + unsigned(y));
        WHEN aSUB =>
          res := std_logic_vector(unsigned(x) - unsigned(y));
        WHEN aAND =>
          res := x and y;
        WHEN aOR =>
          res := x or y;
        WHEN aXOR =>
          res := x xor y;
        WHEN aSL => 
          res := std_logic_vector(shift_left(unsigned(x), to_integer(unsigned(y(4 DOWNTO 0)))));
        WHEN aSRL =>
          res := std_logic_vector(shift_right(unsigned(x), to_integer(unsigned(y(4 DOWNTO 0)))));
        WHEN aSRA =>
          res := std_logic_vector(shift_right(signed(x), to_integer(unsigned(y(4 DOWNTO 0)))));
        WHEN others =>
          res := (others =>'0');
      END CASE;
      IF res = "00000000000000000000000000000000" THEN
        status <= '1';
      ELSE
        status <= '0';
      END IF;
      result <= res;
    END PROCESS;
END ARCHITECTURE;
          