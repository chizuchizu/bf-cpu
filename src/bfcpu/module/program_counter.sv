`ifndef PROGRAM_COUNTER
`define PROGRAM_COUNTER

`include "../logicIC/logic_74HC161.sv"
`include "switch.sv"

module program_counter (
  input clk,
  input clk_switch,
  input clk_manual,
  input n_clr,
  input n_pc_ld,
  input [7:0] in,

  output [7:0] out
);

wire logic_74HC161_clk_1;
wire logic_74HC161_n_rst_1;
wire logic_74HC161_n_ld_1;
wire logic_74HC161_enp_1;
wire logic_74HC161_ent_1;
wire [3:0] logic_74HC161_in_1;
wire [3:0] logic_74HC161_out_1;
wire logic_74HC161_co_1;
logic_74HC161 logic_74HC161_1(
  .clk(logic_74HC161_clk_1),
  .n_rst(logic_74HC161_n_rst_1),
  .n_ld(logic_74HC161_n_ld_1),
  .enp(logic_74HC161_enp_1),
  .ent(logic_74HC161_ent_1),
  .in(logic_74HC161_in_1),
  .out(logic_74HC161_out_1),
  .co(logic_74HC161_co_1)
);

wire logic_74HC161_clk_2;
wire logic_74HC161_n_rst_2;
wire logic_74HC161_n_ld_2;
wire logic_74HC161_enp_2;
wire logic_74HC161_ent_2;
wire [3:0] logic_74HC161_in_2;
wire [3:0] logic_74HC161_out_2;
wire logic_74HC161_co_2;
logic_74HC161 logic_74HC161_2(
  .clk(logic_74HC161_clk_2),
  .n_rst(logic_74HC161_n_rst_2),
  .n_ld(logic_74HC161_n_ld_2),
  .enp(logic_74HC161_enp_2),
  .ent(logic_74HC161_ent_2),
  .in(logic_74HC161_in_2),
  .out(logic_74HC161_out_2),
  .co(logic_74HC161_co_2)
);

wire switch_signal_1;
wire switch_in_1;
wire switch_out_1;
switch switch_1(
  .signal(switch_signal_1),
  .in(switch_in_1),
  .out(switch_out_1) 
);

wire counter_clk;

assign out = {logic_74HC161_out_2, logic_74HC161_out_1};

assign switch_signal_1 = clk_switch;
assign switch_in_1 = clk;

assign counter_clk = switch_out_1;
assign counter_clk = clk_manual; 

assign logic_74HC161_clk_1 = counter_clk;
assign logic_74HC161_n_rst_1 = n_clr;
assign logic_74HC161_n_ld_1 = n_pc_ld;
assign logic_74HC161_enp_1 = 1'b1;
assign logic_74HC161_ent_1 = 1'b1;
assign logic_74HC161_in_1 = in[3:0];

assign logic_74HC161_clk_2 = counter_clk;
assign logic_74HC161_n_rst_2 = n_clr;
assign logic_74HC161_n_ld_2 = n_pc_ld;
assign logic_74HC161_enp_2 = logic_74HC161_co_1;
assign logic_74HC161_ent_2 = 1'b1;
assign logic_74HC161_in_2 = in[7:4];

endmodule

`endif
