`ifndef LOGIC_74HC04
`define LOGIC_74HC04

module logic_74HC04(
    input [5:0] in,
    output [5:0] out
);

    assign out = ~in;
endmodule

`endif
