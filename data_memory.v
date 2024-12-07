module data_memory (
    input clk,rst,
    input wr_en,
    input [15:0] read_add, wr_add, data_in,
    output [15:0] data_out
	
);

    // Memory of 65536 16-bit words
    reg [7:0] mem [40:0];
	 integer i;

    // Read 16-bit word from memory at the read address
    assign data_out = {mem[read_add],mem[read_add+1]};

    always @(posedge clk) begin
		  if(rst) begin
		     mem[0] = 8'b00000000;
           mem[1] = 8'b00000000;	
			  mem[2] = 8'b00000000;
           mem[3] = 8'b00000000;	
			  mem[4] = 8'b00000000;
           mem[5] = 8'b00000000;	
			  mem[6] = 8'b00000000;
           mem[7] = 8'b00000000;	
			  
			  mem[8] =  8'b00000000;
			  mem[9] =  8'b00001100;
			  mem[10] = 8'b00000000;
			  mem[11] = 8'b00000111;
			  mem[12] = 8'b00000000;
			  mem[13] = 8'b00001000;
			  mem[14] = 8'b00000000;
			  mem[15] = 8'b00010000;
			  mem[16] = 8'b00000000;
			  mem[17] = 8'b00000010;
			  
			  
			  //for(i = 18;i<4000;i=i+1) begin
				//	mem[i] <= 0;
			  //end 
	
		  end
		  
		  else begin
			  if (wr_en) begin
					{mem[wr_add],mem[wr_add+1]} <= data_in;  // Write 16-bit data to memory at the write address
			  end 		
        end

    end


endmodule
