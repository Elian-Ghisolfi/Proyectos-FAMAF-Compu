`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.08.2025 17:43:07
// Design Name: 
// Module Name: alu_tb
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


module alu_tb;

    logic [63:0] a, b;
    logic [3:0]  ALUControl;
    logic [63:0] result;
    logic        zero;

    alu alu_tb(
        .a(a),
        .b(b),
        .ALUControl(ALUControl),
        .result(result),
        .zero(zero)
    );

    initial begin
        // Caso 1: positivos
        a = 64'd10; b = 64'd5;
        
        $display("a=%0h, b=%0h", a, b);

        ALUControl = 4'b0000; #10;  // AND
        $display("AND: result=%0h zero=%b", result, zero);

        ALUControl = 4'b0001; #10;  // OR
        $display("OR : result=%0h zero=%b", result, zero);

        ALUControl = 4'b0010; #10;  // ADD
        $display("ADD: result=%0h zero=%b", result, zero);

        ALUControl = 4'b0110; #10;  // SUB
        $display("SUB: result=%0h zero=%b", result, zero);

        ALUControl = 4'b0111; #10;  // PASS b
        $display("PASS b: result=%0h zero=%b", result, zero);

        // Caso 2: negativos
        a = -64'h10; b = -64'h5;
        
        $display("a=%0h, b=%0h", a, b);
        
        ALUControl = 4'b0000; #10;
        $display("AND (negativos): result=%0h, zero=%0b", result, zero);
        
        ALUControl = 4'b0001; #10;
        $display("OR (negativos): result=%0h, zero=%0b", result, zero);

        ALUControl = 4'b0010; #10;
        $display("ADD (negativos): result=%0h zero=%b", result, zero);

        ALUControl = 4'b0110; #10;
        $display("SUB (negativos): result=%0h zero=%b", result, zero);

        // Caso 3: uno positivo y otro negativo
        a = 64'd10; b = -64'd5;
        
        $display("a=%0h, b=%0h", a, b);
        
        ALUControl = 4'b0000; #10;
        $display("AND pos+neg: result=%0h, zero=%0b", result, zero);
        
        ALUControl = 4'b0001; #10;
        $display("OR pos+neg: result=%0h, zero=%0b", result, zero);

        ALUControl = 4'b0010; #10;
        $display("ADD pos+neg: result=%0h zero=%b", result, zero);

        ALUControl = 4'b0110; #10;
        $display("SUB pos-neg: result=%0h zero=%b", result, zero);

        // Caso 4: overflow
        a = 64'h7FFFFFFFFFFFFFFF;  // Máximo positivo
        b = 64'd1;
        
        $display("a=%0h, b=%0h", a, b);
        
        ALUControl = 4'b0010; #10; // ADD
        $display("Overflow test: a=%0h b=%0h result=%0h zero=%b", a, b, result, zero);

        // Caso 5: Verificación de bandera zero
        a = 64'd15; b = 64'd15; ALUControl = 4'b0110; #10; // SUB = 0
        $display("a=%0d, b=%0d", a, b);
        
        $display("Zero flag test (SUB) : a=%0d b=%0d result=%0d zero=%b", a, b, result, zero);

        $finish;
    end
endmodule
