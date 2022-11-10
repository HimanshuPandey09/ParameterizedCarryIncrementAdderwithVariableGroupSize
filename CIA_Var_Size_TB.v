`timescale 1ns / 1ps

module CIA_Var_Size_TB();

parameter N = 64;
//wire [N-1:0] G,P;
reg [N:1] a,b;
reg cin;
wire cout;
wire [N:1] sum;


CIA_Var_Size CIA01(sum,cout,a,b,cin);

initial begin
//    a = 8'b00001110;
//    b = 8'b00001011;
//    a = 16'b1010110111000000;
//    b = 16'b1111111010000000;
//    cin = 1'b1;
//    a = 8'b01101001;
//    b = 8'b11010111;
//    a = 16'b0000000001101100;
//    b = 16'b0000001000110010;
//    a = 4'b1010; b = 4'b1000; cin = 1'b1;
//    cin = 1'b1;
//    #50 a = 16'h3A9A; b = 16'hE544; cin = 1'b0;
//    a = 32'hD47856ED; b = 32'hDCBE1597 ; cin = 1'b1;
//    a = 4'b1010; b = 4'b0111; cin = 1'b1;
//    a= 32'd541; b = 32'd9851; cin = 1'b1;
//    a = 32'd12; b = 32'd11; cin= 1'b1;
//    a = 32'h4a7b; b = 32'h98cd; cin = 1'b0;
    a = 64'd1458996; b = 64'd8547441; cin = 1'b0;
    #20 $finish;
end
endmodule
