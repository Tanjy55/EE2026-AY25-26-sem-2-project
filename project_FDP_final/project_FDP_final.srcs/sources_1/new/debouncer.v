`timescale 1ns / 1ps

module debouncer (
    input clk,          // High-frequency clock (e.g., 100MHz)
    input btn_in,       // Raw noisy button input
    output reg btn_out  // Cleaned, stable output
);

    parameter MAX_COUNT = 1000000; // Adjust based on clock speed (10ms for 100MHz)
    reg [19:0] count;
    reg sync_btn;

    always @(posedge clk) begin
        // 1. Sync button to clock domain to prevent metastability
        sync_btn <= btn_in;
        
        // 2. Check if input has changed
        if (sync_btn != btn_out) begin
            if (count < MAX_COUNT) begin
                count <= count + 1;
            end else begin
                btn_out <= sync_btn; // Update output only after time is up
                count <= 0;
            end
        end else begin
            count <= 0; // Reset timer if signal is not changing
        end
    end
endmodule