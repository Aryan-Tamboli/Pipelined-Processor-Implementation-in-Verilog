module MEM_WB (clk, rst, pc_in, pc2_in, IR_in, pc_out,pc2_out,IR_out,reg_wr_en_in,reg_wr_en_out,alu_out_in,alu_out_out,carryin,carryout,zeroin,zeroout,mem_read_val_in,mem_read_val_out);
  input clk, rst, reg_wr_en_in, carryin, zeroin;
  input [15:0] pc_in, pc2_in, IR_in, alu_out_in, mem_read_val_in;  
  output reg carryout, zeroout;
  output reg reg_wr_en_out;
  output reg [15:0] pc_out, pc2_out, IR_out, alu_out_out, mem_read_val_out;

  always @ (posedge clk) begin    
        if(rst) begin
            reg_wr_en_out <= 0;         
                  
            IR_out <= 0; 
            pc2_out <= 0;
            pc_out <= 0;        
            mem_read_val_out <= 0;
            alu_out_out <= 0;
            carryout <= 0;
            zeroout <= 0;
        end
        else begin

          reg_wr_en_out <= reg_wr_en_in;         
                  
          IR_out <= IR_in; 
          pc2_out <= pc2_in;
          pc_out <= pc_in;        
          mem_read_val_out <= mem_read_val_in;
          alu_out_out <= alu_out_in;
          carryout <= carryin;
          zeroout <= zeroin;
        end
        
  end

endmodule // MEM_WB