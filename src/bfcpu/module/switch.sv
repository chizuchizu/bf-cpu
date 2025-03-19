`ifndef SWITCH
`define SWTICH

module switch(
  input signal,
  input in,

  output out
);

assign out = signal ? 1'bz : in;

endmodule

`endif
