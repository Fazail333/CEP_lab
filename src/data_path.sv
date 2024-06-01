module data_path(
    input logic clk,
    //switches
    input logic [7:0]in,
    input logic reset,
    //controller
    input logic load_en,
    input logic sel,
    input logic Tx_en,
    input logic br_en,

    output logic Tx,
    output logic S_eq,
    output logic br_eq
);

localparam idle = 1'b1;
logic [7:0]d_o; //data out after loading
logic S_out,clk_br;

d_ff Load0(d_o[0], clk, reset, load_en, in[0]);
d_ff Load1(d_o[1], clk, reset, load_en, in[1]);
d_ff Load2(d_o[2], clk, reset, load_en, in[2]);
d_ff Load3(d_o[3], clk, reset, load_en, in[3]);
d_ff Load4(d_o[4], clk, reset, load_en, in[4]);
d_ff Load5(d_o[5], clk, reset, load_en, in[5]);
d_ff Load6(d_o[6], clk, reset, load_en, in[6]);
d_ff Load7(d_o[7], clk, reset, load_en, in[7]);

baud_rate clk_9600(clk, reset, Tx_en, br_en, clk_br, br_eq);

Shift_register Sr_10_bit(d_o, Tx_en, reset, clk_br, S_out, S_eq);

mux2 data_line(S_out, idle, sel, Tx);

endmodule