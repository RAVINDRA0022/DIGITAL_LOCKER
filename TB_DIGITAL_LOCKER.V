`timescale 1ns / 1ps

module tb_digital_locker;

    reg clk, rst, pwd_in, submit;
    wire locked, unlocked;

    digital_locker uut (
        .clk(clk),
        .rst(rst),
        .pwd_in(pwd_in),
        .submit(submit),
        .locked(locked),
        .unlocked(unlocked)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        pwd_in = 0;
        submit = 0;

        #10 rst = 0;

        // Enter password 1100
        @(negedge clk) pwd_in = 1;
        @(negedge clk) pwd_in = 1;
        @(negedge clk) pwd_in = 0;
        @(negedge clk) pwd_in = 0;

        // Observe unlocked
        #5;

        // Submit to reset
        submit = 1;
        #10 submit = 0;

        #20 $stop;
    end

endmodule