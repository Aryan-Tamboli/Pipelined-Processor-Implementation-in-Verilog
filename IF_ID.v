module IF_ID (clk, rst, br_taken, pc_in, pc2_in, IR_in, pc_out,pc2_out,IR_out,freeze);
  input clk, rst, br_taken;
  input [15:0] pc_in, pc2_in, IR_in;
  input freeze;
  output reg [15:0] pc_out, pc2_out, IR_out;

  always @ (posedge clk) begin    
        if(rst) begin         
          {pc_out,IR_out,pc2_out,IR_out} <= 0;
			 
        end
		else begin
			if(freeze==0) begin
			  if (br_taken) begin
				 IR_out <= 0;
				 pc2_out <= pc2_in;
				 pc_out <= pc_in;           
			  end
			  else begin
				 IR_out <= IR_in;
				 pc2_out <= pc2_in;
				 pc_out <= pc_in; 
			  end
			end
			else begin
				IR_out <= IR_out;
				pc2_out <= pc2_out;
				pc_out <= pc_out; 
			end

		  end  
    
  end

endmodule // IF2ID