module control_path(
    input logic clk,
    input logic reset,

    input logic Tx_start,
    input logic load,

    input logic br_eq,
    input logic S_eq,

    output logic load_en,
    output logic sel,
    output logic br_en,
    output logic Tx_en
);

logic [1:0] c_state, n_state;
parameter S0=2'b00, S1=2'b01, S2=2'b10, S3=2'b11;
//state register

always_ff @ (posedge clk or posedge reset)
begin
    //reset is active high
    if (reset)
    c_state <= S0;
    else
    c_state <= n_state;
end

//next_state always block
always_comb
begin
case (c_state)
    S0: begin   if (load) n_state = S1;
                else n_state = S0; end

    S1: begin   if (Tx_start) n_state = S2;
                else n_state = S1; end

    S2: begin   if (S_eq) n_state = S0;
                else n_state = S2; end

    default: n_state = S0;
endcase
end

//output always block
always_comb
begin
case (c_state)
    S0: begin   if (load) begin load_en = 1'b0;
                                Tx_en = 1'b0;
                                sel = 1'b1;
                                br_en = 1'b1; end
                else begin  sel = 1'b1;
                            load_en = 1'b1;
                            Tx_en = 1'b0;
                            br_en = 1'b0;
                            end end

    S1: begin   if (Tx_start) begin sel = 1'b0;
                                    load_en = 1'b0;
                                    Tx_en = 1'b1;
                                    br_en = 1'b1; 
                                    end
                else begin  //load_en = 1'b0;
                            sel = 1'b1;
                            Tx_en = 1'b0;
                            //br_en =1'b1; 
                            end end

    S2: begin   if (S_eq) begin   load_en = 1'b0;
                                  sel = 1'b1;
                                  br_en = 1'b0;
                                  Tx_en = 1'b0; end
                else begin  sel = 1'b0;
                            load_en = 1'b0;
                            //br_en = 1'b1;
                            Tx_en = 1'b1;
                            end end

    default: begin  sel = 1'b1;
                    load_en = 1'b1;
                    Tx_en = 1'b0;
                    br_en = 1'b0;  
            end
endcase
end
endmodule

/*module control_path(
    input logic clk,
    input logic reset,

    input logic Tx_start,
    input logic load,

    input logic br_eq,
    input logic S_eq,

    output logic load_en,
    output logic sel,
    output logic br_en,
    output logic Tx_en
    );
logic [1:0] c_state, n_state;
parameter S0=2'b00, S1=2'b01, S2=2'b10, S3=2'b11;
//state register
always_ff @ (posedge clk or posedge reset)
begin
//reset is active low
if (reset)
c_state <= S0;
else
c_state <= n_state;
end
//next_state always block
always_comb
begin
case (c_state)
S0: begin   if (load) n_state = S1;
            else n_state = S0; end

S1: begin   if (br_eq) n_state = S2;
            else n_state = S1; end

S2: begin   if (Tx_start) n_state = S3;
            else n_state = S2; end

S3: begin   if (S_eq) n_state = S1;
            else n_state = S2; end

default: n_state = S0;
endcase
end

//output always block
always_comb
begin
    case (c_state)
        S0: begin load_en = 1'b1; sel = 1'b1; Tx_en = 1'b0; br_en = 1'b0; end
        S1: begin load_en = 1'b0; br_en = 1'b1; end
        S2: begin Tx_en = 1'b1; sel = 0; end
        S3: begin Tx_en = 1'b0;sel = 1'b1; end
    endcase
end
endmodule*/