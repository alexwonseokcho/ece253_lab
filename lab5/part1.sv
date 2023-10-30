module part1 (input logic Clock, input logic Enable, input logic Reset, output logic [7:0] CounterValue);
    logic [6:0] c;
    assign c[0] = CounterValue[0] & Enable;
    genvar i;
    generate
        for(i = 1; i < 7; i++) begin
            assign c[i] = CounterValue[i] & c[i - 1];
        end
    endgenerate

    T_FlipFlop u0(.T(Enable), .clk(Clock), .reset(Reset), .Q(CounterValue[0]));
    T_FlipFlop u1(.T(c[0]), .clk(Clock), .reset(Reset), .Q(CounterValue[1]));
    T_FlipFlop u2(.T(c[1]), .clk(Clock), .reset(Reset), .Q(CounterValue[2]));
    T_FlipFlop u3(.T(c[2]), .clk(Clock), .reset(Reset), .Q(CounterValue[3]));
    T_FlipFlop u4(.T(c[3]), .clk(Clock), .reset(Reset), .Q(CounterValue[4]));
    T_FlipFlop u5(.T(c[4]), .clk(Clock), .reset(Reset), .Q(CounterValue[5]));
    T_FlipFlop u6(.T(c[5]), .clk(Clock), .reset(Reset), .Q(CounterValue[6]));
    T_FlipFlop u7(.T(c[6]), .clk(Clock), .reset(Reset), .Q(CounterValue[7]));


endmodule

module T_FlipFlop(input logic T, input logic clk, input logic reset, output logic Q);
    logic c1;
    assign c1 = T ^ Q; 

    always_ff @(posedge clk)
    begin
        if(reset)
            Q <= 1'b0;
        else
            Q <= c1;
    end
endmodule