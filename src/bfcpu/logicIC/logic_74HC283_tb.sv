module logic_74HC283_tb();

reg [3:0] a_in;
reg [3:0] b_in;
reg c_in;

wire [3:0] sum_out;
wire c_out;

logic_74HC283 logic_74HC283_instance(
    .a_in,
    .b_in, 
    .c_in,
    .sum_out,
    .c_out
);

initial begin
    $dumpfile("logic_74HC283.vcd");
    $dumpvars(1, logic_74HC283_tb);

    a_in = 4'b0000;
    b_in = 4'b0000;
    c_in = 1'b0;
    #0  test_out(4'b0000, 1'b0);

    #10 a_in = 4'b1111;
        b_in = 4'b1111;
        c_in = 1'b1;
    #0  test_out(4'b1111, 1'b1);

    #10 a_in = 4'b0000;
        b_in = 4'b1111;
        c_in = 1'b1;
    #0  test_out(4'b0000, 1'b1);

    #10 a_in = 4'b0111;
        b_in = 4'b0001;
        c_in = 1'b0;
    #0  test_out(4'b1000, 1'b0);

    #0 $finish;
end

task test_out(
    input [3:0] sum_ans,
    input c_ans
);
begin
    if (sum_out != sum_ans) $error("sum_output must be %b but output is %b", sum_ans, sum_out);
    if (c_out != c_ans) $error("c_output must be %b but output is %b", c_ans, c_out);
end
endtask

endmodule
