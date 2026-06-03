module full_adder(
	input  logic a,
	input  logic b,
	input  logic cin,
	output logic result,
	output logic cout);
  
  assign result = a ^ b ^ cin;
  assign cout = (a & b) | (a & cin) | (b & cin);
  
endmodule
