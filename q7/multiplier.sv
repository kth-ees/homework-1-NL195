/*
Design follows schematic found on page 90
in the book Arithmetic and Algebraic Circuits
*/

module multiplier #(
    parameter int N = 4
)(
    input  logic [N-1:0] x,
    input  logic [N-1:0] y,
    output logic [2*N-1:0] m
);

    logic pp [N-1:0][N-1:0];
    logic s [N-2:0][N-1:0];
    logic c [N-2:0][N-1:0];

    //Generate N*N partial products
    generate
        genvar i, j;
        for (i = 0; i < N; i++) begin : partial_prod_row
            for (j = 0; j < N; j++) begin : partial_prod_col
                assign pp[i][j] = y[i] & x[j];
            end
        end
    endgenerate

    assign m[0] = pp[0][0];

    generate
        genvar row, col;
        for (row = 0; row < N-1; row++) begin : adder_rows
        
            // -- FIRST ROW
            if (row == 0) begin
                half_adder ha_first_row_right (
                    .a(pp[0][1]), .b(pp[1][0]), .s(m[1]), .c_out(c[0][0])
                );
                for (col = 1; col < N-1; col++) begin
                    full_adder fa (
                        .a(pp[0][col+1]), .b(pp[1][col]), .c_in(c[0][col-1]), 
                        .s(s[0][col]), .c_out(c[0][col])
                    );
                end
                half_adder ha_first_row_left (
                    .a(pp[1][N-1]), .b(c[0][N-2]), .s(s[0][N-1]), .c_out(c[0][N-1])
                );

            // -- LAST ROW
            end else if (row == N-2) begin
                half_adder ha_last_row_right (
                   .a(s[row-1][1]), .b(pp[row+1][0]), .s(m[row+1]), .c_out(c[row][0])
                );
                for (col = 1; col < N-1; col++) begin
                    localparam M_BIT_INDEX = row + col + 1; 
                    full_adder fa_final_ripple (
                       .a(s[row-1][col+1]), .b(pp[row+1][col]), .c_in(c[row][col-1]),
                       .s(m[M_BIT_INDEX]), .c_out(c[row][col])
                    );
                end
                full_adder fa_last_row_left (
                   .a(c[row-1][N-1]), .b(pp[row+1][N-1]), .c_in(c[row][N-2]),
                   .s(m[2*N-2]), .c_out(m[2*N-1])
                );

            // -- MIDDLE ROWS
            end else begin
                half_adder ha_middle_row (
                    .a(s[row-1][1]), .b(pp[row+1][0]), .s(m[row+1]), .c_out(c[row][0])
                );
                for (col = 1; col < N-1; col++) begin
                    full_adder fa (
                        .a(s[row-1][col+1]), .b(pp[row+1][col]), .c_in(c[row][col-1]),
                        .s(s[row][col]), .c_out(c[row][col])
                    );
                end
                full_adder fa_middle_row_left (
                   .a(c[row-1][N-1]), .b(pp[row+1][N-1]), .c_in(c[row][N-2]),
                   .s(s[row][N-1]), .c_out(c[row][N-1])
                );
            end
        end
    endgenerate

endmodule