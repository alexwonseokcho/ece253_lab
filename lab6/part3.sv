module datapath(
    input logic clk,
    input logic reset,
    input [3:0] DataIn,
    input logic ld_D, // enable for Dividend
    input logic ld_d, // enable for Divisor
    input logic load_res, // mux select for loading the result in Dividend
    input result_valid,

    output logic [3:0] Quotient,
    output logic [4:0] Remainder,
    );
    logic [3:0] d, // divisor
    logic [3:0] D, // dividend
    logic [4:0] a; // Register A
    assign a = 5'b00000; // I don't know if this is needed
    logic [3:0] a_lsb; // least significant 4 bits of A
    logic D_msb; // most significant bit of Dividend
    logic [4:0] reg_shifted;
    logic [4:0] sub_result;
    logic sub_result_msb;
    // logic [4:0] new_a;
    logic [3:0] D_lsb;
    logic [4:0] new_D;

    // assigning the values to Dividend and Divisor
    always_ff @(posedge clk) begin
        if (reset) begin
            d <= 4'b0000;
            D <= 4'b0000;
        end
        else begin
            if (ld_d) d <= DataIn;
            if (ld_D) D <= load_res ? new_D : DataIn;
        end
    end

    // the actual division
    always@(posedge clk) 
    begin
        if (reset)
        begin
            a <= 5'b00000;
        end
        else
        begin
            a_lsb = a[3:0]; // assign used outside the always block
            D_msb = D[3];
            reg_shifted = {a_lsb, D_msb}; 
            sub_result = reg_shifted - d;
            sub_result_msb = sub_result[4];
            a = sub_result_msb ? reg_shifted : sub_result;
            D_lsb = D[3:0]; 
            new_D = {D_lsb, ~sub_result_msb}; 
        end
    end

    // assigning the values to Quotient and Remainder when division is done
    always_ff @(posedge clk) begin
        if (reset) begin
            Quotient <= 4'b0000;
            Remainder <= 5'b00000;
        end
        else begin
            if (result_valid) begin
                Quotient <= D;
                Remainder <= a;
            end
        end
    end
endmodule
