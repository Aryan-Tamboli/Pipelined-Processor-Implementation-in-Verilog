module ID_RR (clk, rst, br_taken, pc_in, pc2_in, IR_in, pc_out,
              pc2_out,IR_out,alu_ctrl_in,reg_wr_en_in,mem_wr_en_in,
              alu_ctrl_out,reg_wr_en_out,mem_wr_en_out,freeze);
  input clk, rst, br_taken,mem_wr_en_in,reg_wr_en_in;
  input [15:0] pc_in, pc2_in, IR_in;
  input [2:0] alu_ctrl_in;
  input freeze;
  output reg [2:0] alu_ctrl_out;
  output reg mem_wr_en_out,reg_wr_en_out;
  output reg [15:0] pc_out, pc2_out, IR_out;



  always @ (posedge clk) begin 
     
        if(rst) begin
          IR_out <= 0; 
          pc2_out <= 0;
          pc_out <= 0; 
          alu_ctrl_out <= 0;
          mem_wr_en_out <= 0; 
          reg_wr_en_out <= 0;  
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
          end
          else begin
            IR_out <= IR_out; 
            pc2_out <= pc2_out;
            pc_out <= pc_out; 
            alu_ctrl_out <= alu_ctrl_out;
            mem_wr_en_out <= mem_wr_en_out; 
            reg_wr_en_out <= reg_wr_en_out; 
          end
        end


  end

endmodule // IF2ID