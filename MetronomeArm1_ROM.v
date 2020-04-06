module metronomeArm1_ROM
#(parameter DATA_WIDTH=19, parameter ADDR_WIDTH=7)
(
    input [(ADDR_WIDTH-1):0] addr,
    input clk, 
    output reg [(DATA_WIDTH-1):0] q
);

    // Declare the ROM variable
    reg [DATA_WIDTH-1:0] rom[0:2**ADDR_WIDTH-1];

    initial
    begin
        $readmemh("Arm1List.txt", rom);
    end

    always @ (posedge clk)
    begin
        q <= rom[addr];
    end

endmodule
