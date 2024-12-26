module logic_74HC541_tb ();

reg n_g1, n_g2;
reg [7:0] in;

wire [7:0] out; 

logic_74HC541 logic_74HC541_instance(
  .*
);

initial begin
  $dumpfile("logic_74HC541.vcd");
  $dumpvars(0, logic_74HC541_tb);
end

initial begin
    n_g1 <= 1'b0;
    n_g2 <= 1'b0;
    in <= 8'b00000000;
    
    #10
    test_dff(8'b00000000);
    in <= 8'b11111111;

    #10
    test_dff(8'b11111111);
    n_g1 <= 1'b1;
    n_g2 <= 1'b0;
    
    #10
    test_dff(8'bzzzzzzzz);
    n_g1 <= 1'b0;
    n_g2 <= 1'b1;

    #10
    test_dff(8'bzzzzzzzz);
    n_g1 <= 1'b1;
    n_g2 <= 1'b1;

    #10
    test_dff(8'bzzzzzzzz);
    in <= 8'b00000000;
    n_g1 <= 1'b1;
    n_g2 <= 1'b0;
    
    #10
    test_dff(8'bzzzzzzzz);
    n_g1 <= 1'b0;
    n_g2 <= 1'b1;

    #10
    test_dff(8'bzzzzzzzz);
    n_g1 <= 1'b1;
    n_g2 <= 1'b1;
 
    #10
    test_dff(8'bzzzzzzzz);

  $finish;
end

task test_dff(
  input [7:0] e_out 
);
begin
  if(out !== e_out)
    $error("%t: out must be %b, but out is %b", $time, e_out, out);
  end
endtask

endmodule
