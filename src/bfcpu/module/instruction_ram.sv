`ifndef INSTRUCTION_RAM
`define INSTRUCTION_RAM

module instruction_ram(
  input we_switch,
  input oe_switch,
  input we_manual,
  input oe_manual,
  input [7:0] addr,
  input [7:0] in_manual,

  output [7:0] out
);

endmodule

`endif
