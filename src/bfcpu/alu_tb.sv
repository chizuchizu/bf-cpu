module alu_tb;

logic [7:0] a;
logic nochange, decrement, increment;
logic [7:0] out;

alu alu(.*);

initial begin
  $monitor("%d: a=%04x cond=$01x %01x $01x out=%04x",
           $time, a, nochange, decrement, increment, out);

  a <= 8'hAD;


  nochange = 1:
  derecment = 0;
  increment = 0;

  #1 if (out !== 16'hAD) $error("out must be 0xAD");

  nochange = 0:
  derecment = 1;
  increment = 0;
  #1 if (out !== 16'hAC) $error("out must be 0xAC");

  nochange = 0:
  derecment = 0;
  increment = 1;
  #1 if (out !== 16'hAE) $error("out must be 0xAE");

end

endmodule