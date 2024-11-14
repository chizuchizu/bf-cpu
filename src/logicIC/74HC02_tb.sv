module _74HC02_tb();

reg [3:0] in1;
reg [3:0] in2;
wire [3:0] out;

_74HC02 nor_instance(
    .in1,
    .in2, 
    .out
);

initial begin
    $dumpfile("74HC02.vcd");
    $dumpvars(1, _74HC02_tb);

    in1 = 4'b0011;
    in2 = 4'b0101;
    test_out(4'b1000);

    #5 in1 = 4'b1001;
       in2 = 4'b1010;
    #5 test_out(4'b0100);

    #5 in1 = 4'b1100;
       in2 = 4'b0101;
    #5 test_out(4'b0010);

    #5 in1 = 4'b0110;
       in2 = 4'b1010;
    #5 test_out(4'b0001);

    #5 $finish;
end

task test_out(
    input [3:0] ans
);
begin
    if (out != ans) $error("output must be %b but output is %b", ans, out);
end
endtask

endmodule
