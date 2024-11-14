module _74HC04_tb();

reg [5:0] in;
wire [5:0] out;

_74HC04 not_instance(
    .in,
    .out
);

initial begin
    $dumpfile("74HC04.vcd");
    $dumpvars(1, _74HC04_tb);

    in =6'b010101;
    test_out(6'b101010);

    #5 in = 6'b101010;
    #5 test_out(6'b010101);

    #5 $finish;
end

task test_out(
    input [5:0] ans
);
begin
    if (out != ans) $error("output must be %b but output is %b", ans, out);
end
endtask

endmodule
