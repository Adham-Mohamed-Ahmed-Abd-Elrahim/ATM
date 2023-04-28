localparam PINCARD_SIZE=6;
enum bit [3:0] {IDLE,CHECK_CARD,LANGUAGE_CHOICE,OPERATION_CHOICE,DEPOSITE,WITHDRAWAL,BALANCE_SERVICE,TRANSFER,ABORT}state_enum;
covergroup statess;
    cover_cuurent_state: coverpoint atm_top_inst.atm_inst.current_state{
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
    cover_next_state: coverpoint atm_top_inst.atm_inst.next_state{
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
    statess cover_states=new(); 

//////////////////////////////////////////////////

    covergroup state_transitions;
    cover_cuurent_state: coverpoint atm_top_inst.atm_inst.current_state{
        bins IDLE_trans =(IDLE=>CHECK_CARD);
        bins CHECK_CARD_trans[]=(CHECK_CARD=>LANGUAGE_CHOICE,IDLE);
        bins LANGUAGE_CHOICE_trans =(LANGUAGE_CHOICE=>OPERATION_CHOICE);
        bins OPERATION_CHOICE_trans[] =(OPERATION_CHOICE=>DEPOSITE,WITHDRAWAL, BALANCE_SERVICE,TRANSFER,IDLE);
        bins WITHDRAWAL_trans[] =(WITHDRAWAL => OPERATION_CHOICE,ABORT);
        bins DEPOISTE_trans =(DEPOSITE => OPERATION_CHOICE);
        bins BALANCE_SERVICE_trans =(BALANCE_SERVICE => OPERATION_CHOICE);
        bins TRANSFER_trans[] =(TRANSFER => OPERATION_CHOICE, ABORT);
    }
    cover_next_state: coverpoint atm_top_inst.atm_inst.next_state{
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
    state_transitions cover_states_trans=new(); 

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


covergroup toggle (ref logic signal);
cover_toggle: coverpoint signal{
    bins from_0_to_1 = (0 => 1);
    bins from_1_to_0 = (1 => 0);
}
endgroup
// toggle toggle_done = new();
toggle toggle_1 = new(cancel);
toggle toggle_2 = new(done);
toggle toggle_3 = new(card_spell_out);

//toggle toggle_4 = new(atm_top_inst.atm_inst.transfer_en);
toggle toggle_5 = new(insert);
toggle toggle_6 = new(enter);
toggle toggle_7 = new(language_choice);
//toggle toggle_8 = new(atm_top_inst.atm_inst.valid);
toggle toggle_9 = new(atm_init);
toggle toggle_10 = new(abort);

covergroup toggle_trans_en;
cover_toggle_trans_en: coverpoint atm_top_inst.atm_inst.transfer_en{
    bins from_0_to_1 = (0 => 1);
    bins from_1_to_0 = (1 => 0);
}
endgroup
toggle_trans_en toggle_trans_en_int = new();

covergroup toggle_valid ();
cover_toggle_trans_en: coverpoint atm_top_inst.atm_inst.valid{
    bins from_0_to_1 = (0 => 1);
    bins from_1_to_0 = (1 => 0);
}
endgroup
toggle_valid toggle_valid_inst = new();

covergroup toggle_wren ();
cover_toggle_trans_en: coverpoint atm_top_inst.atm_inst.wr_en{
    bins from_0_to_1 = (0 => 1);
    bins from_1_to_0 = (1 => 0);
}
endgroup
toggle_wren toggle_wren_inst = new();



covergroup cg_input_card_pin ; //input card pin , TRANSFER
cover_op: coverpoint input_card_pin;
endgroup

cg_input_card_pin cg_input_card_pin_inst = new();

covergroup cg_op_choice ; //input card pin , TRANSFER
cover_op: coverpoint op_choice;
endgroup

cg_op_choice cg_op_choice_inst = new();