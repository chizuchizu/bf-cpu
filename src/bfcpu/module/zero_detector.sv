`ifndef ZERO_DETECTOR
`define ZERO_DETECTOR

`include "../logicIC/logic_74HC32.sv"

module zero_detector(
	input [7:0] in,
	output out
);

wire [3:0] or_in1_1;
wire [3:0] or_in2_1;
wire [3:0] or_out_1;
logic_74HC32 logic_74HC32_1(
    .in1(or_in1_1),
    .in2(or_in2_1),
    .out(or_out_1)
);

wire [3:0] or_in1_2;
wire [3:0] or_in2_2;
wire [3:0] or_out_2;
logic_74HC32 logic_74HC32_2(
    .in1(or_in1_2),
    .in2(or_in2_2),
    .out(or_out_2)
);

assign or_in1_1[0] = in[0];
assign or_in2_1[0] = in[1]; // or_out_1[0] = in[0] | in[1]

assign or_in1_1[1] = in[2];
assign or_in2_1[1] = in[3]; // or_out_1[1] = in[2] | in[3]

assign or_in1_1[2] = in[4];
assign or_in2_1[2] = in[5]; // or_out_1[2] = in[4] | in[5]

assign or_in1_1[3] = in[6];
assign or_in2_1[3] = in[7]; // or_out_1[3] = in[6] | in[7]

assign or_in1_2[0] = or_out_1[0];
assign or_in2_2[0] = or_out_1[1];

assign or_in1_2[1] = or_out_1[2];
assign or_in2_2[1] = or_out_1[3];

assign or_in1_2[2] = or_out_2[0];
assign or_in2_2[2] = or_out_2[1];

assign out = or_out_2[2];

endmodule

`endif
