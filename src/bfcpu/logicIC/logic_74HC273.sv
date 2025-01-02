`ifndef LOGIC_74HC273
`define LOGIC_74HC273

module logic_74HC273(
    input [7:0] in,
    input clk,
    input n_clr,
    output [7:0] out
);

reg [7:0] reg_d;

assign out = reg_d;

always @(posedge clk, negedge n_clr) begin
    reg_d <= in & {8{n_clr}};
end

endmodule

`endif 
