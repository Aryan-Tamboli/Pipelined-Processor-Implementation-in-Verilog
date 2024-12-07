module EX_stage(clk,IR_in,D1_in,D2_in,alu_ctrl_in,
                carryin,alu_out,carryout,zeroout);
    input clk,carryin;
    input [2:0] alu_ctrl_in;
    input [15:0] IR_in,D1_in,D2_in;
    output [15:0] alu_out;
    output carryout,zeroout;
    
    reg [15:0] Ain,Bin;
    wire [3:0] opcode;
    assign opcode = IR_in[15:12];
    wire [15:0] extended_out;
        
    alu alu(.A(Ain),.B(Bin),.alu_out(alu_out),.carryin(carryin),.alu_ctrl(alu_ctrl_in),
                .carryout(carryout),.zeroout(zeroout));

    sign_extend sign_extend (.IR_in(IR_in),.extended_out(extended_out));     

    always @(*) begin

        if((opcode == 4'b0001) || (opcode == 4'b0010) || (opcode == 4'b1000) || (opcode == 4'b1001) || (opcode == 4'b1010)) begin
            Ain <= D1_in;
            Bin <= D2_in;
        end
        else if(opcode == 4'b0000)begin
            Ain <= D1_in;
            Bin <= extended_out;
        end
        else if((opcode == 4'b0100) || (opcode == 4'b0101))begin
            Ain <= extended_out;
            Bin <= D2_in;
        end
        else if(opcode == 4'b1111)begin
            Ain <= D1_in;
            Bin <= extended_out<<1;
        end
        else begin
            Ain <= D1_in;
            Bin <= D2_in;
        end
    end      
    
endmodule