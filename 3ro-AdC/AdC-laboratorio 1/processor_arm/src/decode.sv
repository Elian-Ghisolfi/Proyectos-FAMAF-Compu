// Etapa: DECODE

module decode #(parameter N = 64)
					(input logic regWrite_D, reg2loc_D, clk,
					input logic [N-1:0] writeData3_D,
					input logic [31:0] instr_D,
					output logic [N-1:0] signImm_D, readData1_D, readData2_D, 
					input logic [4:0] wa3_D,
					output logic [5:0] shamt_D, // Eliminar para single cycle processor
					
					input logic [4:0] ID_EX_Rd,
		            input logic ID_EX_MemRead,
		            output logic HDUControl,
		            output logic IF_ID_Write,
		            output logic PCWrite,
		            output logic [4:0] Rm, Rn, Rd
					);
					
	logic [4:0] ra2;			
	
	mux2 	#(5) 	ra2mux	(.d0(instr_D[20:16]), .d1(instr_D[4:0]), .s(reg2loc_D), .y(ra2));
	
	regfile 		registers(.clk(clk), .we3(regWrite_D), .ra1(instr_D[9:5]), .ra2(ra2), .wa3(wa3_D), 
								 .wd3(writeData3_D), .rd1(readData1_D), .rd2(readData2_D));
								
	// En single cycle processor:						
	//regfile registers (.clk(clk), .we3(regWrite_D), .ra1(instr_D[9:5]), .ra2(ra2), .wa3(instr_D[4:0]), 
	//							 .wd3(writeData3_D), .rd1(readData1_D), .rd2(readData2_D));
	
									
	signext 		ext		(.a(instr_D), .y(signImm_D));	
	
	assign Rm = ra2;
	assign Rn = instr_D[9:5];
	assign Rd = instr_D[4:0];
	
	always_comb
        casez(instr_D[31:21])
            11'b110_1001_1010: shamt_D = instr_D[15:10];   //LSR
			11'b110_1001_1011: shamt_D = instr_D[15:10];   //LSL
            default: shamt_D = '0;
		endcase
	
	hazard_detection_unit HDU(
		.IF_ID_Rn(instr_D[9:5]),
		.IF_ID_Rm(ra2),
		.ID_EX_MemRead(ID_EX_MemRead),
		.ID_EX_Rd(ID_EX_Rd),

		.HDUControl(HDUControl),
		.IF_ID_Write(IF_ID_Write),
		.PCWrite(PCWrite)
	);
	
endmodule
