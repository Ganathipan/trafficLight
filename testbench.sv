module tb_traffic_control_system();
    logic clk, rst;
    logic [3:0] count;
    logic North_Ped, North_Left, North_Fwd, North_Right;
    logic East_Ped, East_Left, East_Fwd, East_Right;
    logic South_Ped, South_Left, South_Fwd, South_Right;
    logic West_Ped, West_Left, West_Fwd, West_Right;

    // Instantiate the traffic control system
    traffic_control_system uut (
        .clk(clk),
        .rst(rst),
        .count(count),
        .North_Ped(North_Ped), .North_Left(North_Left), .North_Fwd(North_Fwd), .North_Right(North_Right),
        .East_Ped(East_Ped), .East_Left(East_Left), .East_Fwd(East_Fwd), .East_Right(East_Right),
        .South_Ped(South_Ped), .South_Left(South_Left), .South_Fwd(South_Fwd), .South_Right(South_Right),
        .West_Ped(West_Ped), .West_Left(West_Left), .West_Fwd(West_Fwd), .West_Right(West_Right)
    );

    // Clock generation
    always #5 clk = ~clk; // 10 time units per cycle

    initial begin
        // Enable waveform dumping
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_traffic_control_system);

        // Initialize
        clk = 0; rst = 1;
        #10 rst = 0; // Release reset

        // Run simulation for a while
        #300 $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0t | Count: %d | A: %b B: %b C: %b D: %b | North_Ped: %b | East_Ped: %b | South_Ped: %b | West_Ped: %b", 
                  $time, count, uut.A, uut.B, uut.C, uut.D, North_Ped, East_Ped, South_Ped, West_Ped);
    end
endmodule
