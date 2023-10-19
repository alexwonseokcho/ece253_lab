//THIS IS THE FINAL VERSION THAT CAN BE SUBMITTED. IF YOU DON'T SEE THIS, YOU'RE ON THE WRONG VERSION BROTHER

module part2(input logic [3:0] A, B, input logic [1:0] Function, output logic [7:0] ALUout);
    logic [3:0] s, c_out;
    part1 RCA(.a(A), .b(B), .c_in(1'b0), .s(s), .c_out(c_out));

    always_comb
    begin
        case (Function)
            2'b00: ALUout = {3'b0, c_out[3], s}; //add properly
            2'b01: ALUout = {7'b0, |{A, B}}; //OR on the concatenated A and B
            2'b10: ALUout = {7'b0, &{A, B}};
            2'b11: ALUout = {A, B};
            default: ALUout = 8'b0;
        endcase
    end
endmodule

//THIS IS THE FINAL VERSION THAT CAN BE SUBMITTED. IF YOU DON'T SEE THIS, YOU'RE ON THE WRONG VERSION BROTHER

module FA(input logic a, b, input logic c_in, output logic s, c_out);
    assign c_out = a&b | b&c_in | a&c_in;
    assign s = a ^ b ^ c_in;
endmodule

module part1(input logic [3:0] a, b, input logic c_in, output logic [3:0] s, c_out);
    FA u0(a[0], b[0], c_in, s[0], c_out[0]);
    FA u1(a[1], b[1], c_out[0], s[1], c_out[1]);
    FA u2(a[2], b[2], c_out[1], s[2], c_out[2]);
    FA u3(a[3], b[3], c_out[2], s[3], c_out[3]);
endmodule

//THIS IS THE FINAL VERSION THAT CAN BE SUBMITTED. IF YOU DON'T SEE THIS, YOU'RE ON THE WRONG VERSION BROTHER

module FA(input logic a, b, input logic c_in, output logic s, c_out);
    assign c_out = a&b | b&c_in | a&c_in;
    assign s = a ^ b ^ c_in;
endmodule

module part1(input logic [3:0] a, b, input logic c_in, output logic [3:0] s, c_out);
    FA u0(a[0], b[0], c_in, s[0], c_out[0]);
    FA u1(a[1], b[1], c_out[0], s[1], c_out[1]);
    FA u2(a[2], b[2], c_out[1], s[2], c_out[2]);
    FA u3(a[3], b[3], c_out[2], s[3], c_out[3]);
endmodule
