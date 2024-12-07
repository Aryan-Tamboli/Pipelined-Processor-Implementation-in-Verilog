module IF_stage(clk,rst,br_taken,pc_update_mux_signal,pc_plus_imm,regb
                ,rega_plus_imm,pc_in,IR,pc_2,pc_updated,pc_write,freeze);
    input clk,rst;
    input br_taken,freeze;
    input [1:0] pc_update_mux_signal;
    input [15:0] pc_in,pc_plus_imm,regb,rega_plus_imm;
    output reg [15:0] pc_updated;
	output [15:0] IR,pc_2;	 
    output pc_write;

    instr_memory Imem(.clk(clk),.rst(rst),.address(pc_in),.IR(IR));
    
    adder add_2(.A(pc_in), .B(16'b0000000000000010), .out(pc_2));

    assign pc_write = (freeze) ? 1'b0 : 1'b1;

    always @(*) begin
        case(pc_update_mux_signal)
            2'b00: pc_updated <= pc_2;
            2'b01: pc_updated <= pc_plus_imm;
            2'b10: pc_updated <= regb;
            2'b11: pc_updated <= rega_plus_imm;
        
        endcase
    end


    

endmodule    



    

