`ifndef LOGIC_74HC283
`define LOGIC_74HC283

module logic_74HC283(
    input [3:0] a_in,
    input [3:0] b_in,
    input c_in,
    output [3:0] sum_out,
    output c_out
);
    reg [4:0] sum;
    
    assign sum = {1'b0, a_in} + {1'b0, b_in} + {4'b0000, c_in};
    assign sum_out = sum[3:0];
    assign c_out = sum[4];
endmodule

`endif
