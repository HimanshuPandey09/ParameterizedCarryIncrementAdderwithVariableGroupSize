`timescale 1ns / 1ps

module CIA_Var_Size#(parameter N = 64,
                     parameter NGs = 7,
                     parameter GS1 = 8,
                     parameter GS2 = 8,
                     parameter GS3 = 9,
                     parameter GS4 = 9,
                     parameter GS5 = 10,
                     parameter GS6 = 10,
                     parameter GS7 = 10,
                     parameter GS8 = 0)
//                     parameter GS5 = 5)
             (output [N:1] sum,
              output cout,
              input [N:1] a,
              input [N:1] b,
              input cin);

wire [N:0] g, p;  // bit P & G Signals.
wire [N-1:0] G;   // Group G Signals.

wire[N-1:1] gn; //Intermediate Group P&G signals.
wire[N-1:1] pn; //Intermediate Group P&G signals.

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
assign gn[GS1-1:1] = g[GS1-1:1];
assign pn[GS1-1:1] = p[GS1-1:1];

genvar jj,kk,mm;
generate for(jj = 1; jj <= NGs; jj = jj + 1) begin: Groups
//////////////////////////////////////////////////////////////////////////////////////////
    if(jj == 1) begin
        for(kk = 1; kk <= GS1-1; kk = kk + 1 ) begin: Group1
//            if(kk = 1)begin
//                assign gn[kk] = g[kk];
//                assign pn[kk] = p[kk];
//            end
            grayCell gc01(G[kk], g[kk], p[kk], g[kk-1]);    
        end
     end
//////////////////////////////////////////////////////////////////////////////////////////   
    if(jj == 2) begin
        for(kk = GS1+1; kk <= GS1+GS2-1; kk = kk + 1 ) begin: Group2
            if(kk == GS1+1) begin
                assign gn[kk-1] = g[kk-1];
                assign pn[kk-1] = p[kk-1];
            end
            blackCell bc00(gn[kk], pn[kk], g[kk], p[kk], gn[kk-1], p[kk], pn[kk-1]);  
        end
        for(mm = GS1; mm <= GS1+GS2-1; mm = mm + 1) begin: G2
            grayCell gc02(G[mm], gn[mm], pn[mm], gn[GS1-1]);    
        end           
    end
//////////////////////////////////////////////////////////////////////////////////////////
    if(jj == 3) begin
        for(kk = GS1+GS2+1; kk <= GS1+GS2+GS3-1; kk = kk + 1 ) begin: Group3
            if(kk == GS1+GS2+1) begin
                assign gn[kk-1] = g[kk-1];
                assign pn[kk-1] = p[kk-1];
            end
            blackCell bc01(gn[kk], pn[kk], g[kk], p[kk], gn[kk-1], p[kk], pn[kk-1]);  
        end
        for(mm = GS1+GS2; mm <= GS1+GS2+GS3-1; mm = mm + 1) begin: G3
            grayCell gc02(G[mm], gn[mm], pn[mm], gn[GS1+GS2-1]);    
        end           
    end
//////////////////////////////////////////////////////////////////////////////////////////
    if(jj == 4) begin
        for(kk = GS1+GS2+GS3+1; kk <= GS1+GS2+GS3+GS4-1; kk = kk + 1 ) begin: Group4
            if(kk == GS1+GS2+GS3+1) begin
                assign gn[kk-1] = g[kk-1];
                assign pn[kk-1] = p[kk-1];
            end
            blackCell bc02(gn[kk], pn[kk], g[kk], p[kk], gn[kk-1], p[kk], pn[kk-1]);  
        end
        for(mm = GS1+GS2+GS3; mm <= GS1+GS2+GS3+GS4-1; mm = mm + 1) begin: G4
            grayCell gc03(G[mm], gn[mm], pn[mm], gn[GS1+GS2+GS3-1]);    
        end           
    end
////////////////////////////////////////////////////////////////////////////////////////////
    if(jj == 5) begin
        for(kk = GS1+GS2+GS3+GS4+1; kk <= GS1+GS2+GS3+GS4+GS5-1; kk = kk + 1 ) begin: Group5
            if(kk == GS1+GS2+GS3+GS4+1) begin
                assign gn[kk-1] = g[kk-1];
                assign pn[kk-1] = p[kk-1];
            end
            blackCell bc03(gn[kk], pn[kk], g[kk], p[kk], gn[kk-1], p[kk], pn[kk-1]);  
        end
        for(mm = GS1+GS2+GS3+GS4; mm <= GS1+GS2+GS3+GS4+GS5-1; mm = mm + 1) begin: G5
            grayCell gc04(G[mm], gn[mm], pn[mm], gn[GS1+GS2+GS3+GS4-1]);    
        end           
    end

//////////////////////////////////////////////////////////////////////////////////////////
    if(jj == 6) begin
        for(kk = GS1+GS2+GS3+GS4+GS5+1; kk <= GS1+GS2+GS3+GS4+GS5+GS6-1; kk = kk + 1 ) begin: Group6
            if(kk == GS1+GS2+GS3+GS4+GS5+1) begin
                assign gn[kk-1] = g[kk-1];
                assign pn[kk-1] = p[kk-1];
            end
            blackCell bc03(gn[kk], pn[kk], g[kk], p[kk], gn[kk-1], p[kk], pn[kk-1]);  
        end
        for(mm = GS1+GS2+GS3+GS4+GS5; mm <= GS1+GS2+GS3+GS4+GS5+GS6-1; mm = mm + 1) begin: G6
            grayCell gc04(G[mm], gn[mm], pn[mm], gn[GS1+GS2+GS3+GS4+GS5-1]);    
        end           
    end

//////////////////////////////////////////////////////////////////////////////////////////
    if(jj == 7) begin
        for(kk = GS1+GS2+GS3+GS4+GS5+GS6+1; kk <= GS1+GS2+GS3+GS4+GS5+GS6+GS7-1; kk = kk + 1 ) begin: Group7
            if(kk == GS1+GS2+GS3+GS4+GS5+GS6+1) begin
                assign gn[kk-1] = g[kk-1];
                assign pn[kk-1] = p[kk-1];
            end
            blackCell bc03(gn[kk], pn[kk], g[kk], p[kk], gn[kk-1], p[kk], pn[kk-1]);  
        end
        for(mm = GS1+GS2+GS3+GS4+GS5+GS6; mm <= GS1+GS2+GS3+GS4+GS5+GS6+GS7-1; mm = mm + 1) begin: G7
            grayCell gc04(G[mm], gn[mm], pn[mm], gn[GS1+GS2+GS3+GS4+GS5+GS6-1]);    
        end           
    end

////////////////////////////////////////////////////////////////////////////////////////////
//    if(jj == 8) begin
//        for(kk = GS1+GS2+GS3+GS4+GS5+GS6+GS7+1; kk <= GS1+GS2+GS3+GS4+GS5+GS6+GS7+GS8-1; kk = kk + 1 ) begin: Group8
//            if(kk == GS1+GS2+GS3+GS4+GS5+GS6+GS7+1) begin
//                assign gn[kk-1] = g[kk-1];
//                assign pn[kk-1] = p[kk-1];
//            end
//            blackCell bc03(gn[kk], pn[kk], g[kk], p[kk], gn[kk-1], p[kk], pn[kk-1]);  
//        end
//        for(mm = GS1+GS2+GS3+GS4+GS5+GS6+GS7; mm <= GS1+GS2+GS3+GS4+GS5+GS6+GS7+GS8-1; mm = mm + 1) begin: G8
//            grayCell gc04(G[mm], gn[mm], pn[mm], gn[GS1+GS2+GS3+GS4+GS5+GS6+GS7-1]);    
//        end           
//    end

//////////////////////////////////////////////////////////////////////////////////////////
end
endgenerate

// Sum Logic Implementation
genvar o;
generate for (o = 1; o <= N; o = o+1) begin: sumLogic

    assign sum[o] = p[o] ^ G[o-1];
    
    if (o == N)
        grayCell gc04(cout, g[N], p[N], G[N-1]);  
end
endgenerate
endmodule
