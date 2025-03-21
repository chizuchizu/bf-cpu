`timescale 1ns / 1ps

module stack_ram_tb ();

parameter PERIOD = 10;

reg n_we, n_oe, n_stack_ld, n_pc_ld;
reg [7:0] addr;
reg [7:0] in;
reg [7:0] out;

stack_ram stack_ram_tb(
  .*
);

initial begin
  $dumpfile("stack_ram.vcd");
  $dumpvars(0, stack_ram_tb);
end

initial begin
  n_we <= 1'b1;
  n_oe <= 1'b1;
  n_stack_ld <= 1'b0;
  n_pc_ld <= 1'b1;
  addr <= 8'b00000000;
  in <= 8'b00010010;

  #PERIOD
  #PERIOD

  #PERIOD
  n_oe <= 1'b0;
  n_we <= 1'b0;

  #PERIOD
  n_oe <= 1'b1;
  n_we <= 1'b1;

  n_stack_ld <= 1'b1;
  n_pc_ld <= 1'b0; 
  in <= 8'b00000000;

  #PERIOD
  #PERIOD

  #PERIOD
  n_oe <= 1'b0;
  n_we <= 1'b0;

  #1
  // adr = 00000000 に値が読み込まれ、さらに出力できるかの確認
  test_dff(8'b00010010);

  #PERIOD
  n_oe <= 1'b1;
  n_we <= 1'b1;


  n_stack_ld <= 1'b1;
  n_pc_ld <= 1'b1;
  in <= 8'b00100001;
  
  #PERIOD
  #PERIOD

  #PERIOD
  n_oe <= 1'b0;
  n_we <= 1'b0;

  #PERIOD
  n_oe <= 1'b1;
  n_we <= 1'b1;

  n_stack_ld <= 1'b1;
  n_pc_ld <= 1'b0;
  in <= 8'b00000000;

  #PERIOD
  #PERIOD

  #PERIOD
  n_oe <= 1'b0;
  n_we <= 1'b0;

  #1
  // n_stack_ldがネゲートされているときに値が読み込まれないことの確認
  test_dff(8'b00010010);

  #PERIOD
  n_oe <= 1'b1;
  n_we <= 1'b1;
  

  n_stack_ld <= 1'b1;
  n_pc_ld <= 1'b1;
  in <= 8'b00000000;

  #PERIOD
  #PERIOD

  #PERIOD
  n_oe <= 1'b0;
  n_we <= 1'b0;

  #1
  // n_pc_ldがアサートされていないとき、値が出力されない(output = H-Z、output of 3-state-buffer = H-Z)ことの確認
  test_dff(8'bzzzzzzzz);

  #PERIOD
  n_oe <= 1'b1;
  n_we <= 1'b1;


  n_stack_ld <= 1'b0;
  n_pc_ld <= 1'b1;
  addr <= 8'b00000001;
  in <= 8'b00111100;
  
  #PERIOD
  #PERIOD

  #PERIOD
  n_oe <= 1'b0;
  n_we <= 1'b0;

  #PERIOD
  n_oe <= 1'b1;
  n_we <= 1'b1;

  n_stack_ld <= 1'b1;
  n_pc_ld <= 1'b0;
  in <= 8'b00000000;

  #PERIOD
  #PERIOD

  #PERIOD
  n_oe <= 1'b0;
  n_we <= 1'b0;

  #1
  // adr = 00000001に値が読み込まれ、出力されることの確認
  test_dff(8'b00111100);

  #PERIOD
  n_oe <= 1'b1;
  n_we <= 1'b1;


  n_stack_ld <= 1'b1;
  n_pc_ld <= 1'b0;
  addr <= 8'b00000000;
  in <= 8'b00000000;

  #PERIOD
  #PERIOD

  #PERIOD
  n_oe <= 1'b0;
  n_we <= 1'b0;

  #1
  // adr = 00000000の値が保持されているかの確認
  test_dff(8'b00010010);

  #PERIOD
  n_oe <= 1'b1;
  n_we <= 1'b1;

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
