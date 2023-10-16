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