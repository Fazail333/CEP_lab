module CEP_tb();

logic clk;
logic rst;
logic Tx_st;
logic ld;
logic [7:0]d;
logic tx;

CEP UUT(
        .Tx_start(Tx_st),
        .load(ld),
        .clk(clk),
        .reset(rst),
        .data(d),
        .Tx(tx)
    );


initial
begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end

initial
begin
    repeat(2)
    rst = 1'b1;  ld = 1'b0;
    d   = 8'h00; Tx_st = 1'b0;
    @(posedge clk)
    rst = 1'b0;
    @(posedge clk)
    ld = 1'b0; d = 8'b0000_1111;
    @(posedge clk)
    ld = 1'b1;
    @(posedge clk)
    ld = 1'b0;
    repeat(20)@(posedge clk)//25
    Tx_st = 1'b1;
    repeat(2)@(posedge clk)
    Tx_st = 1'b0; ld =1'b1;
    @(posedge clk)
    $stop;
end
    
endmodule