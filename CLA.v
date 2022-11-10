`timescale 1ns / 1ps

module CLA#(parameter N = 32,
            parameter GS = 8)(output [N:1] sum,
                              output cout,
                              input [N:1] a,
                              input [N:1] b,
                              input cin);


wire [N:0] g, p;  // bit P & G Signals.
wire [N:0] G;     // Group G Signals.

wire [N/GS -1:0] pn;  //Intermediate Group P&G signals.
wire [N/GS-1 :0] gn;  //Intermediate Group P&G signals.

assign g[0] = cin,
       p[0] = 1'b0;

assign G[0] = g[0];
  
// Bit PG Implementation.    
genvar i;                 
generate for(i = 1; i <= N; i = i + 1) begin: bitPG
    assign g[i] = a[i] & b[i],
           p[i] = a[i] ^ b[i];
    end
endgenerate
 
// Group PG Implementation        
genvar j,k;
generate for(j = 0; j < N; j = j + GS ) begin: GPLogic
    
    Var_Val_BC #(N,GS) vvbc01(gn[j/GS], pn[j/GS], g[j+GS:j+1], p[j+GS:j+1]);
    grayCell gc01(G[j+GS], gn[j/GS], pn[j/GS], G[j]);
    
    for (k = j+1; k <= GS -1+j; k = k + 1) begin: groupPG_GenerateSignal 
        grayCell_Val #(k+1-j)gcv01(G[k], g[k:j+1], p[k:j+1], G[j]);
    end
    end
    
endgenerate

genvar l;
generate for (l = 1; l <= N; l = l+1) begin: sumLogic

    assign sum[l] = p[l] ^ G[l-1];
    
    if (l == N)
        assign cout = G[N];
    
end
endgenerate



 
endmodule
