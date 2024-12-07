module instr_memory(
    input clk, rst,                             // Added rst signal
    input [15:0] address,
    output [15:0] IR
);
    reg [7:0] mem [50:0];  // Declare memory as 8-bit wide with 65536 locations

    // Always block to load instruction on rising edge of clock or reset
	 assign IR = {mem[address],mem[address+1]};
	 integer i;
	 
    always @(posedge clk) begin
        if (rst) begin
            // Initialize memory on reset
            mem[0] <= 8'b01000011;
            mem[1] <= 8'b11001010;
            mem[2] <= 8'b01000101;
            mem[3] <= 8'b11001100;
				mem[4] <= 8'b00010010;
            mem[5] <= 8'b10011000;
				mem[6] <= 8'b11111110;
            mem[7] <= 8'b00010100;
				mem[8] <= 8'b00000000;
            mem[9] <= 8'b00000000;
				mem[10] <= 8'b00010010;
            mem[11] <= 8'b11100000;
				mem[12] <= 8'b00011000;
            mem[13] <= 8'b11101000;
				mem[14] <= 8'b00000000;
            mem[15] <= 8'b00000000;
				mem[16] <= 8'b00000000;
            mem[17] <= 8'b00000000;
				mem[18] <= 8'b01011000;
            mem[19] <= 8'b10001010;
				mem[20] <= 8'b00000000;
            mem[21] <= 8'b00000000;
				mem[22] <= 8'b00000000;
            mem[23] <= 8'b00000000;
				mem[24] <= 8'b00000000;
            mem[25] <= 8'b00000000;
				mem[26] <= 8'b01001100;
            mem[27] <= 8'b10001010;
				mem[28] <= 8'b11001110;
				mem[29] <= 8'b00001000;
				mem[30] <= 8'b00010010;
            mem[31] <= 8'b11101000;
				mem[32] <= 8'b00010010;
            mem[33] <= 8'b11101000;
				mem[34] <= 8'b00010010;
            mem[35] <= 8'b11101000;
				mem[40] <= 8'b01000111;
				mem[41] <= 8'b11001110;
				mem[42] <= 8'b01001001;
				mem[43] <= 8'b11010000;
				
				mem[44] <= 8'b00010111;
            mem[45] <= 8'b00101000;
				mem[46] <= 8'b00001011;
            mem[47] <= 8'b10010000;
				
				
				//for(i = 48;i<4000;i=i+1) begin
					//mem[i] <= 0;
			   //end
			  
				
            // You can initialize more memory locations as needed
        end 
		  
    end
endmodule
