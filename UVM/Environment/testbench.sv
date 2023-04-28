// Code your testbench here
// or browse Examples
import  param::*;

  `include "design.sv" 

`include "interface.sv"

  package uvm_pack;
      import uvm_pkg ::*;
      export uvm_pkg ::*;
      `include "uvm_macros.svh" ;

  //__________________class declarations __________________// 
`include "uvm_classes.sv"

`timescale 1ns/1ns
module atm_tb ();
  import uvm_pkg ::*;
      import uvm_pack::*;
    `include "uvm_macros.svh" ;
      
    intf1 intf1_in ();
//_________________________________________________//
//________________module parameters_____________________//
//______________________________________________//
parameter DATA_WIDTH=16;
//arameter input_num_samples=50;
//----------------------------------
parameter clk_period = 12;


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
            .clk(intf1_in.clk),
          
             // -------Global reset -------//
            .rst_n(intf1_in.rst_n),
    // ------------------------------------------------//       
    // -------------------  Outputs -------------------//
    // ------------------------------------------------//       
    
            .available_credit_out(intf1_in.available_credit_out),
            .abort(intf1_in.abort),
            .done(intf1_in.done),
            .card_spell_out(intf1_in.card_spell_out),
    
       
    
    // ------------------------------------------------//       
    // ----------------  STATE_MACHINE(sm) Inputs  --------//
    // ------------------------------------------------//    
         
            .atm_init(intf1_in.atm_init),
            .insert(intf1_in.insert),   /////////  
            .atm_capacity(intf1_in.atm_capacity),
            .op_choice(intf1_in.op_choice),
            .language_choice(intf1_in.language_choice),
            .input_password(intf1_in.input_password),
            .deposite_value(intf1_in.deposite_value),
            .withdrawal_value(intf1_in.withdrawal_value),
            .enter(intf1_in.enter),
            .cancel(intf1_in.cancel),
    
         
    // ------------------------------------------------//       
    // ----------------  card_handler(ch) Inputs  ----------//
    // ------------------------------------------------// 
     .input_card_pin(intf1_in.input_card_pin),
     .transfer_card_pin(intf1_in.transfer_card_pin),
    // .up_limit(up_limit),
     .transfer_value(intf1_in.transfer_value)
    
    );
//_______________________________________________// 
//________________ stimuls ______________________// 
//_______________________________________________// 

  `include "assertion.sv"
initial begin

    $dumpfile("dump.vcd");
        $dumpvars(0,atm_tb);
        uvm_config_db #(virtual intf1)::set(null,"uvm_test_top","vif",intf1_in);
        run_test("test");
    $stop;
    
   // $get_coverage(); 
  end
 always #5 intf1_in.clk=~intf1_in.clk;
assign intf1_in.current_state=atm_top_inst.atm_inst.current_state;
assign intf1_in.next_state=atm_top_inst.atm_inst.next_state;

endmodule 