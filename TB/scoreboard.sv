
class scoreboard extends uvm_component;

  `uvm_component_utils(scoreboard)
			

	uvm_tlm_analysis_fifo #(apb_xtn)apb2sb;
	uvm_tlm_analysis_fifo #(spi_xtn)spi2sb;
		
	apb_xtn axtn;
	spi_xtn sxtn;

	//transaction for covergroup
	
	apb_xtn apb_xtn_cov;
	spi_xtn spi_xtn_cov;



	

		
		covergroup apb_covergroup;
			option.per_instance =1;//VCS
			Reset : coverpoint apb_xtn_cov.PRESETn{bins rst = {0,1};}
			Address : coverpoint apb_xtn_cov.PADDR{bins addr[] = {0,1,2,3,5};}
			Selx : coverpoint apb_xtn_cov.PSEL{bins sel = {0,1};}
			Enable : coverpoint apb_xtn_cov.PENABLE{bins en = {0,1};}//en local variable
			Write : coverpoint apb_xtn_cov.PWRITE{bins wr[] = {0,1};}
			Ready : coverpoint apb_xtn_cov.PREADY{bins rdy = {0,1};}
			Error : coverpoint apb_xtn_cov.PSLVERR{bins err = {0,1};}
			Wdata : coverpoint apb_xtn_cov.PWDATA{bins wdata_low = {[8'h00 : 8'h7f]};
								    bins	wdata_high = {[8'h80 : 8'hff]};}
			Rdata : coverpoint apb_xtn_cov.PRDATA{bins rdata_low = {[8'h00 : 8'h7f]};
								bins	rdata_high ={[8'h80 : 8'hff]};}
			Selx_Enable : cross Selx,Enable;
			Selx_Enable_Ready : cross Selx,Enable,Ready;
                endgroup

		covergroup spi_covergroup;
			option.per_instance =1;//VCS
			Slave_Select : coverpoint spi_xtn_cov.SS{bins sls = {0,1};}
			miso_data : coverpoint spi_xtn_cov.MISO{bins miso_low = {[8'h00 : 8'h7f]};
								 bins	miso_high ={[8'h80 : 8'hff]};}
			mosi_data : coverpoint spi_xtn_cov.MOSI{bins mosi_low = {[8'h00 : 8'h7f]};
								bins	mosi_high ={[8'h80 : 8'hff]};}
		  endgroup

			

		
  		function new(string name, uvm_component parent);
    			super.new(name, parent);
			apb2sb =new("apb2sb",this);
			spi2sb = new("spi2sb",this);
			spi_covergroup = new();
			apb_covergroup = new();
				
		 endfunction

			

			
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		fork
			begin
				forever
				begin
					apb2sb.get(axtn);
					apb_xtn_cov = new axtn;
					apb_covergroup.sample();
						$display("=========================(COVERAGE)============================================ ");
						$display("Apb_Coverage = %0.2f", apb_covergroup.get_coverage());
						$display("=========================(COVERAGE DONE)============================================ ");
				

					
					`uvm_info(get_type_name(),$sformatf("Scoreboard XTN APB = %s",axtn.sprint()),UVM_LOW)	
						compare_of_reception(axtn);


				end
			end
			begin
				forever
				begin			
					spi2sb.get(sxtn);
					spi_xtn_cov = new sxtn;
					spi_covergroup.sample();
					$display("=========================COVERAGE)============================================ ");
					$display("Apb_Coverage = %0.2f", spi_covergroup.get_coverage());
					$display("=========================(COVERAGE DONE)============================================ ");

					`uvm_info(get_type_name(),$sformatf("Scoreboard XTN SPI = %s",sxtn.sprint()),UVM_LOW)	
									compare_of_transmission(axtn);

				end

			end
		join
	endtask

		task compare_of_transmission(apb_xtn axtn);

		wait(axtn != null);
		wait(sxtn != null);
			

		if((axtn.PWRITE)&&(axtn.PADDR == 3'b101)) //whenPW =1 then we write in data regi
			begin
				$display("=================================== SCORE BOARD REPORT TO CHECK MOSI ============================");
				if(axtn.PWDATA == sxtn.MOSI)
					`uvm_info(get_type_name(),"MOSI COMPARE SUCCESSFUL",UVM_LOW)
				else
					`uvm_info(get_type_name(),"MOSI COMPARE IS FAILED",UVM_LOW)
	
				`uvm_info(get_type_name(),$sformatf("Scoreboard : \n AXTN = \n%s,\n SXTN = \n%s",axtn.sprint(),sxtn.sprint()),UVM_LOW)

				$display("=================================================================================================");
		
			end
		endtask

	
		
		task compare_of_reception(apb_xtn axtn);
			wait(axtn != null);
			//wait(sxtn != null);
			

		if(!(axtn.PWRITE)&&(axtn.PADDR == 3'b101)) //whenPW =1 then we write in data regi
			begin
				$display("=================================== SCORE BOARD REPORT TO CHECK MISO ============================");
				if(axtn.PRDATA == sxtn.MISO)
				//	`uvm_info(get_type_name(),$sformatf("MISO PASS ------ : \n AXTN = \n%s,\n SXTN = \n%s",axtn.sprint(),sxtn.sprint()),UVM_LOW)

					`uvm_info(get_type_name(),"MISO COMPARE SUCCESSFUL",UVM_LOW)
				else
					`uvm_info(get_type_name(),"MISO COMPARE IS FAILED",UVM_LOW)
				//	`uvm_info(get_type_name(),$sformatf("MISO FAILS ------- : \n AXTN = \n%s,\n SXTN = \n%s",axtn.sprint(),sxtn.sprint()),UVM_LOW)

				`uvm_info(get_type_name(),$sformatf("Scoreboard : \n AXTN = \n%s,\n SXTN = \n%s",axtn.sprint(),sxtn.sprint()),UVM_LOW)

				$display("========================================************================================");
		
			end
		endtask
			

endclass

