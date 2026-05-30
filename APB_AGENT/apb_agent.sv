class apb_agent extends uvm_agent;

  `uvm_component_utils(apb_agent)
  
 apb_config apb_conh;

  apb_sequencer seqr;
  apb_driver    drv;
  apb_monitor   mon;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

	if(!uvm_config_db #(apb_config)::get(this,"","apb_config",apb_conh))
	`uvm_fatal("CONFIG","cannot get() apb_conh from apb_config")  
    		mon=apb_monitor::type_id::create("mon",this);	
	if(apb_conh.is_active==UVM_ACTIVE)
		begin
		drv=apb_driver::type_id::create("drv",this);
		seqr=apb_sequencer::type_id::create("seqr",this);
		end
  endfunction


 

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    drv.seq_item_port.connect(seqr.seq_item_export);
  endfunction

endclass
