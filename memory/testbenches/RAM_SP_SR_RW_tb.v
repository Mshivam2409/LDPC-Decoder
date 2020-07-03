// Testbench for RAM_SP_SR_RW module
module test #(
    parameter ADDR_WIDTH = 8,
    parameter DATA_WIDTH = 8,
    parameter RAM_DEPTH = 1 << ADDR_WIDTH
    );

    reg clk;
    reg cs;
    reg we;
    reg  [ADDR_WIDTH-1 : 0] address;
    reg  [DATA_WIDTH-1 : 0] data_write;
    wire [DATA_WIDTH-1 : 0] data_read;

    // Instantiating module to be tested
    RAM_SP_SR_RW #(DATA_WIDTH, ADDR_WIDTH, RAM_DEPTH) RAM (
        .clk(clk),
        .address(address),
        .data_in(data_write),
        .we(we),
        .data_out(data_read),
        .cs(cs)
    );


    // For sanity checking
    integer i;
    reg [DATA_WIDTH-1 : 0] received [0:RAM_DEPTH-1] ;

    always #5 clk = ~clk;
    initial begin
        // dumping of all variables to file
        $dumpfile("dump.vcd");
        $dumpvars(1, test);

        clk <= 0;

        // Writing data into the RAM module to be tested
        for(i=0; i<RAM_DEPTH; ++i) begin
            repeat(1) @(negedge clk);
            address <= i;  we <= 1; cs <=1; data_write <= i;
        end

        // Reading data from the RAM
        for(i=0; i<RAM_DEPTH; ++i) begin
            repeat(1) @(negedge clk);
            address <= i;  we <= 0; cs <=1;

            // for logging error if any
            repeat(1) @(posedge clk);
            #1;
            if(data_read != i) begin
               $display("Incorrect data read from address: %d, expected: %d, received: %d", address, i, data_read);
            end
        end

        $display("Sanity checks completed");
        #10 $finish;
    end
endmodule
