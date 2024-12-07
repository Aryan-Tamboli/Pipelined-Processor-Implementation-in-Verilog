module branch_handler(IR_in_from_EX_stage,pc_update_mux_signal,flush);
    input [15:0] IR_in_from_EX_stage;    
    output reg flush;
    output reg [1:0] pc_update_mux_signal;

    wire [3:0] opcode;
    assign opcode = IR_in_from_EX_stage[15:12];

    always @(*) begin
        if((opcode == 4'b1000) || (opcode == 4'b1001) || (opcode == 4'b1010)) begin
            flush <= 1'b1;
            pc_update_mux_signal <= 2'b01;

        end
        else if(opcode == 4'b1100) begin
            flush <= 1'b1;
            pc_update_mux_signal <= 2'b01;

        end
        else if(opcode == 4'b1101) begin
            flush <= 1'b1;
            pc_update_mux_signal <= 2'b10;

        end
        else if(opcode == 4'b1111) begin
            flush <= 1'b1;
            pc_update_mux_signal <= 2'b11;

        end
        else begin
            flush <= 1'b0;
            pc_update_mux_signal <= 2'b00;
        end

    end



endmodule