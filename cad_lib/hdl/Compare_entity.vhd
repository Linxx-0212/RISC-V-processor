--
-- VHDL Entity cad_lib.Compare.arch_name
--
-- Created:
--          by - 34679.UNKNOWN (DESKTOP-13EGCCO)
--          at - 02:35:02 2019/03/29
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY Compare IS
  PORT(Left, Right : IN std_ulogic_vector(31 DOWNTO 0);
       EQ, GL_s, GL_U: OUT std_ulogic
     );
END ENTITY Compare;

ARCHITECTURE behavior of Compare IS
BEGIN
  PROCESS(Left, Right)
  VARIABLE Left_s, Right_s : SIGNED(31 DOWNTO 0);
  VARIABLE Left_u, RIGHT_U : UNSIGNED(31 DOWNTO 0);
  VARIABLE EQ_v, GL_sv, GL_uv: std_ulogic;
  BEGIN
    Left_s := signed(Left);
    Right_s := signed(Right);
    Left_u := unsigned(Left);
    Right_u := unsigned(Right);
    
    IF Left = RIGHT THEN
      EQ_v := '1';
    ELSE
      EQ_v := '0';
    END IF;
    
    IF Left_s < Right_s THEN
      GL_sv := '1';
    ELSE
      GL_SV := '0';
    END IF;
    
    IF Left_u <Right_u THEN
      GL_uv := '1';
    ELSE
      GL_uv := '0';
    END IF;
    
    EQ <= EQ_v;
    GL_s <= GL_sv;
    GL_u <= GL_uv;
  END PROCESS;
END ARCHITECTURE behavior;
