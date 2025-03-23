module decoder#(
    parameter WIDTH = 8
) (
    input [WIDTH-1:0] inst,
    input skip_flag,
    input data_is_zero,     //value == 0
    input sp_eq_np,         //stack pointer == nest pointer

    output inp_gate,        //input gate

    output nochange_gate,   //nochange signal
    output dec_gate,        //decrement signal
    output inc_gate,        //increment signal

    output adr_gate,        //adress register gate
    output val_gate,        //value RAM gate
    output stp_gate,        //stack pointer register gate

    output adr_reg_load,    //adress register load
    output stp_reg_load,    //stack pointer register load
    output nep_reg_load,    //nest pointer register load
    output flg_reg_load,    //flag register load

    output val_ram_load,    //value RAM load
    output stk_ram_load,    //stack RAM load

    output prc_reg_load    //program counter load 
    output out_reg_load,    //output register load
);

    assign {inp_gate, nochange_gate, dec_gate, inc_gate, adr_gate, val_gate, stp_gate,
            adr_reg_load, stp_reg_load, nep_reg_load, flg_reg_load,
            val_ram_load, stk_ram_load, prc_reg_load, out_reg_load} = decode({inst, skip_flag, data_is_zero, sp_eq_np})

    function [14:0] decode(input [10:0] insn);
        casex(insn)
            11'b00000000_0_xx:                  // increment address 
                return {15'b111001101111110};
            11'b00000000_1_xx:                  // increment address skip
                return {15'b101101101111110};
            11'b00000001_0_xx:                  // decrement address
                return {15'b110101101111110};
            11'b00000001_1_xx:                  // decrement address skip
                return {15'b101101101111110};
            11'b00000010_0_xx:                  // increment value
                return {15'b111010111110110};
            11'b00000010_1_xx:                  // increment value skip
                return {15'b101110111110110};
            11'b00000011_0_xx:                  // decrement value
                return {15'b110110111110110};
            11'b00000011_1_xx:                  // decrement value skip
                return {15'b101110111110110};
            11'b00000100_0_0x:                  // jump next close loop
                return {15'b111111010001010};
            11'b00000100_0_1x:                  // increment stack
                return {15'b111011010111010};
            11'b00000100_1_xx:                  // increment stack skip
                return {15'b101111010111010};
            11'b00000101_0_0x:                  // decrement stack
                return {15'b110111010111110};
            11'b00000101_0_1x:                  // jump back nest
                return {15'b111111010111100};
            11'b00000101_1_00:                  // decrement stack
                return {15'b110111010111110};
            11'b00000101_1_01:                  // skip end
                return {15'b110111010101110};
            11'b00000101_1_10:                  // skip
                return {15'b101111010111110};
            11'b00000101_1_11:                  // skip end and back
                return {15'b101111010101110};
            11'b00000110_0_xx:                  // input
                return {15'b011110111110110};
            11'b00000110_1_xx:                  // input skip
                return {15'b111111111110110};
            11'b00000111_0_xx:                  // output
                return {15'b111111111111111};
            11'b00000111_1_xx:                  // output skip
                return {15'b111111111111110};
        endcase
    endfunction

endmodule

            
            
            
endmodule
