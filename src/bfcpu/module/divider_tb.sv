`timescale 1ns / 1ps

module divider_tb ();

parameter PERIOD = 10;

reg clk, n_clr;
wire half_clk;
wire quarter_clk;

divider divider_tb(
  .*
);

always #(PERIOD) begin
  clk <= ~clk;
end

initial begin
  $dumpfile("divider.vcd");
  $dumpvars(0, divider_tb);
end

initial begin
  clk <= 1'b0;
  n_clr <= 1'b1;

  #1
  n_clr <= 1'b0;

  #1
  n_clr <= 1'b1;

  // n_clr が動作するかの確認
  test_dff(1'b0, 1'b0);

  #PERIOD //posedge
  #PERIOD //negedge
  // half_clk = 1, quarter_clk = 1
  test_dff(1'b1, 1'b1);

  #PERIOD //posedge
  #PERIOD //negedge
  // half_clk = 0, quarter_clk = 1
  test_dff(1'b0, 1'b1);

  #PERIOD //posedge
  #PERIOD //negedge
  // half_clk = 1, quarter_clk = 0 
  test_dff(1'b1, 1'b0);

  #PERIOD //posedge
  #PERIOD //negedge
  // half_clk = 1, quarter_clk = 0 
  test_dff(1'b0, 1'b0);
  
  $finish;
end

task test_dff(
  input e_half_clk,
  input e_quarter_clk 
);
  if(e_half_clk !== 1'bx && half_clk !== e_half_clk) begin
    $error("%t: half_clk must be %d, but half_clk is %d", $time, e_half_clk, half_clk);
  end
  if(e_quarter_clk !== 1'bx && quarter_clk !== e_quarter_clk) begin
    $error("%t: quarter_clk must be %d, but quarter_clk is %d", $time, e_quarter_clk, quarter_clk);
  end
endtask

endmodule

