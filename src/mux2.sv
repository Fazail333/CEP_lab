module mux2( 
    input logic d0,d1,
    input logic sel,
    output logic y
);

assign y = sel ? d1 : d0 ;

endmodule