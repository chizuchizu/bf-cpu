`ifndef STACK_RAM
`define STACK_RAM

`include "../logicIC/logic_74HC541.sv"
`include "../logicIC/logic_74HC32.sv"
`include "asynchronous_ram.sv"

module stack_ram (
  input n_we,
  input n_oe,
  input n_stack_ld,
  input n_pc_ld,
  input [7:0] addr,
  input [7:0] in,

  output [7:0] out
);

// ram input
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

wire n_stack_ram_we;
wire n_stack_ram_oe;

assign out = asynchronous_ram_data_inout_1;

assign logic_74HC32_in1_1 = {6'b000000, n_oe, n_we} ;
assign logic_74HC32_in2_1 = {6'b000000, n_pc_ld, n_stack_ld};

assign n_stack_ram_we = logic_74HC32_out_1[0];
assign n_stack_ram_oe = logic_74HC32_out_1[1];

assign logic_74HC541_n_g1_1 = n_stack_ram_we;
assign logic_74HC541_n_g2_1 = 1'b0;
assign logic_74HC541_in_1 = in; 

assign asynchronous_ram_addr_1 = addr;
assign asynchronous_ram_ce_1 = 1'b1;
assign asynchronous_ram_n_ce_1 = 1'b0;
assign asynchronous_ram_n_we_1 = n_stack_ram_we; 
assign asynchronous_ram_n_oe_1 = n_stack_ram_oe;
assign asynchronous_ram_data_inout_1 = logic_74HC541_out_1;

endmodule

`endif
