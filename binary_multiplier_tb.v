`timescale 1ns/1ns

module binary_multiplier_tb;

    // Inputs
    reg CLK;
    reg RESET;
    reg [7:0] A;
    reg [7:0] B;

    // Outputs
    wire [7:0] MULT_SAIDA;

    // Instancia a UUT 
    binary_multiplier_v uut (
        .CLK(CLK), 
        .RESET(RESET), 
        .A(A), 
        .B(B), 
        .MULT_SAIDA(MULT_SAIDA)
    );

    // Gerador de clock
    initial begin
        CLK = 0;
        forever #10 CLK = ~CLK;
    end

    initial begin
        $monitor ("[%t] CLK = %d RESET = %d A = %d, B = %d, MULT_SAIDA = %d", 
                  $time, CLK, RESET, A, B, MULT_SAIDA);

        // Inicializar os inputs  
        RESET <= 1;
        A <= 8'd0;
        B <= 8'd0;
        #100

        // 4 x 5
        //MULT_SAIDA = 20
        A <= 8'd5;
        B <= 8'd4;
        #20

        RESET = 0;
        #20;
    end
endmodule