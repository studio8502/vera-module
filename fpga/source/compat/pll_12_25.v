/**
 * PLL configuration
 *
 * This Verilog module was generated automatically
 * using the icepll tool from the IceStorm project.
 * Use at your own risk.
 *
 * Given input frequency:        12.000 MHz
 * Requested output frequency:   25.000 MHz
 * Achieved output frequency:    25.125 MHz
 *
 * icepll -i 12 -o 25 -p -m -n pll_12_25 -f pll_12_25.v
 */

module pll_12_25(
	input  clock_in,
	output clock_out,
	output locked
	);

`ifndef verilator
SB_PLL40_PAD #(
		.FEEDBACK_PATH("SIMPLE"),
		.DIVR(4'b0000),		// DIVR =  0
		.DIVF(7'b1000010),	// DIVF = 66
		.DIVQ(3'b101),		// DIVQ =  5
		.FILTER_RANGE(3'b001)	// FILTER_RANGE = 1
	) uut (
		.LOCK(locked),
		.RESETB(1'b1),
		.BYPASS(1'b0),
		.PACKAGEPIN(clock_in),
		.PLLOUTCORE(clock_out)
		);
`endif

endmodule
