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

reg [7:0] mem [255:0];
wire write_enable;

assign data_inout = ce & ~n_ce & ~n_oe & n_we ? mem[addr] : 8'bzzzzzzzz;

assign write_enable = ce & ~n_ce & ~n_we;

always @(posedge write_enable) begin
  mem[addr] <= data_inout;
end

endmodule

`endif
