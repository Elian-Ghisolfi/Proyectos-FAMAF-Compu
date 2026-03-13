`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.08.2025 11:40:40
// Design Name: 
// Module Name: flopr
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module flopr #(parameter N = 64)
            (input logic clk,
             input logic reset,
             input logic [N-1:0] d,
             output logic [N-1:0] q  
            );
    // Se activa por alto positivo del reloj O positivo del reset
    // El reset es asíncrono (no espera al reloj)
    always_ff @(posedge clk, posedge reset)
        if (reset) q <= N'('b0);
        else q <= d;
endmodule
