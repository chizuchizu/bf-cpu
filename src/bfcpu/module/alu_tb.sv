module alu_tb ();

logic [7:0] a;
logic nochange, decrement, increment;
logic [7:0] out;

alu alu_instance(
    .*
);

initial begin
    $dumpfile("alu.vcd");
    $dumpvars(0, alu_tb);
end

initial begin
  a <= 8'b00011111;

  // nochange test
  nochange <= 1'b0;
  decrement <= 1'b1;
  increment <= 1'b1;
  #10 test_out(8'b00011111);

  // decrement test
  nochange <= 1'b1;
  decrement <= 1'b0;
  increment <= 1'b1;
  #10 test_out(8'b00011110);

  // increment test
  nochange <= 1'b1;
  decrement <= 1'b1;
  increment <= 1'b0;
  #10 test_out(8'b00100000);

  nochange <= 1'b0;
  decrement <= 1'b0;
  increment <= 1'b0;
  #10 test_out(8'bzzzzzzzz);

end

task test_out(
    input [7:0] ans
);
begin
    if (out != ans) $error("sum_output must be %b but output is %b", ans, out);
end
endtask


endmodule
