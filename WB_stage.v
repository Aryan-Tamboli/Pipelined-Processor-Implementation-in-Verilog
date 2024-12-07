module WB_stage(clk,IR_in,alu_out,mem_read_val, pc_in,pc2_in, carryin,zeroin,carryout,zeroout,data_to_reg,dest_add,carry_wr,zero_wr,reg_wr_en_in,reg_wr_en_out,carry_flag_status,zero_flag_status);
    input clk,carryin,zeroin,carry_flag_status,zero_flag_status,reg_wr_en_in;
    input [15:0] IR_in,alu_out,mem_read_val,pc_in,pc2_in;
    output reg [15:0] data_to_reg,reg_wr_en_out;
    output reg [2:0] dest_add;
    output reg carryout,zeroout;
    output reg carry_wr,zero_wr;
    

    wire [3:0] opcode;
    wire [2:0] last_3bits;
    assign opcode = IR_in[15:12];
    assign last_3bits = IR_in[2:0];
    wire [15:0] extended_out;

    sign_extend signExtend (.IR_in(IR_in),.extended_out(extended_out));         

    always @(*) begin

        if((opcode == 4'b0001) || (opcode == 4'b0010)) begin
            data_to_reg <= alu_out;
            dest_add <= IR_in[5:3];
             
        end
        else if(opcode == 4'b0000)begin
            data_to_reg <= alu_out;
            dest_add <= IR_in[8:6];
        end
        else if((opcode == 4'b0100) )begin
            data_to_reg <= mem_read_val;
            dest_add <= IR_in[11:9];
        end
        else if((opcode == 4'b0011) )begin
            data_to_reg <= {7'b0000000,IR_in[8:0]};
            dest_add <= IR_in[11:9];
        end
        else if((opcode == 4'b1100) || (opcode == 4'b1101) )begin
            data_to_reg <= pc2_in;
            dest_add <= IR_in[11:9];
        end
        else begin // does not matter because write signals are zero for these instr
            data_to_reg <= 0;
            dest_add <= 0;
            
        end
		
	 end

    always @(*) begin

        if((opcode == 4'b0001)) begin
            carry_wr <= 1'b1;
            zero_wr <= 1'b1;
            carryout <= carryin;
            zeroout <= zeroin;
        end
        else if(opcode == 4'b0000)begin
            carry_wr <= 1'b1;
            zero_wr <= 1'b1;
            carryout <= carryin;
            zeroout <= zeroin;
        end
        else if(opcode == 4'b0010)begin
            carry_wr <= 1'b0;
            zero_wr <= 1'b1;
            carryout <= carryin;
            zeroout <= zeroin;
        end
        else if((opcode == 4'b0100) )begin
            carry_wr <= 1'b0;
            zero_wr <= 1'b1;
            carryout <= carryin;
            zeroout <=  ~(mem_read_val[0] | mem_read_val[1] | mem_read_val[2] | mem_read_val[3] | mem_read_val[4] | mem_read_val[5] | mem_read_val[6] | mem_read_val[7] | 
                   mem_read_val[8] | mem_read_val[9] | mem_read_val[10] | mem_read_val[11] | mem_read_val[12] | mem_read_val[13] | mem_read_val[14] | mem_read_val[15]);
        end
        else begin
            carry_wr <= 1'b0;
            zero_wr <= 1'b0;
            carryout <= carryin;
            zeroout <= zeroin;
        end
    end      

    always @(*) begin

        if((opcode == 4'b0001) ) begin
            if((last_3bits == 3'b000) || (last_3bits == 3'b011) || (last_3bits == 3'b100) || (last_3bits == 3'b111))
                reg_wr_en_out <= reg_wr_en_in;
            else if((last_3bits == 3'b010) || (last_3bits == 3'b110))
                reg_wr_en_out <= (carry_flag_status) ? reg_wr_en_in : 1'b0 ;
            else if((last_3bits == 3'b001) || (last_3bits == 3'b101))
                reg_wr_en_out <= (zero_flag_status) ? reg_wr_en_in : 1'b0 ;

        end
        else if ((opcode == 4'b0010)) begin
            if((last_3bits == 3'b000) ||  (last_3bits == 3'b100))
                reg_wr_en_out <= reg_wr_en_in;
            else if((last_3bits == 3'b010) || (last_3bits == 3'b110))
                reg_wr_en_out <= (carry_flag_status) ? reg_wr_en_in : 1'b0 ;
            else if((last_3bits == 3'b001) || (last_3bits == 3'b101))
                reg_wr_en_out <= (zero_flag_status) ? reg_wr_en_in : 1'b0 ;

        end 
        
        else begin // does not matter because write signals are zero for these instr
            reg_wr_en_out <= reg_wr_en_in;
            
        end
    end  

    
endmodule