// Stolen from: https://github.com/hoglet67/65c02_errata
// File ACIA_BRGEN.vhd translated with vhd2vl v3.0 VHDL to Verilog RTL translator
// vhd2vl settings:
//  * Verilog Module Declaration Style: 2001

// vhd2vl is Free (libre) Software:
//   Copyright (C) 2001 Vincenzo Liguori - Ocean Logic Pty Ltd
//     http://www.ocean-logic.com
//   Modifications Copyright (C) 2006 Mark Gonzales - PMC Sierra Inc
//   Modifications (C) 2010 Shankar Giri
//   Modifications Copyright (C) 2002-2017 Larry Doolittle
//     http://doolittle.icarus.com/~larry/vhd2vl/
//   Modifications (C) 2017 Rodrigo A. Melo
//
//   vhd2vl comes with ABSOLUTELY NO WARRANTY.  Always check the resulting
//   Verilog for correctness, ideally with a formal verification tool.
//
//   You are welcome to redistribute vhd2vl under certain conditions.
//   See the license (GPLv2) file included with the source for details.

// The result of translation follows.  Its copyright status should be
// considered unchanged from the original VHDL.

// no timescale needed

module ACIA_BRGEN #(parameter XTLI_FREQ = 1_843_200)
(
    input  wire       RESET,
    input  wire       XTLI,
    input  wire [3:0] R_SBR,
    output wire       BCLK
);

  reg [31:0] r_clk  = 0;
  reg        r_bclk = 1'b0;

  assign BCLK = (R_SBR == 4'b0000) ? XTLI : r_bclk;
  always @(posedge XTLI, negedge RESET) begin
    if((RESET == 1'b0)) begin
      r_clk <= 0;
      r_bclk <= 1'b0;
    end else begin
      if((r_clk == 0)) begin
        r_bclk <=  ~r_bclk;
        case(R_SBR)
        4'b0000 : begin
          r_clk <= 0;
        end
        4'b0001 : begin
          r_clk <= (XTLI_FREQ / (16 * 50) / 2) - 1;
        end
        4'b0010 : begin
          r_clk <= (XTLI_FREQ / (16 * 75) / 2) - 1;
        end
        4'b0011 : begin
          r_clk <= (XTLI_FREQ / (16 * 109) / 2) - 1;
        end
        4'b0100 : begin
          r_clk <= (XTLI_FREQ / (16 * 134) / 2) - 1;
        end
        4'b0101 : begin
          r_clk <= (XTLI_FREQ / (16 * 150) / 2) - 1;
        end
        4'b0110 : begin
          r_clk <= (XTLI_FREQ / (16 * 300) / 2) - 1;
        end
        4'b0111 : begin
          r_clk <= (XTLI_FREQ / (16 * 600) / 2) - 1;
        end
        4'b1000 : begin
          r_clk <= (XTLI_FREQ / (16 * 1200) / 2) - 1;
        end
        4'b1001 : begin
          r_clk <= (XTLI_FREQ / (16 * 1800) / 2) - 1;
        end
        4'b1010 : begin
          r_clk <= (XTLI_FREQ / (16 * 2400) / 2) - 1;
        end
        4'b1011 : begin
          r_clk <= (XTLI_FREQ / (16 * 3600) / 2) - 1;
        end
        4'b1100 : begin
          r_clk <= (XTLI_FREQ / (16 * 4800) / 2) - 1;
        end
        4'b1101 : begin
          r_clk <= (XTLI_FREQ / (16 * 7200) / 2) - 1;
        end
        4'b1110 : begin
          r_clk <= (XTLI_FREQ / (16 * 9600) / 2) - 1;
        end
        4'b1111 : begin
          r_clk <= (XTLI_FREQ / (16 * 19200) / 2) - 1;
        end
        default : begin
          r_clk <= 0;
        end
        endcase
      end
      else begin
        r_clk <= r_clk - 1;
      end
    end
  end

endmodule
