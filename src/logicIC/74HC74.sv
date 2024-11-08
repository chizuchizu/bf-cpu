module 74HC74(
    input n_clr1,
    input n_pr1,
    input clk1,
    input d1,
    output q1,
    output n_q1,

    input n_clr2,
    input n_pr2,
    input clk2,
    input d2,
    output q2,
    output n_q2

);

reg reg1;
reg reg2;

assign q1 = reg1 & n_clr1 & ~n_pr1; 
assign q2 = reg2 & n_clr2 & ~n_pr2;

assign n_q1 = ~q1;
assign n_q2 = ~q2;

always @(posedge clk1) begin
    d1 <= q1;
end

always @(posedge clk2) begin
    d2 <= q2;
end

endmodule