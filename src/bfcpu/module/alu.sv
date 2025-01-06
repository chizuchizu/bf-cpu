`ifndef ALU
`define ALU

`include "../logicIC/logic_74HC04.sv"
`include "../logicIC/logic_74HC08.sv"
`include "../logicIC/logic_74HC283.sv"
`include "../logicIC/logic_74HC541.sv"

module alu(
  input [7:0] a,
  input nochange,
  input decrement,
  input increment,
  output [7:0] out
);

wire [3:0] and_in1_1;
wire [3:0] and_in2_1;
wire [3:0] and_out_1;
logic_74HC08 logic_74HC08_1(
    .in1(and_in1_1),
    .in2(and_in2_1),
    .out(and_out_1)
);

wire [5:0] not_in_1;
wire [5:0] not_out_1;
logic_74HC04 logic_74HC04_1(
    .in(not_in_1),
    .out(not_out_1)
);

wire tri_n_g1_1;
wire tri_n_g2_1;
wire [7:0] tri_in_1;
wire[7:0] tri_out_1;
logic_74HC541 logic_74HC541_1(
    .n_g1(tri_n_g1_1),
    .n_g2(tri_n_g2_1),
    .in(tri_in_1),
    .out(tri_out_1)
);

wire [3:0] sum_a_in_1;
wire [3:0] sum_b_in_1;
wire sum_c_in_1;
wire [3:0] sum_sum_out_1;
wire sum_c_out_1;
logic_74HC283 logic_74HC283_1(
    .a_in(sum_a_in_1),
    .b_in(sum_b_in_1),
    .c_in(sum_c_in_1),
    .sum_out(sum_sum_out_1),
    .c_out(sum_c_out_1)
);

wire [3:0] sum_a_in_2;
wire [3:0] sum_b_in_2;
wire sum_c_in_2;
wire [3:0] sum_sum_out_2;
wire sum_c_out_2;
logic_74HC283 logic_74HC283_2(
    .a_in(sum_a_in_2),
    .b_in(sum_b_in_2),
    .c_in(sum_c_in_2),
    .sum_out(sum_sum_out_2),
    .c_out(sum_c_out_2)
);


assign not_in_1[0] = decrement; // not_out[0] == ~decrement
assign not_in_1[1] = increment; // not_out[1] == ~increment

assign and_in1_1[0] = decrement;
assign and_in2_1[0] = increment; // and_out[0] == decrement & increment

assign and_in1_1[1] = and_out_1[0];
assign and_in2_1[1] = nochange; // and_out[1] == decrement & increment & nochange

assign sum_a_in_1 = a[3:0];
assign sum_a_in_2 = a[7:4];

assign sum_b_in_1 = {4{not_out_1[0]}};
assign sum_b_in_2 = {4{not_out_1[0]}};

assign sum_c_in_1 = not_out_1[1];
assign sum_c_in_2 = sum_c_out_1; // carry

assign tri_n_g1_1 = and_out_1[1];
assign tri_n_g2_1 = and_out_1[1];
assign tri_in_1 = {sum_sum_out_2, sum_sum_out_1};

assign out = tri_out_1;
endmodule

`endif
