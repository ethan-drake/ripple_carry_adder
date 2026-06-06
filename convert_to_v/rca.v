module adder (
	srca,
	srcb,
	cin,
	is_signed,
	result,
	cout,
	zero_f,
	ov_f
);
	parameter WIDTH = 32;
	input wire [WIDTH - 1:0] srca;
	input wire [WIDTH - 1:0] srcb;
	input wire cin;
	input wire is_signed;
	output wire [WIDTH - 1:0] result;
	output wire cout;
	output wire zero_f;
	output wire ov_f;
	wire [WIDTH:0] c;
	assign c[0] = cin;
	genvar _gv_i_1;
	generate
		for (_gv_i_1 = 0; _gv_i_1 < WIDTH; _gv_i_1 = _gv_i_1 + 1) begin : full_adders
			localparam i = _gv_i_1;
			full_adder adder(
				.a(srca[i]),
				.b(srcb[i]),
				.cin(c[i]),
				.result(result[i]),
				.cout(c[i + 1])
			);
		end
	endgenerate
	assign cout = c[WIDTH];
	assign zero_f = result == 0;
	assign ov_f = (is_signed ? c[WIDTH - 1] ^ c[WIDTH] : c[WIDTH]);
endmodule
