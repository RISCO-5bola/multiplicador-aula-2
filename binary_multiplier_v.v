module binary_multiplier_v (CLK, RESET, A, B, MULT_SAIDA);

input CLK, RESET;
input [7:0] A, B;
output [7:0] MULT_SAIDA;
wire Z;
reg [1:0] STATE, NEXT_STATE;
reg [7:0] BR, AR, PR;

parameter CARREGAR = 2'b00, SOMAR = 2'b01, PARA = 2'b10;

assign MULT_SAIDA = PR;
assign Z = ~| AR;

//initial state
initial begin
    STATE <= CARREGAR;    
end

//state register
always @(posedge CLK or posedge RESET)
begin
    if (RESET == 1'b1)
        STATE <= CARREGAR;
    else
        STATE <=  NEXT_STATE; 
end

//next state
always@(STATE or Z)
begin
    case (STATE)
        CARREGAR: 
            if (Z == 0)
                NEXT_STATE <= SOMAR;
            else
                NEXT_STATE <= PARA;
        SOMAR: 
            if (Z == 0)
                NEXT_STATE <= SOMAR;
            else
                NEXT_STATE <= PARA;
        default: NEXT_STATE <= STATE;
    endcase
end

//datapath function
always@(posedge CLK)
begin
    case (STATE)
        CARREGAR:
            begin
                BR <= A;
                AR <= B - 8'd1;
                PR <= 0;
            end
        SOMAR:
            begin
                AR <= AR - 1;
                PR <= PR + BR;
            end
    endcase
end
    
endmodule
