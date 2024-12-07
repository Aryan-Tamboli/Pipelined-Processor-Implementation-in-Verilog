module forwarding_unit(IR_RR,IR_EX,IR_MEM,IR_WB,alu_out_EX,alu_out_MEM,alu_out_WB,pc2_EX,
                        pc2_MEM,pc2_WB,mem_read_val_MEM,mem_read_val_WB,D1_forward,D1_forward_en,
                        D2_forward,D2_forward_en,
                        freeze,
                        reg_wr_en_EX,reg_wr_en_MEM,reg_wr_en_WB);
                        
    input [15:0] IR_RR,IR_EX,IR_MEM,IR_WB,alu_out_EX,alu_out_MEM,alu_out_WB,pc2_EX,pc2_MEM,pc2_WB;
    input [15:0] mem_read_val_MEM,mem_read_val_WB;
    input reg_wr_en_EX,reg_wr_en_MEM,reg_wr_en_WB;
    output reg [15:0] D1_forward,D2_forward;
    output reg D1_forward_en,D2_forward_en;
    output freeze;
    
    wire [3:0] opcode_RR = IR_RR[15:12];
    wire [3:0] opcode_EX = IR_EX[15:12];
    wire [3:0] opcode_MEM = IR_MEM[15:12];
    wire [3:0] opcode_WB = IR_WB[15:12];
    reg freeze1,freeze2;

    assign freeze = freeze1 || freeze2;
    always @(*) begin
        // Instruction In dependent on In-1, we check EX_stage destination address and RR_Stage operands address
        // For 1st operand
        if(((opcode_EX == 4'b0001) || (opcode_EX == 4'b0010)) && (IR_EX[5:3] == IR_RR[11:9]) && (reg_wr_en_EX == 1'b1)) begin             
                D1_forward <= alu_out_EX;
                D1_forward_en <= 1'b1; 
                freeze1 <= 1'b0;
        end
        else if((opcode_EX == 4'b0000) && (IR_EX[8:6] == IR_RR[11:9]) && (reg_wr_en_EX == 1'b1)) begin
                D1_forward <= alu_out_EX;
                D1_forward_en <= 1'b1; 
                freeze1 <= 1'b0;
        end
        else if(((opcode_EX == 4'b1100) || (opcode_EX == 4'b1101)) && (IR_EX[11:9] == IR_RR[11:9])  && (reg_wr_en_EX == 1'b1)) begin
                D1_forward <= pc2_EX;
                D1_forward_en <= 1'b1;
                freeze1 <= 1'b0;       
        end

        else if((opcode_EX == 4'b0100) && (IR_EX[11:9] == IR_RR[11:9]) && (reg_wr_en_EX == 1'b1) ) begin

                D1_forward <= 0;
                D1_forward_en <= 1'b0; 
                freeze1 <= 1'b1;
         
        end

        // instruction In depends on In-2, we check MEM_stage destination address with RR_stage operands
        else if(((opcode_MEM == 4'b0001) || (opcode_MEM == 4'b0010)) && (IR_MEM[5:3] == IR_RR[11:9]) && (reg_wr_en_MEM == 1'b1)) begin    

                D1_forward <= alu_out_MEM;
                D1_forward_en <= 1'b1; 
                freeze1 <= 1'b0; 
       
        end

        else if((opcode_MEM == 4'b0000) && (IR_MEM[8:6] == IR_RR[11:9])&& (reg_wr_en_MEM == 1'b1)) begin
  
                D1_forward <= alu_out_MEM;
                D1_forward_en <= 1'b1; 
                freeze1 <= 1'b0; 
         
        end
        else if(((opcode_MEM == 4'b1100) || (opcode_MEM == 4'b1101)) && (IR_MEM[11:9] == IR_RR[11:9]) && (reg_wr_en_MEM == 1'b1)) begin

                D1_forward <= pc2_MEM;
                D1_forward_en <= 1'b1; 
                freeze1 <= 1'b0; 
      
        end
        else if((opcode_MEM == 4'b0100) && (IR_MEM[11:9] == IR_RR[11:9]) && (reg_wr_en_MEM == 1'b1) ) begin

                D1_forward <= mem_read_val_MEM;
                D1_forward_en <= 1'b1;
                freeze1 <= 1'b0; 
         
        end
        // Instruction In depends on In-3 we check WB_stage destination address with RR_stage operands
        else if(((opcode_WB == 4'b0001) || (opcode_WB == 4'b0010)) && (IR_WB[5:3] == IR_RR[11:9]) && (reg_wr_en_WB == 1'b1)) begin    

                D1_forward <= alu_out_WB;
                D1_forward_en <= 1'b1;
                freeze1 <= 1'b0; 
           
        end

        else if((opcode_WB == 4'b0000) && (IR_WB[8:6] == IR_RR[11:9]) && (reg_wr_en_WB == 1'b1)) begin

                D1_forward <= alu_out_WB;
                D1_forward_en <= 1'b1; 
                freeze1 <= 1'b0;
                       
        end
        else if((opcode_WB == 4'b0100) && (IR_WB[11:9] == IR_RR[11:9])&& (reg_wr_en_WB == 1'b1)) begin
   
                D1_forward <= mem_read_val_WB;
                D1_forward_en <= 1'b1; 
                freeze1 <= 1'b0;
         
        end
        else if(((opcode_WB == 4'b1100) || (opcode_WB == 4'b1101)) && (IR_WB[11:9] == IR_RR[11:9]) && (reg_wr_en_WB == 1'b1)) begin

                D1_forward <= pc2_WB;
                D1_forward_en <= 1'b1; 
                freeze1 <= 1'b0;
   
        end
        else begin
               D1_forward <= 0;
               D1_forward_en <= 1'b0; 
               freeze1 <= 1'b0;

        end
    end

    always @(*) begin  
  
        // check same for the 2nd operands 
        if(((opcode_EX == 4'b0001) || (opcode_EX == 4'b0010)) && (IR_EX[5:3] == IR_RR[8:6])&& (reg_wr_en_EX == 1'b1)) begin    
         
                D2_forward <= alu_out_EX;
                D2_forward_en <= 1'b1; 
                freeze2 <= 1'b0;
                   
        end
        else if((opcode_EX == 4'b0000) && (IR_EX[8:6] == IR_RR[8:6]) && (reg_wr_en_EX == 1'b1)) begin
         
                D2_forward <= alu_out_EX;
                D2_forward_en <= 1'b1; 
                freeze2 <= 1'b0;
                     
        end
        else if((opcode_EX == 4'b0100) && (IR_EX[11:9] == IR_RR[8:6]) && (reg_wr_en_EX == 1'b1) ) begin
           
                D2_forward <= 0;
                D2_forward_en <= 0; 
                freeze2 <= 1'b1;
           
                  
        end
        else if(((opcode_EX == 4'b1100) || (opcode_EX == 4'b1101)) && (IR_EX[11:9] == IR_RR[8:6]) && (reg_wr_en_EX == 1'b1)) begin
           
                D2_forward <= pc2_EX;
                D2_forward_en <= 1'b1; 
                freeze2 <= 1'b0;
                  
        end

        // instruction In depends on In-2, we check MEM_stage destination address with RR_stage operands
        else if(((opcode_MEM == 4'b0001) || (opcode_MEM == 4'b0010)) && (IR_MEM[5:3] == IR_RR[8:6]) && (reg_wr_en_MEM == 1'b1)) begin    
           
                D2_forward <= alu_out_MEM;
                D2_forward_en <= 1'b1; 
                freeze2 <= 1'b0; 
                      
        end

        else if((opcode_MEM == 4'b0000) && (IR_MEM[8:6] == IR_RR[8:6]) && (reg_wr_en_MEM == 1'b1)) begin
          
                D2_forward <= alu_out_MEM;
                D2_forward_en <= 1'b1; 
                freeze2 <= 1'b0; 
                      
        end
        else if((opcode_MEM == 4'b0100) && (IR_MEM[11:9] == IR_RR[8:6]) && (reg_wr_en_MEM == 1'b1)) begin
       
                D2_forward <= mem_read_val_MEM;
                D2_forward_en <= 1'b1;
                freeze2 <= 1'b0; 
                         
        end
        else if(((opcode_MEM == 4'b1100) || (opcode_MEM == 4'b1101)) && (IR_MEM[11:9] == IR_RR[8:6]) && (reg_wr_en_MEM == 1'b1)) begin
       
                D2_forward <= pc2_MEM;
                D2_forward_en <= 1'b1; 
                freeze2 <= 1'b0;
     
                        
        end

        else if(((opcode_WB == 4'b0001) || (opcode_WB == 4'b0010)) && (IR_WB[5:3] == IR_RR[8:6]) && (reg_wr_en_WB == 1'b1) ) begin    
     
                D2_forward <= alu_out_WB;
                D2_forward_en <= 1'b1; 
                freeze2 <= 1'b0;

                   
        end

        else if((opcode_WB == 4'b0000) && (IR_WB[8:6] == IR_RR[8:6]) && (reg_wr_en_WB == 1'b1)  ) begin
           
                D2_forward <= alu_out_WB;
                D2_forward_en <= 1'b1; 
                freeze2 <= 1'b0;
                        
        end
        else if((opcode_WB == 4'b0100) && (IR_WB[11:9] == IR_RR[8:6]) && (reg_wr_en_WB == 1'b1) ) begin
            
                D2_forward <= mem_read_val_WB;
                D2_forward_en <= 1'b1; 
                freeze2 <= 1'b0;
                      
        end
        else if(((opcode_WB == 4'b1100) || (opcode_WB == 4'b1101)) && (IR_WB[11:9] == IR_RR[8:6]) && (reg_wr_en_WB == 1'b1) ) begin
  
                D2_forward <= pc2_WB;
                D2_forward_en <= 1'b1; 
                freeze2 <= 1'b0;
                           
        end
        else begin
                D2_forward <= 0;
                D2_forward_en <= 1'b0;
                freeze2 <= 1'b0;
        end

   end
endmodule

