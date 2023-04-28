
  //---------------------------------------------//
  //------------------ Agent --------------------//
  //---------------------------------------------//

  class agent extends uvm_agent ;
    `uvm_component_utils(agent)
     
      //--------- Instantiations ------//
    driver driver_i;
    monitor monitor_i;
    sequencer sequencer_i;
    virtual intf1 config_virtual ;
    virtual intf1 local_virtual ;
    uvm_analysis_port #(sequence_item) my_analysis_port; 
   //-------------- New --------//
     function new(string name = "agent",uvm_component parent=null);
      super.new(name,parent);
    endfunction
      //------- build phase -------//
    function void build_phase (uvm_phase phase);
       super.build_phase(phase);
      //--------TLM------------------------//
       my_analysis_port=new("my_analysis_port",this);
    //----------creating--------------------// 
       driver_i=driver::type_id::create("driver_i",this);
       monitor_i=monitor::type_id::create("monitor_i",this);
       sequencer_i=sequencer::type_id::create("sequencer_i",this);
      if(!(uvm_config_db #(virtual intf1)::get(this,"","vif",config_virtual)))
         `uvm_fatal(get_full_name(),"Error!")
      //connecting virtual interface
      local_virtual= config_virtual;
      uvm_config_db #(virtual intf1)::set(this,"driver_i","vif",local_virtual);
      uvm_config_db #(virtual intf1)::set(this,"monitor_i","vif",local_virtual);
      //uvm_config_db #(virtual intf1)::set(this,"sequencer_i","vif",local_virtual);
  
  $display("sequencer_build_phase");
  endfunction
   //------- connect phase -------//
    function void connect_phase (uvm_phase phase);
  super.connect_phase(phase);
      monitor_i.my_analysis_port.connect(my_analysis_port);
      driver_i.seq_item_port.connect(sequencer_i.seq_item_export);
  $display("sequencer_connect_phase");
  endfunction
  endclass 

  //--------