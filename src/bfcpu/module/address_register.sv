`ifndef ADDRESS_REGISTER
`define ADDRESS_REGISTER

`include "general_register.sv"
`include "../logicIC/logic_74HC541.sv"

module address_register (
  input clk,
  input n_clr,
  input n_adr_gate,
  input n_adr_ld,
  input [7:0] in,

  output [7:0] addr_out,
  output [7:0] out
);

wire general_register_clk_1;
wire general_register_n_clr_1;
wire general_register_n_ld_1;
wire [7:0] general_register_in_1;
wire [7:0] general_register_out_1;
general_register general_register_1(
  .clk(general_register_clk_1),
  .n_clr(general_register_n_clr_1),
  .n_ld(general_register_n_ld_1),
  .in(general_register_in_1),
  .out(general_register_out_1)
);

wire logic_74HC541_n_g1_1;
wire logic_74HC541_n_g2_1;
wire [7:0] logic_74HC541_in_1;
wire [7:0] logic_74HC541_out_1;
logic_74HC541 logic_74HC541_1(
  .n_g1(logic_74HC541_n_g1_1),
  .n_g2(logic_74HC541_n_g2_1),
  .in(logic_74HC541_in_1),
  .out(logic_74HC541_out_1) 
);

assign out = logic_74HC541_out_1;
assign addr_out = general_register_out_1;

assign general_register_clk_1 = clk;
assign general_register_n_clr_1 = n_clr;
assign general_register_n_ld_1 = n_adr_ld;
assign general_register_in_1 = in;

assign logic_74HC541_n_g1_1 = n_adr_gate; 
assign logic_74HC541_n_g2_1 = 1'b0;
assign logic_74HC541_in_1 = general_register_out_1;

endmodule

`endif
