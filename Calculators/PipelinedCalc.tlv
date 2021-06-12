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
         // counter
         $count = $reset ? 0 : ( >>1$count + 1 );
         $valid = $count;
         $valid_reset = $valid || $reset;
      ?$valid_reset
         //  pipelined calc
         @1
            $in2[31:0] = $rand[3:0];

            $sum[31:0] = >>2$in1[31:0] + $in2[31:0];

            $sub[31:0] = >>2$in1[31:0] - $in2[31:0];

            $prod[31:0] = >>2$in1[31:0] * $in2[31:0];

            $div[31:0] = >>2$in1[31:0] / $in2[31:0];

            // The calculator
            // If reset then value is 0, else the diferrent operation
            // if op = 0 then in1 is equal to previous stored value.
         @2
            $in1[31:0] = 
                 $reset 
                 ? 0 : 
                 ($op[3:0] == 0) 
                   ? $sum : 
                 ($op == 1)
                   ? $sub : 
                 ($op == 2)
                   ? $prod : 
                 ($op == 3)
                   ? $div : 
                  ($op == 4)
                   ? >>1$mem : >>1$in1;
            $out[31:0] = $in1;
            
            $mem[31:0] =
                 $reset
                 ? 0 :
                 ($op == 5)
                  ? >>1$in1 : >>1$mem;

   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule
