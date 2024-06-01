module d_ff(
    output logic q_o,
    input logic clk_i, reset_i, 
    input logic en,
    input logic num
);

always_ff @ (posedge clk_i or posedge reset_i)
begin
    if (reset_i)begin
        q_o <= 1'b0;
    end
    else begin
        if (en)
            q_o <= num;
        else
            q_o <= q_o;
    end
end

endmodule