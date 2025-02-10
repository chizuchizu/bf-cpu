module decoder_tb();

logic [7:0] inst;
logic skip_flag;
logic data_is_zero;
logic sp_eq_np;

logic inp_gate;

logic nochange_gate;
logic dec_gate;
logic inc_gate;

logic adr_gate;
logic val_gate;
logic stp_gate;

logic adr_reg_load;
logic stp_reg_load;
logic nep_reg_load;
logic flg_reg_load;

logic val_ram_load;
logic stk_ram_load;

logic out_reg_load;
logic prc_reg_load;

decoder decoder_instance(
    .*
);

initial begin
    $dumpfile("decoder.vcd");
    $dumpvars(0, decoder_tb);
end

logic [5:0] in;
assign {inst[2], inst[1], inst[0], skip_flag, data_is_zero, sp_eq_np} = in;

logic [14:0] out;
assign out = {
                inp_gate, 
                nochange_gate,
                dec_gate, 
                inc_gate,
                adr_gate, 
                val_gate, 
                stp_gate, 
                adr_reg_load, 
                stp_reg_load, 
                nep_reg_load, 
                flg_reg_load, 
                val_ram_load, 
                stk_ram_load, 
                prc_reg_load, 
                out_reg_load
                };

initial begin

    // instruction ">"
    in <= 6'b000010;
    #10 test_out(15'b111001101111110);

    // instruction "<"
    in <= 6'b001010;
    #10 test_out(15'b110101101111110);

    // instruction "+"
    in <= 6'b010010;
    #10 test_out(15'b111010111110110);

    // instruction "-"
    in <= 6'b011010;
    #10 test_out(15'b110110111110110);

    // instruction "["
    in <= 6'b100000;
    #10 test_out(15'b111011010001010);

    in <= 6'b100010;
    #10 test_out(15'b111011010111010);

    in <= 6'b100110;
    #10 test_out(15'b101011010111010);

    // instruction "]"
    in <= 6'b101000;
    #10 test_out(15'b110111010111110);

    in <= 6'b101010;
    #10 test_out(15'b101111010111100);

    in <= 6'b101100;
    #10 test_out(15'b110111010111110);

    in <= 6'b101110;
    #10 test_out(15'b101111010111110);

    in <= 6'b101101;
    #10 test_out(15'b110111010101110);

    in <= 6'b101111;
    #10 test_out(15'b101111010101110);

    // instruction "input"
    in <= 6'b110010;
    #10 test_out(15'b011111111110110);

    // instruction "output"
    in <= 6'b111010;
    #10 test_out(15'b111110111111111);
end

task test_out(
    input [14:0] ans
);
begin
    if (out !== ans) $error("output must be %b but output is %b", ans, out);
end
endtask

endmodule
