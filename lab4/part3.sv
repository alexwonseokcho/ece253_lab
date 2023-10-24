//I WANNA SAY THIS IS WORKING FINE - just trust me bro 

module part3(input logic clock, reset, ParallelLoadn, RotateRight, ASRight, input logic [3:0] Data_IN, output logic [3:0] Q);
    logic c1;
    assign c1 = ASRight ? Q[3] : Q[0];

    subcct u3(.left(c1), .right(Q[2]), .LoadLeft(RotateRight), .D(Data_IN[3]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[3]));
    subcct u2(.left(Q[3]), .right(Q[1]), .LoadLeft(RotateRight), .D(Data_IN[2]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[2]));
    subcct u1(.left(Q[2]), .right(Q[0]), .LoadLeft(RotateRight), .D(Data_IN[1]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[1]));
    subcct u(.left(Q[1]), .right(Q[3]), .LoadLeft(RotateRight), .D(Data_IN[0]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[0]));

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