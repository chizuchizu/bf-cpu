`timescale 1ns / 1ps

module logic_74HC161_tb ();

parameter PERIOD = 10;

reg clk, n_rst, n_ld, enp, ent;
reg [3:0] in;

wire co;
wire [3:0] out; 

logic_74HC161 logic_74HC161_instance(
  .*
);

always #(PERIOD) begin
  clk <= ~clk;
end

initial begin
  $dumpfile("logic_74HC161.vcd");
  $dumpvars(0, logic_74HC161_tb);
end

initial begin
    clk <= 1'b0;
    n_rst <= 1'b1;
    n_ld <= 1'b1;
    enp <= 1'b0;
    ent <= 1'b0;
    in = 4'd0;

  #1 // shift time to get output 

  #PERIOD // positive edge

  #1
    n_rst <= 1'b0; 

  #1
    // クリアが非同期に動作することの確認
    test_dff(1'b0, 4'b0000);
  
  #PERIOD // negative edge

    n_rst <= 1'b1;
    enp <= 1'b1;
    ent <= 1'b1;

  #PERIOD // positive edge
    // カウントアップされていることの確認
    test_dff(1'b0, 4'b0001);

  #PERIOD // negative edge
    // 値が変わっていないことの確認 
    test_dff(1'b0, 4'b0001);
  
    ent <= 1'b0; 
    
  #PERIOD // positive edge
  #PERIOD // negative edge
    // ent=0のときにカウントアップされないことの確認
    test_dff(1'b0, 4'b0001);

    ent <= 1'b1;
    enp <= 1'b0; 

  #PERIOD // positive edge
  #PERIOD // negative edge
    // enp=0のときにカウントアップされないことの確認
    test_dff(1'b0, 4'b0001);

    ent <= 1'b0;
    n_ld <= 1'b0;

    in <= 4'b0011;

  #PERIOD // positive edge
  #PERIOD // negative edge
    // 011がロードされているか確認 
    test_dff(1'b0, 4'b0011);

    ent <= 1'b1;
    enp <= 1'b1;
    in <= 4'b1110;

  #PERIOD // postive edge
  #PERIOD // negative edge
    // カウントアップされずに110がロードされているか確認 
    test_dff(1'b0, 4'b1110);

    n_ld <= 1;

  #PERIOD // postive edge
  #PERIOD // negative edge
    // 1111のときにcoが1になることの確認
    test_dff(1'b1, 4'b1111);

    ent <= 1'b0;

  #PERIOD // postive edge
  #PERIOD // negative edge
    // entが1のときにcoが0になることの確認
    test_dff(1'b0, 4'b1111);

    ent <= 1'b1;

  #PERIOD // postive edge
  #PERIOD // negative edge
    // 繰り上がったときに0000になることを確認 
    test_dff(1'b0, 4'b0000);

  $finish;
end

task test_dff(
  input e_co,
  input [3:0] e_out 
);
begin
  if (e_co !== 1'bx && co !== e_co)
    $error("%t: out must be %d, but out is %d", $time, e_co, co);
  if(e_out !== 1'bx && out !== e_out)
    $error("%t: out must be %d, but out is %d", $time, e_out, out);
  end
endtask

endmodule
