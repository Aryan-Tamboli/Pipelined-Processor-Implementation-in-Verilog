module sign_extend (IR_in,extended_out);
  input [15:0] IR_in;
  output [15:0] extended_out;

  wire [3:0] opcode;
  
  assign opcode = IR_in[15:12];
  reg [15:0] extend;
  assign extended_out = extend;
  
  always @(*) begin
       if((opcode == 4'b0000) || (opcode == 4'b0100) || (opcode == 4'b0101) || (opcode == 4'b1000) || (opcode == 4'b1001) || (opcode == 4'b1010))
            extend <= (IR_in[5] == 1) ? {10'b1111111111, IR_in[5:0]} : {10'b0000000000, IR_in[5:0]};
       else if((opcode == 4'b1100) || (opcode == 4'b1111))
            extend <= (IR_in[8] == 1) ? {7'b1111111, IR_in[8:0]} : {7'b0000000, IR_in[8:0]};
		 else
				extend <= 0;

  end
endmodule // signExtend
