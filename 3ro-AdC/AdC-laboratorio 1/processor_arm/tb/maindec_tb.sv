`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.09.2025 12:13:53
// Design Name: 
// Module Name: maindec_tb
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


module maindec_tb();
    logic [10:0] in;
    logic Reg2Loc;
    logic ALUSrc;
    logic MemtoReg;
    logic RegWrite;
    logic MemRead;
    logic MemWrite;
    logic Branch;
    logic [1:0] ALUOp;
    
    maindec dut(.Op(in), .Reg2Loc(Reg2Loc), .ALUSrc(ALUSrc), .MemtoReg(MemtoReg), .RegWrite(RegWrite), 
                .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), .ALUOp(ALUOp));
    initial begin 
        in = 11'b11111000010; #10; //LDUR
        in =  11'b11111000000; #10;// STDUR
        in =  11'b10110100???; #10; //CBZ
        in = 11'b100_0101_1000; #10; // ADD
        in = 11'b110_0101_1000; #10; //SUB
        in = 11'b100_0101_0000; #10; // AND
        in = 11'b101_0101_0000; #10; // ORR
        in = 11'b101_0101_1100; #10; // Default
        $stop;
    end 
endmodule
