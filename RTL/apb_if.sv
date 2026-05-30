interface apb_if (input bit clk);
	bit PCLK;
	
	logic PRESETn,PSEL,PENABLE,PWRITE,PREADY,PSLVERR;
	logic [2:0]PADDR;
	logic [7:0]PWDATA,PRDATA;
	
	assign PCLK = clk;

	clocking apb_drv_cb @(posedge PCLK);
		default input #1 output #1 ;
		output PRESETn,PSEL,PENABLE,PWRITE,PADDR,PWDATA;
		input PREADY,PSLVERR,PRDATA;
	endclocking
	
	
	clocking apb_mon_cb @(posedge PCLK);
		default input #1 output #1 ;
		input PRESETn,PSEL,PENABLE,PWRITE,PADDR,PWDATA;
		input PREADY,PSLVERR,PRDATA;
	endclocking
	
	modport APB_DRV_CB (clocking apb_drv_cb);
	modport APB_MON_CB (clocking apb_mon_cb);



	//................ASSERTIONS...........................
	//=====================================================
	
	property signal_stable;
		@(posedge clk) $rose(PSEL) |-> ($stable(PWRITE) && $stable(PADDR) && $stable(PWDATA)) until PREADY[->1];
	endproperty

	property penable_stable;
		@(posedge clk) $rose(PENABLE) |-> ($stable(PSEL) && $stable(PENABLE)) until PREADY[->1];
	endproperty
	
	property address_reserved;
		@(posedge clk) PSEL |-> ((PADDR != 3'b100) || (PADDR != 3'b110) || (PADDR != 3'b111));
	endproperty

	property psel_to_pready;
		@(posedge clk) (PSEL && PENABLE)|-> ##[0:$]PREADY;
	endproperty

	property penable_deassert;
		@(posedge clk) (!PSEL) |-> (!PENABLE);
	endproperty

	property valid_write_data_transfer;
		@(posedge clk) (PSEL && PENABLE && PWRITE) |-> (PWDATA != 'hx);
	endproperty

	property valid_read_data;
		@(posedge clk) (PSEL && PENABLE && !PWRITE) |->(PRDATA != 'hx);
	endproperty

	property pready_low_at_start;
		@(posedge clk) (PSEL && !PENABLE) |-> (!PREADY);
	endproperty

	property pready_dasserted;
		@(posedge clk)(!PSEL && !PENABLE) |-> (!PREADY);
	endproperty

	signalstable:assert property(signal_stable)
			$display("signal_stable pass");
		else
			$display("signal_stable fail");

	penablestable:assert property(penable_stable)
			$display("penable_stable pass");
		else
			$display("penable_stable fail");

	addressreserved:assert property(address_reserved)
			$display("address_reserved pass");
		else
			$display("address_reserved fail");

	pseltopready:assert property(psel_to_pready)
			$display("psel_to_pready pass");
		else
			$display("psel_to_pready fail");
	
	penabledeassert:assert property(penable_deassert)
			$display("penable_deassert pass");
		else
			$display("penable_deassert fail");

	validwritedata_transfer:assert property(valid_write_data_transfer)
			$display("valid_write_data_transfer pass");
		else
			$display("valid_write_data_transfer fail");

	validreaddata:assert property(valid_read_data)
			$display("valid_read_data pass");
		else
			$display("valid_read_data fail");

	preadylowatstart:assert property(pready_low_at_start)
			$display("pready_low_at_start pass");
		else
			$display("pready_low_at_start fail");

	preadydasserted:assert property(pready_dasserted)
			$display("pready_dasserted pass");
		else
			$display("pready_dasserted fail");
		
	
endinterface 

	

