// Autor Enzo Koichi Jojima - 14568285
// Adaptado do módulo sync_rom_16x4.v do Prof. Dr. Edson Midorikawa
module memoriaLEDs2 (clock, address, data_out);
    input            clock;
    input      [3:0] address;
    output reg [3:0] data_out;

    always @ (posedge clock)
    begin
        case (address)
            4'b0000: data_out = 4'b1000;
            4'b0001: data_out = 4'b0110;
            4'b0010: data_out = 4'b0101;
            4'b0011: data_out = 4'b0001;
            4'b0100: data_out = 4'b1001;
            4'b0101: data_out = 4'b0111;
            4'b0110: data_out = 4'b1010;
            4'b0111: data_out = 4'b0100;
        endcase
    end
endmodule