`timescale 1ns / 1ps

module counter_tb ();

parameter TICKS = 10;

reg sys_clk;
reg rst;
wire [8:0] count;

counter counter_test(
    .sys_clk (sys_clk),
    .rst (rst),
    .out (count)
);

initial begin 
    sys_clk = 1'b0;

    rst = 1'b0;
    #50 rst = 1'b1;
    #50 rst = 1'b0;

    repeat(TICKS * 2) begin
        #50 sys_clk <= ~sys_clk;
    end

    $finish;
end

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, counter_test);
    $monitor("count: %d", counter_test.out);
end

endmodule