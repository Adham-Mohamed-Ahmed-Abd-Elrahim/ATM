
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
    //fork 
    seq_generator(WITHDRAWAL_OP); // Till WITHDRAWAL_STATE
    withdrawal_val_set(with_draw_val);      // To set value to be withdrew
    
    //repeat(255)@(posedge slow_clk);
    /*  begin
        check();
      end*/
 // join 
  end
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
 
  
  //input_password=rom[pin_card][]+$urand(1);
   input_password=rom[input_card_pin][ROM_DATA_WIDTH-1:1]; 
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
  logic valid_card_out;
  //initializing atm_capacity
  atm_capacity=ATM_CAPACITY_VAL;
  pulse(atm_init);
// Card Insertion 
 // input_card_pin=$urandom % DEPTH;
  input_card_pin=0;
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

endtask 

task withdrawal_val_set(logic [WITHDRAW_SIZE-1:0] withdraw_val);
  //initializing withdrawal value
  withdrawal_value=withdraw_val;
  $display("Withdrawal_value=%d",withdrawal_value);
  pulse(enter);
  pulse(enter);
endtask 

//----------------------------------------------
