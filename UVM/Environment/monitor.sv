//-------------------------------------------------//
  //------------------- Monitor --------------------//
  //------------------------------------------------//

  class monitor extends uvm_monitor ;
      `uvm_component_utils(monitor)
      function new(string name = "monitor",uvm_component parent=null);
      super.new(name,parent);
    endfunction
    //----- Instances ---//
      virtual intf1 monitor_virtual ;
      sequence_item seq_item_in;
      sequence_item seq_item_buff;
      uvm_analysis_port #(sequence_item) my_analysis_port; 
      
  
      //------- build phase -------//
    function void build_phase (uvm_phase phase);
  super.build_phase(phase);
      seq_item_in=sequence_item::type_id::create("seq_item_in");
      seq_item_buff=sequence_item::type_id::create("seq_item_buff");
      my_analysis_port=new("my_analysis_port",this);
       if(!(uvm_config_db #(virtual intf1)::get(this,"","vif",monitor_virtual)))
         `uvm_fatal(get_full_name(),"Error!")
  $display("monitor_build_phase");
  endfunction
   //------- connect phase -------//
    function void connect_phase (uvm_phase phase);
  super.connect_phase(phase);
  $display("monitor_connect_phase");
  endfunction
   //------- run phase -------//
    task  run_phase (uvm_phase phase);
  super.run_phase(phase);
      /*phase.raise_objection(this);
      my_analysis_port.write(seq_item_in);
      phase.drop_objection(this);*/
      forever begin
        @(posedge(monitor_virtual.clk))  
  seq_item_in.clk<=monitor_virtual.clk;
  seq_item_in.available_credit_out<=monitor_virtual.available_credit_out;
  seq_item_in.abort<=monitor_virtual.abort;
  seq_item_in.done<=monitor_virtual.done;
  seq_item_in.card_spell_out<=monitor_virtual.card_spell_out;
//states visualizing
  seq_item_in.current_state<=monitor_virtual.current_state;
  seq_item_in.next_state<=monitor_virtual.next_state;
         /* if(monitor_virtual.valid_out)begin
          $display("(begin of Monitoring )");
            //@(negedge monitor_virtual.clk);
          seq_item_in.data_out<=monitor_virtual.data_out;
          seq_item_in.valid_out<=monitor_virtual.valid_out;
            $display("$$$$ Monitor $$$$$ data_out=%h , valid_out=%d",monitor_virtual.data_out,monitor_virtual.valid_out);
          end*/
        
      //for the sake of scoreboard

        
      /* for getting reference */
      /* else begin
        seq_item_in.data_in<=monitor_virtual.data_in;
        seq_item_in.addr<=monitor_virtual.addr;
        end*/
        //bufferring data incase data is changed in seq_item
        #1 $cast(seq_item_buff,seq_item_in);
        //$display("%p",seq_item_buff);
      /*  $display("$$$$ Monitor $$$$$ data_out=%d , valid_out=%d",seq_item_buff.data_out,seq_item_buff.valid_out);*/
       // $display("valid_out.%d",seq_item_buff.valid_out);
         my_analysis_port.write(seq_item_buff);
      end
  $display("monitor_run_phase");
    endtask
  endclass 