
int i=0;
int k=0;
task maintask;
  $display("============================================================");
  $display("=====================main task=====================",$realtime);
  $display("============================================================");
 fork  
  begin 
    clock_gen();
  end
  begin
    reset_init();
    repeat(30)begin
      operation_rand();
     // 
    end
  end
/*begin
  check_idle();
end*/
 join_any 
endtask //automatic

//--------------------------------------------------
task clock_gen;
  $display("============================================================");
  $display("=====================clock_gen =====================",$realtime);
  $display("============================================================");
while(1) begin
clk=0;
#(clk_period/2);
clk=1;
#(clk_period/2);
cover_states.sample();
toggle_1.sample();
toggle_2.sample();
toggle_3.sample();
toggle_4.sample();
toggle_5.sample();
toggle_6.sample();
toggle_7.sample();
toggle_8.sample();
toggle_9.sample();
toggle_10.sample();

end
endtask 
//---------------------------------------------------
task reset_init;
  $display("============================================================");
  $display("=====================reset =====================",$realtime);
  $display("============================================================");

rst_n=1;
#12ns;
rst_n=0;
#12ns;
rst_n=1;
atm_init='0;
enter=0;
cancel=0;

endtask 

task static operation_rand();
  $display("============================================================");
  $display("===================== operation_rand  =====================",$realtime);
  $display("============================================================");
  operation_choice_rand=  $urandom % (4); 
  seq_generator(operation_choice_rand); // Till WITHDRAWAL_STATE
  case(operation_choice_rand)
    WITHDRAWAL_OP:begin 
     //  cancel_rand(); //cancel_Randomization
       withdrawal_val_set();
      // cancel_rand(); //cancel_Randomization

       wait((done==1'b1) /*|| abort==1'b1*/ );
    end
 TRANSFER_OP:begin
  transfer_val_set();   
  wait((done==1'b1)/*|| (abort==1'b1)*/ );
 end
BALANCE_SERVICE_OP:begin
  $display("============================================================");
  $display("===================== BALANCE_SERVICE_OP  =====================",$realtime);
  $display("============================================================");
  wait((done==1'b1));
end
DEPOSITE_OP:begin
  $display("============================================================");
  $display("===================== DEPOSITE_OP  =====================",$realtime);
  $display("============================================================"); 
  deposite_val_set();
  wait(done==1'b1);
 end
  endcase 
 
    // To set value to be withdrew

endtask 
//---------------------------------------------------
 task automatic pulse(ref logic  signal);
  @(posedge clk) begin
    signal=1'b1;
  end
  @(posedge clk) begin
    signal=1'b0;
  end
endtask

task check_card( output bit valid_card);
  $display("============================================================");
  $display("===================== check_card  =====================",$realtime);
  $display("============================================================");
  password_rand=$urandom %2; //password_randomization
  //input_password=rom[pin_card][]+$urand(1);
   input_password=rom[input_card_pin][ROM_DATA_WIDTH-1:1]/*+password_rand*/; 
   pulse(enter);
  $display("ref_password=%d",rom[input_card_pin][ROM_DATA_WIDTH-1:1], "input_password=%d",input_password);
  //check_password
if((input_password==rom[input_card_pin][ROM_DATA_WIDTH-1:1])&& rom[input_card_pin][0]==1'b1)begin
valid_card=1'b1;
end
else 
begin 
  valid_card=1'b0;
end
endtask 
//--------------------------------------------------
task seq_generator(logic [OP_CHOICE_SIZE-1:0] op);
  $display("============================================================");
  $display("===================== seq_generator  =====================",$realtime);
  $display("============================================================");

  //initializing atm_capacity
  atm_capacity=$urandom % 10000000  ;
  pulse(atm_init);
// Card Insertion 
  input_card_pin=$urandom % (DEPTH);   //// Randomize 
  //$display();
 // input_card_pin=0;
  pulse(insert);
  check_card(valid_card_out);
  if(valid_card_out);
begin// language choice
language_choice=1'b1; //English
pulse(enter);
// operation_choice
op_choice=op;
pulse(enter);
end
//seq_generator(op);
  //check_idle();
//cancel_rand(); //cancel_Randomization
endtask 



task transfer_val_set();
  $display("============================================================");
  $display("===================== transfer_val_set  =====================",$realtime);
  $display("============================================================");
  //initializing withdrawal value
  transfer_value=$urandom %(32767);
  transfer_card_pin=1;
  $display("trnasfer_value=%d",withdrawal_value);
  pulse(enter);
  pulse(enter);
endtask 

task withdrawal_val_set();
  $display("============================================================");
  $display("===================== withdrawal_val_set  =====================",$realtime);
  $display("============================================================");
  //initializing withdrawal value
  withdrawal_value=$urandom %(32767);
  $display("Withdrawal_value=%d",withdrawal_value);
  pulse(enter);
  pulse(enter);
endtask 
task deposite_val_set();
  $display("============================================================");
  $display("===================== deposite_val_set  =====================",$realtime);
  $display("============================================================");
  //initializing withdrawal value
  deposite_value=$urandom %(32767);
  $display("deposite_value_value=%d",withdrawal_value);
  pulse(enter);
  pulse(enter);
endtask 

task cancel_rand();
cancel_en=$urandom % 2;
if(cancel_en)begin
  pulse(cancel);
end
endtask
task cancel_rand_cond();
output logic cancel_en;
cancel_en=$urandom % 2;
if(cancel_en)begin
  pulse(cancel);
end
endtask

task check_idle(logic [OP_CHOICE_SIZE-1:0] op);
//while(1)begin
if(atm_top_inst.atm_inst.current_state==IDLE)begin
 //repeat(5) @(posedge clk);
seq_generator(op);
end
endtask
//----------------------------------------------
