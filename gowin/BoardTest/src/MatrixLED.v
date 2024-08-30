module dynamicMatrixLED (
    input wire sys_clock,
    input reg [7:0] LEDdata [7:0],
    output reg [2:0] row,
    output reg [7:0] col
);

reg [32:0] counter;

always @(posedge sys_clock) begin
    if (counter < 32'd26999998) begin
        counter <= counter + 1'b1;
    end else begin
        counter <= 32'd0;
    end
end

always @(posedge sys_clock) begin
    if (counter == 32'd26999998) begin
        
        if(row < 3'd5) begin
            row <= row + 1'b1;
        end else begin
            row <= 3'd0;
        end

        col[7:0] <= LEDdata[row][7:0];
    end
    $display("%d, $d", counter, row);
end

endmodule