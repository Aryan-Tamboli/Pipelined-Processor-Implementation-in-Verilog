module ID_stage(clk,pc_in,pc2_in,IR_in,alu_ctrl,reg_wr_en,mem_wr_en);
    input clk;
    input [15:0] pc_in,pc2_in,IR_in;
    output reg [2:0] alu_ctrl ;
    output reg reg_wr_en,mem_wr_en;

    wire [3:0] opcode;  // Declare opcode as a 4-bit wire

    assign opcode = IR_in[15:12]; 

    always @(*) begin
        if(IR_in != 16'b0000000000000000) begin
            if(opcode == 4'b0000) begin
                alu_ctrl <= 3'b000;
                reg_wr_en <= 1'b1;
                mem_wr_en <=  1'b0;
            end
            else if(opcode == 4'b0001) begin
                reg_wr_en <= 1'b1;
                mem_wr_en <= 1'b0;
                if((IR_in[2:0] == 3'b000) || (IR_in[2:0] == 3'b010) || (IR_in[2:0] == 3'b001)) 
                    alu_ctrl <= 3'b000;
                else if((IR_in[2:0] == 3'b011))
                    alu_ctrl <= 3'b010;
                else if((IR_in[2:0] == 3'b100) || (IR_in[2:0] == 3'b110) || (IR_in[2:0] == 3'b101)) 
                    alu_ctrl <= 3'b001;
                else if((IR_in[2:0] == 3'b111))
                    alu_ctrl <= 3'b011;        

            end
            else if(opcode == 4'b0100) begin
                alu_ctrl <= 3'b000;
                reg_wr_en <= 1'b1;
                mem_wr_en <=  1'b0;

            end
            else if(opcode == 4'b0101) begin
                alu_ctrl <= 3'b000;
                reg_wr_en <= 1'b0;
                mem_wr_en <=  1'b1;
            end
            else if((opcode == 4'b1000) || (opcode == 4'b1001) || (opcode == 4'b1010) ) begin
                alu_ctrl <= 3'b110;
                reg_wr_en <= 1'b0;
                mem_wr_en <=  1'b0;
            end
            else if((opcode == 4'b1100) || (opcode == 4'b1101)) begin
                alu_ctrl <= 3'b000; // does not matter for this instr
                reg_wr_en <= 1'b1;
                mem_wr_en <=  1'b0;
            end
            else if(opcode == 4'b1111) begin
                alu_ctrl <= 3'b000; // does not matter for this instr
                reg_wr_en <= 1'b0;
                mem_wr_en <=  1'b0;
            end
            else if(opcode == 4'b0010) begin
                reg_wr_en <= 1'b1;
                mem_wr_en <= 1'b0;
                if((IR_in[2:0] == 3'b000) || (IR_in[2:0] == 3'b010) || (IR_in[2:0] == 3'b001)) 
                    alu_ctrl <= 3'b000;
                else if((IR_in[2:0] == 3'b100) || (IR_in[2:0] == 3'b110) || (IR_in[2:0] == 3'b101)) 
                    alu_ctrl <= 3'b101;
            else begin
                alu_ctrl <= 3'b000; // does not matter for this instr
                reg_wr_en <= 1'b0;
                mem_wr_en <=  1'b0;

            end        
               
            end
        end    
        else begin
            alu_ctrl <= 3'b000; // does not matter for this instr
            reg_wr_en <= 1'b0;
            mem_wr_en <=  1'b0;
        end

    end
    
endmodule