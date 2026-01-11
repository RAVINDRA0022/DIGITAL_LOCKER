`timescale 1ns / 1ps

module digital_locker (
    input        clk,
    input        rst,
    input        pwd_in,     // serial password input
    input        submit,
    output reg   locked,
    output reg   unlocked
);

    // State encoding (Verilog style)
    parameter IDLE   = 3'b000;
    parameter S1     = 3'b001;
    parameter S2     = 3'b010;
    parameter S3     = 3'b011;
    parameter UNLOCK = 3'b100;
    parameter ERROR  = 3'b101;

    reg [2:0] present_state;
    reg [2:0] next_state;

    // State register
    always @(posedge clk or posedge rst) begin
        if (rst)
            present_state <= IDLE;
        else
            present_state <= next_state;
    end

    // Next state & output logic
    always @(*) begin
        // Default outputs
        locked   = 1'b1;
        unlocked = 1'b0;
        next_state = present_state;

        case (present_state)

            IDLE: begin
                if (pwd_in == 1'b1)
                    next_state = S1;
                else
                    next_state = ERROR;
            end

            S1: begin
                if (pwd_in == 1'b1)
                    next_state = S2;
                else
                    next_state = ERROR;
            end

            S2: begin
                if (pwd_in == 1'b0)
                    next_state = S3;
                else
                    next_state = ERROR;
            end

            S3: begin
                if (pwd_in == 1'b0)
                    next_state = UNLOCK;
                else
                    next_state = ERROR;
            end

            UNLOCK: begin
                locked   = 1'b0;
                unlocked = 1'b1;
                if (submit)
                    next_state = IDLE;
            end

            ERROR: begin
                if (submit)
                    next_state = IDLE;
            end

            default: next_state = IDLE;

        endcase
    end

endmodule