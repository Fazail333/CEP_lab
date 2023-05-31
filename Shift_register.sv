module Shift_register(
    input logic [7:0]data,
    input logic Tx_en,
    input logic reset,
    input logic clk,
    output logic S_out,
    output logic S_eq  
    );

localparam start_bit = 1'b0, stop_bit = 1'b1, maxcount =10;

logic [4:0]count;
logic [7:0]d;
logic stp_bt;

always_ff @(posedge clk or posedge reset) begin
    if (reset) 
        count <= 4'h0;
    else begin 
        if (Tx_en) begin 
            count <= count + 1;
            if (count == maxcount)
                count <= 0; end
        else
            count <= 0;
        end
    end
  
assign S_eq = count == maxcount;

//Shifting the values SIPO
always_ff @(posedge clk or posedge reset) begin
    if (reset)begin
        d <= data;
        stp_bt <= 1'b1;
    end
    else begin
    if(Tx_en) begin
        S_out <= d[0];
        d[0] <= d[1];
        d[1] <= d[2];
        d[2] <= d[3];
        d[3] <= d[4];
        d[4] <= d[5];
        d[5] <= d[6];
        d[6] <= d[7];
        d[7] <= stp_bt;
        end
    else begin
        S_out <= 1'b0;
        d <= data;
        stp_bt <= 1'b1;
    end
    end
end
endmodule