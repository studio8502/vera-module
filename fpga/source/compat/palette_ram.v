//`default_nettype none

module palette_ram(
    input  wire        rst_i,
    input  wire        wr_clk_i,
    input  wire        rd_clk_i,
    input  wire        wr_clk_en_i,
    input  wire        rd_en_i,
    input  wire        rd_clk_en_i,
    input  wire        wr_en_i,
    input  wire  [1:0] ben_i,
    input  wire [15:0] wr_data_i,
    input  wire  [7:0] wr_addr_i,
    input  wire  [7:0] rd_addr_i,
    output wire [15:0] rd_data_o);

`ifndef verilator

SB_RAM40_4K #(
    .READ_MODE(0),
    .WRITE_MODE(0)
    ) bram0 (
    .WADDR(wr_addr_i),
    .RADDR(rd_addr_i),
    .MASK({ {8{~ben_i[1]}}, {8{~ben_i[0]}} }),
    .WDATA(wr_data_i[15:0]),
    .RDATA(rd_data_o[15:0]),
    .WE(wr_en_i),
    .WCLKE(wr_clk_en_i),
    .WCLK(wr_clk_i),
    .RE(rd_en_i),
    .RCLKE(rd_clk_en_i),
    .RCLK(rd_clk_i)
    );

`else
    reg [15:0] data;
    reg [15:0] mem[0:255];

    always @(posedge wr_clk_i) begin
        if (wr_en_i) begin
            if (ben_i[1]) mem[wr_addr_i][15:8] <= wr_data_i[15:8];
            if (ben_i[0]) mem[wr_addr_i][7:0]  <= wr_data_i[7:0];
        end
    end

    always @(posedge rd_clk_i) begin
        data <= mem[rd_addr_i];
    end

    assign rd_data_o = data;
`endif

`ifdef TODO
    initial begin: INIT
        mem[0] = 16'h000;
        mem[1] = 16'hFFF;
        mem[2] = 16'h800;
        mem[3] = 16'hAFE;
        mem[4] = 16'hC4C;
        mem[5] = 16'h0C5;
        mem[6] = 16'h00A;
        mem[7] = 16'hEE7;
        mem[8] = 16'hD85;
        mem[9] = 16'h640;
        mem[10] = 16'hF77;
        mem[11] = 16'h333;
        mem[12] = 16'h777;
        mem[13] = 16'hAF6;
        mem[14] = 16'h08F;
        mem[15] = 16'hBBB;
    end
`endif

endmodule

