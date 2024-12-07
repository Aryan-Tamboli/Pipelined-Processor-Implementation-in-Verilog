module reg_file(
    input clk, rst,wr_en, pc_write,
    input [2:0] A1, A2, A3,
    input [15:0] Data_in, pc_in,
    output [15:0] D1, D2, pc_out,
	 output [15:0] r0,r1,r2,r3,r4,r5,r6,r7
);
    // Declare regfile as an array of 16-bit registers (8 registers in total)
    reg [15:0] regfile [7:0]; // 8 registers of 16-bit width

    // Assign the values from the register file
    assign D1 = regfile[A1];  // Read register A1
    assign D2 = regfile[A2];  // Read register A2
    assign pc_out = regfile[0];  // The PC output is from regfile[0]
	 // outputs of main module
	 assign r0 = regfile[0];
	 assign r1 = regfile[1];
	 assign r2 = regfile[2];
	 assign r3 = regfile[3];
	 assign r4 = regfile[4];
	 assign r5 = regfile[5];
	 assign r6 = regfile[6];
	 assign r7 = regfile[7];
	 

    // Initial block to initialize the registers
    always @(posedge clk) begin
	 
		if (rst) begin
        regfile[0] <= 16'b0000000000000000;
        regfile[1] <= 16'b0000000000000000;
        regfile[2] <= 16'b0000000000000000;
        regfile[3] <= 16'b0000000000000000;
        regfile[4] <= 16'b0000000000000000;
        regfile[5] <= 16'b0000000000000000;
        regfile[6] <= 16'b0000000000000000;
        regfile[7] <= 16'b0000000000000000;
		end 
		else begin
		
			if (wr_en) begin
				regfile[A3] <= Data_in;
			end 
			if (pc_write) begin
				regfile[0] <= pc_in;
			end
		end 	
end

endmodule
