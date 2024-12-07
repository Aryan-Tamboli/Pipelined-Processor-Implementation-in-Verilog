module adder (A, B, out);
  input [15:0] A, B;
  output [15:0] out;

  assign out = A + B;

endmodule // adder
