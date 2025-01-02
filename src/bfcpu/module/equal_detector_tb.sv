module equal_detector_tb ();

reg [7:0]in1;
reg [7:0]in2;

wire out;

equal_detector equal_detector_tb(
  .*
);

initial begin
  $dumpfile("equal_detector.vcd");
  $dumpvars(0, equal_detector_tb);
end

initial begin
  in1 <= 8'd0;
  in2 <= 8'd0;

  #1
    // 0 == 0 より1が出力
    test_dff(1);
    
    in2 <= 8'd1;

  #1
    // 0 == 1 より0が出力
    test_dff(0);

    in1 <= 8'b11111111;
    in2 <= 8'b11111111;

  #1
    // in1が境界地のときのテスト
    test_dff(1);
    
    in2 <= 8'b11111110;

  #1
    // in1が境界地のときのテスト
    test_dff(0);

    in2 <= 8'b00000000;

  $finish;
end

task test_dff(
  input e_out 
);
begin
  if(e_out !== 1'bx && out !== e_out)
    $error("%t: out must be %d, but out is %d", $time, e_out, out);
  end
endtask

endmodule
