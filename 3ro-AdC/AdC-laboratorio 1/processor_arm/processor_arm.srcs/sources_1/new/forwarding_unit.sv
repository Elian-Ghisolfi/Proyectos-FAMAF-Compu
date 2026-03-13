`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2025 04:58:56 PM
// Design Name: 
// Module Name: forwarding_unit
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


module forwarding_unit  #(parameter N = 64)
    (
    // Registros de la instruccion
    input logic [4:0] ID_EX_Rm,
    input logic [4:0] ID_EX_Rn,
    // Registros de destino en Mem
    input logic EX_MEM_RegWrite,
    input logic [4:0] EX_MEM_Rd,
    // Registro de destino en WB
    input logic MEM_WB_RegWrite,
    input logic [4:0] MEM_WB_Rd,
    // Senales de control
    output logic [1:0] ForwardA, ForwardB
    );
    
    logic forwardA_EX_MEM, forwardA_MEM_WB;
    logic forwardB_EX_MEM, forwardB_MEM_WB;

    assign forwardA_EX_MEM = (EX_MEM_RegWrite &&
                             (EX_MEM_Rd != 5'd31) &&
                            (EX_MEM_Rd == ID_EX_Rn));
                            
    assign forwardA_MEM_WB = (MEM_WB_RegWrite &&
                            (MEM_WB_Rd != 5'd31) &&
                            (MEM_WB_Rd == ID_EX_Rn) &&
                            !forwardA_EX_MEM);

    assign forwardB_EX_MEM = (EX_MEM_RegWrite &&
                            (EX_MEM_Rd != 5'd31) &&
                            (EX_MEM_Rd == ID_EX_Rm));
                            
    assign forwardB_MEM_WB = (MEM_WB_RegWrite &&
                            (MEM_WB_Rd != 5'd31) &&
                            (MEM_WB_Rd == ID_EX_Rm) &&
                            !forwardB_EX_MEM);

    // Unidad de forwarding
    always_comb begin
        // Riesgo EX/MEM
        if (forwardA_EX_MEM) ForwardA = 2'b10;
        // Riesgo MEM/WB
        else if (forwardA_MEM_WB) ForwardA = 2'b01;
        // Sin riesgo
        else ForwardA = 2'b00;

        //* ForwardB
        // Riesgo EX/MEM
        if (forwardB_EX_MEM) ForwardB = 2'b10;
        // Riesgo MEM/WB
        else if (forwardB_MEM_WB) ForwardB = 2'b01;
        // Sin riesgo
        else ForwardB = 2'b00;
    end

endmodule
