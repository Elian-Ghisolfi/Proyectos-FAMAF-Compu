
module execute
    #(parameter N = 64)
    (input logic AluSrc,
    input logic [3:0] AluControl,
    input logic [N-1:0] PC_E,
    input logic [N-1:0] signImm_E,
    input logic [N-1:0] readData1_E,
    input logic [N-1:0] readData2_E,
    output logic [N-1:0] PCBranch_E,
    output logic [N-1:0] aluResult_E,
    output logic [N-1:0] writeData_E,
    output logic zero_E,
    input logic [5:0] shamt,
    input logic [4:0] ID_EX_Rm,
    input logic [4:0] ID_EX_Rn,

    input logic EX_MEM_RegWrite,
    input logic [4:0] EX_MEM_Rd,

    input logic MEM_WB_RegWrite,
    input logic [4:0] MEM_WB_Rd,

    input logic [N-1:0] EX_MEM_aluResult,
    input logic [N-1:0] MEM_WB_writeData
    );
    
    logic [N-1:0] result_sl2;
    logic [N-1:0] result_mux2;
    
    logic [N-1:0] out_mux_forwardA;
    logic [N-1:0] out_mux_forwardB;

    logic [1:0] ForwardA, ForwardB;
    
    forwarding_unit #(N) FU (.ID_EX_Rm(ID_EX_Rm), .ID_EX_Rn(ID_EX_Rn), .EX_MEM_RegWrite(EX_MEM_RegWrite),
        .EX_MEM_Rd(EX_MEM_Rd), .MEM_WB_RegWrite(MEM_WB_RegWrite), .MEM_WB_Rd(MEM_WB_Rd),
        .ForwardA(ForwardA), .ForwardB(ForwardB));
    
    adder #(64) adder_E (.a(PC_E), .b(result_sl2), .y(PCBranch_E));
    
    sl2 sl2_E (.number(signImm_E), .result(result_sl2));
    
    mux4 #(N) MUX_ForwardA (.d0(readData1_E), .d1(MEM_WB_writeData), .d2(EX_MEM_aluResult), .d3('0), .s(ForwardA), .y(out_mux_forwardA));

    mux4 #(N) MUX_ForwardB (.d0(readData2_E), .d1(MEM_WB_writeData), .d2(EX_MEM_aluResult), .d3('0), .s(ForwardB), .y(out_mux_forwardB));
    
    mux2 #(64) mux2_E (.d0(out_mux_forwardB), .d1(signImm_E), .s(AluSrc), .y(result_mux2));
    
    alu alu_E (.a(out_mux_forwardA), .b(result_mux2), .ALUControl(AluControl), .result(aluResult_E), .zero(zero_E), .shamt(shamt));
    
    assign writeData_E = out_mux_forwardB;
    
endmodule

module sl2(
    input logic [63:0] number,
    output logic [63:0] result
    );
    
    assign result = number << 2;
endmodule