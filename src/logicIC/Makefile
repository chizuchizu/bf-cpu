BIN = \
        74HC00.out \
        74HC02.out

all: $(BIN)

clean:
	rm -f $(BIN) *.out *.vcd

74HC00.out: \
		74HC00.sv \
		74HC00_tb.sv
	iverilog -g2012 -o $@ $^

74HC02.out: \
		74HC02.sv \
		74HC02_tb.sv
	iverilog -g2012 -o $@ $^
