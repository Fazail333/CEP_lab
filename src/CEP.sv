module CEP(
    input logic clk,
    input logic reset,
    input logic [7:0]data,
    input logic load,
    input logic Tx_start,
    output logic Tx
);

logic load_en, Tx_en, br_en;
logic  sel;
logic S_eq, br_eq;

data_path datapath(clk, data, reset, load_en, sel, Tx_en, br_en, Tx, S_eq, br_eq);

control_path controlpath(clk, reset, Tx_start, load, br_eq, S_eq, load_en, sel, br_en, Tx_en);

endmodule