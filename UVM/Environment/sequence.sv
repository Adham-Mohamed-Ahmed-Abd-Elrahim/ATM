 //--------------------------------------------------//
  //------------------- sequence ---------------------//
  //--------------------------------------------------//
  class my_sequence extends uvm_sequence ;
    `uvm_object_utils(my_sequence)
    function new(string name = "my_sequence");
      super.new(name);
    endfunction
    // Instances 
    sequence_item sequence_item_in;

    logic [RAM_DATA_WIDTH-1:0] ram [0:DEPTH-1];
    logic [ROM_DATA_WIDTH-1:0] rom [0:DEPTH-1];
 logic [WITHDRAW_SIZE-1:0] with_draw_val=15'd123;
logic [TRANSFER_SIZE-1:0] transfer_val=15'd123;
logic [1:0] operation_choice_rand;
logic valid_card_out;
logic cancel_en;
logic password_rand;
logic valid_card;
localparam [OP_CHOICE_SIZE-1:0] DEPOSITE_OP =2'd0 ;
localparam [OP_CHOICE_SIZE-1:0] WITHDRAWAL_OP =2'd1 ;
localparam [OP_CHOICE_SIZE-1:0] BALANCE_SERVICE_OP =2'd2 ;
localparam [OP_CHOICE_SIZE-1:0] TRANSFER_OP =2'd3 ;
  //****************** pulse ***********-///
 task automatic pulse(ref logic  signal,ref sequence_item sequence_item_in);
 start_item(sequence_item_in);
    signal=1'b1;
 finish_item(sequence_item_in);
 start_item(sequence_item_in);
    signal=1'b0;
 finish_item(sequence_item_in);
 

endtask
    //****************** reset ***********-///
 task automatic reset(ref sequence_item sequence_item_in);
  start_item(sequence_item_in);
sequence_item_in.rst_n=1;
sequence_item_in.atm_init=0;
sequence_item_in.enter=0;
sequence_item_in.cancel=0;
sequence_item_in.insert=0;
  finish_item(sequence_item_in);
#12ns;
start_item(sequence_item_in);
sequence_item_in.rst_n=0;
finish_item(sequence_item_in);
#12ns;
start_item(sequence_item_in);
sequence_item_in.rst_n=1;

finish_item(sequence_item_in);
endtask
//****************** Rand_Var ***********-///
 task automatic rand_vars(ref sequence_item sequence_item_in);
start_item(sequence_item_in);
 void'(sequence_item_in.randomize());
finish_item(sequence_item_in);
endtask
    //****************** check_card ***********-///
task automatic check_card(ref sequence_item sequence_item_in);
  //input_password=rom[pin_card][]+$urand(1);
start_item(sequence_item_in);
  sequence_item_in.input_password=rom[sequence_item_in.input_card_pin][ROM_DATA_WIDTH-1:1]; 
 $display("ref_password=%d",rom[sequence_item_in.input_card_pin][ROM_DATA_WIDTH-1:1], "input_password=%d",sequence_item_in.input_password);
 finish_item(sequence_item_in);
 
  //check_password
 /* if((sequence_item_in.input_password==rom[sequence_item_in.input_card_pin][ROM_DATA_WIDTH-1:1])&& rom[sequence_item_in.input_card_pin][0]==1'b1)begin
valid_card=1'b1;
end
else 
begin 
  valid_card=1'b0;
end*/
endtask 

task  automatic seq_generator(logic [OP_CHOICE_SIZE-1:0] op,ref sequence_item sequence_item_in);
 
  pulse(sequence_item_in.atm_init,sequence_item_in);
// Card Insertion 
  pulse(sequence_item_in.insert,sequence_item_in);
  check_card(sequence_item_in);
 // if(valid_card);
//begin// language choice
  pulse(sequence_item_in.enter,sequence_item_in);
// operation_choice
//sequence_item_in.op_choice=op;
  pulse(sequence_item_in.enter,sequence_item_in);
  pulse(sequence_item_in.enter,sequence_item_in);
  pulse(sequence_item_in.enter,sequence_item_in);
//end
endtask 
//`include "TB_2.sv"*/
    //------------Tasks -------------//
    task pre_body;
      sequence_item_in=sequence_item::type_id::create("sequence_item_in");
  $readmemb("ram.txt", ram);   //update coff1
  $readmemb("rom.txt", rom);   //update coff2
    endtask
 task body; 

   reset(sequence_item_in);
   rand_vars(sequence_item_in);
   seq_generator(DEPOSITE_OP,sequence_item_in);

/*
      #10ns;
      start_item(sequence_item_in);
      sequence_item_in.rst_n   = 0;
      sequence_item_in.data_in = 0;
      sequence_item_in.addr    = 0;
      sequence_item_in.en 	   = 1;
      sequence_item_in.wr 	   = 0;
      finish_item(sequence_item_in);
      #10ns;
      $display("start of body");
      //---------Writing--------// 
   for(int i=0;i<32;i++)begin
        start_item(sequence_item_in);
        sequence_item_in.rst_n     = 1;
        sequence_item_in.en 	   = 1;
        sequence_item_in.wr 	   = 1;
   void'(sequence_item_in.randomize());
     //$display("///////////////////// data=%d  //////",sequence_item_in.data_in);

           //$display($time,"Writing process");
      #5ns;
   end
         
      //end
      //---------Reading--------// 
  /* for(int i=0;i<32;i=i+1)begin
        start_item(sequence_item_in);
        sequence_item_in.rst_n   = 1;
        sequence_item_in.en 	   = 1;
        sequence_item_in.wr 	   = 0;
   void'(sequence_item_in.randomize());
       // $display($time,"reading process");
        finish_item(sequence_item_in);
		#5ns;
      end*/
   //  finish_item(sequence_item_in);



    endtask 
    
    endclass 
