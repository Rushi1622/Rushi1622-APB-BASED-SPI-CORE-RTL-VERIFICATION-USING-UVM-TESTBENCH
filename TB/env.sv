class env extends uvm_env;
	`uvm_component_utils(env)

		env_config env_configh;

		//2 agent_tops and scoreboard intances
		apb_agent_top apb_agenth;
		spi_agent_top spi_agenth;
		scoreboard sb;
	
		//both configurations
		apb_config apb_conh; 
		spi_config spi_conh; 	

       	function new(string name = "env",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	       //getcon figuration from test
		if(!uvm_config_db #(env_config)::get(this,"","env_config",env_configh))
			`uvm_fatal("EVN_CONFIG","config not getting from test")

		//setting for agents

		//for apb_agent_top
	        if(env_configh.has_apb_agent)begin
			   //apb_conh = env_configh.apb_conh;
			uvm_config_db#(apb_config)::set(this,"*","apb_config",env_configh.apb_conh);
			apb_agenth = apb_agent_top :: type_id :: create("apb_agenth",this);
		end
		//for_spi_agent_top
		if(env_configh.has_spi_agent)begin
			   //apb_conh = env_configh.apb_conh;
			uvm_config_db#(spi_config)::set(this,"*","spi_config",env_configh.spi_conh);
			spi_agenth = spi_agent_top :: type_id :: create("spi_agenth",this);
		end
		//for scoreboard
		if(env_configh.has_scoreboard)
		sb = scoreboard :: type_id :: create("sb",this);

	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		apb_agenth.apb_agth.mon.apb_ap.connect(sb.apb2sb.analysis_export);
		spi_agenth.spi_agth.mon.spi_ap.connect(sb.spi2sb.analysis_export);
	endfunction
endclass				
