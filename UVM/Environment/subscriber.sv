 //-------------------------------------------------//
  //--------------- subscriber -------------//
  //-------------------------------------------------//
import  param::*;
  class subscriber extends uvm_subscriber #(sequence_item) ;
    
    `uvm_component_utils(subscriber)
    sequence_item seq_item;
   //cover_group_inst
 `include "cover.sv"   // Including all system cover_groups

    function new(string name = "subscriber",uvm_component parent=null);
      super.new(name,parent);
       statess=new(); 
       state_transitions=new(); 
// toggle toggle_done = new();
      data_toggle = new();
      // toggle_done = new(seq_item.done);
      //toggle_card_spell_out= new(seq_item.card_spell_out);

//toggle toggle_4 = new(atm_top_inst.atm_inst.transfer_en);
     //  toggle_insert = new(seq_item.insert);
     //  toggle_enter = new(seq_item.enter);
      //    toggle = new(seq_item.language_choice);    ////************#
//toggle toggle_8 = new(atm_top_inst.atm_inst.valid);
     //  toggle_atm_init = new(seq_item.atm_init);
      // toggle_abort = new(seq_item.abort);
      //new for group.new
/*toggle_trans_en toggle_trans_en_int = new();
toggle_valid toggle_valid_inst = new();
toggle_wren toggle_wren_inst = new();*/
 cg_input_card_pin = new();
 cg_op_choice = new();
    endfunction
    
  //-------- Instances ------ /
    // uvm_analysis_imp #(sequence_item,subscriber) my_analysis_ex port; 
      //------- build phase -------//
    function void build_phase (uvm_phase phase);
  super.build_phase(phase);
  seq_item= sequence_item::type_id::create("seq_item");
     // my_analysis_export=new("my_analysis_export",this);
  $display("subscriber_build_phase");
  endfunction

  //------- write method ------//
  function void write (sequence_item t);
    seq_item=t;
    //sample method 
statess.sample();
state_transitions.sample();
cg_op_choice.sample();
cg_input_card_pin.sample();

data_toggle.sample();
 
/*toggle_2.sample();
toggle_3.sample();
//toggle_4.sample();
toggle_trans_en_int.sample();
toggle_5.sample();
toggle_6.sample();
toggle_7.sample();
//toggle_8.sample();
toggle_valid_inst.sample();
toggle_9.sample();
toggle_10.sample();
toggle_wren_inst.sample();*/
  endfunction
  endclass 
