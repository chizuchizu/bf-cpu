BIN = \
        alu.out \
        general_register.out \
        zero_detector.out \
        equal_detector.out\
        stack_pointer.out \
        bram_primitive.out \
        decoder.out \
        asynchronous_ram.out \
        data_ram.out

.phony: all clean testall

all: $(BIN)

clean:
	rm -f $(BIN) *.out *.vcd

%.out: %.sv %_tb.sv
	iverilog -g2012 -o $@ $^

testall:
	./alu.out
	./general_register.out
	./zero_detector.out
	./equal_detector.out
	./stack_pointer.out
	./bram_primitive.out
	./decoder.out
	./asynchronous_ram.out
