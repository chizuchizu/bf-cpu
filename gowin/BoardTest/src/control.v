module top (
    input wire sys_clock,
    output reg [2:0] row,
    output reg [7:0] col
);

reg [7:0] LEDdata [7:0];
reg [23:0] counter;

dynamicMatrixLED dml(
    .sys_clock (sys_clock),
    .LEDdata (LEDdata),
    .row (row),
    .col (col)
);

initial begin
    integer i;
    for(i = 0; i < 8; i = i + 1) begin
        LEDdata[i] <= 8'd0;
    end

end

endmodule