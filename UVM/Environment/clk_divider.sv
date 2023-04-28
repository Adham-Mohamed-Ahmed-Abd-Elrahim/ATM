module clock_divider
    #(parameter SLOW_CLK_COUNTER_SIZE=5,DIVISOR=16)
     (
    input clk,
    input rst_n,
    output  slow_clk

);
reg [SLOW_CLK_COUNTER_SIZE-1:0] counter;

    always @( posedge clk,negedge rst_n ) begin : blockName
        if(!rst_n)begin
            counter<=1'b0; 
        end
        else begin
            counter<=counter+1;
        end
    end
    assign slow_clk=counter[$clog2(DIVISOR)-1];
endmodule