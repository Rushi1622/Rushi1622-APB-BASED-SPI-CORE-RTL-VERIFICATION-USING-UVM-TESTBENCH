class apb_driver extends uvm_driver #(apb_xtn);

  `uvm_component_utils(apb_driver)
	
	apb_config apb_conh;
	virtual apb_if.APB_DRV_CB vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

	function void build_phase(uvm_phase phase);

	if(!uvm_config_db #(apb_config)::get(this,"","apb_config",apb_conh))
	`uvm_fatal("CONFIG","cannot get() apb_conh from apb_config")  	
		
	endfunction 
	

	//connect_phase for virtual to static interface connection
	function void connect_phase(uvm_phase phase);
	vif = apb_conh.vif;
	endfunction

task run_phase(uvm_phase phase);
	//reset the design active low
		@(vif.apb_drv_cb);
		vif.apb_drv_cb.PRESETn<=1'b0;
		repeat(2)
		@(vif.apb_drv_cb);
		vif.apb_drv_cb.PRESETn<=1'b1;	
		$display("reset working");

	forever
		begin
		seq_item_port.get_next_item(req);
		send_to_dut(req);
		seq_item_port.item_done();
		end
endtask
		
	task send_to_dut(apb_xtn xtn);
		
		//setup phase PSEL=1 and PENABLE=0
		@(vif.apb_drv_cb);
		//vif.apb_drv_cb.PRESETn <= 1'b1;
		vif.apb_drv_cb.PADDR <= xtn.PADDR;
		vif.apb_drv_cb.PWRITE <= xtn.PWRITE;
		vif.apb_drv_cb.PSEL <= 1'b1;
		vif.apb_drv_cb.PENABLE <= 1'b0;
		$display("setup phase working");
		
		//check for PWRITE if it true then data will send 
		//else receive data PRDATA on next cycle 
		if(xtn.PWRITE)
		vif.apb_drv_cb.PWDATA <= xtn.PWDATA;
		$display("checking pwrite true to send data");
		//INITIAL ENABLE PHASE PENABLE= 1 and wait for PREADY to become high 
		
		@(vif.apb_drv_cb);
		vif.apb_drv_cb.PENABLE <= 1'b1;

		//@(vif.apb_drv_cb); // reprents next cycle		
		wait(vif.apb_drv_cb.PREADY);//wait for pready 
		if(!xtn.PWRITE)begin
			xtn.PRDATA = vif.apb_drv_cb.PRDATA;
			end
		$display("enable gettig high and waiting for pready to go high");
		`uvm_info(get_type_name(),$sformatf("The transaction send to dut is \n %s",xtn.sprint()),UVM_LOW)

        	@(vif.apb_drv_cb);
		//idle phase
		vif.apb_drv_cb.PSEL <= 1'b0;
		vif.apb_drv_cb.PENABLE <=1'b0;
		//@(vif.apb_drv_cb);
	endtask	
	

	
endclass
