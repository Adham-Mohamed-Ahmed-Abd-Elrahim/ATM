 //------------------ Scoreboard -------------//
  //---------------------------------------------//

  class scoreboard extends uvm_scoreboard ;
    `uvm_component_utils(scoreboard)
  
    function new(string name = "scoreboard",uvm_component parent=null);
      super.new(name,parent);
    endfunction
    //------- Instances ------//
    uvm_tlm_analysis_fifo #(sequence_item) my_tlm_analysis_fifo;
    uvm_analysis_export #(sequence_item) my_analysis_export; 
    sequence_item sequence_item_in;
      //------- build phase -------//
    function void build_phase (uvm_phase phase);
  super.build_phase(phase);
      //fifo intialization
      my_tlm_analysis_fifo=new("uvm_tlm_fifo",this);
      //export_initialization (for exporting AE from agent to AE in uvm_fifo_tlm)
       my_analysis_export=new("my_analysis_export",this);
  $display("scoreboard_build_phase");
  endfunction
   //------- connect phase -------//
    function void connect_phase (uvm_phase phase);
  super.connect_phase(phase);
      my_analysis_export.connect(my_tlm_analysis_fifo.analysis_export);
  $display("scoreboard_connect_phase");
  endfunction
   //------- run phase -------//
   task run_phase (uvm_phase phase);
  super.run_phase(phase);
     forever begin         
       my_tlm_analysis_fifo.get(sequence_item_in);
       //#2ns;
     
  /*     $display("###data_out=%d",sequence_item_in.data_out);
       $display("###valid_out.%d",sequence_item_in.valid_out);*/
/*  $display("scoreboard_run_phase");
       
          if((sequence_item_in.wr==1)&(sequence_item_in.rst_n==1))begin
           wr_data[sequence_item_in.addr]=sequence_item_in.data_in;
         end
         else if(sequence_item_in.valid_out==1'b1)begin
           if(sequence_item_in.data_out==wr_data[addr])begin
          $display("test is passed data_out=%d , ref_data=%d",sequence_item_in.data_out,wr_data[addr]);
             addr=sequence_item_in.addr;
           end
           else begin
             addr=sequence_item_in.addr;
             $display("test is failed data_out=%d , ref_data=%d",sequence_item_in.data_out,wr_data[addr]);
           end
         end
        $display("data_out=%d",sequence_item_in.data_out);
        $display("valid_out.%d",sequence_item_in.valid_out);
       //end*/
       end
     //comparing with ref_model
  $display("scoreboard_run_phase");
   endtask
  endclass 
