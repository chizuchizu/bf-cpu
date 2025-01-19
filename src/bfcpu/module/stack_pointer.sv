`ifndef STACK_POINTER
`define STACK_POINTER

`include "general_register.sv"
`include "zero_detector.sv"

module stack_pointer (
  input clk,
  input n_clr,
  input reg_sp,
  input reg_np,
  input sp_gate,
  input [7:0] in,

  output [7:0] out,
  output detect_0
);

endmodule

`endif
