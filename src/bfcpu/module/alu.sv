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

wire [3:0] and_in1;
wire [3:0] and_in2;
wire [3:0] and_out;
logic_74HC08 logic_74HC08_1(
    .and_in1,
    .and_in2,
    .and_out
);

wire [5:0] not_in;
wire [5:0] not_out;
logic_74HC04 logic_74HC04_1(
    .not_in,
    .not_out
);

wire tri_n_g1;
wire tri_n_g2;
wire [7:0] tri_in;
wire[7:0] tri_out;
logic_74HC541 logic_74HC541_1(
    .tri_n_g1,
    .tri_n_g2,
    .tri_in,
    .tri_out
);

wire [3:0] fa1_a_in;
wire [3:0] fa1_b_in;
wire fa1_c_in;
wire [3:0] fa1_sum_out;
wire fa1_c_out;
logic_74HC283 logic_74HC283_1(
    .fa1_a_in,
    .fa1_b_in,
    .fa1_c_in,
    .fa1_sum_out,
    .fa1_c_out
);

wire [3:0] fa2_a_in;
wire [3:0] fa2_b_in;
wire fa2_c_in;
wire [3:0] fa2_sum_out;
wire fa2_c_out;
logic_74HC283 logic_74HC283_2(
    .fa2_a_in,
    .fa2_b_in,
    .fa2_c_in,
    .fa2_sum_out,
    .fa2_c_out
);


assign not_in[0] = decrement; // not_out[0] == ~decrement
assign not_in[1] = increment; // not_out[1] == ~increment

assign and_in1[0] = decrement;
assign and_in2[0] = increment; // and_out[0] == decrement & increment

assign and_in1[1] = and_out[0];
assign and_in2[1] = nochange; // and_out[1] == decrement & increment & nochange

assign fa1_a_in = a[3:0];
assign fa2_a_in = a[7:4];

assign fa1_b_in = {4{not_out[0]}};
assign fa2_b_in = {4{not_out[0]}};

assign fa1_c_in = not_out[1];
assign fa2_c_in = fa1_c_out; // carry

assign tri_n_g1 = and_out[1];
assign tri_n_g2 = and_out[1];
assign tri_in = {fa1_sum_out, fa2_sum_out};

assign out = tri_out;
endmodule
