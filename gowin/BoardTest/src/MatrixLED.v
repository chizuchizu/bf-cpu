module dynamicMatrixLED (
    input wire sys_clock,
    input reg [7:0] LEDdata [7:0],
    output reg [2:0] row,
    output reg [7:0] col
);

reg [31:0] counter;

always @(posedge sys_clock) begin
    if (counter < 32'd33750) begin  // 800Hz
        counter <= counter + 1'b1;
    end else begin
        counter <= 32'd0;
    end
end

always @(posedge sys_clock) begin
    if (counter == 32'd33750) begin  // 800Hz

        row <= row + 3'd1;

        // この時点でrowのインクリメントが完了していない
        col[7:0] <= LEDdata[row + 3'd1][7:0];
    end
end

endmodule