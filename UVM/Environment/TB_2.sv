
int i=0;
int k=0;
integer user_count=0;
integer operation_count=0;
int cancel_first = 1;
task automatic maintask (ref sequence_item sequence_item_in);
  $display("============================================================");
  $display("=====================main task=====================",$realtime);
  $display("============================================================");
 /*fork  
 /* begin 
    clock_gen();
  end*/
 // begin
    reset_init(sequence_item_in);
 /* seq_generator(WITHDRAWAL_OP,sequence_item_in);
  withdrawal_val_set(sequence_item_in);*/
      //card_rand(sequence_item_in);
 // end
/*begin
  check_idle();
end*/
// join_any 
endtask //automatic


//---------------------------------------------------
task automatic reset_init(ref sequence_item sequence_item_in);
  $display("============================================================");
  $display("=====================reset =====================",$realtime);
  $display("============================================================");
 start_item(sequence_item_in);
sequence_item_in.rst_n=1;
  finish_item(sequence_item_in);
#12ns;
start_item(sequence_item_in);
sequence_item_in.rst_n=0;
finish_item(sequence_item_in);
#12ns;
start_item(sequence_item_in);
sequence_item_in.rst_n=1;
sequence_item_in.atm_init='0;
sequence_item_in.enter=0;
sequence_item_in.cancel=0;
sequence_item_in.insert=0;
finish_item(sequence_item_in);
//language_choice=0;
endtask 

task automatic pulse(ref logic  signal,ref sequence_item sequence_item_in);
 start_item(sequence_item_in);
    signal=1'b1;
 finish_item(sequence_item_in);
#clk_per;
 start_item(sequence_item_in);
    signal=1'b0;
 finish_item(sequence_item_in);
 

endtask
/*
task automatic check_card(ref sequence_item sequence_item_in);
 start_item(sequence_item_in);
  void'(sequence_item_in.randomize());
  //input_password=rom[pin_card][]+$urand(1);
  sequence_item_in.input_password=rom[sequence_item_in.input_card_pin][ROM_DATA_WIDTH-1:1]; 
 finish_item(sequence_item_in);
  $display("ref_password=%d",rom[sequence_item_in.input_card_pin][ROM_DATA_WIDTH-1:1], "input_password=%d",sequence_item_in.input_password);
  //check_password
  if((sequence_item_in.input_password==rom[sequence_item_in.input_card_pin][ROM_DATA_WIDTH-1:1])&& rom[sequence_item_in.input_card_pin][0]==1'b1)begin
valid_card=1'b1;
end
else 
begin 
  valid_card=1'b0;
end
endtask 

//--------------------------------------------------
task  automatic seq_generator(logic [OP_CHOICE_SIZE-1:0] op,ref sequence_item sequence_item_in);
  logic valid_card_out;
  //initializing atm_capacity
  //sequence_item_in.atm_capacity=ATM_CAPACITY_VAL;
  pulse(sequence_item_in.atm_init);
// Card Insertion 
 // input_card_pin=$urandom % DEPTH;
/* start_item(sequence_item_in);
  sequence_item_in.input_card_pin=0;
 finish_item(sequence_item_in);*/
/*
  pulse(sequence_item_in.insert);
  check_card(sequence_item_in);
  if(valid_card);
begin// language choice
  pulse(sequence_item_in.enter);
// operation_choice
sequence_item_in.op_choice=op;
  pulse(sequence_item_in.enter);
end
endtask 

task automatic withdrawal_val_set(ref sequence_item sequence_item_in);
  //initializing withdrawal value
  $display("Withdrawal_value=%d",sequence_item_in.withdrawal_value);
  pulse(sequence_item_in.enter);
  pulse(sequence_item_in.enter);
endtask 
