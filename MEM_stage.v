module MEM_stage(clk,rst,data_in,mem_wr_en_in,alu_out_in,mem_read_val);
    input clk,mem_wr_en_in,rst;
    input [15:0] data_in,alu_out_in;
    output [15:0] mem_read_val;
 

    data_memory  data_memory(.clk(clk),.rst(rst),.read_add(alu_out_in),.wr_add(alu_out_in),
                        .wr_en(mem_wr_en_in),.data_in(data_in),.data_out(mem_read_val));         
    
    
endmodule