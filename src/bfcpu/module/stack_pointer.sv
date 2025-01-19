`ifndef STACK_POINTER
`define STACK_POINTER

`include "../logicIC/logic_74HC541.sv"
`include "general_register.sv"
`include "equal_detector.sv"

module stack_pointer (
  input clk,
  input n_clr,
  input reg_sp,
  input reg_np,
  input sp_gate,
  input [7:0] in,

  output [7:0] out,
  output detect_equal
);

wire tri_n_g1_1;
wire tri_n_g2_1;
wire [7:0] tri_in_1;
wire [7:0] tri_out_1;
logic_74HC541 logic_74HC541_1(
  .n_g1(tri_n_g1_1),
  .n_g2(tri_n_g2_1),
  .in(tri_in_1),
  .out(tri_out_1)
);

wire greg_clk_1;
wire greg_n_clr_1;
wire greg_n_ld_1;
wire [7:0] greg_in_1;
wire [7:0] greg_out_1; 
general_register general_register_1( //stack pointer
  .clk(greg_clk_1),
  .n_clr(greg_n_clr_1),
  .n_ld(greg_n_ld_1),
  .in(greg_in_1),
  .out(greg_out_1)
);

wire greg_clk_2;
wire greg_n_clr_2;
wire greg_n_ld_2;
wire [7:0] greg_in_2;
wire [7:0] greg_out_2; 
general_register general_register_2( //nest pointer
  .clk(greg_clk_2),
  .n_clr(greg_n_clr_2),
  .n_ld(greg_n_ld_2),
  .in(greg_in_2),
  .out(greg_out_2)
);

wire [7:0] edct_in1_1;
wire [7:0] edct_in2_1;
wire edct_out_1;
equal_detector equal_detector_1(
  .in1(edct_in1_1),
  .in2(edct_in2_1),
  .out(edct_out_1)
);

assign greg_clk_1 = clk;
assign greg_clk_2 = clk;

assign greg_n_clr_1 = n_clr;
assign greg_n_clr_2 = n_clr;

assign greg_n_ld_1 = reg_sp;

assign greg_n_ld_2 = reg_np;

assign greg_in_1 = in;

assign tri_n_g1_1 = 1'b0;
assign tri_n_g2_1 = sp_gate;
assign tri_in_1 = greg_out_1;
assign out = tri_out_1;

assign greg_in_2 = greg_out_1;

assign edct_in1_1 = greg_out_1;
assign edct_in2_1 = greg_out_2;

assign detect_equal = edct_out_1;

endmodule

`endif
