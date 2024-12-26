BIN = \
        logic_74HC00.out \
        logic_74HC02.out \
        logic_74HC04.out \
        logic_74HC08.out \
        logic_74HC32.out \
        logic_74HC74.out \
        logic_74HC283.out \
        logic_74HC161.out \
        logic_74HC273.out \
        logic_74HC541.out

.phony: all clean testall

all: $(BIN)

clean:
	rm -f $(BIN) *.out *.vcd

%.out: %.sv
	iverilog -g2012 -o $@ $^

testall: 
	./logic_74HC00.out
	./logic_74HC02.out
	./logic_74HC04.out
	./logic_74HC08.out
	./logic_74HC32.out
	./logic_74HC74.out
	./logic_74HC283.out
	./logic_74HC273.out
	./logic_74HC161.out
	./logic_74HC541.out
