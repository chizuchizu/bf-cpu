`default_nettype none
module top (
    input wire IN_A,
    input wire IN_B,
    output wire OUT_A,
    output wire OUT_B
);

    assign  OUT_A = IN_A & IN_B;
    assign  OUT_B = IN_A | IN_B;

endmodule
`default_nettype wire