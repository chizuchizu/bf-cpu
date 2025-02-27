`ifndef ASYNCHRONOUS_RAM
`define ASYNCHRONOUS_RAM

module asynchronous_ram (
  input [7:0] addr,
  input ce,
  input n_ce,
  input n_we,
  input n_oe,

  inout [7:0] data_inout
);

endmodule

`endif
