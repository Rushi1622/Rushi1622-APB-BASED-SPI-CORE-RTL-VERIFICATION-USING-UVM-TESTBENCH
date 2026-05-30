package apb_spi_pkg;

	import uvm_pkg::*;
	`include "uvm_macros.svh" 
	
  // Config for spi and apb
	
	
 
  `include "spi_config.sv"
  `include "apb_config.sv"
    `include "env_config.sv"  ///add here env first these both 

  // Transaction
  `include "spi_xtn.sv"
  `include "apb_xtn.sv"

  
  // SEQUENCE RELATED
  

  `include "spi_sequencer.sv"
  `include "apb_sequencer.sv"

  `include "spi_sequence.sv"
  
  `include "apb_sequence.sv"

  
  // COMPONENTS
  

  `include "spi_driver.sv"
  `include "spi_monitor.sv"
 
  `include "apb_driver.sv"
  `include "apb_monitor.sv"


  //------------------------------------------
  // AGENT
  //------------------------------------------

  `include "spi_agent.sv"
  `include "apb_agent.sv"

	
  `include "spi_agent_top.sv"	
  `include "apb_agent_top.sv"


  //------------------------------------------
  // ENV + SCOREBOARD
  //------------------------------------------

  `include "scoreboard.sv"
  
  `include "env.sv"

  //------------------------------------------
  // TEST LAST
  //------------------------------------------

  `include "test.sv"


endpackage
