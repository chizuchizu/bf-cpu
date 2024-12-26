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

all: $(BIN)

clean:
	rm -f $(BIN) *.out *.vcd

logic_74HC00.out: \
		logic_74HC00.sv \
		logic_74HC00_tb.sv
	iverilog -g2012 -o $@ $^

logic_74HC02.out: \
		logic_74HC02.sv \
		logic_74HC02_tb.sv
	iverilog -g2012 -o $@ $^

logic_74HC04.out: \
		logic_74HC04.sv \
		logic_74HC04_tb.sv
	iverilog -g2012 -o $@ $^

logic_74HC08.out: \
		logic_74HC08.sv \
		logic_74HC08_tb.sv
	iverilog -g2012 -o $@ $^

logic_74HC32.out: \
		logic_74HC32.sv \
		logic_74HC32_tb.sv
	iverilog -g2012 -o $@ $^

logic_74HC74.out: \
		logic_74HC74.sv \
		logic_74HC74_tb.sv
	iverilog -g2012 -o $@ $^

logic_74HC283.out: \
		logic_74HC283.sv \
		logic_74HC283_tb.sv
	iverilog -g2012 -o $@ $^

logic_74HC273.out: \
		logic_74HC273.sv \
		logic_74HC273_tb.sv
	iverilog -g2012 -o $@ $^

logic_74HC161.out: \
		logic_74HC161.sv \
		logic_74HC161_tb.sv
	iverilog -g2012 -o $@ $^

logic_74HC541.out: \
		logic_74HC541.sv \
		logic_74HC541_tb.sv
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
