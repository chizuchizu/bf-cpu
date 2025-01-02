BIN = \
        alu.out \
        general_register.out \
        zero_detector.out

.phony: all clean testall

all: $(BIN)

clean:
	rm -f $(BIN) *.out *.vcd

%.out: %.sv %_tb.sv
	iverilog -g2012 -o $@ $^

testall:
	./alu.out
	./general_register.out	
