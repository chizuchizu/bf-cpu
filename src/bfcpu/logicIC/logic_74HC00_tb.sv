module logic_74HC00_tb();

reg [3:0] in1;
reg [3:0] in2;
wire [3:0] out;

logic_74HC00 logic_74HC00_instance(
    .in1,
    .in2, 
    .out
);

initial begin
    $dumpfile("logic_74HC00.vcd");
    $dumpvars(1, logic_74HC00_tb);

    in1 = 4'b0000;
    in2 = 4'b0000;
    test_out(4'b1111);

    #5 in1 = 4'b1111;
    #5 test_out(4'b1111);

    #5 in2 = 4'b0110;
    #5 test_out(4'b1001);

    #5 in1 = 4'b0100;
    #5 test_out(4'b1011);

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
