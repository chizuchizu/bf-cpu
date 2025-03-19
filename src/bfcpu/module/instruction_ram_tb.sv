`timescale 1ns / 1ps

module instruction_ram_tb ();

parameter PERIOD = 10;

reg we_switch, oe_switch, we_manual, oe_manual;
reg [7:0] addr;
reg [7:0] in_manual;
wire [7:0] out;

instruction_ram instruction_ram_tb(
  .*
);

initial begin
  $dumpfile("instruction_ram.vcd");
  $dumpvars(0, instruction_ram_tb);
end

initial begin
  we_switch <= 1'b0;
  oe_switch <= 1'b0;
  we_manual <= 1'bz; 
  oe_manual <= 1'bz;
  addr <= 8'b00000000;
  in_manual <= 8'bzzzzzzzz;

  // addr = 00000001 に 00010000 
  // addr = 00000010 に 00100000
  // addr = 00000011 に 00110000
  #1
  we_switch <= 1'b1;
  oe_switch <= 1'b1; 
   
  #1
  oe_manual <= 1'b1;

  #1
  we_manual <= 1'b0;
  in_manual <= 8'b00010000;

  #PERIOD 
  we_manual <= 1'b1;
  addr <= 8'b00000001;
  
  #PERIOD
  we_manual <= 1'b0;
  in_manual <= 8'b00100000;

  #PERIOD
  we_manual <= 1'b1;
  addr <= 8'b00000010;

  #PERIOD
  we_manual <= 1'b0;
  in_manual <= 8'b00110000;

  #PERIOD
  oe_manual <= 1'bz;
  we_manual <= 1'bz;
  in_manual <= 8'bzzzzzzzz;

  #1
  oe_switch <= 1'b0;
  we_switch <= 1'b0; 
  addr <= 8'b00000000;

  // 代入された値がアドレスの変更によって出力されるかの確認
  #PERIOD
  test_dff(8'b00010000);
  addr <= addr + 1'b1;

  #PERIOD
  test_dff(8'b00100000);
  addr <= addr + 1'b1;

  #PERIOD
  test_dff(8'b00110000);
  addr <= addr + 1'b1;
  

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
