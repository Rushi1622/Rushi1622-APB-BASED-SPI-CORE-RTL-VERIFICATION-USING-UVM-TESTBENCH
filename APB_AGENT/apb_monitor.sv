class apb_monitor extends uvm_monitor;

  `uvm_component_utils(apb_monitor)
	
   	 virtual apb_if.APB_MON_CB vif; 
  	 apb_config apb_conh; // whatever config set in env we will get in lower level components  
         uvm_analysis_port #(apb_xtn)apb_ap;

 	 function new(string name, uvm_component parent);
   		 super.new(name, parent);
		apb_ap = new("apb_ap",this);
  	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		if(!uvm_config_db#(apb_config)::get(this,"","apb_config",apb_conh))
			`uvm_fatal("APB MON CONFIG"," config not getting from env to mon")
		
	endfunction
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		vif = apb_conh.vif;
	endfunction
	
		
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever
		collect_data();
	endtask

		
	task collect_data();
		apb_xtn xtn;
		xtn = apb_xtn :: type_id :: create("xtn");
				

	   // Wait for setup phase (PSEL=1, PENABLE=0) //no
	 	@(vif.apb_mon_cb);

		//wait for penable and ppready go high then sampling happen at that edge 
	   	wait((vif.apb_mon_cb.PREADY)&&(vif.apb_mon_cb.PENABLE));
	
		begin
			//capture the signal in setup phase
			xtn.PRESETn = vif.apb_mon_cb.PRESETn;
			xtn.PSEL = vif.apb_mon_cb.PSEL;
			xtn.PENABLE = vif.apb_mon_cb.PENABLE;
			xtn.PADDR = vif.apb_mon_cb.PADDR;
			xtn.PWRITE= vif.apb_mon_cb.PWRITE;
	       		xtn.PREADY = vif.apb_mon_cb.PREADY;
			xtn.PSLVERR = vif.apb_mon_cb.PSLVERR;

		end
		
	
		//setup to access phase  PREADY =1 and PENABLE =1

			
		//Access Phase	
		if(vif.apb_mon_cb.PWRITE)
			xtn.PWDATA = vif.apb_mon_cb.PWDATA;
		else
			xtn.PRDATA = vif.apb_mon_cb.PRDATA;
		
				

			`uvm_info(get_type_name(),$sformatf("APB MONITOR capture xtn \n %s",xtn.sprint()),UVM_LOW)
	
			//@(vif.apb_mon_cb)scoreboard is not signal-based hardware. It’s just a TLM (transaction-level) component.
			//xtn send to scoreboard
			apb_ap.write(xtn);
	
		//	@(vif.apb_mon_cb);// to run simulation for one more cycle =  delay
	endtask
	

endclass
