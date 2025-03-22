`timescale 1ns / 1ps

module waveform_generator_tb ();

parameter PERIOD = 10;

reg clk, n_clr;
wire first_waveform, second_waveform;

waveform_generator waveform_generator_tb(
  .*
);

always #(PERIOD) begin
  clk <= ~clk;
end

initial begin
  $dumpfile("waveform_generator.vcd");
  $dumpvars(0, waveform_generator_tb);
end

initial begin
  clk <= 1'b0;
  n_clr <= 1'b1;

  #1
  n_clr <= 1'b0;

  #1
  n_clr <= 1'b1;

  // n_clrが動作するかの確認
  test_dff(1'b1, 1'b1);

  // clk            : __|‾‾|__|‾‾|__|‾‾|__|‾‾|__|‾‾|__

  // first_waveform : ‾‾‾‾‾‾‾‾|_____|‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

  // second_waveform: ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾|_____|‾‾‾‾‾

  #PERIOD //posedge
  #PERIOD //negedge
  // first_waveform = 1,  second_waveform = 1 
  test_dff(1'b1, 1'b1);

  #PERIOD //posedge
  #PERIOD //negedge
  // first_waveform = 0,  second_waveform = 1 
  test_dff(1'b0, 1'b1);

  #PERIOD //posedge
  #PERIOD //negedge
  // first_waveform = 1,  second_waveform = 1 
  test_dff(1'b1, 1'b1);

  #PERIOD //posedge
  #PERIOD //negedge
  // first_waveform = 1,  second_waveform = 0 
  test_dff(1'b1, 1'b0);

  #PERIOD //posedge
  #PERIOD //negedge
  // first_waveform = 1,  second_waveform = 1
  test_dff(1'b1, 1'b1);

  $finish;
end

task test_dff(
  input e_first_waveform,
  input e_second_waveform 
);
  if(e_first_waveform !== 1'bx && first_waveform !== e_first_waveform) begin
    $error("%t: first_waveform must be %d, but first_waveform is %d", $time, e_first_waveform, first_waveform);
  end
  if(e_second_waveform !== 1'bx && second_waveform !== e_second_waveform) begin
    $error("%t: second_waveform must be %d, but second_waveform is %d", $time, e_second_waveform, second_waveform);
  end
endtask

endmodule
