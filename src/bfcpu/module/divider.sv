`ifndef DIVIDER
`define DIVIDER

`include "../logicIC/logic_74HC74.sv"

module divider (
  input clk,
  input n_clr,

  output half_clk,
  output quarter_clk
);

// half_clk
wire logic_74HC74_n_clr1_1;
wire logic_74HC74_n_pr1_1;
wire logic_74HC74_clk1_1;
wire logic_74HC74_in1_1;
wire logic_74HC74_out1_1;
wire logic_74HC74_n_out1_1;
// quarter_clk
wire logic_74HC74_n_clr2_1;
wire logic_74HC74_n_pr2_1;
wire logic_74HC74_clk2_1;
wire logic_74HC74_in2_1;
wire logic_74HC74_out2_1;
wire logic_74HC74_n_out2_1;
logic_74HC74 logic_74HC74_1(
  .n_clr1(logic_74HC74_n_clr1_1),
  .n_pr1(logic_74HC74_n_pr1_1),
  .clk1(logic_74HC74_clk1_1),
  .in1(logic_74HC74_in1_1),
  .out1(logic_74HC74_out1_1),
  .n_out1(logic_74HC74_n_out1_1),
  .n_clr2(logic_74HC74_n_clr2_1),
  .n_pr2(logic_74HC74_n_pr2_1),
  .clk2(logic_74HC74_clk2_1),
  .in2(logic_74HC74_in2_1),
  .out2(logic_74HC74_out2_1),
  .n_out2(logic_74HC74_n_out2_1)
);

assign half_clk = logic_74HC74_out1_1;
assign quarter_clk = logic_74HC74_out2_1;

// half_clk
assign logic_74HC74_n_clr1_1 = n_clr;
assign logic_74HC74_n_pr1_1 = 1'b1;
assign logic_74HC74_clk1_1 = clk;
assign logic_74HC74_in1_1 = logic_74HC74_n_out1_1;
// quarter_clk
assign logic_74HC74_n_clr2_1 = n_clr;
assign logic_74HC74_n_pr2_1 = 1'b1;
assign logic_74HC74_clk2_1 = logic_74HC74_out1_1;
assign logic_74HC74_in2_1 = logic_74HC74_n_out2_1;

endmodule

`endif
