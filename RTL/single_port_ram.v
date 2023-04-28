module single_port_ram #(parameter  FINAL_UP_LIMIT_WIDTH   = 15,
                                    AVAILABLE_CREDIT_WIDTH = 25,
                                    RAM_DATA_WIDTH         = FINAL_UP_LIMIT_WIDTH + AVAILABLE_CREDIT_WIDTH,
                                    RAM_MEM_SIZE           = 64)
(
    // input & output ports
	input  wire                             clk,
	input  wire                             write_enable,
	input  wire  [$clog2(RAM_MEM_SIZE)-1:0] address,
	input  wire  [RAM_DATA_WIDTH-1:0]       data_in,
	output wire   [RAM_DATA_WIDTH-1:0]       data_out
);

//-----------------------------------------------
//-------------  Memory Decleration -------------
//-----------------------------------------------
reg [RAM_DATA_WIDTH-1:0] memory [0:RAM_MEM_SIZE-1];

//-----------------------------------------------
//----------------- Memory Logic ----------------
//-----------------------------------------------
always  @(posedge clk) begin
    if (write_enable) begin
        memory[address] <= data_in; 
    end

end

//-----------------------------------------------
//------------ Memory Initialization ------------
//-----------------------------------------------
initial begin
    $readmemb("../Ref_Model/ATM/ram.txt", memory) ;
end
assign data_out=memory[address];
endmodule
