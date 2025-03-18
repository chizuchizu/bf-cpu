`timescale 1ns / 1ps

module data_ram_tb ();

parameter PERIOD = 10;

reg clk;
reg n_we, n_oe, n_val_gate, n_val_ld, n_clr;
reg [7:0] addr;
reg [7:0] in;
wire [7:0] out;
wire n_detect_zero;

data_ram data_ram_tb(
  .*
);

always #(PERIOD + 1) begin
  clk <= ~clk;
end

initial begin
  $dumpfile("data_ram.vcd");
  $dumpvars(0, data_ram_tb);
end

initial begin
  // 1st instruction
  n_clr <= 1'b1;
  n_we <= 1'b1;
  n_oe <= 1'b1;
  n_val_gate <= 1'b1;
  n_val_ld <= 1'b0; 
  addr <= 8'b00000000;
  in <= 8'b00000000;

  #1
  n_clr <= 1'b0;

  #1
  n_clr <= 1'b1;

  #PERIOD
  n_oe <= 1'b0;

  #PERIOD
  n_oe <= 1'b1;

  #1
  // n_val_gate がネゲートされているのでハイインピーダンス
  test_dff(8'bzzzzzzzz, 1'bx);

  #PERIOD
  n_we <= 1'b0;

  #PERIOD

  // 2nd instruction

  n_we <= 1'b1;
  n_val_gate <= 1'b0;
  n_val_ld <= 1'b0;
  in <= 8'b00000001;

  #PERIOD
  n_oe <= 1'b0;

  #PERIOD
  n_oe <= 1'b1;

  #1
  // addr = 00000000に値が入力されるか確認
  test_dff(8'b00000000, 1'b0);

  #PERIOD
  n_we <= 1'b0;

  #PERIOD

  // 3rd instruction

  n_we <= 1'b1;
  n_val_gate <= 1'b0;
  n_val_ld <= 1'b1;
  in <= 8'b00000010;

  #PERIOD
  n_oe <= 1'b0;

  #PERIOD
  n_oe <= 1'b1;

  #1
  // addr = 0000000の値が更新されるか確認
  test_dff(8'b00000001, 1'b1);

  #PERIOD
  n_we <= 1'b0;

  #PERIOD

  // 4th instruction
  
  n_we <= 1'b1;
  n_val_gate <= 1'b0;
  n_val_ld <= 1'b1;
  in <= 8'b00000011;
  
  #PERIOD
  n_oe <= 1'b0;

  #PERIOD
  n_oe <= 1'b1;

  #1
  // n_val_ld = 1 のときに値が更新されないことの確認
  test_dff(8'b00000001, 1'b1);

  #PERIOD
  n_we <= 1'b0;

  #PERIOD

  // 5th instrcution

  n_we <= 1'b1;
  n_val_gate <= 1'b0;
  n_val_ld <= 1'b0;
  in <= 8'b00010000;
  addr <= 8'b00000001;

  #PERIOD
  n_oe <= 1'b0;

  #PERIOD
  n_oe <= 1'b1;

  #PERIOD
  n_we <= 1'b0;

  #PERIOD

  // 6th instruction  

  n_we <= 1'b1;
  n_val_gate <= 1'b0;
  n_val_ld <= 1'b1;
  in <= 8'b00110000;

  #PERIOD
  n_oe <= 1'b0;

  #PERIOD
  n_oe <= 1'b1;

  #1
  // addr = 00000001に値が入力されるか確認
  test_dff(8'b00010000, 1'b1);

  #PERIOD
  n_we <= 1'b0;

  #PERIOD
  n_we <= 1'b1;
  

  $finish;
end

task test_dff(
  input [7:0] e_out,
  input e_n_detect_zero
);
  if(e_out !== 8'bxxxxxxxx && out !== e_out) begin
    $error("%t: out must be %b, but out is %b",$time, e_out, out);
  end 
  if(n_detect_zero !== e_n_detect_zero) begin
    $error("%t: out must be %b, but out is %b",$time, e_n_detect_zero, n_detect_zero);
  end

endtask

endmodule
