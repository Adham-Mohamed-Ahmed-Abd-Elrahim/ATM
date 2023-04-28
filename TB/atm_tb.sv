import  param::*;
`include "../RTL/rom.v"
`include "../RTL/single_port_ram.v"
`include "../RTL/card_handling.v"  
`include "../RTL/clk_divider.sv" 
`include "../RTL/ATM.sv" 
  `include "../RTL/atm_topmodule.sv" 


`timescale 1ns/1ns
module atm_tb ();
//_________________________________________________//
//________________module parameters_____________________//
//______________________________________________//
parameter DATA_WIDTH=16;
//arameter input_num_samples=50;
//----------------------------------
parameter clk_period = 12;

logic [WITHDRAW_SIZE-1:0] with_draw_val=15'd123;
logic [TRANSFER_SIZE-1:0] transfer_val=15'd123;
logic [1:0] operation_choice_rand;
logic valid_card_out;
logic cancel_en;
logic password_rand;
logic valid_card;
//_________________________________________________//
//________________ Test_bench parameters ____________//
//______________________________________________//

parameter ATM_CAPACITY_VAL=1234;
//typedef enum bit [3:0] { IDLE,CHECK_CARD,LANGUAGE_CHOICE,OPERATION_CHOICE,TRANSFER,BALANCE_SERVICE,WITHDRAWAL,DEPOSITE,ABORT } state_enum;
// States 
/*localparam IDLE=4'd0;
localparam CHECK_CARD=4'd1;
localparam LANGUAGE_CHOICE=4'd2;
localparam OPERATION_CHOICE=4'd3;
localparam TRANSFER=4'd4;
localparam BALANCE_SERVICE=4'd5;
localparam WITHDRAWAL=4'd6;
localparam DEPOSITE=4'd7;
localparam ABORT=4'd 8;*/
// Operation Choice 
localparam [OP_CHOICE_SIZE-1:0] DEPOSITE_OP =2'd0 ;
localparam [OP_CHOICE_SIZE-1:0] WITHDRAWAL_OP =2'd1 ;
localparam [OP_CHOICE_SIZE-1:0] BALANCE_SERVICE_OP =2'd2 ;
localparam [OP_CHOICE_SIZE-1:0] TRANSFER_OP =2'd3 ;
//_______________________________________________// 
//________________instantiation__________________// 
//_______________________________________________// 
       // -----------Clocks----------- //
     logic  clk;
      
     // -------Global reset -------//
    logic  rst_n;
// ------------------------------------------------//       
// -------------------  Outputs -------------------//
// ------------------------------------------------//       

  logic [CREDIT_VAL_SIZE-1:0] available_credit_out;
  logic abort;
  logic done;
  logic card_spell_out;



// ------------------------------------------------//       
// ----------------  STATE_MACHINE(sm) Inputs  --------//
// ------------------------------------------------//    
 
  logic atm_init;
  logic insert ;/////////  
  logic [ATM_CAP_SIZE-1:0] atm_capacity;
  logic [OP_CHOICE_SIZE-1:0] op_choice;
  logic language_choice;
  logic [PASSWORD_SIZE-1:0]input_password;
  logic [DEPOSITE_SIZE-1:0]deposite_value;
  logic [WITHDRAW_SIZE-1:0]withdrawal_value;
  logic enter;
  logic cancel;

 
// ------------------------------------------------//       
// ----------------  card_handler(ch) Inputs  ----------//
// ------------------------------------------------// 
 logic [PINCARD_SIZE-1:0] input_card_pin;
 logic [PINCARD_SIZE-1:0] transfer_card_pin;
 logic [UP_LIMIT_SIZE-1:0] up_limit;
 logic [TRANSFER_SIZE-1:0] transfer_value;
// ------------------------------------------------//       
// ----------------  Memories  ---------------//
// ------------------------------------------------// 
      logic [RAM_DATA_WIDTH-1:0] ram [0:DEPTH-1];
      logic [ROM_DATA_WIDTH-1:0] rom [0:DEPTH-1];
      integer     fd;
//_______________________________________________// 
//________________instantiation__________________// 
//_______________________________________________// 
       atm_top  atm_top_inst
        (
           // -----------Clocks----------- //
            .clk(clk),
          
             // -------Global reset -------//
            .rst_n(rst_n),
    // ------------------------------------------------//       
    // -------------------  Outputs -------------------//
    // ------------------------------------------------//       
    
            .available_credit_out(available_credit_out),
            .abort(abort),
            .done(done),
            .card_spell_out(card_spell_out),
    
       
    
    // ------------------------------------------------//       
    // ----------------  STATE_MACHINE(sm) Inputs  --------//
    // ------------------------------------------------//    
         
            .atm_init(atm_init),
            .insert(insert),   /////////  
            .atm_capacity(atm_capacity),
            .op_choice(op_choice),
            .language_choice(language_choice),
            .input_password(input_password),
            .deposite_value(deposite_value),
            .withdrawal_value(withdrawal_value),
            .enter(enter),
            .cancel(cancel),
    
         
    // ------------------------------------------------//       
    // ----------------  card_handler(ch) Inputs  ----------//
    // ------------------------------------------------// 
     .input_card_pin(input_card_pin),
     .transfer_card_pin(transfer_card_pin),
    // .up_limit(up_limit),
     .transfer_value(transfer_value)
    
    );
//_______________________________________________// 
//________________ stimuls ______________________// 
//_______________________________________________// 
    `include"cover.sv"
    `include"assertion.sv"
`ifdef withdrawal
  `include "TEST_CASES/withdrawal.sv"
  `endif
 `ifdef transfer
   `include "TEST_CASES/transfer.sv"
 `endif
    `ifdef rand
   `include "TEST_CASES/rand.sv"
 `endif
    `ifdef rand_no_cancels
    `include "TEST_CASES/rand_no_cancels.sv"
  `endif
    `ifdef tb_2
    `include "TEST_CASES/TB_2.sv"
  `endif
initial begin
  $readmemb("../Ref_Model/ATM/ram.txt", ram);   //update coff1
  $readmemb("../Ref_Model/ATM/rom.txt", rom);   //update coff2
    maintask();
    $stop;
    
   // $get_coverage(); 
  end

endmodule 