module top;

	import uvm_pkg::*;
	`include "uvm_macros.svh"
	import apb_spi_pkg::*;
	
	
		bit clk;
		always #5 clk = ~clk;

		apb_if avif(clk);
		spi_if svif(clk);

		/*top_module dut(avif.clk,
			       avif.preset_n, 
			       avif.paddr_i, 
			       avif.pwrite_i, 
			       avif.psel_i, 
			       avif.penable_i,
			       avif.pwdata_i, 
			       avif.prdata_o, 
			       avif.pready_o, 
			       avif.pslverr_o, 
		               svif.sclk_o, 
			       svif.mosi_o, 
			       svif.ss_o,
			       svif.miso_i,
			       svif.spi_int_req_o);*/
		
		SPI_Top_Block dut(
    			.PCLK        (avif.clk),
   			.PRESET_n    (avif.PRESETn),
    			.PADDR   (avif.PADDR),
    			.PWRITE   (avif.PWRITE),
   			.PSEL    (avif.PSEL),
    			.PENABLE   (avif.PENABLE),
    			.PWDATA    (avif.PWDATA),
    			.PRDATA    (avif.PRDATA),
    			.PREADY    (avif.PREADY),
   			.PSLVERR   (avif.PSLVERR),

    			.sclk     (svif.SCLK),  
   			 .mosi      (svif.MOSI),
    			.ss       (svif.SS),
    			.miso      (svif.MISO)
    			//.spi_int_req_o (svif.spi_int_req)
);

		initial begin
			clk=1'b0;
	
			uvm_config_db #(virtual apb_if)::set(null,"*","apb_if",avif);
			uvm_config_db #(virtual spi_if)::set(null,"*","spi_if",svif);

			
			run_test();


		end
endmodule
