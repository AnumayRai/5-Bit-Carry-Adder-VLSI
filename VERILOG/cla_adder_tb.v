module cla_adder_tb;
    reg clk;
    reg [4:0] a, b;
    wire [4:0] sum;
    wire cout;
    
    cla_adder uut (
        .clk(clk),
        .a(a),
        .b(b),
        .sum(sum),
        .cout(cout)
    );

    initial begin
        clk = 0;
        forever #50 clk = ~clk;
    end
    
    initial begin
        $dumpfile("cla_adder_test.vcd");
        $dumpvars(0, cla_adder_tb);
   
        a = 0;
        b = 0;
        #100;

        a = 5'b00001; b = 5'b00001; 
        #100;

        a = 5'b11111; b = 5'b00001;
        #100;

        a = 5'b10101; b = 5'b01101; 
        #100;

        a = 5'b00010; b = 5'b11011; 
        #100;

        a = 5'b11111; b = 5'b11111; 
        #100;
        
        #100;
        
        $finish;
    end
endmodule

