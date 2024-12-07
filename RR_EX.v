module RR_EX (clk, rst, br_taken, pc_in, pc2_in, IR_in, pc_out,pc2_out,
              IR_out,alu_ctrl_in,reg_wr_en_in,mem_wr_en_in,alu_ctrl_out,
              reg_wr_en_out,mem_wr_en_out,D1_in,D2_in,D1_out,D2_out,D1_forward,
              D1_forward_en,D2_forward,D2_forward_en,freeze);

  input clk, rst, br_taken,mem_wr_en_in,reg_wr_en_in;
  input [15:0] pc_in, pc2_in, IR_in,D1_in,D2_in;
  input [2:0] alu_ctrl_in;
  input [15:0] D1_forward,D2_forward;
  input D1_forward_en,D2_forward_en;
  input freeze;
  output reg [2:0] alu_ctrl_out;
  output reg mem_wr_en_out,reg_wr_en_out;
  output reg [15:0] pc_out, pc2_out, IR_out,D1_out,D2_out;

  always @ (posedge clk) begin 
      
        if (rst) begin
          IR_out <= 0; 
          pc2_out <= 0;
          pc_out <= 0; 
          alu_ctrl_out <= 0;
          D1_out <= 0;
          D2_out <= 0;
          mem_wr_en_out <= 1'b0; 
          reg_wr_en_out <= 1'b0;

        end
		  
        else begin
          if(freeze==0) begin 
            if (br_taken) begin
              mem_wr_en_out <= 1'b0; // we need to flush the instruction so write signals are set to 0
              reg_wr_en_out <= 1'b0;     
            end
            else begin
              mem_wr_en_out <= mem_wr_en_in; 
              reg_wr_en_out <= reg_wr_en_in;          
            end          
            IR_out <= IR_in; 
            pc2_out <= pc2_in;
            pc_out <= pc_in; 
            alu_ctrl_out <= alu_ctrl_in;
            if(D1_forward_en)
                D1_out <= D1_forward;
            else 
                D1_out <= D1_in;

            if(D2_forward_en) 
                D2_out <= D2_forward;   
            else       
                D2_out <= D2_in;
          end

          else begin
                IR_out <= 0; 
                pc2_out <= 0;
                pc_out <= 0; 
                alu_ctrl_out <= 0;
                D1_out <= 0;
                D2_out <= 0;
                mem_wr_en_out <= 0; 
                reg_wr_en_out <= 0;
          end
        end


        
  end

endmodule // RR_EX