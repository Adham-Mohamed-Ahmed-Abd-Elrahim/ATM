 //------------------------------------------------//
  //------------------- driver --------------------//
  //-----------------------------------------------//

  class driver extends uvm_driver #(sequence_item) ;
      `uvm_component_utils(driver)
    function new(string name = "driver",uvm_component parent=null);
      super.new(name,parent);
    endfunction
      virtual intf1 driver_virtual ;
    sequence_item  seq_item_in;
      //------- build phase -------//
    function void build_phase (uvm_phase phase);
  super.build_phase(phase);
       if(!(uvm_config_db #(virtual intf1)::get(this,"","vif",driver_virtual)))
         `uvm_fatal(get_full_name(),"Error!")
         seq_item_in= sequence_item::type_id::create("seq_item_in");    
  $display("driver_build_phase");
  endfunction
   //------- connect phase -------//
    function void connect_phase (uvm_phase phase);
  super.connect_phase(phase);
  $display("driver_connect_phase");
  endfunction
   //------- run phase -------//
    task  run_phase (uvm_phase phase);
  super.run_phase(phase);
      forever begin
   
        seq_item_port.get_next_item(seq_item_in);
        $display("After next item (DRIVER)");
        //tiing between seq item and virtual interface
        @(posedge driver_virtual.clk)
// ------------------------------------------------//       
// ----------------  STATE_MACHINE(sm) Inputs  --------//
// ------------------------------------------------//    
         driver_virtual.rst_n<=seq_item_in.rst_n;
        driver_virtual.atm_init<=seq_item_in.atm_init;
        driver_virtual.insert<=seq_item_in.insert;   /////////  
    
        driver_virtual.input_password<=seq_item_in.input_password; 
 
        driver_virtual.enter<=seq_item_in.enter;
        driver_virtual.cancel<=seq_item_in.cancel;

     
// ------------------------------------------------//       
// ----------------  card_handler(ch) Inputs  ----------//
// ------------------------------------------------// 

//input logic [UP_LIMIT_SIZE-1:0] up_limit,

    //Module Random Variables
    /*randc  bit  [DATA_WIDTH-1:0]     addr;
    randc  bit  [ADDR_WIDTH-1:0]  data_in;*/
  driver_virtual.input_card_pin<=seq_item_in.input_card_pin;
  driver_virtual.transfer_card_pin<=seq_item_in.transfer_card_pin;
 driver_virtual.deposite_value<=seq_item_in.deposite_value;
   driver_virtual.withdrawal_value<=seq_item_in.withdrawal_value;
   driver_virtual.atm_capacity<=seq_item_in.atm_capacity;
   driver_virtual.op_choice<=seq_item_in.op_choice;
        driver_virtual.language_choice<=seq_item_in.language_choice;
 driver_virtual.transfer_value<=seq_item_in.transfer_value;
    
        
        $display("before  item done (DRIVER)");
        
        $display($time  , "%p",seq_item_in);
        seq_item_port.item_done();
     
      end
  $display("driver_run_phase");
    endtask
  endclass 