`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/03/2025 02:54:06 PM
// Design Name: 
// Module Name: execute_tb
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

module execute_tb();

    logic AluSrc;
    logic [3:0] AluControl;
    logic [63:0] PC_E;
    logic [63:0] signImm_E;
    logic [63:0] readData1_E;
    logic [63:0] readData2_E;
    logic [63:0] PCBranch_E;
    logic [63:0] aluResult_E;
    logic [63:0] writeData_E;
    logic zero_E;

    execute dut (
        .AluSrc(AluSrc),
        .AluControl(AluControl),
        .PC_E(PC_E),
        .signImm_E(signImm_E),
        .readData1_E(readData1_E),
        .readData2_E(readData2_E),
        .PCBranch_E(PCBranch_E),
        .aluResult_E(aluResult_E),
        .writeData_E(writeData_E),
        .zero_E(zero_E)
    );

    initial begin

        // Inicializa todas las señales en 0
        AluSrc      = 1'b0;
        AluControl  = 4'b0000;
        PC_E        = 64'b0;
        signImm_E   = 64'b0;
        readData1_E = 64'b0;
        readData2_E = 64'b0;

        // ---------------------------------------------------------------------
        // Caso de prueba 1: Probar el Mux y una operación de la ALU (ADD)
        // La salida del mux debe ser `readData2_E` (AluSrc = 0)
        // La ALU debe realizar una suma.
        AluSrc      = 1'b0;       // Selecciona readData2_E
        AluControl  = 4'b0010;    // Operación ADD
        readData1_E = 64'h00000000_0000000A; // 10 en decimal
        readData2_E = 64'h00000000_00000005; // 5 en decimal
        #10;

        // ---------------------------------------------------------------------
        // Caso de prueba 2: Probar el Mux y una operación de la ALU (SUB)
        // La salida del mux debe ser `signImm_E` (AluSrc = 1)
        // La ALU debe realizar una resta.
        AluSrc      = 1'b1;       // Selecciona signImm_E
        AluControl  = 4'b0110;   //Operación SUB
        readData1_E = 64'h00000000_00000010; // 16 en decimal
        signImm_E   = 64'h00000000_00000005; // 5 en decimal
        #10;
        
        // ---------------------------------------------------------------------
        // Caso de prueba 3: Verificar la Zero Flag (ADD)
        // La suma debe dar 0.
        AluSrc      = 1'b0;       // Selecciona readData2_E
        AluControl  = 4'b0010;    // Operación ADD
        readData1_E = 64'hFFFFFFFF_FFFFFFFF; // -1 en complemento a dos
        readData2_E = 64'h00000000_00000001; // 1 en decimal
        #10;
        
        // ---------------------------------------------------------------------
        // Caso de prueba 4: Verificar la Zero Flag (AND)
        // La operación AND debe dar 0.
        AluSrc      = 1'b0;       // Selecciona readData2_E
        AluControl  = 4'b0000;    // Operación AND
        readData1_E = 64'h00000000_FFFFFFFF;
        readData2_E = 64'h00000000_00000000;
        #10;

        $stop;
    end
endmodule
