`include "dff.v"
module cla_adder (
    input wire clk,
    input wire [4:0] a,
    input wire [4:0] b,
    output wire [4:0] sum,
    output wire cout
);
    wire [4:0] qa, qb;
    wire [4:0] s;
    wire qc0;
    wire [4:0] gb;
    wire [4:0] p, g;
    wire [4:0] c;
    wire [14:0] w;
    
    assign c[0]=0;
    
    dff qa0 (.clk(clk), .d(a[0]), .q(qa[0]));
    dff qa1 (.clk(clk), .d(a[1]), .q(qa[1]));
    dff qa2 (.clk(clk), .d(a[2]), .q(qa[2]));
    dff qa3 (.clk(clk), .d(a[3]), .q(qa[3]));
    dff qa4 (.clk(clk), .d(a[4]), .q(qa[4]));
    
    dff qb0 (.clk(clk), .d(b[0]), .q(qb[0]));
    dff qb1 (.clk(clk), .d(b[1]), .q(qb[1]));
    dff qb2 (.clk(clk), .d(b[2]), .q(qb[2]));
    dff qb3 (.clk(clk), .d(b[3]), .q(qb[3]));
    dff qb4 (.clk(clk), .d(b[4]), .q(qb[4]));
    
    dff qcin (.clk(clk), .d(c[0]), .q(qc0));
    
    //Pi and Gi generator

    xor (p[0],qa[0],qb[0]);
    xor (p[1],qa[1],qb[1]);
    xor (p[2],qa[2],qb[2]);
    xor (p[3],qa[3],qb[3]);
    xor (p[4],qa[4],qb[4]);
    
    nand (gb[0],qa[0],qb[0]);
    nand (gb[1],qa[1],qb[1]);
    nand (gb[2],qa[2],qb[2]);
    nand (gb[3],qa[3],qb[3]);
    nand (gb[4],qa[4],qb[4]);  
    
    assign g[0]=~gb[0];
    assign g[1]=~gb[1];
    assign g[2]=~gb[2];
    assign g[3]=~gb[3];
    assign g[4]=~gb[4];
    
    // Carry Generator
    //C1
    nand(w[0],p[0],g[0]);
    nand(c[1],w[0],gb[0]);
    //C2
    nand(w[1],p[1],g[0]);
    nand(w[2],p[1],p[0],c[0]);
    nand(c[2],w[1],w[2],gb[1]);
    //C3
    nand(w[3],p[2],g[1]);
    nand(w[4],p[2],p[1],g[0]);
    nand(w[5],p[2],p[1],p[0],c[0]);
    nand(c[3],w[3],w[4],w[5],gb[2]);
    //C4
    nand(w[6],p[3],g[2]);
    nand(w[7],p[3],p[2],g[1]);
    nand(w[8],p[3],p[2],p[1],g[0]);
    nand(w[9],p[3],p[2],p[1],p[0],c[0]);
    nand(c[4],w[6],w[7],w[8],w[9],gb[3]);
    //Cout
    nand(w[10],p[4],g[3]);
    nand(w[11],p[4],p[3],g[2]);
    nand(w[12],p[4],p[3],p[2],g[1]);
    nand(w[13],p[4],p[3],p[2],p[1],g[0]);
    nand(w[14],p[4],p[3],p[2],p[1],p[0],c[0]);
    nand(cout,w[10],w[11],w[12],w[13],w[14],gb[4]);
    
    //SUM
    xor(s[0],p[0],c[0]);
    xor(s[1],p[1],c[1]);
    xor(s[2],p[2],c[2]);
    xor(s[3],p[3],c[3]);
    xor(s[4],p[4],c[4]);
    
    dff qsum0 (.clk(clk), .d(s[0]), .q(sum[0]));
    dff qsum1 (.clk(clk), .d(s[1]), .q(sum[1]));
    dff qsum2 (.clk(clk), .d(s[2]), .q(sum[2]));
    dff qsum3 (.clk(clk), .d(s[3]), .q(sum[3]));
    dff qsum4 (.clk(clk), .d(s[4]), .q(sum[4]));
    
endmodule
