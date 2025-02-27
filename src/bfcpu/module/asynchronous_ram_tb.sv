`timescale 1ns / 1ps

module asynchronous_ram_tb ();

parameter PERIOD = 10;

reg [7:0] data_in;
reg [7:0] addr;
reg n_ce, ce, n_we, n_oe;

wire [7:0] data_inout;

assign data_inout = data_in;

asynchronous_ram asynchronous_ram_tb(
  .*
);

initial begin
  $dumpfile("asynchronous_ram.vcd");
  $dumpvars(0, asynchronous_ram_tb);
end

initial begin
  n_ce <= 1'b1;
  ce <= 1'b0;
  n_we <= 1'b1;
  n_oe <= 1'b1; 

  data_in <= 8'd0;
  addr <= 8'd0;

  #PERIOD
  // ce = 0、n_ce = 1、Deselectなので、ハイインピーダンス、よって= data_in
  test_dff(8'd0);

  ce <= 1'b1;

  #PERIOD
  // ce = 1、n_ce = 1、Deselectなので、ハイインピーダンス、よって= data_in
  test_dff(8'd0); 

  ce <= 1'b0;
  n_ce <= 1'b0;

  #PERIOD
  // ce = 0、n_ce = 0、Deselectなので、ハイインピーダンス、よって= data_in
  test_dff(8'd0); 
  
  ce <= 1'b1;

  #PERIOD
  // n_oe = 1、n_we = 1、Readなので、ハイインピーダンス、よって= data_in
  test_dff(8'd0); 

  n_we <= 1'b0;
  n_oe <= 1'b1; 
  data_in <= 8'b10101001;

  #PERIOD
  // n_oe = 1、n_we = 0、writeなので、ハイインピーダンス、よって= data_in
  test_dff(8'b10101001); 
  
  n_we <= 1'b1; //weコントロールで書き込み

  data_in <= 8'bzzzzzzzz;

  #PERIOD
  // data_in、data_inoutともにハイインピーダンスなので、= z 
  test_dff(8'bzzzzzzzz); 

  n_oe <= 1'b0; //reコントロールで読み込み

  #PERIOD
  // n_oe = 0、n_we = 1、readなので、= mem[addr = 0]
  test_dff(8'b10101001); 
  
  n_we <= 1'b0;
  data_in <= 8'b01010110;
  addr <= 8'b00000001;

  #PERIOD
  // n_oe = 0、n_we = 0、writeなので、ハイインピーダンス、よって= data_in
  test_dff(8'b01010110); 

  n_we <= 1'b1; //weコントロールで書き込み
  n_oe <= 1'b0; //reコントロールで読み込み
  data_in <= 8'bzzzzzzzz;

  #PERIOD
  // n_oe = 0、n_we = 1、readなので、= mem[addr = 1]
  test_dff(8'b01010110); 

  addr <= 8'b00000000; //addrコントロールで読み込み

  #PERIOD
  // n_oe = 0、n_we = 1、readなので、= mem[addr = 0]
  test_dff(8'b10101001); 

  n_we <= 1'b0;
  n_oe <= 1'b1;
  ce <= 1'b0;

  #PERIOD
  // ce = 0、deselectedなので、= data_in 
  test_dff(8'bzzzzzzzz); 

  ce <= 1'b1;
  data_in <= 8'b00001111;

  #PERIOD
  // ce = 1、we = 0、writeなので、= data_in 
  test_dff(8'b00001111); 

  ce <= 1'b0; //ceコントロールで書き込み

  #PERIOD
  // ce = 0、deselectedなので、= data_in 
  test_dff(8'bzzzzzzzz); 

  n_we <= 1'b1;
  n_oe <= 1'b0;

  #PERIOD

  ce <= 1'b1; //ceコントロールで読み込み

  #PERIOD
  // ce = 1、n_oe = 0、n_we = 1、readなので、= mem[addr = 0]
  test_dff(8'b00001111); 
  
  $finish;
end

task test_dff(
  input [7:0] e_data_inout
);
begin
  if(e_data_inout !== 8'bxxxxxxxx && data_inout !== e_data_inout)
    $error("%t: data_inout must be %b, but data_inout is %b", $time, e_data_inout, data_inout);
  end
endtask

endmodule
