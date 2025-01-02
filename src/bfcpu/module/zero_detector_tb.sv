module zero_detector_tb ();

logic [7:0] in;
logic out;

zero_detector zero_detector_instance(
	.*
);

initial begin
	$dumpfile("zero_detector.vcd");
	$dumpvars(0, zero_detector_tb);
end

initial begin
	in <= 8'b00000000;
	#10 test_out(1'b0);

	in <= 8'b00000001;
	#10 test_out(1'b1);

	in <= 8'b00000010;
	#10 test_out(1'b1);

	in <= 8'b00000100;
	#10 test_out(1'b1);

	in <= 8'b00001000;
	#10 test_out(1'b1);

	in <= 8'b00010000;
	#10 test_out(1'b1);

	in <= 8'b00100000;
	#10 test_out(1'b1);

	in <= 8'b01000000;
	#10 test_out(1'b1);

	in <= 8'b10000000;
	#10 test_out(1'b1);

	in <= 8'b11111111;
	#10 test_out(1'b1);

end

task test_out(
	input ans
);
begin
	if (out != ans) $error("out must be %b but output is %b", ans, out);
end
endtask

endmodule
