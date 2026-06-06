
module adder#(parameter WIDTH=8)(
  input logic [WIDTH-1:0] srca,
  input logic [WIDTH-1:0] srcb,
  input logic cin,
  input logic is_signed,
  output logic [WIDTH-1:0] result,
  output logic cout,
  output logic zero_f,
  output logic ov_f);
  
  logic [WIDTH:0] c;
  assign c[0] = cin;
  
  genvar i;
  generate
    for (i=0; i < WIDTH; i++) begin: full_adders
      full_adder adder (
        .a(srca[i]),
        .b(srcb[i]),
        .cin(c[i]),
        .result(result[i]),
        .cout(c[i+1])	
      );
    end
  endgenerate
  
  assign cout = c[WIDTH];
  assign zero_f = (result==0);
  assign ov_f = is_signed ? ((c[WIDTH-1]) ^ (c[WIDTH])) : c[WIDTH];
    
endmodule
