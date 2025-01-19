`timescale 1ns / 1ps

module stack_pointer_tb ();

parameter PERIOD = 10;

reg clk, n_clr, reg_sp, reg_np, sp_gate;
reg [7:0] in;

wire [7:0] out;
wire detect_0;

stack_pointer stack_pointer(
  .*
);

always #(PERIOD) begin
  clk <= ~clk;
end

initial begin
  $dumpfile("stack_pointer.vcd");
  $dumpvars(0, stack_pointer_tb);
end

initial begin
  clk <= 1'b0;
  n_clr <= 1'b1;
  in <= 8'b00000000;

  reg_sp <= 1'b1;
  reg_np <= 1'b1;
  sp_gate <= 1'b1;

  #1 // shift time to get output

  #PERIOD //posedge

  sp_gate <= 1'b0;
  n_clr <= 1'b0;

  #1

  n_clr <= 1'b1;

  #1

  //clrが正常に動作することのテスト
  test_dff(8'b00000000, 1'b0);

  sp_gate <= 1'b1;

  #1

  //stack pointerのトライステートバッファが正常に動作することのテスト
  test_dff(8'bzzzzzzzz, 1'b0);

  #PERIOD //negedge

  in <= 8'b10101101;
  reg_sp <= 1'b0;
  sp_gate <= 1'b0;

  #PERIOD //posedge
  #PERIOD //negedge

  //stack pointerに値が保存されることのテスト
  test_dff(8'b10101101, 1'b1);

  in <= 8'b11100101;
  reg_sp <= 1'b1;

  #PERIOD //posedge
  #PERIOD //negedge
  
  //stack pointer ldが正常に動作することのテスト
  test_dff(8'b10101101, 1'b1);

  reg_np <= 1'b0;

  #PERIOD //posedge
  #PERIOD //negedge
  
  //np pointerに値が保存されることのテスト
  test_dff(8'b10101101, 1'b0);

  reg_np <= 1'b1;

  $finish;
end

task test_dff(
  input [7:0] e_out,
  input e_detect_0
);
begin
  if(e_out !== 8'bxxxxxxxx && out !== e_out)
    $error("%t: out must be %d, but out is %d", $time, e_out, out);
  if(e_detect_0 !== 8'bx && detect_0 !== e_detect_0)
    $error("%t: detect 0 must be %d, but detect 0 is %d", $time, e_detect_0, detect_0);
  end
endtask

endmodule
