`timescale 1ns / 1ns // `timescale time_unit/time_precision

module part3(
    input logic Clock,
    input logic Reset,
    input logic Go,
    input logic [3:0] Divisor,
    input logic [3:0] Dividend,
    output logic [3:0] Quotient,
    output logic [3:0] Remainder,
    output logic ResultValid
);

logic load_res, reset_a, enable;

logic [4:0] RemainderWire;

control c0(
    .clk(Clock),
    .reset(Reset),
    .go(Go),

    .load_res(load_res),
    .reset_a(reset_a),
    .enable(enable), // enable for Dividend, divisor, and register a
    .result_valid(ResultValid)
);

datapath d0(
    .clk(Clock),
    .reset(Reset),
    .reset_a(reset_a), //only resets register a

    .divisor(Divisor),
    .dividend(Dividend),

    .enable(enable), // enable for Dividend, divisor, and register a
    .load_res(load_res),


    .result_valid(ResultValid),

    .Quotient(Quotient),
    .Remainder(RemainderWire)

    );

    assign Remainder = RemainderWire[3:0]; 
 endmodule


module datapath(
    input logic clk,
    input logic reset,
    input logic reset_a,
    input [3:0] dividend,
    input [3:0] divisor,
    input logic enable, // enable for Dividend, divisor, and register a
    input logic load_res, // mux select for loading the result in Dividend
    input result_valid,


    output logic [3:0] Quotient, //starts as the dividend
    output logic [4:0] Remainder //register a
    );
    logic [3:0] d; // divisor

    logic [3:0] a_lsb; // least significant 4 bits of A
    logic D_msb; // most significant bit of Dividend
    logic [4:0] reg_shifted;
    logic [4:0] sub_result;
    logic sub_result_msb;
    logic [3:0] D_lsb;
    logic [4:0] new_D;

    //combinational logic for division
    assign a_lsb = Remainder[3:0]; // assign used outside the always block
    assign D_msb = Quotient[3];
    assign reg_shifted = {a_lsb, D_msb}; 
    assign sub_result = reg_shifted - d;
    assign sub_result_msb = sub_result[4];
    assign new_D = {D_lsb, ~sub_result_msb}; 
    assign D_lsb = Quotient[3:0]; 

    // assigning the values to Dividend and Divisor
    always_ff @(posedge clk) begin
        if (reset) begin
            d <= 4'b0000;
            Quotient <= 4'b0000;
        end
        else if(enable) begin
            d <= divisor;
            Quotient <= load_res ? new_D : dividend;
        end
    end

    always_ff @(posedge clk) 
    begin
        if (reset | reset_a)
        begin
            Remainder <= 5'b00000;
        end
        else if(enable)
        begin
            Remainder <= sub_result_msb ? reg_shifted : sub_result;
        end
    end

    
    

endmodule


module control(
    input logic clk,
    input logic reset,
    input logic go,

    output logic load_res,
    output logic reset_a,
    output logic result_valid,
    output logic enable
    );

    typedef enum logic [3:0]  { A    = 'd0,
                                B        = 'd1,
                                cycle_0   = 'd2,
                                cycle_1        = 'd3,
                                cycle_2   = 'd4,
                                cycle_3        = 'd5,
                                done_comp = 'd6} statetype;
                                
    statetype current_state, next_state;                            

    // Next state logic aka our state table
    always_comb begin
        case (current_state)
            A: next_state = go ? B : A; // Loop in current state until value is input
            B: next_state = cycle_0;
            
            cycle_0: next_state = cycle_1;
            cycle_1: next_state = cycle_2;
            cycle_2: next_state = cycle_3;
            cycle_3: next_state = done_comp;
            done_comp: next_state = go ? B : done_comp;

            default:   next_state = A;
        endcase
    end // state_table

    // output logic logic aka all of our datapath control signals
    always_comb begin
        // By default make all our signals 0
        load_res = 1'b0;
        reset_a = 1'b0;
        result_valid = 1'b0;
        enable = 1'b0;

        case (current_state)
            A: begin
                end
            B: begin
                reset_a = 1'b1;
                enable = 1'b1;
                end
            cycle_0: begin
                load_res = 1'b1;
                enable = 1'b1;
                end
            cycle_1: begin
                load_res = 1'b1;
                enable = 1'b1;
                end
            cycle_2: begin
                load_res = 1'b1;
                enable = 1'b1;
                end
            cycle_3: begin
                load_res = 1'b1;  
                enable = 1'b1;             
            end
            done_comp: begin
                result_valid = 1'b1;
            end

            //maybe add a done comp state
            
            
        // We don't need a default case since we already made sure all of our outputs were assigned a value at the start of the always block.
        endcase
    end // enable_signals

    // current_state logicisters
    always_ff@(posedge clk) begin
        if(reset)
            current_state <= A;
        else
            current_state <= next_state;
    end // state_FFS
endmodule