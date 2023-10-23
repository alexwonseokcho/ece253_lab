// Tested by Mr.Garbaeg, this works... If you disagree, well.... I don't care

module part2(input logic Clock, Reset_b, input logic[3:0] Data, input logic [1:0] Function, output logic [7:0] ALUout);
    assign ALUout = 8'b0;
    logic [7:0] c1;
    logic [7:0] c2;
    register8bit u1(Clock, Reset_b, c1, ALUout);
    register8bit u2(Clock, Reset_b, c1, c2);
    
    always_comb
    begin
        case (Function)
            2'b00: c1 = Data + ALUout[3:0];
            2'b01: c1 = Data * ALUout[3:0];
            2'b10: c1 = ALUout << Data;
            2'b11: c1 = c2;
            default: c1 = 8'b0;
        endcase
    end

endmodule

module FF(input logic clk, Reset_b, input logic DataIn, output logic DataOut);
    always_ff @(posedge clk)
    begin
        if (Reset_b)
            DataOut <= 1'b0;
        else
            DataOut <= DataIn;
    end
endmodule

module register8bit(input logic clk, Reset_b, input logic [7:0] DataIn, output logic [7:0] DataOut);
    always_ff @(posedge clk)
    begin
        if (Reset_b)
            DataOut <= 8'b0;
        else
            DataOut <= DataIn;
    end
endmodule

