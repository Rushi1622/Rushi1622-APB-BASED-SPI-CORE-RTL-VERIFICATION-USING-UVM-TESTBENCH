class spi_sequence_base extends uvm_sequence #(spi_xtn);

  `uvm_object_utils(spi_sequence_base)

  function new(string name="spi_sequence_base");
    super.new(name);
  endfunction
endclass

class spi_sequence extends spi_sequence_base;
	
`uvm_object_utils(spi_sequence)

  function new(string name="spi_sequence");
    super.new(name);
  endfunction
	
	task body();

		repeat(1)
			begin
			req = spi_xtn :: type_id :: create("req");
	
			start_item(req);
			assert(req.randomize());
			
			finish_item(req);
			$display("**************************************SPI SEQUENCE*******************************");
			//req.print();
					
			end
	endtask


endclass




