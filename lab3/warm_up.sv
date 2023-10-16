module part1(input logic [2:0] MuxSelect, input logic [6:0] MuxIn, output logic Out);
    always_comb // declare always_comb block
    begin
        case (MuxSelect)
            3'b000: Out = MuxIn[0];
            3'b001: Out = MuxIn[1];
            3'b010: Out = MuxIn[2];
            3'b011: Out = MuxIn[3];
            3'b100: Out = MuxIn[4];
            3'b101: Out = MuxIn[5];
            3'b110: Out = MuxIn[6];
            
            default: Out = 1'b0;
        endcase
    end
endmodule