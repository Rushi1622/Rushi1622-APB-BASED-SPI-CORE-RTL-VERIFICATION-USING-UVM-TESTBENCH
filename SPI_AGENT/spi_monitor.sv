class spi_monitor extends uvm_monitor;

  `uvm_component_utils(spi_monitor)
		
		virtual spi_if.SPI_MON_CB vif;
		spi_config spi_conh;
		
		bit [7:0]ctrl;
		bit cphol;
		bit cphase;
		bit lsb;
	
		uvm_analysis_port #(spi_xtn)spi_ap;

 	 	function new(string name, uvm_component parent);
    			super.new(name, parent);
			spi_ap = new("spi_ap",this);
  	 	endfunction
	
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			if(!uvm_config_db#(spi_config)::get(this,"","spi_config",spi_conh))
				`uvm_fatal("SPI_MON","Not getting configuration from env")
		endfunction


	
		function void connect_phase(uvm_phase phase);
			vif = spi_conh.vif;
		endfunction

	
	
		task run_phase(uvm_phase phase);
			forever 
			collect_data();
		endtask

		
		task collect_data();
			spi_xtn xtn;
			xtn = spi_xtn ::type_id :: create("xtn");
	
			if(!uvm_config_db #(bit[7:0])::get(this,"","bit[7:0]",ctrl))
			`uvm_fatal(get_type_name(),"Get method of ctrl are failed from test")
			cphase = ctrl[2];
			cphol = ctrl[3];
			lsb =ctrl[0];
			
		wait(!vif.spi_mon_cb.SS)
		begin
	
			if(lsb)
				begin
					
					for(int i=0;i<=7;i++)
						begin
							if( (cphase && cphol) || ((!cphase) && (!cphol)) )
								begin
								//for(int i=0;i<=7;i++)
									@(posedge vif.spi_mon_cb.SCLK);
									xtn.MOSI[i] = vif.spi_mon_cb.MOSI;
									xtn.MISO[i] = vif.spi_mon_cb.MISO;
									xtn.SS = vif.spi_mon_cb.SS;
								end
							else
								begin
									@(negedge vif.spi_mon_cb.SCLK);
									xtn.MOSI[i] = vif.spi_mon_cb.MOSI;
									xtn.MISO[i] = vif.spi_mon_cb.MISO;
									xtn.SS = vif.spi_mon_cb.SS;
								end
						end
				end
					
			else
			 	begin
					//msb first
					for(int i=7;i>=0;i--)
						begin			       	
					//	for(int i=7;i>=0;i--)
							if((cphase && cphol)||((!cphase) && (!cphol)))
								begin
									@(posedge vif.spi_mon_cb.SCLK);
									xtn.MOSI[i] = vif.spi_mon_cb.MOSI;
									xtn.MISO[i] = vif.spi_mon_cb.MISO;
									xtn.SS = vif.spi_mon_cb.SS;
								end
				

						
				
					////	for(int i=7;i>=0;i--)
							else
								begin
									@(negedge vif.spi_mon_cb.SCLK);
									xtn.MOSI[i] = vif.spi_mon_cb.MOSI;
									xtn.MISO[i] = vif.spi_mon_cb.MISO;
									xtn.SS = vif.spi_mon_cb.SS;
								end
						end
				end
		end
			
			
			  	spi_ap.write(xtn);
				`uvm_info(get_type_name(),$sformatf("SPI MONITOR xtn data = \n%s",xtn.sprint()),UVM_LOW)
			
			//	@(vif.spi_mon_cb);
		endtask

		
endclass
