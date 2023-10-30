module part2 #(parameter CLOCK_FREQUENCY = 500) (input logic ClockIn, input logic Reset, input logic [1:0] Speed, output logic [3:0] CounterValue);
    
    logic EnableDC;
    RateDivider #(CLOCK_FREQUENCY) rate1 (ClockIn, Reset, Speed, EnableDC);

    DisplayCounter dc (ClockIn, Reset, EnableDC, CounterValue);

endmodule

module RateDivider #(parameter CLOCK_FREQUENCY = 500) (input logic ClockIn, Reset, [1:0] Speed, output logic Enable);
    //when speed 00, full speed --> enable @ every clockIn
    //when speed 01, 1Hz --> generate clock once a second
    //when speed 10, 0.5Hz --> every two seconds 
    //when speed 11, 0.25 Hz --> every four seconds

    logic [$clog2(CLOCK_FREQUENCY * 4 + 1): 0] countStart;
    logic [$clog2(CLOCK_FREQUENCY * 4 + 1): 0] RateDividerCount;

    always_comb
    begin
        case (Speed)
            2'b00: countStart = 0; //full speed (only count to 1)
            2'b01: countStart = CLOCK_FREQUENCY - 1; // remember to do minus one of this
            2'b10: countStart = CLOCK_FREQUENCY * 2 - 1;
            2'b11: countStart = CLOCK_FREQUENCY * 4 - 1;
            default: countStart = 0;
        endcase
    end

    assign Enable = (RateDividerCount == 'b0) ? 'b1 : 'b0;

    always_ff @(posedge ClockIn)
    begin
        if (Reset || Enable)
            RateDividerCount <= countStart;
        else
            RateDividerCount <= RateDividerCount - 1;  
    end

endmodule

module DisplayCounter (input logic Clock, Reset, EnableDC, output logic [3:0] CounterValue);
    always_ff @(posedge Clock)
    begin 
        if(Reset)
            CounterValue = 'b0;
        else if (EnableDC)
            CounterValue = CounterValue + 1;
    end

endmodule