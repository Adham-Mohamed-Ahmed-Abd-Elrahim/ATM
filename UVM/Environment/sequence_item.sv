  //------------------------------------------------//
  //------------------- sequence_Item --------------------//
  //------------------------------------------------// 
class sequence_item extends uvm_sequence_item ;
      `uvm_object_utils(sequence_item)
    function new(string name = "sequence_item");
      super.new(name);
    endfunction
    // Module state variables 
    parameter ADDR_WIDTH=32;
    parameter DATA_WIDTH=32;
      
         // -------Global reset -------//
       logic  rst_n;
		logic clk;
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

   logic [PASSWORD_SIZE-1:0]input_password;
 
        logic    enter;
       logic  cancel;

// ------------------------------------------------//       
// ----------------  Internal Signals --------//
// ------------------------------------------------//    
logic  [3:0]  current_state,next_state;
// Operation Choice 
// ------------------------------------------------//       
// ----------------  card_handler(ch) Inputs  ----------//
// ------------------------------------------------// 

//input logic [UP_LIMIT_SIZE-1:0] up_limit,

    //Module Random Variables
    /*randc  bit  [DATA_WIDTH-1:0]     addr;
    randc  bit  [ADDR_WIDTH-1:0]  data_in;*/
  randc  bit  [PINCARD_SIZE-1:0] input_card_pin;
  randc  bit  [PINCARD_SIZE-1:0] transfer_card_pin;
  randc  bit  [DEPOSITE_SIZE-1:0]deposite_value;
   randc  bit  [WITHDRAW_SIZE-1:0]withdrawal_value;
   randc  bit  [ATM_CAP_SIZE-1:0] atm_capacity;
   randc  bit  [OP_CHOICE_SIZE-1:0] op_choice;
  randc  bit  language_choice;
  randc bit [TRANSFER_SIZE-1:0] transfer_value;
    //Randomization Constrains
  constraint input_card_pin_constrains {input_card_pin inside{[0:DEPTH-1]};};
  constraint transfer_card_pin_constrains {transfer_card_pin inside{[0:DEPTH-1]};};
  constraint deposite_value_constrains {deposite_value inside{[0:32767-1]};};
  constraint withdrawal_value_constrains {withdrawal_value inside{[0:32767-1]};};
  constraint transfer_value_constrains {transfer_value inside{[0:32767-1]};};
  constraint atm_capacity_constrains {atm_capacity inside{[0:10000000-1]};};
  constraint op_choice_constrains {op_choice inside{[0:3]};};
  constraint language_choice_constrains {language_choice inside{[0:1]};};
  endclass //className extends superClass
