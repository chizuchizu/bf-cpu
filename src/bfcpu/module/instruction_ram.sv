`ifndef INSTRUCTION_RAM
`define INSTRUCTION_RAM

`include "asynchronous_ram.sv"
`include "switch.sv"
module instruction_ram(
  input we_switch,
  input oe_switch,
  input we_manual,
  input oe_manual,
  input [7:0] addr,
  input [7:0] in_manual,

  output [7:0] out
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

wire switch_signal_1;
wire switch_in_1;
wire switch_out_1;
switch switch_1(
  .signal(switch_signal_1),
  .in(switch_in_1),
  .out(switch_out_1)
);

wire switch_signal_2;
wire switch_in_2;
wire switch_out_2;
switch switch_2(
  .signal(switch_signal_2),
  .in(switch_in_2),
  .out(switch_out_2)
);

assign out = asynchronous_ram_data_inout_1;

assign asynchronous_ram_addr_1 = addr;
assign asynchronous_ram_ce_1 = 1'b1;
assign asynchronous_ram_n_ce_1 = 1'b0;
assign asynchronous_ram_n_we_1 = switch_out_1; 
assign asynchronous_ram_n_we_1 = we_manual;
assign asynchronous_ram_n_oe_1 = switch_out_2; 
assign asynchronous_ram_n_oe_1 = oe_manual; 
assign asynchronous_ram_data_inout_1 = in_manual;

assign switch_signal_1 = we_switch;
assign switch_in_1 = 1'b1;
assign switch_signal_2 = oe_switch;
assign switch_in_2 = 1'b0;

endmodule

`endif
