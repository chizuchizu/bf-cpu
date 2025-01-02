`ifndef LOGIC_74HC32
`define LOGIC_74HC32

module logic_74HC32(
    input [3:0] in1,
    input [3:0] in2,
    output [3:0] out
);

    assign out = in1 | in2;

endmodule

`endif
