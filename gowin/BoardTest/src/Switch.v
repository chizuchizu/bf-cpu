module switch (
    input sys_clock,
    input switch_in,
    output reg switch_out 
);

reg [7:0] div_clk;
reg [2:0] counter;

always @(posedge sys_clock) begin
    div_clk <= div_clk + 8'b1;
end

always @(posedge sys_clock) begin
    if(div_clk == 8'd255) begin
        if(switch_out) begin
            if(switch_in) begin
                counter <= counter + 3'b1;
                /*if(counter == 3'd7) begin
                    switch_out  <= ~switch_out;
                end*/
            end else begin
                counter <= 3'b0;
            end
        end else begin
            if(~switch_in) begin
                counter <= counter + 3'b1;
                /*if (counter == 3'd7) begin
                    switch_out <= ~switch_out;
                end*/
            end else begin
                counter <= 3'b0;
            end
        end
        if (counter == 3'd7) begin
            switch_out <= ~switch_out;
        end
    end
end

endmodule