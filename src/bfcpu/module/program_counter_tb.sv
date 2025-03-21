`timescale 1ns / 1ps

module program_counter_tb ();

parameter PERIOD = 10;

reg clk, clk_switch, clk_manual;
reg n_clr, n_pc_ld;
reg [7:0] in;
wire [7:0] out;

program_counter program_counter_tb(
  .*
);

initial begin
  $dumpfile("program_counter.vcd");
  $dumpvars(0, program_counter_tb);
end

always #(PERIOD) begin
  clk <= ~clk;
end

initial begin
  clk <= 1'b0;
  clk_switch <= 1'b0;
  clk_manual <= 1'bz;
  n_clr <= 1'b1;
  n_pc_ld <= 1'b1;
  in <= 8'b00000000;



  // clk のマニュアル動作の確認
  #1
  clk_switch <= 1'b1;

  #1
  n_clr <= 1'b0;

  #1
  n_clr <= 1'b1;

  // n_clr が作動するかの確認
  test_dff(8'b00000000);

  #PERIOD
  clk_manual <= 1'b1;

  #PERIOD
  clk_manual <= 1'b0;

  test_dff(8'b00000001);

  #PERIOD
  clk_manual <= 1'b1;

  #PERIOD
  clk_manual <= 1'b0;
  
  test_dff(8'b00000010);

  #1
  clk_manual <= 1'bz;

  #1
  clk_switch <= 1'b0;

  #1
  n_clr <= 1'b0;

  #1
  n_clr <= 1'b1;

  #PERIOD
  #PERIOD
  // 通常のclkでカウントアップの確認
  test_dff(8'b00000001); 

  n_pc_ld <= 1'b0;
  in <= 8'b00001111;

  #PERIOD
  #PERIOD
  // n_pc_ldをアサートしたとき、値が入力されるかの確認
  test_dff(8'b00001111); 

  n_pc_ld <= 1'b1;
   
  #PERIOD
  #PERIOD
  // 5bit目以降に値が代入されるかの確認
  test_dff(8'b00010000);
  
  n_pc_ld <= 1'b0;
  in <= 8'b11111111;

  #PERIOD
  #PERIOD
  n_pc_ld <= 1'b1;

  #PERIOD
  #PERIOD
  // 値が繰り上がって0になることの確認
  test_dff(8'b00000000);

  $finish;
end

task test_dff(
  input [7:0] e_out
);
  if(e_out !== 8'bxxxxxxxx && out !== e_out) begin
    $error("%t: out must be %b, but out is %b",$time, e_out, out);
  end 
endtask

endmodule
