var g_data = {"13":{"st":"inst","pa":0,"n":"/atm_tb/atm_top_inst/atm_inst/clk_divider_inst","l":"Verilog","sn":6,"du":{"n":"work.clock_divider","s":6,"b":1},"bc":[{"n":"atm_tb","s":10,"b":1},{"n":"atm_top_inst","s":11,"b":1},{"n":"atm_inst","s":12,"b":1},{"n":"clk_divider_inst","s":13,"z":1}],"loc":{"cp":100.00,"data":{"s":[3,3],"b":[2,2]}}},"12":{"st":"inst","pa":0,"n":"/atm_tb/atm_top_inst/atm_inst","l":"Verilog","sn":5,"du":{"n":"work.atm","s":5,"b":1},"bc":[{"n":"atm_tb","s":10,"b":1},{"n":"atm_top_inst","s":11,"b":1},{"n":"atm_inst","s":12,"z":1}],"children":[{"n":"clk_divider_inst","id":13,"zf":1,"tc":100.00,"s":100.00,"b":100.00}],"rec":{"cp":86.04,"data":{"s":[139,136],"b":[66,61],"fc":[28,19]}},"loc":{"cp":85.94,"data":{"s":[136,133],"b":[64,59],"fc":[28,19]}}},"15":{"st":"inst","pa":0,"n":"/atm_tb/atm_top_inst/card_handler/card_handling_rom","l":"Verilog","sn":8,"du":{"n":"work.rom","s":8,"b":1},"bc":[{"n":"atm_tb","s":10,"b":1},{"n":"atm_top_inst","s":11,"b":1},{"n":"card_handler","s":14,"b":1},{"n":"card_handling_rom","s":15,"z":1}],"loc":{"cp":97.73,"data":{"s":[65,64],"b":[67,65]}}},"16":{"st":"inst","pa":0,"n":"/atm_tb/atm_top_inst/card_handler/card_handling_ram","l":"Verilog","sn":8,"du":{"n":"work.single_port_ram","s":9,"b":1},"bc":[{"n":"atm_tb","s":10,"b":1},{"n":"atm_top_inst","s":11,"b":1},{"n":"card_handler","s":14,"b":1},{"n":"card_handling_ram","s":16,"z":1}],"loc":{"cp":100.00,"data":{"s":[4,4],"b":[2,2]}}},"14":{"st":"inst","pa":0,"n":"/atm_tb/atm_top_inst/card_handler","l":"Verilog","sn":5,"du":{"n":"work.card_handling","s":7,"b":1},"bc":[{"n":"atm_tb","s":10,"b":1},{"n":"atm_top_inst","s":11,"b":1},{"n":"card_handler","s":14,"z":1}],"children":[{"n":"card_handling_ram","id":16,"zf":1,"tc":100.00,"s":100.00,"b":100.00},{"n":"card_handling_rom","id":15,"zf":1,"tc":97.73,"s":98.46,"b":97.01}],"rec":{"cp":97.93,"data":{"s":[72,71],"b":[73,71]}},"loc":{"cp":100.00,"data":{"s":[3,3],"b":[4,4]}}},"11":{"st":"inst","pa":0,"n":"/atm_tb/atm_top_inst","l":"Verilog","sn":2,"du":{"n":"work.atm_top","s":4,"b":0},"bc":[{"n":"atm_tb","s":10,"b":1},{"n":"atm_top_inst","s":11,"z":1}],"children":[{"n":"card_handler","id":14,"zf":1,"tc":97.93,"s":98.61,"b":97.26},{"n":"atm_inst","id":12,"zf":1,"tc":86.04,"s":97.84,"b":92.42,"fc":67.85}],"rec":{"cp":86.97,"data":{"s":[211,207],"b":[139,132],"fc":[28,19]}}},"10":{"st":"inst","pa":0,"n":"/atm_tb","l":"Verilog","sn":2,"du":{"n":"work.atm_tb","s":3,"b":1},"bc":[{"n":"atm_tb","s":10,"z":1}],"children":[{"n":"atm_top_inst","id":11,"zf":1,"tc":86.97,"s":98.10,"b":94.96,"fc":67.85}],"rec":{"cp":89.42,"data":{"s":[353,346],"b":[164,152],"fc":[43,26],"gb":[138,137],"cvpc":[10],"g":[8,99.80],"a":[26,25]}},"loc":{"cp":84.10,"data":{"s":[142,139],"b":[25,20],"fc":[15,7],"gb":[138,137],"cvpc":[10],"g":[8,99.80],"a":[26,25]}}},"5":{"st":"du","pa":0,"n":"work.atm","l":"Verilog","sn":6,"one_inst":12,"loc":{"cp":85.94,"data":{"s":[136,133],"b":[64,59],"fc":[28,19]}}},"3":{"st":"du","pa":0,"n":"work.atm_tb","l":"Verilog","sn":2,"one_inst":10,"loc":{"cp":84.10,"data":{"s":[142,139],"b":[25,20],"fc":[15,7],"gb":[138,137],"cvpc":[10],"g":[8,99.80],"a":[26,25]}}},"7":{"st":"du","pa":0,"n":"work.card_handling","l":"Verilog","sn":8,"one_inst":14,"loc":{"cp":100.00,"data":{"s":[3,3],"b":[4,4]}}},"6":{"st":"du","pa":0,"n":"work.clock_divider","l":"Verilog","sn":7,"one_inst":13,"loc":{"cp":100.00,"data":{"s":[3,3],"b":[2,2]}}},"8":{"st":"du","pa":0,"n":"work.rom","l":"Verilog","sn":9,"one_inst":15,"loc":{"cp":97.73,"data":{"s":[65,64],"b":[67,65]}}},"9":{"st":"du","pa":0,"n":"work.single_port_ram","l":"Verilog","sn":10,"one_inst":16,"loc":{"cp":100.00,"data":{"s":[4,4],"b":[2,2]}}}};
processSummaryData(g_data);