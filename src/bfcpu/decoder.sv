module decoder#(
    parameter WIDTH = 8
) (
    input [WIDTH-1:0] instruction,
    input skip_flag,
    input data_is_zero,     //value == 0
    input sp_eq_np,         //stack pointer == nest pointer

    output inp_gate,        //input gate
    output nochange_gate,
    output dec_gate,        //decrement signal
    output inc_gate,        //increment signal
    output adr_gate,        //adress register gate
    output val_gate,        //value register gate
    output stp_gate,        //stack pointer register gate

    output adr_reg_load,    //adress register load
    output stp_reg_load,    //stack pointer register load
    output nep_reg_load,    //nest pointer register load
    output flg_reg_load,    //flag register load
    output out_reg_load,    //output register load
    output prc_reg_load,    //program counter load 

    output stk_ram_load,    //stack RAM load
    output val_ram_load,    //stack RAM load
)