import  param::*;
interface intf1#(parameter ADDR_WIDTH=32,DATA_WIDTH=32);

  // -----------Clocks----------- //
       bit  clk;
      
         // -------Global reset -------//
       bit  rst_n;
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
        logic insert;   /////////  
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
//input logic [UP_LIMIT_SIZE-1:0] up_limit,
  logic [TRANSFER_SIZE-1:0] transfer_value;
//Internal signals 
logic  [3:0]  current_state,next_state;

  endinterface 