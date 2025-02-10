module bram_primitive_tb ();

parameter PERIOD = 10;

reg [7:0] data_in; 
reg [7:0] addr; 
reg clk, wre, ce, rst;

wire [7:0] data_out;

bram_primitive bram_primitive_tb(
  .*
);

always #(PERIOD) begin
  clk <= ~clk;
end

initial begin
  $dumpfile("bram_primitive.vcd");
  $dumpvars(0, bram_primitive_tb);
end

initial begin
  data_in <= 8'd0;
  addr <= 8'd0;
  clk <= 1'b0;
  wre <= 1'b0; 
  ce <= 1'b0; 
  rst <= 1'b0; 

  #1 // shift time to get output

  #PERIOD // posedge

  #1
  rst <= 1'b1;
  #1
  // クリアが非同期に動作することの確認
  test_dff(8'b00000000);

  rst <= 1'b0;

  #PERIOD // negedge

  data_in <= 8'b10101010;
  ce <= 1'b1;
  wre <= 1'b1;

  #PERIOD //posedge
  #PERIOD //negedge
  // データが読み込まれていないことの確認
  test_dff(8'b00000000);
 
  ce <= 1'b1;
  wre <= 1'b0;

  #PERIOD //posedge
  #PERIOD //negedge
  // データが書き込まれ、それが読み込まれていることの確認
  test_dff(8'b10101010);

  data_in <= 8'b01010101;
  ce <= 1'b0;
  wre <= 1'b0;

  #PERIOD //posedge
  #PERIOD //negedge

  ce <= 1'b1;
  wre <= 1'b0;

  #PERIOD //posedge
  #PERIOD //negedge
  // ce=0,wre=0のとき、データが書き込まれないことの確認
  test_dff(8'b10101010);

  data_in <= 8'b01010101;
  ce <= 1'b1;
  wre <= 1'b0;

  #PERIOD //posedge
  #PERIOD //negedge

  ce <= 1'b1;
  wre <= 1'b0;

  #PERIOD //posedge
  #PERIOD //negedge
  // ce=1,wre=0のとき、データが書き込まれないことの確認
  test_dff(8'b10101010);

  data_in <= 8'b01010101;
  ce <= 1'b0;
  wre <= 1'b1;

  #PERIOD //posedge
  #PERIOD //negedge

  ce <= 1'b1;
  wre <= 1'b0;

  #PERIOD //posedge
  #PERIOD //negedge
  // ce=0,wre=1のとき、データが書き込まれないことの確認
  test_dff(8'b10101010);

  data_in <= 8'b01010101;
  ce <= 1'b1;
  wre <= 1'b1;

  #PERIOD //posedge
  #PERIOD //negedge

  ce <= 1'b1;
  wre <= 1'b1;

  #PERIOD //posedge
  #PERIOD //negedge
  // ce=1,wre=1のとき、データが読み込まれないことの確認
  test_dff(8'b10101010);

  ce <= 1'b0;
  wre <= 1'b0;

  #PERIOD //posedge
  #PERIOD //negedge
  // ce=0のとき、データが読み込まれないことの確認
  test_dff(8'b10101010);
  
  addr <= 8'b00000001;
  data_in <= 8'b00001111;
  ce <= 1'b1;
  wre <= 1'b1;

  #PERIOD //posedge
  #PERIOD //negedge

  addr <= 8'b00000001;
  ce <= 1'b0;
  wre <= 1'b1;

  #PERIOD //posedge
  #PERIOD //negedge
  // 別のアドレスにも書き込まれることの確認
  test_dff(8'b00001111);
  
  addr <= 8'b00000000;
  ce <= 1'b0;
  wre <= 1'b1;

  #PERIOD //posedge
  #PERIOD //negedge
  // 上書きされないことの確認
  test_dff(8'b01010101);
  
  $finish;
end
  
task test_dff(
  input [7:0] e_data_out 
);
begin
  if(e_data_out !== 8'bxxxxxxxx && data_out !== e_data_out)
    $error("%t: data_out must be %b, but data_out is %b", $time, e_data_out, data_out);
  end
endtask

endmodule
