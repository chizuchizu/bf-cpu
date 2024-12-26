module logic_74HC541 (
    input n_g1,
    input n_g2,
    input [7:0] in,
    output [7:0] out
);

assign out = (n_g1 | n_g2) ? 8'bzzzzzzzz : in;

endmodule
