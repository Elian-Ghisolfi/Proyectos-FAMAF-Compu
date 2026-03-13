`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/29/2025 03:41:17 PM
// Design Name: 
// Module Name: signext_tb
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


module signext_tb();
    logic [31:0] in;
    logic [63:0] out;
    
    signext dut(.a(in), .y(out));
    initial begin
        in = 32'b11111000000_000001000_00_00010_00001; #10; // STUR X1, [X2, #8]
        in = 32'b11111000000_111111000_00_00010_00001; #10; // STUR X1, [X2, #-8]
        in = 32'b11111000010_000001100_00_00100_00011; #10; // LDUR X3, [X4, #12]
        in = 32'b11111000010_111110100_00_00100_00011; #10; // LDUR X3, [X4, #-12]
        in = 32'b10110100_0000000000000000100_00001; #10; // CBZ X1, #4
        in = 32'b10110100_1111111111111111110_00010; #10; // CBZ X2, #-2
        in = 32'b11111111111111111111111111111111; #10; // no es instruccion
        $stop;
    end
endmodule
