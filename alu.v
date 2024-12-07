module alu(A,B,alu_out,carryin,alu_ctrl,carryout,zeroout);
    input [15:0] A,B;
    input carryin;
    input [2:0] alu_ctrl;
    output [15:0] alu_out;
    output zeroout,carryout;

    reg [16:0] result;
    
    always @(*) begin
        case(alu_ctrl)
            3'b000: result <= A + B;
            3'b001: result <= A + ~B;
            3'b010: result <= A + B + carryin;
            3'b011: result <= A + ~B + carryin;
            3'b100: result <= ~(A & B);
            3'b101: result <= ~(A & ~B);          
            3'b110: result <= A - B;

        endcase

    end

    assign alu_out = result[15:0];
    assign carryout = result[16];
    assign zeroout =  ~(alu_out[0] | alu_out[1] | alu_out[2] | alu_out[3] | alu_out[4] | alu_out[5] | alu_out[6] | alu_out[7] | 
                   alu_out[8] | alu_out[9] | alu_out[10] | alu_out[11] | alu_out[12] | alu_out[13] | alu_out[14] | alu_out[15]);

    


endmodule    
    