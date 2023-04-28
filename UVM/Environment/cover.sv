localparam PINCARD_SIZE=6;
enum bit [3:0] {IDLE,CHECK_CARD,LANGUAGE_CHOICE,OPERATION_CHOICE,DEPOSITE,WITHDRAWAL,BALANCE_SERVICE,TRANSFER,ABORT}state_enum;
covergroup statess;
    cover_cuurent_state: coverpoint seq_item.current_state{
        bins st_0= {IDLE};
        bins st_1= {CHECK_CARD};
        bins st_2= {LANGUAGE_CHOICE};
        bins st_3= {OPERATION_CHOICE};
        bins st_4= {TRANSFER};
        bins st_5= {BALANCE_SERVICE};
        bins st_6= {WITHDRAWAL};
        bins st_7= {DEPOSITE};
        bins st_8= {ABORT};
    }
    cover_next_state: coverpoint seq_item.next_state{
        bins nst_0= {IDLE};
        bins nst_1= {CHECK_CARD};
        bins nst_2= {LANGUAGE_CHOICE};
        bins nst_3= {OPERATION_CHOICE};
        bins nst_4= {TRANSFER};
        bins nst_5= {BALANCE_SERVICE};
        bins nst_6= {WITHDRAWAL};
        bins nst_7= {DEPOSITE};
        bins nst_8= {ABORT};
    }
    endgroup
  

//////////////////////////////////////////////////

    covergroup state_transitions;
    cover_cuurent_state: coverpoint seq_item.current_state{
        bins IDLE_trans =(IDLE=>CHECK_CARD);
        bins CHECK_CARD_trans[]=(CHECK_CARD=>LANGUAGE_CHOICE,IDLE);
        bins LANGUAGE_CHOICE_trans =(LANGUAGE_CHOICE=>OPERATION_CHOICE);
        bins OPERATION_CHOICE_trans[] =(OPERATION_CHOICE=>DEPOSITE,WITHDRAWAL, BALANCE_SERVICE,TRANSFER,IDLE);
        bins WITHDRAWAL_trans[] =(WITHDRAWAL => OPERATION_CHOICE,ABORT);
        bins DEPOISTE_trans =(DEPOSITE => OPERATION_CHOICE);
        bins BALANCE_SERVICE_trans =(BALANCE_SERVICE => OPERATION_CHOICE);
        bins TRANSFER_trans[] =(TRANSFER => OPERATION_CHOICE, ABORT);
    }
    cover_next_state: coverpoint seq_item.next_state{
        bins IDLE_trans =(IDLE=>CHECK_CARD);
        bins CHECK_CARD_trans[]=(CHECK_CARD=>LANGUAGE_CHOICE,IDLE);
        bins LANGUAGE_CHOICE_trans =(LANGUAGE_CHOICE=>OPERATION_CHOICE);
        bins OPERATION_CHOICE_trans[] =(OPERATION_CHOICE=>DEPOSITE,WITHDRAWAL, BALANCE_SERVICE,TRANSFER,IDLE);
        bins WITHDRAWAL_trans[] =(WITHDRAWAL => OPERATION_CHOICE,ABORT);
        bins DEPOISTE_trans =(DEPOSITE => OPERATION_CHOICE);
        bins BALANCE_SERVICE_trans =(BALANCE_SERVICE => OPERATION_CHOICE);
        bins TRANSFER_trans[] =(TRANSFER => OPERATION_CHOICE, ABORT);
    }
    endgroup
  

    //cover_states.get_inst_coverage();
 
/*typedef enum bit [3:0] { IDLE,CHECK_CARD,LANGUAGE_CHOICE,OPERATION_CHOICE,TRANSFER,BALANCE_SERVICE,WITHDRAWAL,DEPOISTE,ABORT } state_enum;
/*localparam IDLE=4'd0;
localparam CHECK_CARD=4'd1;
localparam LANGUAGE_CHOICE=4'd2;
localparam OPERATION_CHOICE=4'd3;
localparam DEPOSITE=4'd4;
localparam WITHDRAWAL=4'd5;
localparam BALANCE_SERVICE=4'd6;
localparam TRANSFER=4'd7;
localparam ABORT=4'd8;

covergroup states(state_enum states);
cover_states: coverpoint states{
    bins st[9]= (IDLE,CHECK_CARD,LANGUAGE_CHOICE,OPERATION_CHOICE,TRANSFER,BALANCE_SERVICE,WITHDRAWAL,DEPOISTE,ABORT);
}
endgroup
states current_state = new(atm_inst.current_state);
states next_state= new(atm_inst.next_state);
*/

/*covergroup state_tran(ref reg states);
cover_trans: coverpoint states{
    bins IDLE_trans =(IDLE<=CHECK_CARD);
    bins CHECK_CARD_trans=(CHECK_CARD<=LANGUAGE_CHOICE,CHECK_CARD<=IDLE);
    bins LANGUAGE_CHOICE_trans =(LANGUAGE_CHOICE<=OPERATION_CHOICE);
    bins OPERATION_CHOICE_trans =(OPERATION_CHOICE <=DEPOSITE, OPERATION_CHOICE <=WITHDRAWAL, OPERATION_CHOICE <=BALANCE_SERVICE, OPERATION_CHOICE <=TRANSFER ,OPERATION_CHOICE <=IDLE);
    bins WITHDRAWAL_trans =(WITHDRAWAL => OPERATION_CHOICE, WITHDRAWAL=>ABORT);
    bins DEPOISTE_trans =(DEPOSITE => OPERATION_CHOICE, DEPOSITE=>ABORT);
    bins BALANCE_SERVICE _trans =(BALANCE_SERVICE |=> OPERATION_CHOICE);
    bins TRANSFER_trans =(TRANSFER => OPERATION_CHOICE, TRANSFER=>ABORT);
}
endgroup
state_tran statestrans_1 = new(atm_top_inst.atm_inst.current_state);
states_tran statestrans_2 = new(atm_top_inst.atm_inst.next_state);*/


//toggle toggle_4 = new(atm_top_inst.atm_inst.transfer_en);

      //    toggle = new(seq_item.language_choice);    ////************#
//toggle toggle_8 = new(atm_top_inst.atm_inst.valid);
      
  
	covergroup data_toggle;

		cancel: coverpoint seq_item.cancel {
              bins ZERO_ONE = (1'b0 => 1'b1);
              bins ONE_ZERO = (1'b1 => 1'b0);
			}
		done: coverpoint seq_item.done {
              bins ZERO_ONE = (1'b0 => 1'b1);
              bins ONE_ZERO = (1'b1 => 1'b0);
			}
		card_spell_out: coverpoint seq_item.card_spell_out {
              bins ZERO_ONE = (1'b0 => 1'b1);
              bins ONE_ZERO = (1'b1 => 1'b0);
			}
		insert: coverpoint seq_item.insert {
              bins ZERO_ONE = (1'b0 => 1'b1);
              bins ONE_ZERO = (1'b1 => 1'b0);
			}
		enter: coverpoint seq_item.enter {
              bins ZERO_ONE = (1'b0 => 1'b1);
              bins ONE_ZERO = (1'b1 => 1'b0);
			}
		atm_init: coverpoint seq_item.atm_init {
              bins ZERO_ONE = (1'b0 => 1'b1);
              bins ONE_ZERO = (1'b1 => 1'b0);
			}
	abort: coverpoint seq_item.abort {
              bins ZERO_ONE = (1'b0 => 1'b1);
              bins ONE_ZERO = (1'b1 => 1'b0);
			}

		endgroup

/*covergroup seq_item.data_in.cancel (ref logic signal);
cover_toggle: coverpoint signal{
    bins from_0_to_1 = (0 => 1);
    bins from_1_to_0 = (1 => 0);
}
endgroup

covergroup toggle_done (ref logic signal);
cover_toggle: coverpoint signal{
    bins from_0_to_1 = (0 => 1);
    bins from_1_to_0 = (1 => 0);
}
endgroup

covergroup toggle_card_spell_out (ref logic signal);
cover_toggle: coverpoint signal{
    bins from_0_to_1 = (0 => 1);
    bins from_1_to_0 = (1 => 0);
}
endgroup

covergroup toggle_insert (ref logic signal);
cover_toggle: coverpoint signal{
    bins from_0_to_1 = (0 => 1);
    bins from_1_to_0 = (1 => 0);
}
endgroup

covergroup toggle_enter (ref logic signal);
cover_toggle: coverpoint signal{
    bins from_0_to_1 = (0 => 1);
    bins from_1_to_0 = (1 => 0);
}
endgroup

covergroup toggle_atm_init (ref logic signal);
cover_toggle: coverpoint signal{
    bins from_0_to_1 = (0 => 1);
    bins from_1_to_0 = (1 => 0);
}
endgroup

covergroup toggle_abort (ref logic signal);
cover_toggle: coverpoint signal{
    bins from_0_to_1 = (0 => 1);
    bins from_1_to_0 = (1 => 0);
}
endgroup
/**/
/*
covergroup toggle_trans_en;
cover_toggle_trans_en: coverpoint atm_top_inst.atm_inst.transfer_en{
    bins from_0_to_1 = (0 => 1);
    bins from_1_to_0 = (1 => 0);
}
endgroup


covergroup toggle_valid ();
cover_toggle_trans_en: coverpoint atm_top_inst.atm_inst.valid{
    bins from_0_to_1 = (0 => 1);
    bins from_1_to_0 = (1 => 0);
}
endgroup


covergroup toggle_wren ();
cover_toggle_trans_en: coverpoint atm_top_inst.atm_inst.wr_en{
    bins from_0_to_1 = (0 => 1);
    bins from_1_to_0 = (1 => 0);
}
endgroup
*/


covergroup cg_input_card_pin ; //input card pin , TRANSFER
cover_op: coverpoint seq_item.input_card_pin;
endgroup


covergroup cg_op_choice ; //input card pin , TRANSFER
cover_op: coverpoint seq_item.op_choice;
endgroup

