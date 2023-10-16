module part3 # (parameter N = 4) 
                (input logic [N-1:0] A, B, input logic [1:0] Function, output logic [2*N-1:0] ALUout);
    //number of bits in ALUout will always be double the number of bits of A and B
    always_comb
    begin
        case(Function):
            2'b00: ALUout = A + B; //can 2'b00 just be replaced with a 0? 
            2'b01: ALUout = {(N-1){1'b0}, |{A, B}};
            2'b10: ALUout = {(N-1){1'b0}, &{A, B}};;
            2'b11: ALUout = {A, B};
            default: ALUout = {N{1'b0}};
        endcase
    end
endmodule