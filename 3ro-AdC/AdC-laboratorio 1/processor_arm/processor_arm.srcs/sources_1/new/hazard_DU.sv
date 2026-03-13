`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2025 05:12:20 PM
// Design Name: 
// Module Name: hazard_detection_unit
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


module hazard_detection_unit(
    input logic [4:0] IF_ID_Rn,
    input logic [4:0] IF_ID_Rm,
    
    input logic ID_EX_MemRead,
    input logic [4:0] ID_EX_Rd,
    
    output logic PCWrite,
    output logic IF_ID_Write,
    output logic HDUControl
    );
    
    always_comb begin
		if (ID_EX_MemRead && (
			(ID_EX_Rd == IF_ID_Rn) ||
			(ID_EX_Rd == IF_ID_Rm)
			)) begin
			// Se hace stall y se insertan bubbles
			PCWrite = 0;
			IF_ID_Write = 0;
			HDUControl = 1;
			
		end
		else begin
		    // No hay stall
		    PCWrite = 1;
		    IF_ID_Write = 1;
			HDUControl = 0;

		end
	end

endmodule
