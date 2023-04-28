`timescale 1 ns/1 ps
`include "param_pkg.sv"
import  param::*;
`include "card_handling.v"
`include "ATM.sv"
import param::*;
module atm_top 
    (
       // -----------Clocks----------- //
       input  clk,
      
         // -------Global reset -------//
       input  rst_n,
// ------------------------------------------------//       
// -------------------  Outputs -------------------//
// ------------------------------------------------//       

       output logic [CREDIT_VAL_SIZE-1:0] available_credit_out,
       output logic abort,
       output logic done,
       output logic card_spell_out,

   

// ------------------------------------------------//       
// ----------------  STATE_MACHINE(sm) Inputs  --------//
// ------------------------------------------------//    
     
       input logic atm_init,
       input logic insert,   /////////  
       input logic [ATM_CAP_SIZE-1:0] atm_capacity,
       input logic [OP_CHOICE_SIZE-1:0] op_choice,
       input logic language_choice,
       input logic [PASSWORD_SIZE-1:0]input_password,
       input logic [DEPOSITE_SIZE-1:0]deposite_value,
       input logic [WITHDRAW_SIZE-1:0]withdrawal_value,
       input logic enter,
       input logic cancel,

     
// ------------------------------------------------//       
// ----------------  card_handler(ch) Inputs  ----------//
// ------------------------------------------------// 
input logic [PINCARD_SIZE-1:0] input_card_pin,
input logic [PINCARD_SIZE-1:0] transfer_card_pin,
//input logic [UP_LIMIT_SIZE-1:0] up_limit,
input logic [TRANSFER_SIZE-1:0] transfer_value

);
// ------------------------------------------------\\      
// ------- Interconnect Signals (src_signal_dst) -----//    <-------1) Interconnect signals Section
//\\ -----------------------------------------------// 
/////////// From  card_handler to state_machine
 logic [CREDIT_VAL_SIZE-1:0] ch_available_credit_sm;
 logic [PASSWORD_SIZE-1:0]  ch_ref_password_sm;
 logic                      ch_valid_cm;
 logic [UP_LIMIT_SIZE-1:0]  ch_up_limit_sm;
/////////// From state_machine to card_handler
logic [CREDIT_VAL_SIZE-1:0] sm_final_credit_ch;
logic [UP_LIMIT_SIZE-1:0]   sm_final_up_limit_ch;
logic                       sm_transfer_en_ch;
logic                       sm_wr_en_ch;
// ------------------------------------------------\\      
// ------- Interconnect Signals (src_signal_dst) -----//    <-------1) Interconnect signals Section
//\\ -----------------------------------------------// 
 atm  atm_inst
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
        .final_credit(sm_final_credit_ch),
        .final_up_limit(sm_final_up_limit_ch),
        .transfer_en(sm_transfer_en_ch),
        .wr_en(sm_wr_en_ch),
// ------------------------------------------------//       
// -------------------  Inputs  -------------------//
// ------------------------------------------------//    
       
        .atm_init(atm_init),
        .insert(insert),
        .atm_capacity(atm_capacity),
        .op_choice(op_choice),
        .language_choice(language_choice),
        .input_password(input_password),
        .deposite_value(deposite_value),
        .withdrawal_value(withdrawal_value),
        .transfer_value(transfer_value),
        .enter(enter),
        .cancel(cancel), 
        .available_credit(ch_available_credit_sm),
        .ref_password(ch_ref_password_sm),
        .valid(ch_valid_cm),
        .up_limit(ch_up_limit_sm)
);

 card_handling #(  .FINAL_UP_LIMIT_WIDTH(UP_LIMIT_SIZE) ,
       .AVAILABLE_CREDIT_WIDTH (CREDIT_VAL_SIZE),
       .TRANSFER_SIZE(TRANSFER_SIZE),
       .RAM_DATA_WIDTH         (RAM_DATA_WIDTH),
       .ROM_DATA_WIDTH          (ROM_DATA_WIDTH),
       .MEM_SIZE                (DEPTH)
 ) 
 card_handler 
(
// input & output ports

 .clk(clk),

//-------------------------------------------------
//              From USER
//-------------------------------------------------
.input_card_pin(input_card_pin),
.insert(insert),

//-------------------------------------------------
//              From FSM
//-------------------------------------------------
.ram_write_enable(sm_wr_en_ch),
 .transfer_card_pin(transfer_card_pin),
 .transfer_enable(sm_transfer_en_ch),
 .transfer_value(transfer_value),
.final_credit(sm_final_credit_ch),
.final_up_limit(sm_final_up_limit_ch),

//-----------------------------------------------
//               From RAM
//-----------------------------------------------
 .available_credit(ch_available_credit_sm),
 .up_limit(ch_up_limit_sm),

//-----------------------------------------------
//               From ROM
//-----------------------------------------------
    .ref_password(ch_ref_password_sm),
    .valid(ch_valid_cm)
);

endmodule 