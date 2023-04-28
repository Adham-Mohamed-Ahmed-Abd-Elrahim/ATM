package param;
    parameter CREDIT_VAL_SIZE = 25 ;
    parameter UP_LIMIT_SIZE = 15 ;
    parameter ATM_CAP_SIZE=        18 ;
    parameter PASSWORD_SIZE = 16 ;
    parameter DEPTH = 64 ;
    parameter PINCARD_SIZE = 6 ;
    parameter WITHDRAW_SIZE=		15;
    parameter TRANSFER_SIZE=		15;
    parameter DEPOSITE_SIZE=		15;
    parameter OP_CHOICE_SIZE=		2;
    parameter WAITING_TIMER_SIZE = 8;
    parameter SLOW_CLK_COUNTER_SIZE=5 ;
    parameter DIVISOR=16;
    parameter RAM_DATA_WIDTH=UP_LIMIT_SIZE+CREDIT_VAL_SIZE;
    parameter ROM_DATA_WIDTH=PASSWORD_SIZE+1;
    parameter WAITING_TIME=5;
endpackage 