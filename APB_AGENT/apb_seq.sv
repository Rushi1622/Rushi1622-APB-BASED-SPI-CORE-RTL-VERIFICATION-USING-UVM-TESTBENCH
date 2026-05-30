class apb_sequence extends uvm_sequence#(apb_xtn);
	`uvm_object_utils(apb_sequence)
	function new (string name = "apb_sequece");
		super.new(name);
	endfunction
endclass

	
	
class cpol0_cphase0_lsb extends apb_sequence;
	`uvm_object_utils(cpol0_cphase0_lsb)
	bit[7:0]ctrl;
	function new (string name = "cpol0_cphase0_lsb");
		super.new(name);
	endfunction

	task body();
	if(!uvm_config_db #(bit[7:0])::get(null,get_full_name(),"bit[7:0]",ctrl)) //no hierachy present thats why null + object_will not 
		`uvm_fatal("APB_SEQ","ctrl config not get !!")
	
		repeat(1)
			begin
			req = apb_xtn :: type_id :: create("req");
	
			//CR1
			start_item(req);
			assert(req.randomize()with {
					PRESETn == 1'b1;
					PWRITE == 1'b1;
					PADDR  == 3'b000;
					PWDATA == ctrl;});
			finish_item(req);
			//req.print();

			//CR2
			start_item(req);
			assert(req.randomize()with {
					PRESETn == 1'b1;
					PWRITE == 1'b1;
					PADDR  == 3'b001;
					PWDATA == 8'b0001_1001;});//same for 
			finish_item(req);
			//req.print();
	
			//BR
			start_item(req);
			assert(req.randomize()with {
					PRESETn == 1'b1;
					PWRITE == 1'b1;
					PADDR  == 3'b010;
					PWDATA == 8'b0000_0001;});
			finish_item(req);
			//req.print();

			//DR
			start_item(req);
			assert(req.randomize()with {
					PRESETn == 1'b1;
					PWRITE == 1'b1;
					PADDR  == 3'b101;});	
			finish_item(req);
			$display("*************************************APB TRANSACTION**********************************");
			req.print();

		end
	endtask
endclass


class cpol0_cphase1_lsb extends apb_sequence;
	`uvm_object_utils(cpol0_cphase1_lsb)
	bit [7:0]ctrl;
	function new (string name = "cpol0_cphase1_lsb");
		super.new(name);
	endfunction

	task body();
	if(!uvm_config_db #(bit[7:0])::get(null,get_full_name(),"bit[7:0]",ctrl)) //no hierachy present thats why null + object_will not 
		`uvm_fatal("APB_SEQ","ctrl config not get !!")	
	
		repeat(1)
			begin
			req = apb_xtn :: type_id :: create("req");
	
			//CR1
			start_item(req);
			assert(req.randomize()with {
					PRESETn == 1'b1;
					PWRITE == 1'b1;
					PADDR  == 3'b000;
					PWDATA == ctrl;});
			finish_item(req);
			
			//CR2
			start_item(req);
			assert(req.randomize()with {
					PRESETn == 1'b1;
					PWRITE == 1'b1;
					PADDR  == 3'b001;
					PWDATA == 8'b0001_1001;});
			finish_item(req);
	
			//BR
			start_item(req);
			assert(req.randomize()with {
					PRESETn == 1'b1;
					PWRITE == 1'b1;
					PADDR  == 3'b010;
					PWDATA == 8'b0001_0001;});
			finish_item(req);
		
			//DR
			start_item(req);
			assert(req.randomize()with {
					PRESETn == 1'b1;
					PWRITE == 1'b1;
					PADDR  == 3'b101;});
			finish_item(req);
		
		
		end
	endtask
endclass

class cpol1_cphase0_lsb extends apb_sequence;
	`uvm_object_utils(cpol1_cphase0_lsb)
	bit [7:0]ctrl;
	function new (string name = "cpol1_cphase0_lsb");
		super.new(name);
	endfunction

	task body();
             	if(!uvm_config_db #(bit[7:0])::get(null,get_full_name(),"bit[7:0]",ctrl)) //no hierachy present thats why null + object_will not 
		`uvm_fatal("APB_SEQ","ctrl config not get !!")
	
		repeat(1)
			begin
			req = apb_xtn :: type_id :: create("req");
	
			//CR1
			start_item(req);
			assert(req.randomize()with {
					PRESETn == 1'b1;
					PWRITE == 1'b1;
					PADDR  == 3'b000;
					PWDATA == ctrl;});
			finish_item(req);
			
			//CR2
			start_item(req);
			assert(req.randomize()with {
					PRESETn == 1'b1;
					PWRITE == 1'b1;
					PADDR  == 3'b001;
					PWDATA == 8'b0001_1001;});
			finish_item(req);
	
			//BR
			start_item(req);
			assert(req.randomize()with {
					PRESETn == 1'b1;
					PWRITE == 1'b1;
					PADDR  == 3'b010;
					PWDATA == 8'b0001_0001;});
			finish_item(req);
		
			//DR
			start_item(req);
			assert(req.randomize()with {
					PRESETn == 1'b1;
					PWRITE == 1'b1;
					PADDR  == 3'b101;});
			finish_item(req);
		
		
		end
	endtask
endclass

class cpol1_cphase1_lsb extends apb_sequence;
	`uvm_object_utils(cpol1_cphase1_lsb)
	bit [7:0]ctrl;

	function new (string name = "cpol1_cphase1_lsb");
		super.new(name);
	endfunction

	task body();
		if(!uvm_config_db #(bit[7:0])::get(null,get_full_name(),"bit[7:0]",ctrl)) //no hierachy present thats why null + object_will not 
		`uvm_fatal("APB_SEQ","ctrl config not get !!")	
		repeat(1)
			begin
			req = apb_xtn :: type_id :: create("req");
	
			//CR1
			start_item(req);
			assert(req.randomize()with {
					PRESETn == 1'b1;
					PWRITE == 1'b1;
					PADDR  == 3'b000;
					PWDATA == ctrl;});
			finish_item(req);
			
			//CR2
			start_item(req);
			assert(req.randomize()with {
					PRESETn == 1'b1;
					PWRITE == 1'b1;
					PADDR  == 3'b001;
					PWDATA == 8'b0001_1001;});
			finish_item(req);
	
			//BR
			start_item(req);
			assert(req.randomize()with {
					PRESETn == 1'b1;
					PWRITE == 1'b1;
					PADDR  == 3'b010;
					PWDATA == 8'b0001_0001;});
			finish_item(req);
		
			//DR
			start_item(req);
			assert(req.randomize()with {
					PRESETn == 1'b1;
					PWRITE == 1'b1;
					PADDR  == 3'b101;});
			finish_item(req);
		
		
		end
	endtask
endclass
//MSB FIRST
class cpol0_cphase0_msb extends apb_sequence;
	`uvm_object_utils(cpol0_cphase0_msb)
	bit [7:0]ctrl;
	function new (string name = "cpol0_cphase0_msb");
		super.new(name);
	endfunction

	task body();
			if(!uvm_config_db #(bit[7:0])::get(null,get_full_name(),"bit[7:0]",ctrl)) //no hierachy present thats why null + object_will not 
		`uvm_fatal("APB_SEQ","ctrl config not get !!")	
		repeat(1)
			begin
			req = apb_xtn :: type_id :: create("req");
	
			//CR1
			start_item(req);
			assert(req.randomize()with {
					PRESETn == 1'b1;
					PWRITE == 1'b1;
					PADDR  == 3'b000;
					PWDATA == ctrl;});
			finish_item(req);
			
			//CR2
			start_item(req);
			assert(req.randomize()with {
					PRESETn == 1'b1;
					PWRITE == 1'b1;
					PADDR  == 3'b001;
					PWDATA == 8'b0001_1001;});
			finish_item(req);
	
			//BR
			start_item(req);
			assert(req.randomize()with {
					PRESETn == 1'b1;
					PWRITE == 1'b1;
					PADDR  == 3'b010;
					PWDATA == 8'b0001_0001;});
			finish_item(req);
		
			//DR
			start_item(req);
			assert(req.randomize()with {
					PRESETn == 1'b1;
					PWRITE == 1'b1;
					PADDR  == 3'b101;});
			finish_item(req);
		
		
		end
	endtask
endclass

class cpol0_cphase1_msb extends apb_sequence;
	`uvm_object_utils(cpol0_cphase1_msb)
	bit [7:0]ctrl;
	function new (string name = "cpol0_cphase1_msb");
		super.new(name);
	endfunction

	task body();
			if(!uvm_config_db #(bit[7:0])::get(null,get_full_name(),"bit[7:0]",ctrl)) //no hierachy present thats why null + object_will not 
		`uvm_fatal("APB_SEQ","ctrl config not get !!")	
		repeat(1)
			begin
			req = apb_xtn :: type_id :: create("req");
	
			//CR1
			start_item(req);
			assert(req.randomize()with {
					PRESETn == 1'b1;
					PWRITE == 1'b1;
					PADDR  == 3'b000;
					PWDATA == ctrl;});
			finish_item(req);
			
			//CR2
			start_item(req);
			assert(req.randomize()with {
					PRESETn == 1'b1;
					PWRITE == 1'b1;
					PADDR  == 3'b001;
					PWDATA == 8'b0001_1001;});
			finish_item(req);
	
			//BR
			start_item(req);
			assert(req.randomize()with {
					PRESETn == 1'b1;
					PWRITE == 1'b1;
					PADDR  == 3'b010;
					PWDATA == 8'b0001_0001;});
			finish_item(req);
		
			//DR
			start_item(req);
			assert(req.randomize()with {
					PRESETn == 1'b1;
					PWRITE == 1'b1;
					PADDR  == 3'b101;});
			finish_item(req);
		
		
		end
	endtask
endclass

class cpol1_cphase0_msb extends apb_sequence;
	`uvm_object_utils(cpol1_cphase0_msb)
	bit [7:0]ctrl;
	function new (string name = "cpol1_cphase0_msb");
		super.new(name);
	endfunction

	task body();
			if(!uvm_config_db #(bit[7:0])::get(null,get_full_name(),"bit[7:0]",ctrl)) //no hierachy present thats why null + object_will not 
		`uvm_fatal("APB_SEQ","ctrl config not get !!")
		repeat(1)
			begin
			req = apb_xtn :: type_id :: create("req");
	
			//CR1
			start_item(req);
			assert(req.randomize()with {
					PRESETn == 1'b1;
					PWRITE == 1'b1;
					PADDR  == 3'b000;
					PWDATA == ctrl;});
			finish_item(req);
			
			//CR2
			start_item(req);
			assert(req.randomize()with {
					PRESETn == 1'b1;
					PWRITE == 1'b1;
					PADDR  == 3'b001;
					PWDATA == 8'b0001_1001;});
			finish_item(req);
	
			//BR
			start_item(req);
			assert(req.randomize()with {
					PRESETn == 1'b1;
					PWRITE == 1'b1;
					PADDR  == 3'b010;
					PWDATA == 8'b0001_0001;});
			finish_item(req);
		
			//DR
			start_item(req);
			assert(req.randomize()with {
					PRESETn == 1'b1;
					PWRITE == 1'b1;
					PADDR  == 3'b101;});
			finish_item(req);
		
		
		end
	endtask
endclass


class cpol1_cphase1_msb extends apb_sequence;
	`uvm_object_utils(cpol1_cphase1_msb)
	bit [7:0]ctrl;
	function new (string name = "cpol1_cphase1_msb");
		super.new(name);
	endfunction

	task body();
			if(!uvm_config_db #(bit[7:0])::get(null,get_full_name(),"bit[7:0]",ctrl)) //no hierachy present thats why null + object_will not 
		`uvm_fatal("APB_SEQ","ctrl config not get !!")	
		repeat(1)
			begin
			req = apb_xtn :: type_id :: create("req");
	
			//CR1
			start_item(req);
			assert(req.randomize()with {
					PRESETn == 1'b1;
					PWRITE == 1'b1;
					PADDR  == 3'b000;
					PWDATA == ctrl;});
			finish_item(req);
			
			//CR2
			start_item(req);
			assert(req.randomize()with {
					PRESETn == 1'b1;
					PWRITE == 1'b1;
					PADDR  == 3'b001;
					PWDATA == 8'b0001_1001;});
			finish_item(req);
	
			//BR
			start_item(req);
			assert(req.randomize()with {
					PRESETn == 1'b1;
					PWRITE == 1'b1;
					PADDR  == 3'b010;
					PWDATA == 8'b0001_0001;});
			finish_item(req);
		
			//DR
			start_item(req);
			assert(req.randomize()with {
					PRESETn == 1'b1;
					PWRITE == 1'b1;
					PADDR  == 3'b101;});
			finish_item(req);
		
		
		end
	endtask
endclass

class apb_rd_sequence extends apb_sequence;
	`uvm_object_utils(apb_rd_sequence)
	
	function new (string name = "apb_rd_sequence");
		super.new(name);
	endfunction

	task body();	
		repeat(1)
			begin
			req = apb_xtn :: type_id :: create("req");
	
			
			start_item(req);
			assert(req.randomize()with {
					PRESETn == 1'b1;
					PWRITE == 1'b0;
					PADDR  == 3'b101;//it will take this address 
					});
			finish_item(req);
			
		
		end
	endtask


endclass
