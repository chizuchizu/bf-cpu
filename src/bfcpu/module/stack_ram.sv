`ifndef STACK_RAM
`define STACK_RAM


module stack_ram (
  input n_we,
  input n_oe,
  input n_stack_ld,
  input n_pc_ld,
  input [7:0] addr,
  input [7:0] in,

  output [7:0] out
);

endmodule

`endif
