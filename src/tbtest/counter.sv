module counter(
    input sys_clk,
    input rst,
    output [8:0] out
);

reg [8:0] count;

assign out = count;

always @(posedge sys_clk or posedge rst) begin
    if(rst) begin
        count <= 8'd0;
    end else begin
        count <= count + 8'd1;
    end
end

endmodule