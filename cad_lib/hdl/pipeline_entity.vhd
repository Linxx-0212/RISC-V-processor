--
-- VHDL Entity cad_lib.pipeline.arch_name
--
-- Created:
--          by - 34679.UNKNOWN (DESKTOP-13EGCCO)
--          at - 16:27:17 2019/04/20
--
-- using Mentor Graphics HDL Designer(TM) 2015.1b (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.RV32I.all;

ENTITY pipeline IS
  PORT( 
      clock,Reset : IN std_ulogic;
      re,stall_1,stall_2,stall_3 : OUT std_ulogic
      );
END ENTITY pipeline;

ARCHITECTURE Structure OF pipeline IS
  SIGNAL Addrin, DataIn,Adde,Datae,Addf,Addm: std_ulogic_vector(31 DOWNTO 0);
  SIGNAL we,rs1v,rs2v,rdv,m_fetch,m_re,m_we,Jmp: std_ulogic;
  SIGNAL mdelay,delayf,delaym,free,stall,stall2 : std_ulogic;
  SIGNAL Jaddr,Dataout,Inst,rs1D,rs2D,left,right,extra,Data_m,Data_w: std_ulogic_vector(31 DOWNTO 0);
  SIGNAL Fund,Fune,Funm: RV32I_Op;
  SIGNAL rs1_d,rs2_d,r_d,r_e,r_m,Rd_wb: std_ulogic_vector(4 DOWNTO 0);
BEGIN
    Memory: ENTITY work.MemorySystem(Behavior)
    PORT MAP( Addr => Addrin, DataIn => DataIn, clock => clock, we => we, re => re, mdelay => mdelay, Dataout => Dataout);
    
    Arbiter: ENTITY work.Arbiter(Behavior)
    PORT MAP(mdelay => delayf, delay => delaym, write => we, read => re, del => mdelay,Add => Addm, Add2 => Addf, Addout => Addrin, fetch => m_fetch, re => m_re, we => m_we);
    
    Fetch: ENTITY work.Fetch_new(Structure)
    PORT MAP (Jaddr => Jaddr, Mdata => Dataout, Address => Addf, Inst=> Inst, Clock=>clock, Jmp=> Jmp, Reset => Reset, Delay => delayf, Stall => Stall or Stall2, Read=> m_fetch);
    
    Decoder: ENTITY work.Decoder_stage(Structure)
    PORT MAP(instruction => inst, Functout => Fund, RS1 => rs1_d,RS2=>rs2_d,RD => r_d, RS1D => rs1D, RS2D => rs2D,LEFT=> left, right => right, extra => extra,rs1v => rs1v, rs2v=>rs2v,rdv=>rdv,stall => stall2);
      
    Execute : ENTITY work.Execute_stage(Structure)
    PORT MAP(LEFT => right, RIGHT => left, EXTRA => extra,PC=>Addf, RD => r_d, Func => Fund, Jaddr =>Jaddr, Address => Adde, Data => Datae, Dreg => r_e,Func_out=>Fune,Jump => Jmp, Clk => clock,stall => stall);
    
    Memorystage : ENTITY work.Memory_stage(Structure)
    PORT MAP(Data => Datae, Data_m => Dataout, Address => Adde, Reg_d => r_e, Add_out => Addm, Data_out => DataIn, Data_out2 => Data_m, Reg_out => r_m,Fun_out => Funm, Fun_IN => fune, Read => m_re, Write => m_we, Delay => delaym, stall => stall,Clk => Clock);
    
    Write : ENTITY work.Write_stage(Structure)
    PORT MAP(Data => Data_m, Rd => r_m,Fun => Funm, Data_out => Data_w,Rd_out => Rd_wb, write => free, Clk=>Clock);
    
    Tracker :ENTITY work.Reg_tracker(Behavior)
    PORT MAP(Clock=>Clock, Free => free, RS1 => rs1_d, RS2 => rs2_d, Rd_D => r_d, RD_WB => Rd_wb, ReadA => rs1v, ReadB =>rs2v, Reserve => rdv,Stall => stall2 ,stall_1 =>Stall_1,stall_2 => stall_2,stall3 =>stall_3);
      
    Regfile :ENTITY work.RegisterFile(Structure)
    PORT MAP(D => Data_w, Qr => rs1D, Qr2 => rs2D, ReadSel => rs1_d,  ReadSel2 => rs2_d, WriteSel => Rd_wb, Clock =>clock, Load => free, Read1 => rs1v,Read2 => rs2v);
    
END ARCHITECTURE structure;