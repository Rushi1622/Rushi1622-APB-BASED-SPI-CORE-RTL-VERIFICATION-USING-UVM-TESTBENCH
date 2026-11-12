class spi_agent extends uvm_agent;

  `uvm_component_utils(spi_agent)
    spi_config spi_conh;
	 
  spi_sequencer seqr;
  spi_driver    drv;
  spi_monitor   mon;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

   
	if(!uvm_config_db #(spi_config)::get(this,"","spi_config",spi_conh))
	`uvm_fatal("CONFIG","cannot get() spi_conh from spi_config")  
    		mon=spi_monitor::type_id::create("mon",this);	
	if(spi_conh.is_active == UVM_ACTIVE)
		begin
		drv=spi_driver::type_id::create("drv",this);
		seqr=spi_sequencer::type_id::create("seqr",this);
		end
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    drv.seq_item_port.connect(seqr.seq_item_export); // connection
  endfunction

endclass

