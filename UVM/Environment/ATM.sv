import  param::*;
`include "clk_divider.sv"
module atm 
     (
        // -----------Clocks----------- //
        input  clk,
       
          // -------Global reset -------//
        input  rst_n,
// ------------------------------------------------//       
// -------------------  Outputs -------------------//
// ------------------------------------------------//       

        output logic [CREDIT_VAL_SIZE-1:0] available_credit_out,
        output logic    abort,
        output logic    done,
        output logic    card_spell_out,
        output logic [CREDIT_VAL_SIZE-1:0] final_credit,
        output logic [UP_LIMIT_SIZE-1:0] final_up_limit,
        output logic    transfer_en,
        output logic    wr_en,
// ------------------------------------------------//       
// -------------------  Inputs  -------------------//
// ------------------------------------------------//    
    
        input logic atm_init,
        input logic insert,
        input logic [ATM_CAP_SIZE-1:0] atm_capacity,
        input logic [OP_CHOICE_SIZE-1:0] op_choice,
        input logic language_choice,
        input logic [PASSWORD_SIZE-1:0]input_password,
        input logic [DEPOSITE_SIZE-1:0]deposite_value,
        input logic [WITHDRAW_SIZE-1:0]withdrawal_value,
        input logic [TRANSFER_SIZE-1:0]transfer_value,
        input logic enter,
        input logic cancel,
        input logic [CREDIT_VAL_SIZE-1:0]available_credit,
        input logic [PASSWORD_SIZE-1:0] ref_password,
        input logic valid,
        input logic [UP_LIMIT_SIZE-1:0] up_limit
);
    
/*/ ------------------------------------------------\\      
// ----------------  Internal Signals   -----------//    <-------1) Internal signals Section
\\ ------------------------------------------------/*/ 

// ------------------------------------------------//       
// -------------------   States   -----------------//
// ------------------------------------------------// 
enum bit [3:0] {IDLE,CHECK_CARD,LANGUAGE_CHOICE,OPERATION_CHOICE,DEPOSITE,WITHDRAWAL,BALANCE_SERVICE,TRANSFER,ABORT} current_state,next_state;
// Operation Choice 
localparam [OP_CHOICE_SIZE-1:0] DEPOSITE_OP =2'd0 ;
localparam [OP_CHOICE_SIZE-1:0] WITHDRAWAL_OP =2'd1 ;
localparam [OP_CHOICE_SIZE-1:0] BALANCE_SERVICE_OP =2'd2 ;
localparam [OP_CHOICE_SIZE-1:0] TRANSFER_OP =2'd3 ;
// ------------------------------------------------//       
// ------------------- STATE_VARIABLES   --------//
// ------------------------------------------------// 
 logic [CREDIT_VAL_SIZE-1:0] available_credit_out_nx,available_credit_out_r;
 logic abort_nx,abort_r;
 logic done_nx,done_r;
 logic card_spell_out_nx,card_spell_out_r;
 logic [CREDIT_VAL_SIZE-1:0] final_credit_nx,final_credit_r;
 logic [UP_LIMIT_SIZE-1:0] final_up_limit_nx,final_up_limit_r;
 logic transfer_en_nx,transfer_en_r;
 logic wr_en_nx,wr_en_r;
 logic dead_lock_nx,dead_lock_r;
 logic no_feedthrough_nx,no_feedthrough_r;
 //////////////////// For Transfer Sequence ///////////////
 logic [2:0] transfer_seq_count_nx, transfer_seq_count_r;
 // ------------------------------------------------//       
// -------------------   ATM Items Buffering  --------//
// ------------------------------------------------// 
logic [ATM_CAP_SIZE-1:0] atm_capacity_nx,atm_capacity_r;
logic  language_choice_nx,language_choice_r;
// ------------------------------------------------//       
// ------------------ Edge detector variables  ----//
// ------------------------------------------------// 
  logic enter_r,enter_pe;
  logic cancel_r,cancel_pe;
// ------------------------------------------------//       
// ------------------ Timers --------------------//
// ------------------------------------------------// 
  logic [WAITING_TIMER_SIZE-1:0] waiting_timer;     //----> Driven by slow clock
  logic timer_en_nx,timer_en_r;                     //----> Driven by state_machine (internal)
  logic [$clog2(DIVISOR)-1:0] last_cycle_timer_nx,last_cycle_timer_r;  // DIVISOR-1 ticks to wait till count goes zero . 
 // logic freeze_nx,freeze_r;                         //----> To avoid 
/* ------------------------------------------------\\       
// ----------------  Edge detectors   ---------------//    <-------2) Edge detectors section
\\ ------------------------------------------------/*/ 
always_ff @( posedge clk, negedge rst_n ) begin : posedge_detector
    if(!rst_n)begin
        enter_r<=1'b0; 
        cancel_r<=1'b0;
    end
    else begin
        enter_r<=enter; 
        cancel_r<=cancel;
    end
end
assign enter_pe= (enter && ~enter_r);
assign cancel_pe= (cancel && ~cancel_r);
/*/ ------------------------------------------------\\      
// ----------------  Clock Divider    --------------//    <-------3) CLock divider
\\ ------------------------------------------------/*/ 
logic  slow_clk;
 clock_divider  #(.SLOW_CLK_COUNTER_SIZE(SLOW_CLK_COUNTER_SIZE),.DIVISOR(DIVISOR)) clk_divider_inst
     (
     .clk(clk),
     .rst_n(rst_n),
      .slow_clk(slow_clk)
);
/*/ ------------------------------------------------\\      
// ----------------  Timers  -----------------------//    <-------4) System Timers
\\ ------------------------------------------------/*/ 
always_ff @( posedge slow_clk, negedge rst_n ) begin : wating_timer
    if(!rst_n) begin
        waiting_timer<='0; 
    end
    else if(timer_en_r==1'b1) begin
        waiting_timer<=waiting_timer+1; 
    
    end
    else begin
        waiting_timer<='0; 
    end
end
/*/ ------------------------------------------------\\      
// ----------------  Transition Always block  ------//    <-------5) Edge detectors section
\\ ------------------------------------------------/*/ 
always_ff @( posedge clk, negedge rst_n ) begin : Transition_Always_block
    if(!rst_n)begin
        current_state<=IDLE;
        available_credit_out_r<='0;
        abort_r<='0;
        done_r<='0;
        card_spell_out_r<='0;
        final_credit_r<='0;
        final_up_limit_r<='0;
        transfer_en_r<='0;
        atm_capacity_r<='0;
        language_choice_r<='0;
        transfer_seq_count_r<='0;
        wr_en_r<='0;
        timer_en_r<='0;
        dead_lock_r<=1'b1;
        no_feedthrough_r<=1'b0;
        last_cycle_timer_r<='0;
    end
    else begin
        current_state<=next_state;
        available_credit_out_r<=available_credit_out_nx;
        abort_r<=abort_nx;
        done_r<=done_nx;
        card_spell_out_r<=card_spell_out_nx;
        final_credit_r<=final_credit_nx;
        final_up_limit_r<=final_up_limit_nx;
        transfer_en_r<=transfer_en_nx;
        atm_capacity_r<=atm_capacity_nx;
        language_choice_r<=language_choice_nx;
        transfer_seq_count_r<=transfer_seq_count_nx;
        wr_en_r<=wr_en_nx;
        timer_en_r<=timer_en_nx;
        dead_lock_r<=dead_lock_nx;
        no_feedthrough_r<=no_feedthrough_nx;
        last_cycle_timer_r<=last_cycle_timer_nx;
    end
end
/*/ ------------------------------------------------\\      
// ----------------  State machine body  -----------//    <-------6) State_Machine body
\\ ------------------------------------------------/*/ 
always@(*)begin
  next_state=current_state;
  available_credit_out_nx=available_credit_out_r;
  abort_nx=1'b0;
  done_nx=1'b0;
  wr_en_nx=1'b0;
  card_spell_out_nx=1'b0;
  final_credit_nx=final_credit_r;
  final_up_limit_nx=final_up_limit_r;
  transfer_en_nx=transfer_en_r; 
  timer_en_nx=timer_en_r;
  transfer_seq_count_nx=transfer_seq_count_r;
  atm_capacity_nx=atm_capacity_r;
  dead_lock_nx=dead_lock_r;
  no_feedthrough_nx=no_feedthrough_r;
  last_cycle_timer_nx=last_cycle_timer_r;
  case(current_state)
// ------------------------------------------------//       
//                    IDLE 
// ------------------------------------------------// 
    IDLE:begin
     
        if(atm_init==1'b1)begin
            atm_capacity_nx=atm_capacity;
        end
       else if(insert==1'b1)begin
        next_state=CHECK_CARD;
        end
    end  
// ------------------------------------------------//       
//                    CHECK_CARD 
// ------------------------------------------------// 
    CHECK_CARD:begin
        if(cancel_pe==1'b1)begin
            next_state=IDLE;
            card_spell_out_nx=1'b1;
        end
        else if(enter_pe==1'b1)begin
           if((input_password==ref_password)&&(valid==1'b1) )begin
            next_state=LANGUAGE_CHOICE;
            final_credit_nx=available_credit;
            final_up_limit_nx=up_limit;
           end
        else begin
          next_state=IDLE;
          card_spell_out_nx=1'b1;
        end
        end
    end  
// ------------------------------------------------//       
//                    LANGUAGE_CHOICE 
// ------------------------------------------------// 
    LANGUAGE_CHOICE:begin
        if(cancel_pe==1'b1)begin
            next_state=IDLE;
            card_spell_out_nx=1'b1;
        end
        else if(enter_pe==1'b1)begin
        language_choice_nx=language_choice;
        next_state=OPERATION_CHOICE;
      
        end
    end
// ------------------------------------------------//       
//                    OPERATION_CHOICE 
// ------------------------------------------------//    
    OPERATION_CHOICE:begin
        transfer_seq_count_nx='0;
        dead_lock_nx=1'b1;
        if(cancel_pe==1'b1)begin
            next_state=IDLE;
            card_spell_out_nx=1'b1;
        end
        else if(enter_pe==1'b1)begin
            
           case(op_choice)
            DEPOSITE_OP:begin
                next_state=DEPOSITE;
            end
            WITHDRAWAL_OP:begin
                next_state=WITHDRAWAL;
               
            end
            BALANCE_SERVICE_OP:begin
                next_state=BALANCE_SERVICE;
            end
            TRANSFER_OP:begin
                next_state=TRANSFER;
            end
            //default:next_state=OPERATION_CHOICE;
           endcase
            end
    end
// ------------------------------------------------//       
//                    DEPOSITE 
// ------------------------------------------------//        
    DEPOSITE:begin
        if((cancel_pe==1'b1)&&(timer_en_r==1'b0) && (last_cycle_timer_r == 0))begin
            next_state=OPERATION_CHOICE;
        end
        else if (no_feedthrough_r==1'b0)begin
            no_feedthrough_nx=1'b1;
        end
        else if((enter_pe==1'b1)&&(dead_lock_r==1'b1)&&(no_feedthrough_r==1'b1))begin
            final_credit_nx=final_credit_r+deposite_value;
            atm_capacity_nx=atm_capacity_r+deposite_value;
            wr_en_nx=1'b1;
            timer_en_nx=1;
            dead_lock_nx=1'b0;
        end
       else if((waiting_timer==WAITING_TIME)/*&&(freeze!=1'b1)*/)begin
            timer_en_nx=1'b0;
            last_cycle_timer_nx=last_cycle_timer_r+1;
            if(last_cycle_timer_r==(DIVISOR-1))begin
            done_nx=1'b1;
            next_state=OPERATION_CHOICE;
            dead_lock_nx=1'b1;
            no_feedthrough_nx=1'b0;
            last_cycle_timer_nx='0;
       end
        end

    end
// ------------------------------------------------//       
//                    WITHDRAWAL 
// ------------------------------------------------//       
    WITHDRAWAL:begin
        if((cancel_pe==1'b1)&&(timer_en_r==1'b0) && (last_cycle_timer_r == 0))begin
            next_state=OPERATION_CHOICE;
        end
        else if (no_feedthrough_r==1'b0)begin
            no_feedthrough_nx=1'b1;
        end
        else if((enter_pe==1'b1)&&(dead_lock_r==1'b1)&&(no_feedthrough_r==1'b1))begin
            if((withdrawal_value<=atm_capacity_r)&&(withdrawal_value<=final_credit_r)&&(withdrawal_value<=final_up_limit_r))begin
                final_credit_nx=final_credit_r-withdrawal_value;
                final_up_limit_nx=final_up_limit_r-withdrawal_value;
                atm_capacity_nx=atm_capacity_r-withdrawal_value;
                //if(waiting_timer!=WAITING_TIME)begin
              //  freeze_nx=1'b1;
                timer_en_nx=1'b1;
               // end
                wr_en_nx=1'b1;
                dead_lock_nx=1'b0;
           
            end
            else begin
                abort_nx=1'b1;
                next_state=ABORT;
                card_spell_out_nx=1'b1;
                dead_lock_nx=1'b1;
                no_feedthrough_nx=1'b0;
            end
        end
      /*  else if (waiting_timer==WAITING_TIME-1)begin

        end*/
        else if(waiting_timer==WAITING_TIME/*&&(freeze_r!=1'b0)*/)begin
            timer_en_nx=1'b0;
            last_cycle_timer_nx=last_cycle_timer_r+1;
            if(last_cycle_timer_r==(DIVISOR-1))begin
            done_nx=1'b1;
            next_state=OPERATION_CHOICE;
            dead_lock_nx=1'b1;
            no_feedthrough_nx=1'b0;
            last_cycle_timer_nx='0;
       end
        end
                
        
    
    end


// ------------------------------------------------//       
//                    BALANCE_SERVICE 
// ------------------------------------------------//     
    BALANCE_SERVICE:begin
    done_nx=1'b1;
    next_state=OPERATION_CHOICE;
    available_credit_out_nx=final_credit_r;
    end
// ------------------------------------------------//       
//                    TRANSFER 
// ------------------------------------------------//         
    TRANSFER:begin
        if(cancel_pe==1'b1)begin
            next_state=OPERATION_CHOICE;
        end
        else if (no_feedthrough_r==1'b0)begin
            no_feedthrough_nx=1'b1;
        end
        else if((enter_pe==1'b1)&&(dead_lock_r==1'b1)&&(no_feedthrough_r==1'b1))begin
            if((transfer_value<=final_credit_r)&&(transfer_value<=final_up_limit_r))begin
                final_credit_nx=final_credit_r-transfer_value;
                final_up_limit_nx=final_up_limit_r-transfer_value;
                dead_lock_nx=1'b0;
            end

            else begin
                abort_nx=1'b1;
                next_state=ABORT;
                card_spell_out_nx=1'b1;
                dead_lock_nx=1'b1;
                no_feedthrough_nx=1'b0;
            end
        end
        else if(transfer_seq_count_r!=3'd4 && (dead_lock_r==1'b0))begin
            transfer_seq_count_nx=transfer_seq_count_r+1;  
                    case(transfer_seq_count_r)
                        3'b000:begin
                            wr_en_nx=1'b1;                          
                        end
                        3'b001:begin
                            transfer_en_nx=1'b1;
                        end
                        3'b010:begin
                            wr_en_nx=1'b1;
                        end
                        3'b011:begin
                            transfer_en_nx=1'b0;
                            next_state=OPERATION_CHOICE;
                            done_nx=1'b1;
                            dead_lock_nx=1'b1;
                            no_feedthrough_nx=1'b0;
                        end
                    endcase 
         end
      
    end
// ------------------------------------------------//       
//                    ABORT 
// ------------------------------------------------//     
    ABORT:begin
        next_state=IDLE;
    end
endcase
end

assign   available_credit_out=available_credit_out_r;
assign   abort=abort_r;
assign   done=done_r;
assign   card_spell_out=card_spell_out_r;
assign   final_credit=final_credit_r;
assign   final_up_limit=final_up_limit_r;
assign   transfer_en=transfer_en_r;
assign   wr_en=wr_en_r;
endmodule