module _74HC74(
    input n_clr1,
    input n_pr1,
    input clk1,
    input in1,
    output out1,
    output n_out1,

    input n_clr2,
    input n_pr2,
    input clk2,
    input in2,
    output out2,
    output n_out2
);

reg reg1;
reg reg2;

assign out1 = reg1 & n_clr1 | ~n_pr1; 
assign out2 = reg2 & n_clr2 | ~n_pr2;

assign n_out1 = ~out1;
assign n_out2 = ~out2;

always @(posedge clk1) begin
    reg1 <= in1;
end

always @(posedge clk2) begin
    reg2 <= in2;
end

endmodule
