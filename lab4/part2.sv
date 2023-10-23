module part2(input logic Clock, Reset_b, input logic[3:0] Data, input logic [1:0] Function, input logic [7:0] ALUout);
    register8bit1 u1(Clock, Reset_b, c1, ALUout);
    logic [7:0] c1;
    always_comb
    begin
        case (Function)
            2'b00: c1 = Data + ALUOut[4:0];
            2'b01: c1 = Data * ALUout[4:0];
            2'b10: ALUout[4:0] << A;;
            // 2'b11: 
            // default: c1 = c1;
        endcase
    end
endmodule

module hex_decoder 

module register8bit(input logic clk, Reset_b, input logic [7:0] DataIn, output logic [7:0] DataOut);
    always_ff @(posedge clk)
    begin
        if (Reset_b)
            DataOut <= 8'b0;
        else
            DataOut <= DataIn;
    end
endmodule

