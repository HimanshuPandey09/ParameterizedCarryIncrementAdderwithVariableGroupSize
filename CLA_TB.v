`timescale 1ns / 1ps



module CLA_TB();


parameter N = 32;
//wire [N-1:0] G,P;
reg [N:1] a,b;
reg cin;
wire cout;
wire [N:1] sum;


CLA CLA01(sum,cout,a,b,cin);

initial begin
//    a = 8'b00001110;
//    b = 8'b00001011;
//    a = 16'b0000000001101100;
//    b = 16'b0000001000110010;
//    cin = 1'b0;
    a = 16'h3A9A; b = 16'hE544; cin = 1'b1;
//    #50 a = 32'hD47856ED; b = 32'hDCBE1597 ; cin = 1'b1;
//      a = 32'd56321; b = 32'd21456; cin = 1'd1;
        #50 a = 32'd521; b  = 32'd856; cin = 1'b1;
    #20 $finish;
end
endmodule
