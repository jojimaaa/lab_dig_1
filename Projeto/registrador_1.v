module registrador_1 (
    input        clock,
    input        clear,
    input        enable,
    input   D,
    output  Q
);

    reg IQ;

    always @(posedge clock or posedge clear) begin
        if (clear)
            IQ <= 0;
        else if (enable)
            IQ <= D;
    end

    assign Q = IQ;

endmodule