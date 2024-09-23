`timescale 1ns / 1ps

module alu_tb;

logic [7:0] a;
logic nochange, decrement, increment;
logic [7:0] out;

alu alu(.*);

initial begin
  $monitor("%d: a=%04x cond=$d %d $d out=%04x",
           $time, a, nochange, decrement, increment, out);

  a = 8'hAD;

  nochange = 1'b1;
  decrement = 1'b0;
  increment = 1'b0;

  #1 if (out !== 8'hAD) $error("out must be 0xAD");

  nochange = 1'b0;
  decrement = 1'b1;
  increment = 1'b0;
  #1 if (out !== 8'hAC) $error("out must be 0xAC");

  nochange = 1'b0;
  decrement = 1'b0;
  increment = 1'b1;
  #1 if (out !== 8'hAE) $error("out must be 0xAE");

end

endmodule