module part3 #(parameter CLOCK_FREQUENCY=500) (input logic ClockIn, Reset, Start, input logic [2:0] Letter, output logic DotDashOut, NewBitOut);
    logic leftbit;
    logic [11:0] shift_reg_out;
    mux3to12_morse mux(.sel(Letter), .out(letter_morse));
    shift_reg shift(.clock(ClockIn), .reset(Reset), .ParallelLoadn(0), .RotateRight(1'b1), .ASRight(1'b0), .Data_IN(letter_morse), .Q(shift_reg_out), .leftbit(leftbit));
    



endmodule



module mux3to12_morse(input [2:0] sel, output [11:0] out);
    always_comb
    begin
        case(sel)
            3'b000: out = 101110000000;
            3'b001: out = 111010101000;
            3'b010: out = 111010111010;
            3'b011: out = 111010100000;
            3'b100: out = 100000000000;
            3'b101: out = 101011101000;
            3'b110: out = 111011101000;
            3'b111: out = 101010100000;
        endcase
    end

endmodule


module shift_reg(input logic clock, reset, ParallelLoadn, RotateRight, ASRight, input logic [11:0] Data_IN, output logic [11:0] Q, output logic leftbit);
    logic c1;
    assign c1 = ASRight ? Q[11] : Q[0];

    subcct u11(.left(c1), .right(Q[10]), .LoadLeft(RotateRight), .D(Data_IN[11]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[11]));
    subcct u10(.left(Q[11]), .right(Q[9]), .LoadLeft(RotateRight), .D(Data_IN[10]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[10]));
    subcct u9(.left(Q[10]), .right(Q[8]), .LoadLeft(RotateRight), .D(Data_IN[9]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[9]));
    subcct u8(.left(Q[9]), .right(Q[7]), .LoadLeft(RotateRight), .D(Data_IN[8]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[8]));
    subcct u7(.left(Q[8]), .right(Q[6]), .LoadLeft(RotateRight), .D(Data_IN[7]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[7]));
    subcct u6(.left(Q[7]), .right(Q[5]), .LoadLeft(RotateRight), .D(Data_IN[6]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[6]));
    subcct u5(.left(Q[6]), .right(Q[4]), .LoadLeft(RotateRight), .D(Data_IN[5]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[5]));
    subcct u4(.left(Q[5]), .right(Q[3]), .LoadLeft(RotateRight), .D(Data_IN[4]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[4]));
    subcct u3(.left(Q[4]), .right(Q[2]), .LoadLeft(RotateRight), .D(Data_IN[3]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[3]));
    subcct u2(.left(Q[3]), .right(Q[1]), .LoadLeft(RotateRight), .D(Data_IN[2]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[2]));
    subcct u1(.left(Q[2]), .right(Q[0]), .LoadLeft(RotateRight), .D(Data_IN[1]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[1]));
    subcct u0(.left(Q[1]), .right(Q[11]), .LoadLeft(RotateRight), .D(Data_IN[0]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[0]));
    leftbit = Q[11];
endmodule

module subcct(input logic left, right, LoadLeft, D, loadn, clock, reset, output logic Q);
    logic c1, c2;
    assign c1 = LoadLeft ? left : right;
    assign c2 = loadn ? c1 : D;

    always_ff @(posedge clock)
    begin
        if(reset == 1'b1)
            Q <= 1'b0;
        else
            Q <= c2;
    end
endmodule
