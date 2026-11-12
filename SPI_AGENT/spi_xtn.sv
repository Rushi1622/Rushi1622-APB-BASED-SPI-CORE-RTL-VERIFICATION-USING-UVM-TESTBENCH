class spi_xtn extends uvm_sequence_item;

  `uvm_object_utils(spi_xtn)
	bit SS;
	bit [7:0] MOSI;//confirm bits
	rand bit[7:0] MISO;
	

  function new(string name = "spi_xtn");
    super.new(name);
  endfunction

	
	function void do_print (uvm_printer printer);
		super.do_print(printer);
	printer.print_field("SS",this.SS,1,UVM_BIN);
	printer.print_field("MOSI",this.MOSI,8,UVM_BIN);
	printer.print_field("MISO",this.MISO,8,UVM_BIN);

	endfunction
	


endclass

