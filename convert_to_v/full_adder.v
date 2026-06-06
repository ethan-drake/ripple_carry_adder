module full_adder (
	a,
	b,
	cin,
	result,
	cout
);
	input wire a;
	input wire b;
	input wire cin;
	output wire result;
	output wire cout;
	assign result = (a ^ b) ^ cin;
	assign cout = ((a & b) | (a & cin)) | (b & cin);
endmodule
