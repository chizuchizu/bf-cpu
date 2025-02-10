`ifndef BRAM_PRIMITVE 
`define BRAM_PRIMITVE 

module bram_primitive(
  input [7:0] data_in,
  input [7:0] addr,
  input clk,
  input wre,
  input ce,
  input rst,

  output [7:0] data_out
);

endmodule

`endif
