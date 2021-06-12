\m4_TLV_version 1d: tl-x.org
\SV

   // =========================================
   // Welcome!  Try the tutorials via the menu.
   // =========================================

   // Default Makerchip TL-Verilog Code Template
   
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV
   |calc
      @1
         $reset = *reset;
         //  pipelined calc
         $in2[31:0] = $rand[3:0];
   
         $sum[31:0] = >>1$in1[31:0] + $in2[31:0];
   
         $sub[31:0] = >>1$in1[31:0] - $in2[31:0];
   
         $prod[31:0] = >>1$in1[31:0] * $in2[31:0];
   
         $div[31:0] = >>1$in1[31:0] / $in2[31:0];
         
         // The calculator
         // If reset then value is 0, else the diferrent operation
         // if op = 0 then in1 is equal to previous stored value.
         $in1[31:0] = 
              $reset 
              ? 0 : 
              $op[0] 
                ? $sum : 
              $op[1] 
                ? $sub : 
              $op[2] 
                ? $prod : 
              $op[3] 
                ? $div : >>1$in1;
         //$in1 = >>1$out;
         // counter
         $count = $reset ? 0 : ( >>1$count + 1 );

   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule
