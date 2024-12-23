module logic_74HC74(
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
reg n_reg1;
reg reg2;
reg n_reg2;

assign out1 = reg1;
assign out2 = reg2;

assign n_out1 = n_reg1;
assign n_out2 = n_reg2;

always @(posedge clk1 or negedge n_clr1 or negedge n_pr1) begin
    if(~n_clr1 | ~n_pr1) begin
      reg1 <= n_clr1 | ~n_pr1; 
      n_reg1 <= ~n_clr1 | n_pr1;
    end else begin
      reg1 <= in1;
      n_reg1 <= ~in1;
    end
end

always @(posedge clk2 or negedge n_clr2 or negedge n_pr2) begin
    if(~n_clr2 | ~n_pr2) begin
      reg2 <= n_clr2 | ~n_pr2; 
      n_reg2 <= ~n_clr2 | n_pr2;
    end else begin
      reg2 <= in2;
      n_reg2 <= ~in2;
    end
end

endmodule
