`timescale 1ns/1ns
module testbench ();
  reg clk, rst;
  wire [15:0] r0,r1,r2,r3,r4,r5,r6,r7;

  // Instantiate the top-level module
  cpu_top_level top_module (
      .clk(clk),
      .rst(rst),
		.r0(r0),.r1(r1),.r2(r2),.r3(r3),.r4(r4),.r5(r5),.r6(r6),.r7(r7)
  );

  // Clock generation
  initial begin
    clk = 1;
    forever #50 clk = ~clk;  // Generate a clock with a period of 100 ns
  end

  // Reset sequence
  initial begin
    rst = 1;          // Assert reset
    #220;             // Hold reset for 100 ns
    rst = 0;          // De-assert reset
  end


endmodule
