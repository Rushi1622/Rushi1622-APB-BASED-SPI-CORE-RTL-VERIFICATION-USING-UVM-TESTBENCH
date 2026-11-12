class spi_driver extends uvm_driver #(spi_xtn);

  `uvm_component_utils(spi_driver)
	
   	  spi_config spi_conh;
	  virtual spi_if.SPI_DRV_CB vif;

	
	bit [7:0] ctrl;//ctrtl taken to change cphase cpol values
	bit cphase,cphol,lsb;



  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
	if(!uvm_config_db #(spi_config)::get(this,"","spi_config",spi_conh))
	`uvm_fatal("CONFIG","cannot get() spi_conh from spi_config")  	
		
	endfunction 
	
	
	//connect_phase for virtual to static interface connection
	function void connect_phase(uvm_phase phase);
	vif = spi_conh.vif;
	endfunction

	
 	 task run_phase (uvm_phase phase);
		
		forever begin
		seq_item_port.get_next_item(req);
		drive_to_dut(req);
		seq_item_port.item_done();
		end
	 endtask


	task drive_to_dut(spi_xtn xtn);
		
			//get the ctrl from the test
				if(!uvm_config_db #(bit[7:0])::get(this,"","bit[7:0]",ctrl))
				   `uvm_fatal(get_type_name(),"Get method of ctrl are failed from test")
			$display("ctrl=%0b",ctrl);
			cphase = ctrl[2];
			cphol = ctrl[3];
			lsb = ctrl[0];

		//lsb cphase=0 cpol=0 data get immediatly 
		//@(vif.spi_drv_cb);
		$display("*******************************Before SS**********************************");
		wait(!vif.spi_drv_cb.SS);
		$display("*******************************After SS***********************************");
		//$display("Time=%0t SS=%0b SCLK=%0b", $time, vif.spi_drv_cb.SS, vif.spi_drv_cb.SCLK);
		begin
			if(lsb)
			begin
				$display("lsb %d",lsb);
   				if((!cphol) && (!cphase))
				begin
					$display("am in");
	       				vif.spi_drv_cb.MISO <= xtn.MISO[0];
							for(int i=1;i<=7;i++)
							begin
								$display("inside loop");
								@(negedge vif.spi_drv_cb.SCLK);
								vif.spi_drv_cb.MISO <= xtn.MISO[i];
							end
						end
				
						// cphase=0 cphol 1  == mode 2
						else if((!cphase) && (cphol))
						begin
	       						vif.spi_drv_cb.MISO <= xtn.MISO[0];
							for(int i=1;i<=7;i++)
							begin
								@(posedge vif.spi_drv_cb.SCLK);
								vif.spi_drv_cb.MISO <= xtn.MISO[i];
							end
						end
						
						// cphase=1 cphol 0  == mode 1  
						else if((cphase) && (!cphol))
						begin
	       			                //vif.spi_drv_cb.miso <= xtn.miso[0];//we declared in loop beacuse we dont want data on same clock
							for(int i=0;i<=7;i++)
							begin
								@(posedge vif.spi_drv_cb.SCLK);
								vif.spi_drv_cb.MISO <= xtn.MISO[i];
							end
						end
						
						// cphase=1 cphol 1  == mode 3 
						else if((cphase) && (cphol))
						begin
	       			                //vif.spi_drv_cb.miso <= xtn.miso[0];//we declared in loop beacuse we dont want on same clock
							for(int i=0;i<=7;i++)
							begin
								@(negedge vif.spi_drv_cb.SCLK);
								vif.spi_drv_cb.MISO <= xtn.MISO[i];
							end
						end
					end
				else
					//msb 
					begin
						//// cphase=0 cphol 1  == mode 0
						if((!cphase) && (!cphol))
						begin
	       						vif.spi_drv_cb.MISO <= xtn.MISO[7];
							for(int i=6;i>=0;i--)
							begin
								@(negedge vif.spi_drv_cb.SCLK);
								vif.spi_drv_cb.MISO <= xtn.MISO[i];
							end
						end
				
						// cphase=0 cphol 1  == mode 2
						else if((!cphase) && (cphol))
						begin
	       						vif.spi_drv_cb.MISO <= xtn.MISO[7];
							for(int i=6;i>=0;i--)
							begin
								@(posedge vif.spi_drv_cb.SCLK);
								vif.spi_drv_cb.MISO <= xtn.MISO[i];
							end
						end
						
						// cphase=1 cphol 0  == mode 1  
						else if((cphase) && (!cphol))
						begin
	       			                //vif.spi_drv_cb.miso <= xtn.miso[0];//we declared in loop beacuse we dont want on same clock
							for(int i=7;i>=0;i--)
							begin
								@(posedge vif.spi_drv_cb.SCLK);
								vif.spi_drv_cb.MISO <= xtn.MISO[i];
							end
						end
						
						// cphase=1 cphol 1  == mode 3 
						else if((cphase) && (cphol))
						begin
	       			                //vif.spi_drv_cb.miso <= xtn.miso[0];//we declared in loop beacuse we dont want on same clock
							for(int i=7;i>=0;i--)
							begin
								 @(negedge vif.spi_drv_cb.SCLK);
								vif.spi_drv_cb.MISO <= xtn.MISO[i];
							end
						end
			  		end
			
					
		        	end	
			
				`uvm_info(get_type_name(),$sformatf("SPI_XTN == \n %s",xtn.sprint()),UVM_LOW)							
		endtask

				
endclass

