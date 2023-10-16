`timescale 1ns / 1ns // `timescale time_unit/time_precision

module mux2to1(input logic x,y,s, output logic m);

	logic [2:0] con;

	v7404 NOT (
		.pin1(s),
		.pin2(con[0])
	);

	v7408 AND (
		.pin1(con[0]),
		.pin2(x),
		.pin3(con[1]),
		.pin4(s),
		.pin5(y),
		.pin6(con[2])
	);

	v7432 OR (
		.pin1(con[1]),
		.pin2(con[2]),
		.pin3(m)
	);
endmodule

module v7404 (input logic pin1, pin3, pin5, pin9, pin11, pin13,
				output logic pin2, pin4, pin6, pin8, pin10, pin12);
	assign pin2 = ~pin1;
	assign pin4 = ~pin3;
	assign pin6 = ~pin5;
	assign pin8 = ~pin9;
	assign pin10 = ~pin11;
	assign pin12 = ~pin13;

endmodule
	
module v7408 (input logic pin1, pin2, pin4, pin5, pin9, pin10, pin12, pin13,
				output logic pin3, pin6, pin11, pin8);
	assign pin3 = pin1 & pin2;
	assign pin6 = pin4 & pin5;
	assign pin8 = pin9 & pin10;
	assign pin11 = pin12 & pin13;

endmodule

module v7432 (input logic pin1, pin2, pin4, pin5, pin9, pin10, pin12, pin13,
				output logic pin3, pin6, pin11, pin8);
	assign pin3 = pin1 | pin2;
	assign pin6 = pin4 | pin5;
	assign pin8 = pin9 | pin10;
	assign pin11 = pin12 | pin13;

endmodule