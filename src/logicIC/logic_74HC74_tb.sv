`timescale 1ns / 1ps

module logic_74HC74_tb ();

parameter PERIOD1 = 10;

reg n_clr1, n_clr2, n_pr1, n_pr2, clk1, clk2, in1, in2;
wire out1, n_out1, out2, n_out2;

logic_74HC74 logic_74HC74_instance(
  .*
);

always #(PERIOD1) begin
  clk1 <= ~clk1;
end

// D-FF1のテスト
initial begin 
  integer i;
  i = 0;

  clk1 = 1'b0;
  n_clr1 = 1'b1;
  n_pr1 = 1'b1; 
  in1 = 1'b0;
 
  #1 //1nsずらす

  #(PERIOD1) //pos
  // 立ち上がり時に値が0になることの確認
    test_dff1(i, 1'b0, 1'b1);
    i++;
    in1 = 1'b1;
  #(PERIOD1) //neg
  // 立下り時に値が変わらないことの確認  
    test_dff1(i, 1'b0, 1'b1);
    i++;

  in1 = 1'b1;

  #(PERIOD1) //pos
  // 立ち上がり時に値が1になることの確認
    test_dff1(i, 1'b1, 1'b0);
    i++;
  #(PERIOD1) //neg
    
  n_clr1 = 1'b0;
  #1
  // CLRが有効になったことの確認
    test_dff1(i, 1'b0, 1'b1);
    i++;
  #1
  n_clr1 = 1'b1;

  in1 = 1'b0;

  #(PERIOD1) //pos
  #(PERIOD1) //neg

  n_pr1 = 1'b0;
  #1
  // PRが有効になったことの確認
    test_dff1(i, 1'b1, 1'b0);
    i++;
  #1
  n_pr1 = 1'b1;

  #1
  $finish;
end

initial begin
    $dumpfile("logic_74HC74.vcd");
    $dumpvars(0, logic_74HC74_tb);
end

task test_dff1(
  integer i,
  input e_out, 
  input e_n_out
);
begin
  if (e_out !== 1'bx && out1 !== e_out)
    $error("test%d: out must be %d, but out is %d", i, e_out, out1);
  if (e_n_out !== 1'bx && n_out1 !== e_n_out)
    $error("test%d: ~out must be %d, but ~out is %d", i, e_n_out, n_out1);
end
endtask

endmodule
