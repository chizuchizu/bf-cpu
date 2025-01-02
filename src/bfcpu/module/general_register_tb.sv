`timescale 1ns / 1ps

module general_register_tb ();

parameter PERIOD = 10;

reg clk, n_clr, n_ld;
reg [7:0] in;

wire [7:0] out;

general_register general_register_tb(
  .*
);

always #(PERIOD) begin
  clk <= ~clk;
end

initial begin
  $dumpfile("general_register.vcd");
  $dumpvars(0, general_register_tb);
end

initial begin
  clk <= 1'b0;
  n_clr <= 1'b1;
  n_ld <= 1'b1;
  in <= 8'b00000000;

  #1 // shift time to get output

  #PERIOD // posedge
  
  #1
    n_clr <= 1'b0;
  #1
    // クリアが非同期に動作することの確認
    test_dff(8'b00000000);

  #PERIOD // negedge

    n_clr <= 1'b1;
    in <= 8'b11111111;

  #PERIOD // posedge
  #PERIOD // negedge

    // 値が代入されないことの確認 
    test_dff(8'b00000000);

    n_ld <= 1'b0;

  #PERIOD // posedge
  #PERIOD // negedge

    // 値が代入されることの確認 
    test_dff(8'b11111111);

    in <= 8'b10101110;

  #PERIOD // posedge
  #PERIOD // negedge

    // 入力通りに出力ができるかの確認 
    test_dff(8'b10101110);

  $finish;
end

task test_dff(
  input [7:0] e_out 
);
begin
  if(e_out !== 8'bxxxxxxxx && out !== e_out)
    $error("%t: out must be %d, but out is %d", $time, e_out, out);
  end
endtask

endmodule
  
