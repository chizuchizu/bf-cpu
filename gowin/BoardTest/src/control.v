module top (
    input wire sys_clock,
    output reg [2:0] row,
    output reg [7:0] col
);

reg [7:0] LEDdata [7:0];
reg [31:0] counter;

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

    LEDdata[0] <= 8'b01111111;
    LEDdata[1] <= 8'b10111111;
    LEDdata[2] <= 8'b11011111;
    LEDdata[3] <= 8'b11101111;
    LEDdata[4] <= 8'b11110111;
    LEDdata[5] <= 8'b11111011;
    LEDdata[6] <= 8'b11111101;
    LEDdata[7] <= 8'b11111110;

end

always @(posedge sys_clock) begin
    if (counter < 32'd2700000) begin  // 10Hz
        counter <= counter + 1'b1;
    end else begin
        counter <= 32'd0;
    end
end

always @(posedge sys_clock) begin
    if (counter == 32'd2700000) begin  // 10Hz

        integer i;
        for(i = 0; i < 8; i = i + 1) begin
            // sift to the left
            LEDdata[i] <= {LEDdata[i][6:0],LEDdata[i][7]};
        end
        
    end
end

endmodule