module alu#(
  parameter WIDTH = 8
) (
  input [WIDTH-1:0] a,
  input nochange,
  input decrement,
  input increment,
  output [WIDTH-1:0] out
);

assign out = alu(a, nochange, decrement, increment);

function [WIDTH-1:0] alu(
  input [WIDTH-1:0] a,
  input nochange,
  input decrement,
  input increment);

begin
  if (nochange) begin
    alu = a;
  end else if(decrement) begin 
    alu = a - {WIDTH{1'd1}};
  end else if (increment) begin
    alu = a + {WIDTH{1'd1}};
  end
end
endfunction

endmodule