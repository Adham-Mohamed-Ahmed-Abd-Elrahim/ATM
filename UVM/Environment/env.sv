 //-------------------------------------------------//
  //----------------- Env ----------------//
  //-------------------------------------------------//

  class envir extends uvm_env ;
    `uvm_component_utils(envir)
    function new(string name = "envir",uvm_component parent=null);
      super.new(name,parent);
    endfunction
    virtual intf1 config_virtual ;
    virtual intf1 local_virtual ;
    //--------- Instantiations ------//
    agent agent_i;
    subscriber subscriber_i;
    scoreboard scoreboard_i;
      //------- build phase -------//
    function void build_phase (uvm_phase phase);
  super.build_phase(phase);
  agent_i=agent::type_id::create("agent_i",this);
  subscriber_i=subscriber::type_id::create("subscriber_i",this);
  scoreboard_i=scoreboard::type_id::create("scoreboard_i",this);
      if(!uvm_config_db#(virtual intf1)::get(this,"","vif",config_virtual))begin
           `uvm_fatal(get_full_name(),"Error!")
      end
  local_virtual=config_virtual;
      uvm_config_db #(virtual intf1)::set(this,"agent_i","vif",local_virtual);
  $display("envir_build_phase");
  endfunction
   //------- connect phase -------//
    function void connect_phase (uvm_phase phase);
  super.connect_phase(phase);
      agent_i.my_analysis_port.connect(scoreboard_i.my_analysis_export);
      agent_i.my_analysis_port.connect(subscriber_i.analysis_export);
  $display("envir_connect_phase");
  endfunction
  
  endclass 
