 
  property states;
  @(posedge clk) atm_top_inst.atm_inst.current_state == $past(atm_top_inst.atm_inst.next_state);
endproperty 
assert property(states);
////////////////////// IDEL TRANSITION  ////////////////////////////////////
property IDLE_Transition_1;
  @(posedge clk) ($rose(insert) && atm_top_inst.atm_inst.current_state==IDLE |=>atm_top_inst.atm_inst.current_state==CHECK_CARD);
endproperty 
assert property(IDLE_Transition_1);

property IDLE_Transition_2;
  @(posedge clk) (!insert && atm_top_inst.atm_inst.current_state==IDLE |=>atm_top_inst.atm_inst.current_state==IDLE);
endproperty 
assert property(IDLE_Transition_2);
////////////////////// Checkcard TRANSITION  ////////////////////////////////////
property checkcard_transition_1;
  @(posedge clk) ((atm_top_inst.atm_inst.current_state==CHECK_CARD) && ($rose(enter) &&!cancel && ((atm_top_inst.atm_inst.input_password != atm_top_inst.atm_inst.ref_password) || !(atm_top_inst.atm_inst.valid))) |=> atm_top_inst.atm_inst.current_state==IDLE && $rose(card_spell_out));
endproperty 
assert property(checkcard_transition_1);

property checkcard_transition_2;
  @(posedge clk) (((($rose(enter) && (atm_top_inst.atm_inst.ref_password == input_password)) && !cancel && atm_top_inst.atm_inst.valid  ) && atm_top_inst.atm_inst.current_state==CHECK_CARD) |=>atm_top_inst.atm_inst.current_state==LANGUAGE_CHOICE);
endproperty 
assert property(checkcard_transition_2);

////////////////////// OPERATION_CHOICE TRANSITION  ////////////////////////////////////
property OPERATION_CHOICE_transition_1;
  @(posedge clk) ($rose(cancel))&&atm_top_inst.atm_inst.current_state==OPERATION_CHOICE|=> atm_top_inst.atm_inst.current_state==IDLE && $rose(card_spell_out);
endproperty 
assert property(OPERATION_CHOICE_transition_1);

property OPERATION_CHOICE_transition_2;
  @(posedge clk)($rose(enter))&&(op_choice==DEPOSITE_OP &&!cancel&&atm_top_inst.atm_inst.current_state==OPERATION_CHOICE) |=>atm_top_inst.atm_inst.current_state==DEPOSITE;
endproperty 
assert property(OPERATION_CHOICE_transition_2);

property OPERATION_CHOICE_transition_3;
  @(posedge clk)($rose(enter))&&(op_choice==WITHDRAWAL_OP&&!cancel&&atm_top_inst.atm_inst.current_state==OPERATION_CHOICE) |=>atm_top_inst.atm_inst.current_state==WITHDRAWAL;
endproperty 
assert property(OPERATION_CHOICE_transition_3);

property OPERATION_CHOICE_transition_4;
  @(posedge clk)($rose(enter))&&(op_choice==BALANCE_SERVICE_OP&&!cancel&&atm_top_inst.atm_inst.current_state==OPERATION_CHOICE) |=>atm_top_inst.atm_inst.current_state==BALANCE_SERVICE;
endproperty 
assert property(OPERATION_CHOICE_transition_4);

property OPERATION_CHOICE_transition_5;
  @(posedge clk)($rose(enter))&&(op_choice==TRANSFER_OP&&!cancel&&atm_top_inst.atm_inst.current_state==OPERATION_CHOICE) |=> atm_top_inst.atm_inst.current_state==TRANSFER;
endproperty 
assert property(OPERATION_CHOICE_transition_5);

////////////////////// DEPOSITE TRANSITION  ////////////////////////////////////
/*property DEPOSITE_transition_1;
  @(posedge clk) ( ($rose(enter)) && (atm_top_inst.atm_inst.current_state==DEPOSITE) |=>$past(atm_top_inst.atm_inst.waiting_timer)==WAITING_TIME) -> atm_top_inst.atm_inst.current_state==OPERATION_CHOICE && ($rose(done));
endproperty 
assert property(DEPOSITE_transition_1);*/

////////////////////// WITHDRAWAL TRANSITION  ////////////////////////////////////
property WITHDRAWAL_transition_1;
  @(posedge clk) ((atm_top_inst.atm_inst.current_state==WITHDRAWAL)&&($rose(atm_top_inst.atm_inst.cancel)) &&(atm_top_inst.atm_inst.timer_en_nx == 0 && atm_top_inst.atm_inst.waiting_timer == 0)) |=> (atm_top_inst.atm_inst.current_state==OPERATION_CHOICE&&!card_spell_out);
endproperty 
assert property(WITHDRAWAL_transition_1);

property WITHDRAWAL_transition_2;
  @(posedge clk) (($rose(enter))&&(atm_top_inst.atm_inst.current_state==WITHDRAWAL)&&($rose(atm_top_inst.atm_inst.abort_nx)))|=> (atm_top_inst.atm_inst.current_state==ABORT&&card_spell_out);
endproperty 
assert property(WITHDRAWAL_transition_2);
////////////////////// BALANCE_SERVICE TRANSITION  ////////////////////////////////////
property Balance_service_transition;
  @(posedge clk) (atm_top_inst.atm_inst.current_state==BALANCE_SERVICE) |=> (atm_top_inst.atm_inst.current_state==OPERATION_CHOICE&&($rose(done)));
endproperty 
assert property(Balance_service_transition);



property Transfer_transition_1;
  @(posedge clk) ((atm_top_inst.atm_inst.current_state==TRANSFER)&&($rose(atm_top_inst.atm_inst.cancel))) |=> (atm_top_inst.atm_inst.current_state==OPERATION_CHOICE) && (~card_spell_out);
endproperty 
assert property(Transfer_transition_1);

property Transfer_transition_2;
  @(posedge clk) (atm_top_inst.atm_inst.current_state==TRANSFER)&&($rose(atm_top_inst.atm_inst.abort_nx)) |=> (atm_top_inst.atm_inst.current_state==ABORT && card_spell_out);
endproperty 
assert property(Transfer_transition_2);



sequence WITHDRAWAL_proscess_right;
@(posedge clk) (atm_top_inst.atm_inst.current_state==WITHDRAWAL)&&
              ($rose(enter))&&(withdrawal_value<=atm_top_inst.atm_inst.atm_capacity_r)
              &&(withdrawal_value<=atm_top_inst.atm_inst.final_up_limit_r)&&(withdrawal_value<=atm_top_inst.atm_inst.final_credit_r)  && (atm_top_inst.atm_inst.waiting_timer == 0)
              ##[1:DIVISOR] $rose(atm_top_inst.atm_inst.slow_clk) ;//"We can use && operator with delay"
endsequence
property Done_signal_in_WITHDRAWAL ;
@(posedge clk) WITHDRAWAL_proscess_right |=> ##(DIVISOR * SLOW_CLK_COUNTER_SIZE - 1) $rose(done);
endproperty 
assert property(Done_signal_in_WITHDRAWAL);





property Abort_signal_in_WITHDRAWAL;
  @(posedge clk) (atm_top_inst.atm_inst.current_state==WITHDRAWAL)
               &&(atm_top_inst.atm_inst.timer_en_nx == 0 && atm_top_inst.atm_inst.waiting_timer == 0)
               &&($rose(enter))&&((withdrawal_value>atm_top_inst.atm_inst.atm_capacity_r)
               ||(withdrawal_value>atm_top_inst.atm_inst.final_up_limit_r)
               ||(withdrawal_value>atm_top_inst.atm_inst.final_credit_r)) |=>  $rose(abort);
endproperty 
assert property(Abort_signal_in_WITHDRAWAL);


property Abort_signal_in_Transfer;
  @(posedge clk) (atm_top_inst.atm_inst.current_state==TRANSFER)
              && ($rose(enter) && ~atm_top_inst.atm_inst.wr_en_r) 
              &&((transfer_value>atm_top_inst.atm_inst.final_up_limit_r)
              ||(transfer_value>atm_top_inst.atm_inst.final_credit_r)) |=> $rose(abort);
endproperty 
assert property(Abort_signal_in_Transfer);

property final_credit;
  @(posedge clk) (atm_top_inst.atm_inst.current_state==TRANSFER)&&
  ($rose(atm_top_inst.atm_inst.done_nx)) 
  |=> (atm_top_inst.atm_inst.final_credit_r==($past(atm_top_inst.atm_inst.final_credit_r, 6)-transfer_value));
endproperty 
assert property(final_credit);

property final_credit_1;
  @(posedge clk) (atm_top_inst.atm_inst.current_state==WITHDRAWAL)&&($rose(atm_top_inst.atm_inst.wr_en_r)) |-> (atm_top_inst.atm_inst.final_credit_r==($past(atm_top_inst.atm_inst.final_credit_r,1)-withdrawal_value));
endproperty 
assert property(final_credit_1);

property Final_Up_limit;
  @(posedge clk)(atm_top_inst.atm_inst.current_state==TRANSFER)&&($rose(atm_top_inst.atm_inst.wr_en_r) && ~atm_top_inst.atm_inst.transfer_en_r)|->(atm_top_inst.atm_inst.final_up_limit_r==($past(atm_top_inst.atm_inst.final_up_limit_r,2)-transfer_value));
endproperty 
assert property(Final_Up_limit);

property Final_Up_limit_1;
  @(posedge clk) (atm_top_inst.atm_inst.current_state==WITHDRAWAL)&&($rose(atm_top_inst.atm_inst.wr_en_r))|->(atm_top_inst.atm_inst.final_up_limit_r==($past(atm_top_inst.atm_inst.final_up_limit_r,2)-withdrawal_value));
endproperty 
assert property(Final_Up_limit_1);

property final_credit_2;
  @(posedge clk) (atm_top_inst.atm_inst.current_state==DEPOSITE)&&($rose(atm_top_inst.atm_inst.wr_en_r))|->(atm_top_inst.atm_inst.final_credit==$past(atm_top_inst.atm_inst.final_credit,2)+deposite_value);
endproperty 
assert property(final_credit_2);

property ATM_capacity;
  @(posedge clk)(atm_top_inst.atm_inst.current_state==WITHDRAWAL)&&($rose(atm_top_inst.atm_inst.wr_en_r))|->(atm_top_inst.atm_inst.atm_capacity_r==($past(atm_top_inst.atm_inst.atm_capacity_r,2)-withdrawal_value));
endproperty 
assert property(ATM_capacity);

property ATM_capacity_1;
  @(posedge clk) (atm_top_inst.atm_inst.current_state==DEPOSITE)&&($rose(atm_top_inst.atm_inst.wr_en_r)) |-> (atm_top_inst.atm_inst.atm_capacity_r==($past(atm_top_inst.atm_inst.atm_capacity_r,2)+deposite_value));
endproperty 
assert property(ATM_capacity_1);

property Ref_password;
  @(posedge clk) $rose(insert)|=> $changed(atm_top_inst.atm_inst.ref_password);
endproperty 
assert property(Ref_password);

