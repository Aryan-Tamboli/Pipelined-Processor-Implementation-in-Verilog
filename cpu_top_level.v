module cpu_top_level(clk,rst,r0,r1,r2,r3,r4,r5,r6,r7);
    input clk,rst;
	output [15:0] r0,r1,r2,r3,r4,r5,r6,r7;

    wire [15:0] pc_IF,pc_ID,pc_RR,pc_EX,pc_MEM,pc_WB;
    wire [15:0] pc2_IF,pc2_ID,pc2_RR,pc2_EX,pc2_MEM,pc2_WB;
    wire [15:0] IR_IF,IR_ID,IR_RR,IR_EX,IR_MEM,IR_WB;
    wire [15:0] pc_updated;
    wire [1:0] pc_mux_signal;
    wire [15:0] pc_plus_imm;
    wire reg_wr_en_ID,mem_wr_en_ID,reg_wr_en_RR,mem_wr_en_RR,reg_wr_en_EX,mem_wr_en_EX;
    wire reg_wr_en_MEM,mem_wr_en_MEM,reg_wr_en_WB;
    wire [2:0] alu_ctrl_ID,alu_ctrl_RR,alu_ctrl_EX;
    wire pc_write;
    wire write_signal_to_reg;
    wire [15:0] data_in_to_reg;
    wire [15:0] D1_val,D2_val,D1_EX,D2_EX,D1_MEM;
    wire [15:0] alu_out_EX,alu_out_MEM,alu_out_WB;
    wire [15:0] mem_read_val_MEM,mem_read_val_WB;
    wire carry_EX,zero_EX,carry_MEM,zero_MEM,carry_WB,zero_WB;
    wire carry_wr,zero_wr;
    reg carry_flag_status,zero_flag_status;
    wire [2:0] dest_add_to_reg;
    wire flush;
	wire carryout_WB,zeroout_WB;
    wire [15:0] Imm_16 ;
	wire [15:0] Imm_16_left_shifted;
    wire [15:0] D1_forward,D2_forward ;
    wire D1_forward_en,D2_forward_en;
    wire freeze;
    wire [7:0] mem_dump [65535:0];


    IF_stage IF_stage(.clk(clk),.rst(rst),.br_taken(flush),
                        .pc_update_mux_signal(pc_mux_signal),
                        .pc_plus_imm(pc_plus_imm),
                        .regb(D2_EX),
                        .rega_plus_imm(alu_out_EX),
                        .pc_in(pc_IF),
                        .IR(IR_IF),
                        .pc_2(pc2_IF),
                        .pc_updated(pc_updated),
                        .pc_write(pc_write),
                        .freeze(freeze));

    IF_ID IF_ID(.clk(clk), .rst(rst), .br_taken(flush), .pc_in(pc_IF),
                     .pc2_in(pc2_IF), .IR_in(IR_IF), .pc_out(pc_ID)
                     ,.pc2_out(pc2_ID),.IR_out(IR_ID),.freeze(freeze));

    ID_stage ID_stage(.clk(clk),.pc_in(pc_ID),.pc2_in(pc2_ID),.IR_in(IR_ID),
                        .alu_ctrl(alu_ctrl_ID),.reg_wr_en(reg_wr_en_ID),.mem_wr_en(mem_wr_en_ID));

    ID_RR ID_RR(.clk(clk), .rst(rst), .br_taken(flush), .pc_in(pc_ID), .pc2_in(pc2_ID),
                     .IR_in(IR_ID), .pc_out(pc_RR),.pc2_out(pc2_RR),.IR_out(IR_RR),
                     .alu_ctrl_in(alu_ctrl_ID),
                     .reg_wr_en_in(reg_wr_en_ID),.mem_wr_en_in(mem_wr_en_ID),.alu_ctrl_out(alu_ctrl_RR),
                     .reg_wr_en_out(reg_wr_en_RR),.mem_wr_en_out(mem_wr_en_RR),.freeze(freeze));

    RR_stage  RR_stage(.clk(clk),.rst(rst),.IR_in(IR_RR),.dest_add(dest_add_to_reg),.data_in(data_in_to_reg),
                        .write_signal(write_signal_to_reg),
                        .D1_out(D1_val),
                        .D2_out(D2_val),
                        .pc(pc_IF),
                        .pc_update(pc_updated),
                        .pc_write(pc_write),
								.r0(r0),.r1(r1),.r2(r2),.r3(r3),.r4(r4),.r5(r5),.r6(r6),.r7(r7)
								);

    RR_EX RR_EX(.clk(clk), .rst(rst), .br_taken(flush),
                     .pc_in(pc_RR), .pc2_in(pc2_RR), 
                    .IR_in(IR_RR), .pc_out(pc_EX),.pc2_out(pc2_EX),.IR_out(IR_EX),
                    .alu_ctrl_in(alu_ctrl_RR),
                    .reg_wr_en_in(reg_wr_en_RR),
                    .mem_wr_en_in(mem_wr_en_RR),
                    .alu_ctrl_out(alu_ctrl_EX),
                    .reg_wr_en_out(reg_wr_en_EX),
                    .mem_wr_en_out(mem_wr_en_EX),
                    .D1_in(D1_val),
                    .D2_in(D2_val),
                    .D1_out(D1_EX),
                    .D2_out(D2_EX),
                    .D1_forward(D1_forward),
                    .D1_forward_en(D1_forward_en),
                    .D2_forward(D2_forward),
                    .D2_forward_en(D2_forward_en),
                    .freeze(freeze));


    EX_stage EX_stage(.clk(clk),.IR_in(IR_EX),.D1_in(D1_EX),.D2_in(D2_EX),
                      .alu_ctrl_in(alu_ctrl_EX),
                      .carryin(),.alu_out(alu_out_EX),.carryout(carry_EX),.zeroout(zero_EX));

    EX_MEM EX_MEM(.clk(clk), .rst(rst), .pc_in(pc_EX), .pc2_in(pc2_EX), .IR_in(IR_EX),
                         .pc_out(pc_MEM),.pc2_out(pc2_MEM),
                         .IR_out(IR_MEM),
                         .reg_wr_en_in(reg_wr_en_EX),
                         . mem_wr_en_in(mem_wr_en_EX),
                         .reg_wr_en_out(reg_wr_en_MEM),.mem_wr_en_out(mem_wr_en_MEM),
                        .D1_in(D1_EX),.D1_out(D1_MEM),.alu_out_in(alu_out_EX),
                        .alu_out_out(alu_out_MEM),.carryin(carry_EX)
                        ,.carryout(carry_MEM),
                        .zeroin(zero_EX),
                        .zeroout(zero_MEM));

    MEM_stage MEM_stage(.clk(clk),.rst(rst),.data_in(D1_MEM),.mem_wr_en_in(mem_wr_en_MEM),
                        .alu_out_in(alu_out_MEM),.mem_read_val(mem_read_val_MEM)
                           );

    MEM_WB MEM_WB(.clk(clk), .rst(rst), .pc_in(pc_MEM), .pc2_in(pc2_MEM),
                       .IR_in(IR_MEM),  
                       .pc_out(pc_WB),.pc2_out(pc2_WB),.IR_out(IR_WB),
                       .reg_wr_en_in(reg_wr_en_MEM),
                       .reg_wr_en_out(reg_wr_en_WB),
                       .alu_out_in(alu_out_MEM),
                       .alu_out_out(alu_out_WB),
                       .carryin(carry_MEM),
                       .carryout(carry_WB),
                       .zeroin(zero_MEM),
                       .zeroout(zero_WB),
                       .mem_read_val_in(mem_read_val_MEM),
                       .mem_read_val_out(mem_read_val_WB));

    WB_stage WB_stage(.clk(clk),.IR_in(IR_WB),
                      .alu_out(alu_out_WB),
                      .mem_read_val(mem_read_val_WB),
                      .pc_in(pc_WB),
                      .pc2_in(pc2_WB),
                      .carryin(carry_WB),
                      .zeroin(zero_WB),
                      .carryout(carryout_WB),
                      .zeroout(zeroout_WB),
                      .data_to_reg(data_in_to_reg),
                      .dest_add(dest_add_to_reg),
                      .carry_wr(carry_wr),
                      .zero_wr(zero_wr),
                      .reg_wr_en_in(reg_wr_en_WB),
                      .reg_wr_en_out(write_signal_to_reg),
                      .carry_flag_status(carry_flag_status),
                      .zero_flag_status(zero_flag_status));    

    branch_handler branch_handler(.IR_in_from_EX_stage(IR_EX),
                                  .pc_update_mux_signal(pc_mux_signal),
                                  .flush(flush));    

    adder pc_branching(.A(pc_EX), .B(Imm_16_left_shifted), .out(pc_plus_imm));
	 
	forwarding_unit forwarding_unit(.IR_RR(IR_RR),.IR_EX(IR_EX),.IR_MEM(IR_MEM),.IR_WB(IR_WB),
									.alu_out_EX(alu_out_EX),.alu_out_MEM(alu_out_MEM),
                                    .alu_out_WB(alu_out_WB),
									.pc2_EX(pc2_EX),
									.pc2_MEM(pc2_MEM),
									.pc2_WB(pc2_WB),
                           .mem_read_val_MEM(mem_read_val_MEM),
                           .mem_read_val_WB(mem_read_val_WB),
									.D1_forward(D1_forward),
									.D1_forward_en(D1_forward_en),
									.D2_forward(D2_forward),
									.D2_forward_en(D2_forward_en),
                           .freeze(freeze),
                           .reg_wr_en_EX(reg_wr_en_EX),.reg_wr_en_MEM(reg_wr_en_MEM)
                           ,.reg_wr_en_WB(reg_wr_en_WB)
                                    );
	
	 assign Imm_16_left_shifted = Imm_16<<1;

    sign_extend nine_to_sixteen(.IR_in(IR_EX),.extended_out(Imm_16));                                                  

endmodule