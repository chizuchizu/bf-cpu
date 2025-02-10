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

reg [7:0] mem [255:0];
reg [7:0] data_out;

always@(posedge clk or posedge rst)
  if(rst) begin
    data_out <= 0;
  end else begin
    if(ce & !wre) begin
      data_out <= mem[addr];
    end
  end

always@(posedge clk)
  if(ce & wre) begin
    mem[addr] <= data_in;
  end

endmodule

`endif
