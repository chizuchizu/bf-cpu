`ifndef WAVEFORM_GENERATOR
`define WAVEFORM_GENERATOR

`include "../logicIC/logic_74HC00.sv"
`include "../logicIC/logic_74HC04.sv"
`include "../logicIC/logic_74HC74.sv"
`include "divider.sv"

module waveform_generator (
  input clk,
  input n_clr,

  output first_waveform,
  output second_waveform
);

wire [3:0] logic_74HC00_in1_1;
wire [3:0] logic_74HC00_in2_1;
wire [3:0] logic_74HC00_out_1;
logic_74HC00 logic_74HC00_1(
  .in1(logic_74HC00_in1_1),
  .in2(logic_74HC00_in2_1),
  .out(logic_74HC00_out_1)
);

wire [5:0] logic_74HC04_in_1;
wire [5:0] logic_74HC04_out_1;
logic_74HC04 logic_74HC04_1(
  .in(logic_74HC04_in_1),
  .out(logic_74HC04_out_1)
);

// first waveform
wire logic_74HC74_n_clr1_1;
wire logic_74HC74_n_pr1_1;
wire logic_74HC74_clk1_1;
wire logic_74HC74_in1_1;
wire logic_74HC74_out1_1;
wire logic_74HC74_n_out1_1;
// second waveform
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

wire divider_clk_1;
wire divider_n_clr_1;
wire divider_half_clk_1;
wire divider_quarter_clk_1;
divider divider_1(
  .clk(divider_clk_1),
  .n_clr(divider_n_clr_1),
  .half_clk(divider_half_clk_1),
  .quarter_clk(divider_quarter_clk_1)
);

assign first_waveform = logic_74HC74_out1_1;
assign second_waveform = logic_74HC74_out2_1;

assign divider_clk_1 = clk;
assign divider_n_clr_1 = n_clr;

assign logic_74HC04_in_1 = {5'b00000, divider_quarter_clk_1};

assign logic_74HC00_in1_1 = {2'b00, divider_half_clk_1, divider_half_clk_1};
assign logic_74HC00_in2_1 = {2'b00, logic_74HC04_out_1[0], divider_quarter_clk_1};

// first waveform
assign logic_74HC74_n_clr1_1 = 1'b1; 
assign logic_74HC74_n_pr1_1 = n_clr; 
assign logic_74HC74_clk1_1 = clk;
assign logic_74HC74_in1_1 = logic_74HC00_out_1[0];
// second waveform 
assign logic_74HC74_n_clr2_1 = 1'b1; 
assign logic_74HC74_n_pr2_1 = n_clr; 
assign logic_74HC74_clk2_1 = clk; 
assign logic_74HC74_in2_1 = logic_74HC00_out_1[1];

endmodule

`endif
