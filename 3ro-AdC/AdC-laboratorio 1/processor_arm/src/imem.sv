`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2025 02:45:10 PM
// Design Name: 
// Module Name: imem
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


module imem
    #(parameter N = 32)
    (input logic [6:0] addr,
    output logic [N-1:0] q
    );
    // 64 palabras de N
    logic [N-1:0] ROM [0:128];

initial begin
  for (int i = 0; i <= 127; i++) begin
            ROM[i] = N'('h0);
  end
   ROM [0:58] ='{N'('hf8000001),
                 N'('hf8008002),
                 N'('hf8000203),
                 N'('h8b050083),
                 N'('hf8018003),
                 N'('hcb050083),
                 N'('hf8020003),
                 N'('hcb0a03e4),
                 N'('hf8028004),
                 N'('h8b040064),
                 N'('hf8030004),
                 N'('hcb030025),
                 N'('hf8038005),
                 N'('h8a1f0145),
                 N'('hf8040005),
                 N'('h8a030145),
                 N'('hf8048005),
                 N'('h8a140294),
                 N'('hf8050014),
                 N'('haa1f0166),
                 N'('hf8058006),
                 N'('haa030166),
                 N'('hf8060006),
                 N'('hf840000c),
                 N'('h8b1f0187),
                 N'('hf8068007),
                 N'('hf807000c),
                 N'('h8b0e01bf),
                 N'('hf807801f),
                 N'('hb40000c0),
                 N'('h8b1f03ff),
                 N'('h8b1f03ff),
                 N'('h8b1f03ff),
                 N'('h8b1f03ff),
                 N'('hf8080015),
                 N'('hf8088015),
                 N'('h8b0103e2),
                 N'('hcb010042),
                 N'('h8b0103f8),
                 N'('hf8090018),
                 N'('h8b080000),
                 N'('hb4ffff82),
                 N'('h8b1f03ff),
                 N'('h8b1f03ff),
                 N'('h8b1f03ff),
                 N'('h8b1f03ff),
                 N'('hf809001e),
                 N'('h8b1e03de),
                 N'('hcb1503f5),
                 N'('h8b1403de),
                 N'('hf85f83d9),
                 N'('h8b1e03de),
                 N'('h8b1003de),
                 N'('hf81f83d9),
                 N'('hb400001f),
                 N'('h8b1f03ff),
                 N'('h8b1f03ff),
                 N'('h8b1f03ff),
                 N'('h8b1f03ff)};
    end   
    assign q = ROM[addr];
endmodule
