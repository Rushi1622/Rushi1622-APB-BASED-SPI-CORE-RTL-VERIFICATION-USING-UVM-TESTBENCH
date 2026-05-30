class apb_xtn extends uvm_sequence_item;

  `uvm_object_utils(apb_xtn)

	rand bit PRESETn;
	rand bit PWRITE;
	bit PSEL;
	bit PENABLE;
	rand bit[2:0]PADDR;
	rand bit [7:0]PWDATA;
	 bit [7:0]PRDATA;
	bit PREADY;
	bit PSLVERR;
	
 	 function new(string name = "apb_xtn");
   		 super.new(name);
 	 endfunction

	function void do_print (uvm_printer printer);
		super.do_print(printer);
	printer.print_field("PRESETn",this.PRESETn,1,UVM_BIN);
	printer.print_field("PWRITE",this.PWRITE,1,UVM_BIN);
	printer.print_field("PSEL",this.PSEL,1,UVM_BIN);
	printer.print_field("PENABLE",this.PENABLE,1,UVM_BIN);
	printer.print_field("PADDR",this.PADDR,3,UVM_BIN);
	printer.print_field("PWDATA",this.PWDATA,8,UVM_BIN);
	printer.print_field("PRDATA",this.PRDATA,8,UVM_BIN);
	printer.print_field("PREADY",this.PREADY,1,UVM_BIN);
	printer.print_field("PSLVERR",this.PSLVERR,1,UVM_BIN);
	endfunction
	

endclass
