class env_config extends uvm_object;

	`uvm_object_utils(env_config)
		//to control the agents and scoreboard directly
		bit has_spi_agent =1;
		bit has_apb_agent =1;
		bit has_scoreboard =1;

		//both agent config
		apb_config apb_conh; 
		spi_config spi_conh; 
		
		
		function new (string name = "env_config");
			super.new(name);
		endfunction
		
		
endclass 
