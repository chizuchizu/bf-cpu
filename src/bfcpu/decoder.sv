module decoder#(
    parameter WIDTH = 8
) (
    input [WIDTH-1:0] inst,
    input skip_flag,
    input data_is_zero,     //value == 0
    input sp_eq_np,         //stack pointer == nest pointer

    output nochange_sig,   //nochange signal
    output dec_sig,        //decrement signal
    output inc_sig,        //increment signal

    output inp_gate,        //input gate
    output adr_gate,        //adress register gate
    output stp_gate,        //stack pointer register gate
    output val_gate,        //value RAM gate

    output adr_reg_load,    //adress register load
    output stp_reg_load,    //stack pointer register load
    output nep_reg_load,    //nest pointer register load
    output flg_reg_load,    //flag register load
    output out_reg_load,    //output register load
    output prc_reg_load,    //program counter load 

    output stk_ram_load,    //stack RAM load
    output val_ram_load,    //value RAM load
);

assign {adr_gate, val_gate, stp_gate, inp_gate} = decode_gate(inst[2:0]);

function [3:0] decode_gate(input [2:0] inst);

    casex (inst)
        3'b00x:
            decode_gate = 4b'1000;
        3'b01x:
            decode_gate = 4b'0100;
        3'b10x:
            decode_gate = 4b'0010;
        3'b110:
            decode_gate = 4b'0001;
    endcase

endfunction