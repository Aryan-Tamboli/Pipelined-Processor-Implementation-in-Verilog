module RR_stage(clk,rst,IR_in,dest_add,data_in,write_signal,
D1_out,D2_out,pc,pc_update,pc_write,r0,r1,r2,r3,r4,r5,r6,r7);

    input clk, rst,write_signal, pc_write;
    input [2:0] dest_add;
    input [15:0] IR_in,data_in,pc_update;
    output [15:0] D1_out,D2_out,pc;
	output [15:0] r0,r1,r2,r3,r4,r5,r6,r7;

    wire [2:0] Ra,Rb;
    assign Ra = IR_in[11:9];
    assign Rb = IR_in[8:6];

    reg_file regfile(.clk(clk),.rst(rst),.A1(Ra),.A2(Rb),.A3(dest_add),.D1(D1_out)
                    ,.D2(D2_out),.Data_in(data_in),.wr_en(write_signal),.pc_out(pc),.pc_in(pc_update),.pc_write(pc_write),
						  .r0(r0),.r1(r1),.r2(r2),.r3(r3),.r4(r4),.r5(r5),.r6(r6),.r7(r7));


endmodule