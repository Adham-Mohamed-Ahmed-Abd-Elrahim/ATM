onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /atm_tb/user_count
add wave -noupdate -radix unsigned /atm_tb/operation_count
add wave -noupdate -radix unsigned /atm_tb/with_draw_val
add wave -noupdate -radix unsigned /atm_tb/clk
add wave -noupdate -radix unsigned /atm_tb/rst_n
add wave -noupdate -expand -group STATES -radix unsigned /atm_tb/atm_top_inst/atm_inst/current_state
add wave -noupdate -expand -group STATES -radix unsigned /atm_tb/atm_top_inst/atm_inst/next_state
add wave -noupdate -expand -group ATM_INITIALIZE -radix unsigned /atm_tb/atm_init
add wave -noupdate -expand -group ATM_INITIALIZE -radix unsigned /atm_tb/atm_capacity
add wave -noupdate -expand -group user_inputs -radix unsigned /atm_tb/atm_top_inst/atm_inst/op_choice
add wave -noupdate -expand -group user_inputs -radix unsigned /atm_tb/atm_top_inst/atm_inst/language_choice
add wave -noupdate -expand -group user_inputs -radix unsigned /atm_tb/atm_top_inst/atm_inst/input_password
add wave -noupdate -expand -group user_inputs -radix unsigned /atm_tb/atm_top_inst/atm_inst/deposite_value
add wave -noupdate -expand -group user_inputs -radix unsigned /atm_tb/atm_top_inst/atm_inst/withdrawal_value
add wave -noupdate -expand -group user_inputs -radix unsigned /atm_tb/atm_top_inst/atm_inst/transfer_value
add wave -noupdate -expand -group user_inputs -color {Indian Red} -radix unsigned /atm_tb/atm_top_inst/atm_inst/enter
add wave -noupdate -expand -group user_inputs -radix unsigned /atm_tb/atm_top_inst/atm_inst/cancel
add wave -noupdate -group test_bench_inputs /atm_tb/available_credit_out
add wave -noupdate -group test_bench_inputs /atm_tb/abort
add wave -noupdate -group test_bench_inputs /atm_tb/done
add wave -noupdate -group test_bench_inputs /atm_tb/card_spell_out
add wave -noupdate -group test_bench_inputs /atm_tb/insert
add wave -noupdate -group test_bench_inputs /atm_tb/op_choice
add wave -noupdate -group test_bench_inputs /atm_tb/language_choice
add wave -noupdate -group test_bench_inputs /atm_tb/input_password
add wave -noupdate -group test_bench_inputs /atm_tb/deposite_value
add wave -noupdate -group test_bench_inputs /atm_tb/withdrawal_value
add wave -noupdate -group test_bench_inputs /atm_tb/enter
add wave -noupdate -group test_bench_inputs /atm_tb/cancel
add wave -noupdate -group test_bench_inputs /atm_tb/input_card_pin
add wave -noupdate -group test_bench_inputs /atm_tb/transfer_card_pin
add wave -noupdate -group test_bench_inputs /atm_tb/up_limit
add wave -noupdate -group test_bench_inputs /atm_tb/transfer_value
add wave -noupdate -group test_bench_inputs /atm_tb/check_card/valid_card
add wave -noupdate -group top_module -color Yellow /atm_tb/atm_top_inst/input_card_pin
add wave -noupdate -group top_module /atm_tb/atm_top_inst/available_credit_out
add wave -noupdate -group top_module /atm_tb/atm_top_inst/abort
add wave -noupdate -group top_module /atm_tb/atm_top_inst/done
add wave -noupdate -group top_module /atm_tb/atm_top_inst/card_spell_out
add wave -noupdate -group top_module /atm_tb/atm_top_inst/atm_init
add wave -noupdate -group top_module /atm_tb/atm_top_inst/insert
add wave -noupdate -group top_module /atm_tb/atm_top_inst/atm_capacity
add wave -noupdate -group top_module /atm_tb/atm_top_inst/op_choice
add wave -noupdate -group top_module /atm_tb/atm_top_inst/language_choice
add wave -noupdate -group top_module /atm_tb/atm_top_inst/input_password
add wave -noupdate -group top_module /atm_tb/atm_top_inst/deposite_value
add wave -noupdate -group top_module /atm_tb/atm_top_inst/withdrawal_value
add wave -noupdate -group top_module /atm_tb/atm_top_inst/transfer_card_pin
add wave -noupdate -group top_module /atm_tb/atm_top_inst/transfer_value
add wave -noupdate -group top_module /atm_tb/atm_top_inst/ch_available_credit_sm
add wave -noupdate -group top_module /atm_tb/atm_top_inst/ch_ref_password_sm
add wave -noupdate -group top_module /atm_tb/atm_top_inst/ch_valid_cm
add wave -noupdate -group top_module /atm_tb/atm_top_inst/ch_up_limit_sm
add wave -noupdate -group top_module /atm_tb/atm_top_inst/sm_final_credit_ch
add wave -noupdate -group top_module /atm_tb/atm_top_inst/sm_final_up_limit_ch
add wave -noupdate -group top_module /atm_tb/atm_top_inst/sm_transfer_en_ch
add wave -noupdate -group top_module /atm_tb/atm_top_inst/sm_wr_en_ch
add wave -noupdate -group top_module /atm_tb/atm_top_inst/atm_inst/clk
add wave -noupdate -group top_module /atm_tb/atm_top_inst/atm_inst/rst_n
add wave -noupdate -group top_module /atm_tb/atm_top_inst/atm_inst/available_credit_out
add wave -noupdate -group top_module /atm_tb/atm_top_inst/atm_inst/abort
add wave -noupdate -group top_module /atm_tb/atm_top_inst/atm_inst/done
add wave -noupdate -group top_module /atm_tb/atm_top_inst/atm_inst/card_spell_out
add wave -noupdate -group top_module /atm_tb/atm_top_inst/atm_inst/final_credit
add wave -noupdate -group top_module /atm_tb/atm_top_inst/atm_inst/final_up_limit
add wave -noupdate -group top_module /atm_tb/atm_top_inst/atm_inst/transfer_en
add wave -noupdate -group top_module /atm_tb/atm_top_inst/atm_inst/atm_init
add wave -noupdate -group top_module /atm_tb/atm_top_inst/atm_inst/insert
add wave -noupdate -group top_module /atm_tb/atm_top_inst/atm_inst/atm_capacity
add wave -noupdate -group RAM -group ram_card_handler -radix unsigned /atm_tb/atm_top_inst/card_handler/card_handling_ram/clk
add wave -noupdate -group RAM -group ram_card_handler -radix unsigned /atm_tb/atm_top_inst/card_handler/card_handling_ram/write_enable
add wave -noupdate -group RAM -group ram_card_handler -radix unsigned /atm_tb/atm_top_inst/card_handler/card_handling_ram/address
add wave -noupdate -group RAM -group ram_card_handler -radix hexadecimal /atm_tb/atm_top_inst/card_handler/card_handling_ram/data_in
add wave -noupdate -group RAM -group ram_card_handler -radix hexadecimal /atm_tb/atm_top_inst/card_handler/card_handling_ram/data_out
add wave -noupdate -group RAM -radix unsigned /atm_tb/atm_top_inst/atm_inst/wr_en
add wave -noupdate -group RAM /atm_tb/atm_top_inst/card_handler/card_handling_ram/memory
add wave -noupdate -group RAM /atm_tb/ram
add wave -noupdate -group RAM -radix unsigned /atm_tb/atm_top_inst/atm_inst/available_credit
add wave -noupdate -group RAM -radix unsigned /atm_tb/atm_top_inst/atm_inst/up_limit
add wave -noupdate -group ROM /atm_tb/rom
add wave -noupdate -group ROM /atm_tb/atm_top_inst/atm_inst/insert
add wave -noupdate -group ROM /atm_tb/atm_top_inst/atm_inst/ref_password
add wave -noupdate -group ROM /atm_tb/atm_top_inst/atm_inst/valid
add wave -noupdate -expand -group state_outputs -radix unsigned /atm_tb/atm_top_inst/atm_inst/available_credit_out_nx
add wave -noupdate -expand -group state_outputs -radix unsigned /atm_tb/atm_top_inst/atm_inst/available_credit_out_r
add wave -noupdate -expand -group state_outputs -radix unsigned /atm_tb/atm_top_inst/atm_inst/abort_nx
add wave -noupdate -expand -group state_outputs -radix unsigned /atm_tb/atm_top_inst/atm_inst/abort_r
add wave -noupdate -expand -group state_outputs -radix unsigned /atm_tb/atm_top_inst/atm_inst/done_nx
add wave -noupdate -expand -group state_outputs -radix unsigned /atm_tb/atm_top_inst/atm_inst/done_r
add wave -noupdate -expand -group state_outputs -radix unsigned /atm_tb/atm_top_inst/atm_inst/card_spell_out_nx
add wave -noupdate -expand -group state_outputs -radix unsigned /atm_tb/atm_top_inst/atm_inst/card_spell_out_r
add wave -noupdate -expand -group state_outputs -radix unsigned /atm_tb/atm_top_inst/atm_inst/final_credit_nx
add wave -noupdate -expand -group state_outputs -radix unsigned /atm_tb/atm_top_inst/atm_inst/final_credit_r
add wave -noupdate -expand -group state_outputs -radix unsigned /atm_tb/atm_top_inst/atm_inst/final_up_limit_nx
add wave -noupdate -expand -group state_outputs -radix unsigned /atm_tb/atm_top_inst/atm_inst/final_up_limit_r
add wave -noupdate -expand -group state_outputs -radix unsigned /atm_tb/atm_top_inst/atm_inst/transfer_en_nx
add wave -noupdate -expand -group state_outputs -color Orange -radix unsigned /atm_tb/atm_top_inst/atm_inst/transfer_en_r
add wave -noupdate -expand -group state_outputs -radix unsigned /atm_tb/atm_top_inst/atm_inst/wr_en_nx
add wave -noupdate -expand -group state_outputs -color Magenta -radix unsigned /atm_tb/atm_top_inst/atm_inst/wr_en_r
add wave -noupdate -expand -group state_outputs -color Goldenrod -radix unsigned /atm_tb/atm_top_inst/atm_inst/transfer_seq_count_nx
add wave -noupdate -expand -group state_outputs -color Goldenrod -radix unsigned /atm_tb/atm_top_inst/atm_inst/transfer_seq_count_r
add wave -noupdate -expand -group state_outputs -radix unsigned /atm_tb/atm_top_inst/atm_inst/atm_capacity_nx
add wave -noupdate -expand -group state_outputs -radix unsigned /atm_tb/atm_top_inst/atm_inst/atm_capacity_r
add wave -noupdate -expand -group state_outputs -radix unsigned /atm_tb/atm_top_inst/atm_inst/language_choice_nx
add wave -noupdate -expand -group state_outputs -radix unsigned /atm_tb/atm_top_inst/atm_inst/language_choice_r
add wave -noupdate -group posedege_detect(enter/cancel) /atm_tb/atm_top_inst/enter
add wave -noupdate -group posedege_detect(enter/cancel) /atm_tb/atm_top_inst/cancel
add wave -noupdate -group posedege_detect(enter/cancel) /atm_tb/atm_top_inst/atm_inst/enter_r
add wave -noupdate -group posedege_detect(enter/cancel) /atm_tb/atm_top_inst/atm_inst/enter_pe
add wave -noupdate -group posedege_detect(enter/cancel) /atm_tb/atm_top_inst/atm_inst/cancel_r
add wave -noupdate -group posedege_detect(enter/cancel) /atm_tb/atm_top_inst/atm_inst/cancel_pe
add wave -noupdate -expand -group state_safety /atm_tb/atm_top_inst/atm_inst/no_feedthrough_r
add wave -noupdate -expand -group state_safety /atm_tb/atm_top_inst/atm_inst/no_feedthrough_nx
add wave -noupdate -expand -group state_safety -color {Medium Orchid} /atm_tb/atm_top_inst/atm_inst/dead_lock_r
add wave -noupdate -expand -group state_safety -color {Medium Orchid} /atm_tb/atm_top_inst/atm_inst/dead_lock_nx
add wave -noupdate -expand -group waiting_timer /atm_tb/atm_top_inst/atm_inst/last_cycle_timer_nx
add wave -noupdate -expand -group waiting_timer /atm_tb/atm_top_inst/atm_inst/last_cycle_timer_r
add wave -noupdate -expand -group waiting_timer -radix unsigned /atm_tb/atm_top_inst/atm_inst/waiting_timer
add wave -noupdate -expand -group waiting_timer /atm_tb/atm_top_inst/atm_inst/timer_en_nx
add wave -noupdate -expand -group waiting_timer /atm_tb/atm_top_inst/atm_inst/timer_en_r
add wave -noupdate -expand -group waiting_timer /atm_tb/atm_top_inst/atm_inst/slow_clk
add wave -noupdate -group card_handler -radix unsigned /atm_tb/atm_top_inst/atm_inst/clk_divider_inst/clk
add wave -noupdate -group card_handler -radix unsigned /atm_tb/atm_top_inst/atm_inst/clk_divider_inst/rst_n
add wave -noupdate -group card_handler -radix unsigned /atm_tb/atm_top_inst/atm_inst/clk_divider_inst/slow_clk
add wave -noupdate -group card_handler -radix unsigned /atm_tb/atm_top_inst/atm_inst/clk_divider_inst/counter
add wave -noupdate -group card_handler -radix unsigned /atm_tb/atm_top_inst/card_handler/clk
add wave -noupdate -group card_handler -radix unsigned /atm_tb/atm_top_inst/card_handler/insert
add wave -noupdate -group card_handler -radix unsigned /atm_tb/atm_top_inst/card_handler/ram_write_enable
add wave -noupdate -group card_handler -radix unsigned /atm_tb/atm_top_inst/card_handler/transfer_card_pin
add wave -noupdate -group card_handler -radix unsigned /atm_tb/atm_top_inst/card_handler/transfer_enable
add wave -noupdate -group card_handler -radix unsigned /atm_tb/atm_top_inst/card_handler/transfer_value
add wave -noupdate -group card_handler -radix unsigned /atm_tb/atm_top_inst/card_handler/final_credit
add wave -noupdate -group card_handler -radix unsigned /atm_tb/atm_top_inst/card_handler/input_card_pin
add wave -noupdate -group card_handler -radix unsigned /atm_tb/atm_top_inst/card_handler/final_up_limit
add wave -noupdate -group card_handler -radix unsigned /atm_tb/atm_top_inst/card_handler/available_credit
add wave -noupdate -group card_handler -radix unsigned /atm_tb/atm_top_inst/card_handler/up_limit
add wave -noupdate -group card_handler -radix unsigned /atm_tb/atm_top_inst/card_handler/ref_password
add wave -noupdate -group card_handler -radix unsigned /atm_tb/atm_top_inst/card_handler/valid
add wave -noupdate -group card_handler -radix unsigned /atm_tb/atm_top_inst/card_handler/rom_data_out
add wave -noupdate -group card_handler -radix unsigned /atm_tb/atm_top_inst/card_handler/ram_addr
add wave -noupdate -group card_handler -color Blue -radix binary /atm_tb/atm_top_inst/card_handler/ram_data_in
add wave -noupdate -group card_handler -radix unsigned /atm_tb/atm_top_inst/card_handler/ram_data_out
add wave -noupdate -group card_handler -color Blue -radix unsigned /atm_tb/atm_top_inst/card_handler/final_transfered_available_credit
add wave -noupdate -group card_handler -radix unsigned /atm_tb/atm_top_inst/card_handler/card_handling_rom/clk
add wave -noupdate -group card_handler -radix unsigned /atm_tb/atm_top_inst/card_handler/card_handling_rom/read_enable
add wave -noupdate -group card_handler -radix unsigned /atm_tb/atm_top_inst/card_handler/card_handling_rom/address
add wave -noupdate -group card_handler -radix unsigned /atm_tb/atm_top_inst/card_handler/card_handling_rom/data_out
add wave -noupdate -group card_handler -radix unsigned /atm_tb/atm_top_inst/card_handler/card_handling_rom/data
add wave -noupdate -group clock_divider /atm_tb/atm_top_inst/atm_inst/clk_divider_inst/clk
add wave -noupdate -group clock_divider /atm_tb/atm_top_inst/atm_inst/clk_divider_inst/rst_n
add wave -noupdate -group clock_divider /atm_tb/atm_top_inst/atm_inst/clk_divider_inst/slow_clk
add wave -noupdate -group clock_divider /atm_tb/atm_top_inst/atm_inst/clk_divider_inst/counter
add wave -noupdate -group assertions /atm_tb/assert__states
add wave -noupdate -group assertions /atm_tb/assert__IDLE_Transition_1
add wave -noupdate -group assertions /atm_tb/assert__IDLE_Transition_2
add wave -noupdate -group assertions /atm_tb/assert__checkcard_transition_1
add wave -noupdate -group assertions /atm_tb/assert__checkcard_transition_2
add wave -noupdate -group assertions /atm_tb/assert__OPERATION_CHOICE_transition_1
add wave -noupdate -group assertions /atm_tb/assert__OPERATION_CHOICE_transition_2
add wave -noupdate -group assertions /atm_tb/assert__OPERATION_CHOICE_transition_3
add wave -noupdate -group assertions /atm_tb/assert__OPERATION_CHOICE_transition_4
add wave -noupdate -group assertions /atm_tb/assert__OPERATION_CHOICE_transition_5
add wave -noupdate -group assertions /atm_tb/assert__WITHDRAWAL_transition_1
add wave -noupdate -group assertions /atm_tb/assert__WITHDRAWAL_transition_2
add wave -noupdate -group assertions /atm_tb/assert__Balance_service_transition
add wave -noupdate -group assertions /atm_tb/assert__Transfer_transition_1
add wave -noupdate -group assertions /atm_tb/assert__Transfer_transition_2
add wave -noupdate -group assertions /atm_tb/assert__Done_signal_in_WITHDRAWAL
add wave -noupdate -group assertions /atm_tb/assert__Abort_signal_in_WITHDRAWAL
add wave -noupdate -group assertions /atm_tb/assert__Abort_signal_in_Transfer
add wave -noupdate -group assertions /atm_tb/assert__final_credit
add wave -noupdate -group assertions /atm_tb/assert__final_credit_1
add wave -noupdate -group assertions /atm_tb/assert__Final_Up_limit
add wave -noupdate -group assertions /atm_tb/assert__Final_Up_limit_1
add wave -noupdate -group assertions /atm_tb/assert__final_credit_2
add wave -noupdate -group assertions /atm_tb/assert__ATM_capacity
add wave -noupdate -group assertions /atm_tb/assert__ATM_capacity_1
add wave -noupdate -group assertions /atm_tb/assert__Ref_password
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {933 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 484
configure wave -valuecolwidth 149
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {768 ns} {1812 ns}
