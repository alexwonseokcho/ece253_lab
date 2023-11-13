module datapath(
    input logic [4:0] a,
    input logic [3:0] d,
    input logic [3:0] D,
    output logic [4:0] new_a,
    output logic [3:0] new_d
    );

    logic [3:0] a_lsb;
    logic d_msb;
    assign a_lsb = a[3:0]; // assign outside the always block
    assign d_msb = D[3];
    logic [4:0] reg_shifted;
    assign reg_shifted = {a_lsb, d_msb}; 
    logic [4:0] sub_result;
    assign sub_result = reg_shifted - d;
    logic sub_result_msb;
    assign sub_result_msb = sub_result[4];
    // logic [4:0] new_a;
    assign new_a = sub_result_msb ? reg_shifted : sub_result;

    logic [3:0] D_lsb;
    assign D_lsb = D[3:0]; 
    // logic [4:0] new_d;
    assign new_d = {D_lsb, ~sub_result_msb};

    // always_ff @(posedge clk) begin
    //     if (reset) begin
    //         a <= 0;
    //         D <= 0;
    //     end
    //     else begin
    //         a <= new_a;
    //         D <= new_d;
    //     end
    // end
endmodule