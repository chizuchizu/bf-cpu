module data_ram (
  input n_we,
  input n_oe,
  input n_ce,
  input n_val_gate,
  input n_val_ld,
  input n_clr,
  input [7:0] adr,
  input [7:0] in,

  output [7:0] out,
  output n_detect_zero
);

endmodule
