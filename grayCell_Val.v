`timescale 1ns / 1ps


module grayCell_Val #(parameter V = 4 )( output out,
                                         input [V-1:1] g,
                                         input [V-1:1] p,
                                         input gprev);

wire [V-1:1] pn;      
wire [V-1:1] gn;                                   
genvar ii;
generate for(ii = 1; ii < V; ii = ii + 1) begin: abc
    if(ii == 1) begin
        assign pn[ii] = p[ii] & gprev;
    end
    else begin
        assign pn[ii] = p[ii] & gn[ii-1];
    end
    
    assign gn[ii] = g[ii] | pn[ii];
end
endgenerate

assign out = gn[V-1];
  
endmodule
