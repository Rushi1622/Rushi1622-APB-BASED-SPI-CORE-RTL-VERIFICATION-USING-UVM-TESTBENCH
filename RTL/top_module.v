module SPI_Top_Block(
  input PCLK,PRESET_n,PWRITE,PSEL,PENABLE,miso,
  input [2:0]PADDR,
  input [7:0]PWDATA,
  output ss,sclk,spi_interrupt_request,mosi,PREADY,PSLVERR,
  output [7:0]PRDATA);


  wire [1:0] spi_mode;
  wire [2:0] sppr,spr;
  wire [7:0] data_miso,data_mosi;
  wire [11:0] BaudRateDivisor;


  // Instantiate the Baud_Rate_Generator RTL module with named base
  
	Baud_Rate_Generator module_1(
		 PCLK, 
		 PRESET_n, 
		 spiswai, 
		 cpol, 
		 cpha, 
		 ss, 
		 sppr, 
		 spr, 
		 spi_mode, 
		 miso_receive_sclk, 
		 miso_receive_sclk0, 
		 mosi_send_sclk, 
		 mosi_send_sclk0, 
		 sclk, 
		 BaudRateDivisor
	);


  // Instantiate the Slave_Select_Generator RTL module with named base
  
	Slave_Select_Generator module_2(
		 PCLK, 
		 PRESET_n, 
		 mstr, 
		 send_data, 
		 spiswai, 
		 spi_mode, 
		 BaudRateDivisor, 
		 ss, 
		 receive_data, 
		 tip
	);

  
  // Instantiate the SPI_Shifter RTL module with named base

  
	SPI_Shifter module_3(
		 PCLK, 
		 PRESET_n, 
		 ss, 
		 send_data, 
		 lsbfe, 
		 cpol, 
		 cpha, 
		 receive_data, 
		 miso, 
		 miso_receive_sclk, 
		 mosi_send_sclk, 
		 miso_receive_sclk0, 
		 mosi_send_sclk0, 
		 data_mosi, 
		 mosi, 
		 data_miso
	);


  // Instantiate the APB_Slave_Interface RTL module with named base
  
	APB_Slave_Interface module_4(
		 PCLK, 
		 PRESET_n, 
		 PWRITE, 
		 PSEL, 
		 PENABLE, 
		 ss, 
		 receive_data, 
		 tip, 
		 PADDR, 
		 PWDATA, 
		 data_miso, 
		 mstr, 
		 cpol, 
		 cpha, 
		 lsbfe, 
		 spiswai, 
		 PREADY, 
		 PSLVERR, 
		 spi_mode, 
		 send_data, 
		 spi_interrupt_request, 
		 data_mosi, 
		 sppr, 
		 spr, 
		 PRDATA
	);

endmodule
