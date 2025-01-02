`include "../logicIC/logic_74HC161.sv"

module general_register (
  input clk,
  input n_clr,
  input n_ld,
  input [7:0] in,

  output [7:0] out
);

wire co;

wire [3:0] in1;
wire [3:0] out1;
logic_74HC161 logic_74HC161_1(
  .clk,
  .n_rst(n_clr),
  .n_ld,
  .enp(1'b0),
  .ent(1'b0),
  .in(in1),
  .out(out1),
  .co
);

wire [3:0] in2;
wire [3:0] out2;
logic_74HC161 logic_74HC161_2(
  .clk,
  .n_rst(n_clr),
  .n_ld,
  .enp(1'b0),
  .ent(1'b0),
  .in(in2),
  .out(out2),
  .co
);

assign in1 = in[3:0];
assign in2 = in[7:4];
assign out = {out2, out1};

endmodule
