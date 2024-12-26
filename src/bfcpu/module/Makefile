BIN =

.phony: all clean testall

all: %(BIN)

clean:
	rm -f $(BIN) *.out *.vcd

%.out: %.sv
	iverilog -g2012 -o $@ $^

testall:
