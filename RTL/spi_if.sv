interface spi_if (input bit clk);
	logic SCLK;
	
	logic SS;
	logic  MOSI; //spi communicate serially it transfer data bit by bit
	logic  MISO;	

	clocking spi_drv_cb @(posedge clk);
		default input #1 output #1 ;
		output MISO;
		input SS,SCLK,MOSI;
	endclocking
	
	
	clocking spi_mon_cb @(posedge clk);
		default input #1 output #1 ;
		input SCLK,SS,MOSI,MISO;
		endclocking
	
	modport SPI_DRV_CB (clocking spi_drv_cb);
	modport SPI_MON_CB (clocking spi_mon_cb);
	
endinterface 


