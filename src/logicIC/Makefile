BIN = \
        74HC00.out \
        74HC02.out \
        74HC04.out \
        74HC08.out \
        74HC32.out

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

74HC04.out: \
		74HC04.sv \
		74HC04_tb.sv
	iverilog -g2012 -o $@ $^

74HC08.out: \
		74HC08.sv \
		74HC08_tb.sv
	iverilog -g2012 -o $@ $^

74HC32.out: \
		74HC32.sv \
		74HC32_tb.sv
	iverilog -g2012 -o $@ $^
