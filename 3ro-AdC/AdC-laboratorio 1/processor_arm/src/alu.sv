
module alu( input logic [63:0] a, input logic [63:0] b, input logic [3:0] ALUControl,
            output logic [63:0] result, output logic zero, input [5:0] shamt );
    
    always_comb begin
    
        case(ALUControl)
            4'b0000: result = a & b;
            4'b0001: result = a | b;
            4'b0010: result = a + b;
            4'b0110: result = a - b;
            4'b1001: result = a >> shamt; //Shift Derecha
            4'b1010: result = a << shamt; //Shift izquierda
            4'b0111: result = b;
            default: result = 64'b0;
        endcase 
        
        if (result == 64'b0) zero = 1;
        else zero = 0;
    end
endmodule
