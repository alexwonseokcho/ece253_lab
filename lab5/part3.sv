module part3 #(parameter CLOCK_FREQUENCY=500) (input logic ClockIn, Reset, Start, input logic [2:0] Letter, output logic DotDashOut, NewBitOut);
    // // logic leftbit;
    // // logic [11:0] shift_reg_out;
    // // logic [7:0] count_value;
    // // logic [7:0] count_value_start;
    // // mux3to12_morse mux(.sel(Letter), .out(letter_morse));
    // // shift_reg shift(.clock(ClockIn), .reset(Reset), .ParallelLoadn(0), .RotateRight(1'b1), .ASRight(1'b0), .Data_IN(letter_morse), .Q(shift_reg_out), .leftbit(leftbit));
    // // counter count_start(.Clock(ClockIn), .Enable(start), .Reset(Reset), .CounterValue(count_value_start));
    
    // // counter count(.Clock(ClockIn), .Enable(shift_reg_out[11]), .Reset(Reset), .CounterValue(count_value));

    // mux3to12_morse mux(.sel(Letter), .out(letter_morse));
    // RateDivider #(CLOCK_FREQUENCY) rd(.ClockIn(0.5), .Reset(Reset), .Enable(start));
    // counter(.Clock(start), .Enable(rd.Enable), .Reset(Reset), .CounterValue(count_value));
    // // shift_reg shift(.clock(ClockIn), .reset(Reset), .ParallelLoadn(0), .RotateRight(1'b1), .ASRight(1'b0), .Data_IN(letter_morse), .Q(shift_reg_out), .leftbit(leftbit));

    logic [11:0] letter_morse;

    mux12bit8to1 mux0(.sel(Letter), .out(letter_morse));

    logic halfSecondPulse;
    RateDivider #(CLOCK_FREQUENCY) rd(.ClockIn(ClockIn), .Reset(Reset), .Enable(halfSecondPulse));
    
    counter count0(.ClockIn(ClockIn), .Enable(halfSecondPulse), .Reset(Reset), .Start(Start),  .NewBitOut(NewBitOut)); //.CounterOut(0),

    logic [11:0] shift_reg_out;
    shiftregister12bit shift0(.Reset(Reset), .Shift(NewBitOut), .ParallelLoad(Start), .ClockIn(ClockIn), .ParallelLoadn(letter_morse), .Q(shift_reg_out));
    assign DotDashOut = shift_reg_out[11];

endmodule




module RateDivider #(parameter CLOCK_FREQUENCY = 500) (input logic ClockIn, Reset, output logic Enable);

    logic [$clog2(CLOCK_FREQUENCY * 4 + 1): 0] countStart;
    logic [$clog2(CLOCK_FREQUENCY * 4 + 1): 0] RateDividerCount;

    assign countStart = (CLOCK_FREQUENCY / 2) - 1;

    assign Enable = (RateDividerCount == 'b0) ? 'b1 : 'b0;

    always_ff @(posedge ClockIn)
    begin
        if (Reset || Enable)
            RateDividerCount <= countStart;
        else
            RateDividerCount <= RateDividerCount - 1;  
    end

endmodule

module counter(input logic ClockIn, Enable, Reset, Start, output logic [3:0] CounterOut, output logic NewBitOut);

    always_ff @(posedge ClockIn)
    begin
        if (Reset)
            CounterOut <= 'b0;
        else if(Start)
            CounterOut <= 12;
        else if(CounterOut != 'b0 && Enable)
            CounterOut <= CounterOut - 1;  
    end

    // assign CounterOut = CounterCount;
    assign NewBitOut = ~(CounterOut == 'b0) & Enable & ~(CounterOut == 12);
endmodule 

module shiftregister12bit(input logic Reset, Shift, ParallelLoad, ClockIn, input logic [11:0] ParallelLoadn, output logic [11:0] Q);
    flipflop u0(.D((ParallelLoad == 'b0) ? 'b0 : ParallelLoadn[0]), .ClockIn(ClockIn), .Reset(Reset), .Enable(Shift | ParallelLoad), .Q(Q[0]));
    flipflop u1(.D((ParallelLoad == 'b0) ? Q[0] : ParallelLoadn[1]), .ClockIn(ClockIn), .Reset(Reset), .Enable(Shift | ParallelLoad), .Q(Q[1]));
    flipflop u2(.D((ParallelLoad == 'b0) ? Q[1] : ParallelLoadn[2]), .ClockIn(ClockIn), .Reset(Reset), .Enable(Shift | ParallelLoad), .Q(Q[2]));
    flipflop u3(.D((ParallelLoad == 'b0) ? Q[2] : ParallelLoadn[3]), .ClockIn(ClockIn), .Reset(Reset), .Enable(Shift | ParallelLoad), .Q(Q[3]));
    flipflop u4(.D((ParallelLoad == 'b0) ? Q[3] : ParallelLoadn[4]), .ClockIn(ClockIn), .Reset(Reset), .Enable(Shift | ParallelLoad), .Q(Q[4]));
    flipflop u5(.D((ParallelLoad == 'b0) ? Q[4] : ParallelLoadn[5]), .ClockIn(ClockIn), .Reset(Reset), .Enable(Shift | ParallelLoad), .Q(Q[5]));
    flipflop u6(.D((ParallelLoad == 'b0) ? Q[5] : ParallelLoadn[6]), .ClockIn(ClockIn), .Reset(Reset), .Enable(Shift | ParallelLoad), .Q(Q[6]));
    flipflop u7(.D((ParallelLoad == 'b0) ? Q[6] : ParallelLoadn[7]), .ClockIn(ClockIn), .Reset(Reset), .Enable(Shift | ParallelLoad), .Q(Q[7]));
    flipflop u8(.D((ParallelLoad == 'b0) ? Q[7] : ParallelLoadn[8]), .ClockIn(ClockIn), .Reset(Reset), .Enable(Shift | ParallelLoad), .Q(Q[8]));
    flipflop u9(.D((ParallelLoad == 'b0) ? Q[8] : ParallelLoadn[9]), .ClockIn(ClockIn), .Reset(Reset), .Enable(Shift | ParallelLoad), .Q(Q[9]));
    flipflop u10(.D((ParallelLoad == 'b0) ? Q[9] : ParallelLoadn[10]), .ClockIn(ClockIn), .Reset(Reset), .Enable(Shift | ParallelLoad), .Q(Q[10]));
    flipflop u11(.D((ParallelLoad == 'b0) ? Q[10] : ParallelLoadn[11]), .ClockIn(ClockIn), .Reset(Reset), .Enable(Shift | ParallelLoad), .Q(Q[11]));

endmodule

module flipflop(input logic D, ClockIn, Reset, Enable, output logic Q);
    always_ff @(posedge ClockIn)
    begin
        if(Reset)
            Q <= 1'b0;
        else if(Enable)
            Q <= D;
    end
endmodule 


module mux12bit8to1(input logic [2:0] sel, output logic [11:0] out);
    always_comb
    begin
        case(sel)
            3'b000: out = 'b101110000000;
            3'b001: out = 'b111010101000;
            3'b010: out = 'b111010111010;
            3'b011: out = 'b111010100000;
            3'b100: out = 'b100000000000;
            3'b101: out = 'b101011101000;
            3'b110: out = 'b111011101000;
            3'b111: out = 'b101010100000;
        endcase
    end

endmodule


// module shift_reg(input logic clock, reset, ParallelLoadn, RotateRight, ASRight, input logic [11:0] Data_IN, output logic [11:0] Q, output logic leftbit);
//     logic c1;
//     assign c1 = ASRight ? Q[11] : Q[0];

//     subcct u11(.left(c1), .right(Q[10]), .LoadLeft(RotateRight), .D(Data_IN[11]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[11]));
//     subcct u10(.left(Q[11]), .right(Q[9]), .LoadLeft(RotateRight), .D(Data_IN[10]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[10]));
//     subcct u9(.left(Q[10]), .right(Q[8]), .LoadLeft(RotateRight), .D(Data_IN[9]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[9]));
//     subcct u8(.left(Q[9]), .right(Q[7]), .LoadLeft(RotateRight), .D(Data_IN[8]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[8]));
//     subcct u7(.left(Q[8]), .right(Q[6]), .LoadLeft(RotateRight), .D(Data_IN[7]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[7]));
//     subcct u6(.left(Q[7]), .right(Q[5]), .LoadLeft(RotateRight), .D(Data_IN[6]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[6]));
//     subcct u5(.left(Q[6]), .right(Q[4]), .LoadLeft(RotateRight), .D(Data_IN[5]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[5]));
//     subcct u4(.left(Q[5]), .right(Q[3]), .LoadLeft(RotateRight), .D(Data_IN[4]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[4]));
//     subcct u3(.left(Q[4]), .right(Q[2]), .LoadLeft(RotateRight), .D(Data_IN[3]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[3]));
//     subcct u2(.left(Q[3]), .right(Q[1]), .LoadLeft(RotateRight), .D(Data_IN[2]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[2]));
//     subcct u1(.left(Q[2]), .right(Q[0]), .LoadLeft(RotateRight), .D(Data_IN[1]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[1]));
//     subcct u0(.left(Q[1]), .right(Q[11]), .LoadLeft(RotateRight), .D(Data_IN[0]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[0]));
//     leftbit = Q[11];
// endmodule

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




// module counter (input logic Clock, input logic Enable, input logic Reset, output logic [7:0] CounterValue);
//     logic [6:0] c;
//     assign c[0] = CounterValue[0] & Enable;
//     genvar i;
//     generate
//         for(i = 1; i < 7; i++) begin
//             assign c[i] = CounterValue[i] & c[i - 1];
//         end
//     endgenerate

//     T_FlipFlop u0(.T(Enable), .clk(Clock), .reset(Reset), .Q(CounterValue[0]));
//     T_FlipFlop u1(.T(c[0]), .clk(Clock), .reset(Reset), .Q(CounterValue[1]));
//     T_FlipFlop u2(.T(c[1]), .clk(Clock), .reset(Reset), .Q(CounterValue[2]));
//     T_FlipFlop u3(.T(c[2]), .clk(Clock), .reset(Reset), .Q(CounterValue[3]));
//     T_FlipFlop u4(.T(c[3]), .clk(Clock), .reset(Reset), .Q(CounterValue[4]));
//     T_FlipFlop u5(.T(c[4]), .clk(Clock), .reset(Reset), .Q(CounterValue[5]));
//     T_FlipFlop u6(.T(c[5]), .clk(Clock), .reset(Reset), .Q(CounterValue[6]));
//     T_FlipFlop u7(.T(c[6]), .clk(Clock), .reset(Reset), .Q(CounterValue[7]));


// endmodule

// module T_FlipFlop(input logic T, input logic clk, input logic reset, output logic Q);
//     logic c1;
//     assign c1 = T ^ Q; 

//     always_ff @(posedge clk)
//     begin
//         if(reset)
//             Q <= 1'b0;
//         else
//             Q <= c1;
//     end
// endmodule