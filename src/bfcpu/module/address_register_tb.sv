`timescale 1ns / 1ps

module address_register_tb ();

parameter PERIOD = 10;

reg clk;
reg n_adr_gate, n_adr_ld, n_clr;
reg [7:0] in;
wire [7:0] addr_out;
wire [7:0] out;

address_register address_register_tb(
  .*
);

initial begin
  $dumpfile("address_register.vcd");
  $dumpvars(0, address_register_tb);
end

always #(PERIOD) begin
  clk <= ~clk;
end

initial begin
  clk <= 1'b0;
  n_adr_gate <= 1'b1; 
  n_adr_ld <= 1'b1;
  n_clr <= 1'b1;
  in <= 8'b00000001;

  #1
  n_clr <= 1'b0;

  #1
  n_clr <= 1'b1;

  #PERIOD
  #PERIOD
  // n_adr_gate がネゲートされているのでハイインピーダンス
  test_dff(8'bzzzzzzzz, 8'b00000000);

  n_adr_gate <= 1'b0;
  n_adr_ld <= 1'b0;

  #PERIOD
  #PERIOD
  // 値が代入されるかの確認
  test_dff(8'b00000001, 8'b00000001);

  n_adr_ld <= 1'b1;
  in <= 8'b00000010;

  #PERIOD
  #PERIOD
  // n_adr_ld がネゲートされたときに、値が代入されないことの確認
  test_dff(8'b00000001, 8'b00000001);

  $finish;
  
end

task test_dff(
  input [7:0] e_out,
  input [7:0] e_addr_out
); 
  if(e_out !== 8'bxxxxxxxx && out !== e_out) begin
    $error("%t: out must be %b, but out is %b",$time, e_out, out);
  end
  if(addr_out !== 8'bxxxxxxxx && addr_out !== e_addr_out) begin
    $error("%t: addr_out must be %b, but addr_out is %b",$time, e_addr_out, addr_out);
  end
endtask
endmodule
