// Autor: Enzo Koichi Jojima - 14568285
module displayMem (
    input clock,
    input [1:0] displayAddr,
    input nivel,
    
    output reg [6:0] HEX0,
                     HEX1, 
                     HEX2, 
                     HEX3, 
                     HEX4,
                     HEX5
);
    always @(posedge clock) begin
        case (displayAddr)
            2'b00: begin            //nivel0/1
                if (nivel) begin
                HEX0 <= 7'b1111001; //1
                HEX1 <= 7'b1000111; //l
                HEX2 <= 7'b0000110; //e
                HEX3 <= 7'b1000001; //v
                HEX4 <= 7'b1111001; //i
                HEX5 <= 7'b1001000; //n    
                end else begin
                HEX0 <= 7'b1000000; //0
                HEX1 <= 7'b1000111; //l
                HEX2 <= 7'b0000110; //e
                HEX3 <= 7'b1000001; //v
                HEX4 <= 7'b1111001; //i
                HEX5 <= 7'b1001000; //n  
                end
            end 

            2'b01: begin            //venceu
                HEX0 <= 7'b1000001; //u
                HEX1 <= 7'b0000110; //e
                HEX2 <= 7'b1000110; //c
                HEX3 <= 7'b1001000; //n
                HEX4 <= 7'b0000110; //e
                HEX5 <= 7'b1000001; //v
            end

            2'b10: begin            //perdeu
                HEX0 <= 7'b1000001; //u
                HEX1 <= 7'b0000110; //e
                HEX2 <= 7'b0100001; //d
                HEX3 <= 7'b0101111; //r
                HEX4 <= 7'b0000110; //e
                HEX5 <= 7'b0001100; //p
            end


            default: begin
                HEX0 <= 7'b1111111;
                HEX1 <= 7'b1111111;
                HEX2 <= 7'b1111111;
                HEX3 <= 7'b1111111;
                HEX4 <= 7'b1111111;
                HEX5 <= 7'b1111111;
            end
        endcase
    end

endmodule