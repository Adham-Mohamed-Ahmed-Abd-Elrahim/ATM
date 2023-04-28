 //--------------------------------------------------//
  //------------------- sequencer --------------------//
  //--------------------------------------------------//

  class sequencer extends uvm_sequencer #(sequence_item) ;
    `uvm_component_utils(sequencer)
    function new(string name = "sequencer",uvm_component parent=null);
      super.new(name,parent);
    endfunction
      //------- build phase -------//
    function void build_phase (uvm_phase phase);
  super.build_phase(phase);
  $display("sequencer_build_phase");
  endfunction
   //------- connect phase -------//
    function void connect_phase (uvm_phase phase);
  super.connect_phase(phase);
  $display("sequencer_connect_phase");
  endfunction
   //------- run phase -------//
    task run_phase (uvm_phase phase);
  super.run_phase(phase);
  $display("sequencer_run_phase");
    endtask
  endclass 