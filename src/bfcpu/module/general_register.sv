`ifndef GENERAL_REGISTER
`define GENERAL_REGISTER

`include "../logicIC/logic_74HC161.sv"

module general_register (
  input clk,
  input n_clr,
  input n_ld,
  input [7:0] in,

  output [7:0] out
);

wire cnt_clk_1;
wire cnt_n_rst_1;
wire cnt_n_ld_1;
wire cnt_enp_1;
wire cnt_ent_1;
wire [3:0] cnt_in_1;
wire [3:0] cnt_out_1;
wire cnt_co_1;
logic_74HC161 logic_74HC161_1(
  .clk(cnt_clk_1),
  .n_rst(cnt_n_clr_1),
  .n_ld(cnt_n_ld_1),
  .enp(cnt_enp_1),
  .ent(cnt_ent_1),
  .in(cnt_in_1),
  .out(cnt_out_1),
  .co(cnt_co_1)
);

wire cnt_clk_2;
wire cnt_n_rst_2;
wire cnt_n_ld_2;
wire cnt_enp_2;
wire cnt_ent_2;
wire [3:0] cnt_in_2;
wire [3:0] cnt_out_2;
wire cnt_co_2;
logic_74HC161 logic_74HC161_2(
  .clk(cnt_clk_2),
  .n_rst(cnt_n_clr_2),
  .n_ld(cnt_n_ld_2),
  .enp(cnt_enp_2),
  .ent(cnt_ent_2),
  .in(cnt_in_2),
  .out(cnt_out_2),
  .co(cnt_co_2)
);

assign cnt_clk_1 = clk;
assign cnt_clk_2 = clk;

assign cnt_n_clr_1 = n_clr;
assign cnt_n_clr_2 = n_clr;

assign cnt_n_ld_1 = n_ld;
assign cnt_n_ld_2 = n_ld;

assign cnt_enp_1 = 1'b0;
assign cnt_enp_2 = 1'b0;
assign cnt_ent_1 = 1'b0;
assign cnt_ent_2 = 1'b0;

assign cnt_in_1 = in[3:0];
assign cnt_in_2 = in[7:4];
assign out = {cnt_out_2, cnt_out_1};

endmodule

`endif
