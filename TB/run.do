vlog .\atm_tb.sv +define+tb_2 -cover bcs -suppress vlog-13364
vsim -assertdebug  -voptargs=+acc -msgmode both -coverage  work.atm_tb
do {D:/Work Zone/ACADMIC/ECEE/Fourth Year/Second Term/Projects/EDA/1st Project/TB/withdrawal.do}