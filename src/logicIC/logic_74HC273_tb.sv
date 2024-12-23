`timescale 1ns / 1ps

module logic_74HC273_tb ();

parameter PERIOD = 15;

reg [7:0] in;
reg clk, n_clr;
wire [7:0] out;

logic_74HC273 logic_74HC273_instance(
    .*
);

always #(PERIOD) begin
    clk <= ~clk;
end

// D-FF1のテスト
initial begin 
    clk = 1'b0;
    n_clr = 1'b1;
    in = 8'b00000000;
    #1

    #(PERIOD) // positive edge
        // 値がinと同じになっているか確認
        test_dff(8'b00000000);

    #(PERIOD) // negative edge
        // 立ち下がり時に値が更新されていないか確認
        in = 8'b11111111;
        test_dff(8'b00000000);

    #(PERIOD) // positive edge
        // 立ち上がり時に値が同じになっているか確認
        in = 8'b11111111;
        test_dff(8'b11111111);

    #(PERIOD) // negative edge
        // 立ち下がり時に値が更新されていないか確認
        in = 8'b00000000;
        test_dff(8'b11111111);

    #(PERIOD) // positive edge
        // clrが有効か確認
        in = 8'b11111111;
        n_clr = 1'b0;
        test_dff(8'b00000000);

    #(PERIOD) // negative edge
        // clrが1になった際、値が0のままか
        in = 8'b11111111;
        n_clr = 1'b1;
        test_dff(8'b00000000);

    #(PERIOD) //positive edge
        // 値が更新されるか確認
        in = 8'b11111111;
        n_clr = 1'b1;
        test_dff(8'b11111111);

    $finish;
end

initial begin
    $dumpfile("logic_74HC273.vcd");
    $dumpvars(0, logic_74HC273_tb);
end

task test_dff(
    input [7:0] e_out
);
begin
    if (e_out !== 1'bx && out !== e_out)
        $error("%t: out must be %d, but out is %d", $time, e_out, out);
end
endtask

endmodule
