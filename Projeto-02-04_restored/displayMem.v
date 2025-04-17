// Autor: Enzo Koichi Jojima - 14568285
module displayMem (
    input clock,
    input [1:0] displayAddr,
    input [1:0] modo,
    
    output reg [6:0] HEX0,
                     HEX1, 
                     HEX2, 
                     HEX3, 
                     HEX4,
                     HEX5
);
    always @(posedge clock) begin
        case (displayAddr)
            2'b00: begin    //nivel 0/1/2/3
                case (modo) 
                    2'b00: begin
                            HEX0 <= 7'b0111111; //0
                            HEX1 <= 7'b0111000; //l
                            HEX2 <= 7'b1111001; //e
                            HEX3 <= 7'b0111110; //v
                            HEX4 <= 7'b0000110; //i
                            HEX5 <= 7'b0110111; //n 
                    end 
                    2'b01: begin
                            HEX0 <= 7'b0000110; //1
                            HEX1 <= 7'b0111000; //l
                            HEX2 <= 7'b1111001; //e
                            HEX3 <= 7'b0111110; //v
                            HEX4 <= 7'b0000110; //i
                            HEX5 <= 7'b0110111; //n
                    end
                    2'b10: begin
                            HEX0 <= 7'b1011011; //2
                            HEX1 <= 7'b0111000; //l
                            HEX2 <= 7'b1111001; //e
                            HEX3 <= 7'b0111110; //v
                            HEX4 <= 7'b0000110; //i
                            HEX5 <= 7'b0110111; //n
                    end
                    2'b11: begin
                            HEX0 <= 7'b1001111; //3
                            HEX1 <= 7'b0111000; //l
                            HEX2 <= 7'b1111001; //e
                            HEX3 <= 7'b0111110; //v
                            HEX4 <= 7'b0000110; //i
                            HEX5 <= 7'b0110111; //n
                    end
                endcase
            end

            2'b01: begin            //venceu
                HEX0 <= 7'b0111110; //u
                HEX1 <= 7'b1111001; //e
                HEX2 <= 7'b0111001; //c
                HEX3 <= 7'b0110111; //n
                HEX4 <= 7'b1111001; //e
                HEX5 <= 7'b0111110; //v
            end

            2'b10: begin            //perdeu
                HEX0 <= 7'b0111110; //u
                HEX1 <= 7'b1111001; //e
                HEX2 <= 7'b1011110; //d
                HEX3 <= 7'b1010000; //r
                HEX4 <= 7'b1111001; //e
                HEX5 <= 7'b1110011; //p
            end

            default: begin
                HEX0 <= 7'b0000000;
                HEX1 <= 7'b0000000;
                HEX2 <= 7'b0000000;
                HEX3 <= 7'b0000000;
                HEX4 <= 7'b0000000;
                HEX5 <= 7'b0000000;
            end
        endcase
    end

endmodule
