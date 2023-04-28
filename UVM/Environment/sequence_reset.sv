 //--------------------------------------------------//
  //------------------- sequence ---------------------//
  //--------------------------------------------------//
  class my_sequence extends uvm_sequence ;
    `uvm_object_utils(my_sequence)
    function new(string name = "my_sequence");
      super.new(name);
    endfunction
    // Instances 
    sequence_item sequence_item_reset;

`include "TB_2.sv"
    //------------Tasks -------------//
    task pre_body;
      sequence_item_reset=sequence_item::type_id::create("sequence_item_reset");
    endtask
 task body; 


      start_item(sequence_item_in);
     // reset_init(sequence_item_in);
      sequence_item_in.rst_n   = 0;
      sequence_item_in.atm_init='0;
      sequence_item_in.enter=0;
      sequence_item_in.cancel=0;
      finish_item(sequence_item_in);
   #10ns;
    start_item(sequence_item_in);
     // reset_init(sequence_item_in);
      sequence_item_in.rst_n   = 1;
      sequence_item_in.atm_init='0;
      sequence_item_in.enter=0;
      sequence_item_in.cancel=0;
      finish_item(sequence_item_in);
      finish_item(sequence_item_in);



     #100ns;
    endtask 
    
    endclass 
