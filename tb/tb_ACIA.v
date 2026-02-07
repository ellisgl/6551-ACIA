// Testbench for the 6551 ACIA module
// This testbench instantiates the ACIA and provides basic stimulus for reset, clock, and data lines.

`timescale 1ns/1ps

module tb_ACIA;
    // Parameters
    parameter XTLI_FREQ = 1_843_200;

    // DUT signals
    reg RESET;
    reg PHI2;
    reg CS;
    reg RWN;
    reg [1:0] RS;
    reg [7:0] DATAIN;
    wire [7:0] DATAOUT;
    reg XTLI;
    wire RTSB;
    reg CTSB;
    wire DTRB;
    reg RXD;
    wire TXD;
    wire IRQn;

    // Instantiate the ACIA
    ACIA #(.XTLI_FREQ(XTLI_FREQ)) dut (
        .RESET(RESET),
        .PHI2(PHI2),
        .CS(CS),
        .RWN(RWN),
        .RS(RS),
        .DATAIN(DATAIN),
        .DATAOUT(DATAOUT),
        .XTLI(XTLI),
        .RTSB(RTSB),
        .CTSB(CTSB),
        .DTRB(DTRB),
        .RXD(RXD),
        .TXD(TXD),
        .IRQn(IRQn)
    );

    // Clock generation
    initial begin
        PHI2 = 0;
        forever #5 PHI2 = ~PHI2; // 100 MHz clock
    end
    initial begin
        XTLI = 0;
        forever #2 XTLI = ~XTLI; // 250 MHz clock
    end

    // Test sequence
    initial begin
        // Initialize inputs
        RESET = 0;
        CS = 1;
        RWN = 1;
        RS = 2'b00;
        DATAIN = 8'h00;
        CTSB = 1;
        RXD = 1;
        #20;
        // Release reset
        RESET = 1;
        #20;
        // Select device and write control register
        CS = 0;
        RWN = 0;
        RS = 2'b10;
        DATAIN = 8'b10010001; // Example control word
        #10;
        // Write data
        RS = 2'b00;
        DATAIN = 8'hA5;
        #10;
        // Read status
        RWN = 1;
        RS = 2'b01;
        #10;
        // Read data
        RS = 2'b00;
        #10;
        // End simulation
        $finish;
    end

    // Monitor outputs
    initial begin
        $dumpfile("tb_ACIA.vcd");
        $dumpvars(0, tb_ACIA);
        $display("Time\tRESET\tCS\tRWN\tRS\tDATAIN\tDATAOUT\tRTSB\tDTRB\tTXD\tIRQn");
        $monitor("%0t\t%b\t%b\t%b\t%02b\t%02x\t%02x\t%b\t%b\t%b\t%b",
            $time, RESET, CS, RWN, RS, DATAIN, DATAOUT, RTSB, DTRB, TXD, IRQn);
    end
endmodule
