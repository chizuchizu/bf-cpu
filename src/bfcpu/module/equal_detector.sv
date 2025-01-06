`include "../logicIC/logic_74HC04.sv"
`include "../logicIC/logic_74HC283.sv"
`include "../logicIC/logic_74HC02.sv"
`include "../logicIC/logic_74HC08.sv"

module equal_detector (
  input [7:0] in1,
  input [7:0] in2,

  output out
);

wire [5:0] not_in_1;
wire [5:0] not_out_1;
logic_74HC04 logic_74HC04_1(
  .in(not_in_1),
  .out(not_out_1)
);

wire [5:0] not_in_2;
wire [5:0] not_out_2;
logic_74HC04 logic_74HC04_2(
  .in(not_in_2),
  .out(not_out_2)
);

wire [3:0] sum_a_in_1;
wire [3:0] sum_b_in_1;
wire [3:0] sum_out_1;
wire sum_c_in_1;
wire sum_c_out_1;
logic_74HC283 logic_74HC283_1(
  .a_in(sum_a_in_1),
  .b_in(sum_b_in_1),
  .c_in(sum_c_in_1),
  .sum_out(sum_out_1),
  .c_out(sum_c_out_1)
);

wire [3:0] sum_a_in_2;
wire [3:0] sum_b_in_2;
wire [3:0] sum_out_2;
wire sum_c_in_2;
wire sum_c_out_2;
logic_74HC283 logic_74HC283_2(
  .a_in(sum_a_in_2),
  .b_in(sum_b_in_2),
  .c_in(sum_c_out_1),
  .sum_out(sum_out_2),
  .c_out(sum_c_out_2)
);

wire [3:0] nor_in1;
wire [3:0] nor_in2;
wire [3:0] nor_out;
logic_74HC02 logic_74HC02_1(
  .in1(nor_in1),
  .in2(nor_in2),
  .out(nor_out)
);

wire [3:0] and_in1;
wire [3:0] and_in2;
wire [3:0] and_out;
logic_74HC08 logic_74HC08_1(
  .in1(and_in1),
  .in2(and_in2),
  .out(and_out)
);

assign not_in_1[3:0] = in1[3:0];
assign not_in_2[3:0] = in1[7:4];

assign sum_c_in_1 = 1'b1;
assign sum_a_in_1 = not_out_1;
assign sum_b_in_1 = in2[3:0];

assign sum_c_in_2 = sum_c_out_1; 
assign sum_a_in_2 = not_out_2;
assign sum_b_in_2 = in2[7:4];

assign nor_in1 = sum_out_1;
assign nor_in2 = sum_out_2;

assign and_in1[1:0] = nor_out[1:0];
assign and_in2[1:0] = nor_out[3:2];

assign and_in1[2] = and_out[0];
assign and_in2[2] = and_out[1];

assign out = and_out[2];

endmodule
