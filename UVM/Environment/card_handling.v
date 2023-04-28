`include "rom.v"
`include "single_port_ram.v"
module card_handling #(parameter  FINAL_UP_LIMIT_WIDTH   = 15,
                                  AVAILABLE_CREDIT_WIDTH = 25,
                                  TRANSFER_SIZE          = 15,
                                  RAM_DATA_WIDTH         = FINAL_UP_LIMIT_WIDTH + AVAILABLE_CREDIT_WIDTH,
                                  ROM_DATA_WIDTH         = 17,
                                  MEM_SIZE               = 64)
(
    // input & output ports

    input  wire                        clk,
    
    //-------------------------------------------------
    //              From USER
    //-------------------------------------------------
    input  wire [$clog2(MEM_SIZE)-1:0] input_card_pin,
    input  wire                        insert,

    //-------------------------------------------------
    //              From FSM
    //-------------------------------------------------
    input  wire                                        ram_write_enable,
    input  wire [$clog2(MEM_SIZE)-1:0]                 transfer_card_pin,
    input  wire                                        transfer_enable,
    input  wire [TRANSFER_SIZE-1:0]                    transfer_value,
    input  wire  [AVAILABLE_CREDIT_WIDTH-1:0]          final_credit,
    input  wire  [FINAL_UP_LIMIT_WIDTH-1:0]            final_up_limit,

    //-----------------------------------------------
    //               From RAM
    //-----------------------------------------------
    output wire [AVAILABLE_CREDIT_WIDTH-1:0] available_credit,
    output wire [FINAL_UP_LIMIT_WIDTH-1:0]   up_limit,

    //-----------------------------------------------
    //               From ROM
    //-----------------------------------------------
    output wire [ROM_DATA_WIDTH-2:0]   ref_password,
    output wire                        valid
);

//==============================================
//             internal signals
//==============================================
wire [ROM_DATA_WIDTH-1:0]   rom_data_out;
wire [$clog2(MEM_SIZE)-1:0] ram_addr;
wire [RAM_DATA_WIDTH-1:0]   ram_data_in;
wire [RAM_DATA_WIDTH-1:0]   ram_data_out;

wire [AVAILABLE_CREDIT_WIDTH-1:0] final_transfered_available_credit;

//==============================================
//             ROM instantiation
//==============================================
rom #(.ROM_DATA_WIDTH(ROM_DATA_WIDTH),
      .ROM_MEM_SIZE(MEM_SIZE))
card_handling_rom (
    // input & output ports
	.clk(clk),
	.read_enable(insert),
	.address(input_card_pin),
	.data_out(rom_data_out)
);

assign ref_password = rom_data_out[ROM_DATA_WIDTH-1:1];
assign valid        = rom_data_out[0];

//==============================================
//             RAM instantiation
//==============================================
single_port_ram #(.FINAL_UP_LIMIT_WIDTH(FINAL_UP_LIMIT_WIDTH),
                  .AVAILABLE_CREDIT_WIDTH(AVAILABLE_CREDIT_WIDTH),
                  .RAM_MEM_SIZE(MEM_SIZE))
card_handling_ram(
    // input & output ports
	.clk(clk),
	.write_enable(ram_write_enable),
	.address(ram_addr),
	.data_in(ram_data_in),
	.data_out(ram_data_out)
);

assign final_transfered_available_credit = available_credit + transfer_value;

assign available_credit = ram_data_out[AVAILABLE_CREDIT_WIDTH-1:0];
assign up_limit         = ram_data_out[RAM_DATA_WIDTH-1:AVAILABLE_CREDIT_WIDTH];

assign ram_data_in = transfer_enable ? {up_limit, final_transfered_available_credit} : {final_up_limit, final_credit};
assign ram_addr    = transfer_enable ? transfer_card_pin : input_card_pin;


endmodule