`ifndef DATA_RAM
`define DATA_RAM

`include "../logicIC/logic_74HC541.sv"
`include "../logicIC/logic_74HC273.sv"
`include "../logicIC/logic_74HC32.sv"
`include "asynchronous_ram.sv"
`include "zero_detector.sv"

module data_ram (
  input n_we,
  input n_oe,
  input n_val_gate,
  input n_val_ld,
  input n_clr,
  input [7:0] addr,
  input [7:0] in,

  output [7:0] out,
  output n_detect_zero
);

// ram output
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

// ram input
wire logic_74HC541_n_g1_2;
wire logic_74HC541_n_g2_2;
wire [7:0] logic_74HC541_in_2;
wire [7:0] logic_74HC541_out_2;
logic_74HC541 logic_74HC541_2(
  .n_g1(logic_74HC541_n_g1_2),
  .n_g2(logic_74HC541_n_g2_2),
  .in(logic_74HC541_in_2),
  .out(logic_74HC541_out_2) 
);

wire [7:0] logic_74HC273_in_1;
wire logic_74HC273_clk_1;
wire logic_74HC273_n_clr_1;
wire [7:0] logic_74HC273_out_1;
logic_74HC273 logic_74HC273_1(
  .in(logic_74HC273_in_1),
  .clk(logic_74HC273_clk_1),
  .n_clr(logic_74HC273_n_clr_1),
  .out(logic_74HC273_out_1) 
);

wire [7:0] asynchronous_ram_addr_1;
wire asynchronous_ram_ce_1;
wire asynchronous_ram_n_ce_1;
wire asynchronous_ram_n_we_1;
wire asynchronous_ram_n_oe_1;
wire [7:0] asynchronous_ram_data_inout_1;
asynchronous_ram asynchronous_ram_1(
  .addr(asynchronous_ram_addr_1),
  .ce(asynchronous_ram_ce_1),
  .n_ce(asynchronous_ram_n_ce_1),
  .n_we(asynchronous_ram_n_we_1),
  .n_oe(asynchronous_ram_n_oe_1),
  .data_inout(asynchronous_ram_data_inout_1)
);

wire [3:0] logic_74HC32_in1_1;
wire [3:0] logic_74HC32_in2_1;
wire [3:0] logic_74HC32_out_1;
logic_74HC32 logic_74HC32_1(
  .in1(logic_74HC32_in1_1),
  .in2(logic_74HC32_in2_1),
  .out(logic_74HC32_out_1)
);

wire [7:0] zero_detector_in_1;
wire zero_detector_out_1;
zero_detector zero_detector_1(
  .in(zero_detector_in_1),
  .out(zero_detector_out_1)
);

wire n_data_we;

assign out = logic_74HC541_out_1;
assign n_detect_zero = zero_detector_out_1; 

assign logic_74HC32_in1_1 = {7'b0000000, n_we} ;
assign logic_74HC32_in2_1 = {7'b0000000, n_val_ld};

assign n_data_we = logic_74HC32_out_1[0];

assign logic_74HC541_n_g1_1 = n_val_gate;
assign logic_74HC541_n_g2_1 = 1'b0;
assign logic_74HC541_in_1 = logic_74HC273_out_1;

assign logic_74HC541_n_g1_2 = n_data_we;
assign logic_74HC541_n_g2_2 = 1'b0;
assign logic_74HC541_in_2 = in; 

assign logic_74HC273_in_1 = asynchronous_ram_data_inout_1;
assign logic_74HC273_clk_1 = n_oe;
assign logic_74HC273_n_clr_1 = n_clr;

assign asynchronous_ram_addr_1 = addr;
assign asynchronous_ram_ce_1 = 1'b1;
assign asynchronous_ram_n_ce_1 = 1'b0;
assign asynchronous_ram_n_we_1 = n_data_we; 
assign asynchronous_ram_n_oe_1 = n_oe;
assign asynchronous_ram_data_inout_1 = logic_74HC541_out_2;


assign zero_detector_in_1 = logic_74HC273_out_1;

endmodule

`endif
