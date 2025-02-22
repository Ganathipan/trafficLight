module traffic_control_system (
    input logic clk,        // Clock signal
    input logic rst,        // Active-high reset
    output logic [3:0] count, // 4-bit pedestrian counter
    output logic North_Ped, North_Left, North_Fwd, North_Right, // North Side
    output logic East_Ped, East_Left, East_Fwd, East_Right,		// East Side
    output logic South_Ped, South_Left, South_Fwd, South_Right,	// South Side
    output logic West_Ped, West_Left, West_Fwd, West_Right		// West Side
);

    logic A, B, C, D; // Control signals derived from the counter

    // Pedestrian Counter Logic (counts from 0 to 14, skipping 5, 7, 13)
    always_ff @(posedge clk or posedge rst) begin
        if (rst) 
            count <= 4'd0;  // Reset counter to 0
        else begin
            case (count)
                4'd4:  count <= 4'd6;  // Skip 5
                4'd6:  count <= 4'd8;  // Skip 7
                4'd12: count <= 4'd14; // Skip 13
                4'd14: count <= 4'd0;  // Wrap back to 0
                default: count <= count + 1; // Increment otherwise
            endcase
        end
    end

    // Map count value to A, B, C, D
    assign A = count[3];
    assign B = count[2];
    assign C = count[1];
    assign D = count[0];

    // North Lane Logic
    assign North_Ped   = (A & D) | (~A & ~D & ~(B ^ C));
    assign North_Left  = (A ^ C) & ~(B & D);
    assign North_Fwd   = (~A & D) | (A & C & ~(B & D));
    assign North_Right = (B & C & (A ^ D)) | (~A & D & (B ^ C));

    // East Lane Logic
    assign East_Ped   = (~A & D) | (A & ~D & (B ^ C));
    assign East_Left  = (A & D & (B ^ C)) | (B & ~C & ~(A ^ D));
    assign East_Fwd   = (~A & ~D & ~(B ^ C)) | (~A & C & ~(B & D));
    assign East_Right = (A ^ C) & ~(B & D);

    // South Lane Logic
    assign South_Ped   = (B & C) | (~A & ~(B & D));
    assign South_Left  = (A & ~C & (B & D));
    assign South_Fwd   = (~A & ~C & (B & D)) | (A & C & ~(B & D));
    assign South_Right = (B & ~C & ~(A ^ D)) | (A & D & (B ^ C));

    // West Lane Logic
    assign West_Ped   = (~A & ~C & (B & D)) | (A & ~(B & D));
    assign West_Left  = (~A & D & (B ^ C)) | (B & C & (A ^ D));
    assign West_Fwd   = (~A & ~D & ~(B ^ C)) | (B & ~C & ~(A ^ D));
    assign West_Right = (A & ~C & (B & D));

endmodule
