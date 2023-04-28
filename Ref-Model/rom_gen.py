def convert_to_binary(num):

    # Convert the integer to a string
    num_str = str(num)

    # Iterate through each character in the string and print the digit
    binary_num = ""
    for char in num_str:
        bunary_char = bin(int(char))
        binary_num = binary_num + bunary_char[2:].rjust(4, '0')

    return binary_num

ROM_DATA_WIDTH = 17
ROM_MEM_SIZE   = 64

module_dec_str = f'''module rom #(parameter ROM_DATA_WIDTH = {ROM_DATA_WIDTH},
                       ROM_MEM_SIZE   = {ROM_MEM_SIZE})
(
    // input & output ports
	input  wire                             clk,
	input  wire                             read_enable,
	input  wire  [$clog2(ROM_MEM_SIZE)-1:0] address,
	output wire  [ROM_DATA_WIDTH-1:0]       data_out
);

(*rom_style = "block" *) reg [ROM_DATA_WIDTH-1:0] data; // to infer block ram Resources

//-----------------------------------------------------------
//----------------------- Memory Logic ----------------------
//-----------------------------------------------------------
always  @(posedge clk) begin

    if(read_enable) begin

        case (address)

'''

case_code_str = ""
with open('credit_file.txt', 'r') as file:
    # Read the file line by line
    for i,line in enumerate(file):

        # Process each line here
        line_nums = line.strip().split(' ')
        ref_password = convert_to_binary(int(line_nums[0]))
        valid_bit = line_nums[1]
        data_str = ref_password + '_' + valid_bit
        if i <= 9:
            space = " "
        else:
            space = ""
        if (i+1)%2 == 0:
            addr_code = f"\t\t'd{i}:{space} data <= 'b{data_str};\n"
        else:
            addr_code = f"\t\t\t'd{i}:{space} data <= 'b{data_str};"
        case_code_str = case_code_str + addr_code

end_str = '''\n        endcase
    end
end

assign data_out = data;

endmodule'''

with open('..\\..\\RTL\\rom.v', 'w') as file:
    # Write the text to the file
    file.write(module_dec_str+case_code_str+end_str)
