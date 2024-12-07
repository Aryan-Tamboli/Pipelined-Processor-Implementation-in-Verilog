module EX_MEM (clk, rst, pc_in, pc2_in, IR_in, pc_out,pc2_out,IR_out,reg_wr_en_in,mem_wr_en_in,reg_wr_en_out,mem_wr_en_out,D1_in,D1_out,alu_out_in,alu_out_out,carryin,carryout,zeroin,zeroout);
  input clk, rst, mem_wr_en_in,reg_wr_en_in,carryin,zeroin;
  input [15:0] pc_in, pc2_in, IR_in,D1_in,alu_out_in;  
  output reg carryout,zeroout;
  output reg mem_wr_en_out,reg_wr_en_out;
  output reg [15:0] pc_out, pc2_out, IR_out,D1_out,alu_out_out;

  always @ (posedge clk) begin    
        if(rst) begin
          mem_wr_en_out <= 0; 
          reg_wr_en_out <= 0;         
                  
          IR_out <= 0; 
          pc2_out <= 0;
          pc_out <= 0;        
          D1_out <= 0;
          carryout <= 0;
          zeroout <= 0;
          alu_out_out <= 0;
        end
        else begin
          mem_wr_en_out <= mem_wr_en_in; 
          reg_wr_en_out <= reg_wr_en_in;         
                  
          IR_out <= IR_in; 
          pc2_out <= pc2_in;
          pc_out <= pc_in;        
          D1_out <= D1_in;
          carryout <= carryin;
          zeroout <= zeroin;
          alu_out_out <= alu_out_in;
        end    
        
  end

endmodule // EX_MEM