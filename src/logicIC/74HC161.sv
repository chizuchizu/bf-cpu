module 74HC161(
    input clk,
    input n_rst,
    input n_ld,
    input enp,
    input ent,
    input [3:0] in,

    output [3:0] out,
    output co
);

reg [3:0] count;

assign out = count; //if n_clr == 0 then out <= 4'0000
assign co = ent & count[0] & count[1] & count[2] & count[3] //carry = ent * A * B * C * D

always @(posedge clk or negedge n_rst) begin
    if(~n_rst) begin
        count <= 4'd0;
    end else if(~n_ld) begin
        count <= in;
    end else begin
        if(ent & enp) begin
            count <= count + 4'd1;
        end
    end
    
end

endmodule