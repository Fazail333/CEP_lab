module baud_rate(
    input logic clk,
    input logic reset,

    input logic Tx_en,
    input logic br_en,

    output logic clk_br,
    output logic br_eq
);

localparam maxcount = 1;
logic [13:0]count;
logic toggle;

always_ff @(posedge clk or posedge reset) begin
    if (reset)
        count <= 0;
    else begin
        if (Tx_en) begin begin
            count <= count + 1;
            end
            if (count == maxcount)begin
                count <= 0; 
            end end
        else 
            count <= 0;
        end
    end

assign br_eq = count == maxcount;

always_ff @(posedge clk or posedge reset ) begin
    if (reset) begin
        clk_br <= 1'b0;
        toggle <= 1'b1;
    end
    else begin
        if (br_en) begin
            toggle <= ~toggle;
            clk_br <= toggle;
        end
    end
end

endmodule