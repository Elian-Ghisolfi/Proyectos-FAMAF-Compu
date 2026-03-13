`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.08.2025 12:35:05
// Design Name: 
// Module Name: flopr_tb
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


module flopr_tb();
    parameter local_N = 32; // tamaño del cable
    logic clk, reset;
    logic [local_N-1:0] d_in; // entradas
    logic [local_N-1:0] q_out;            // salidas
    flopr #(local_N) dut(.clk(clk), .reset(reset), .d(d_in), .q(q_out));
    
    always 
        begin
            clk = 0; #5; clk = 1; #5;
        end
    initial begin
        d_in = local_N'('h2); reset = 1; #10; //2
        d_in = local_N'('h4); #10;  //4
        d_in = local_N'('h8); #10;  //8
        d_in = local_N'('h10); #10; //16
        d_in = local_N'('h20); #10; //32
        d_in = local_N'('h40); reset = 0; #10; //64
        d_in = local_N'('h80); #10; //128    
        d_in = local_N'('h100); #10; //256
        d_in = local_N'('h200); #10; //512
        d_in = local_N'('h400); #10; //1024
        $stop;
    end 
endmodule
