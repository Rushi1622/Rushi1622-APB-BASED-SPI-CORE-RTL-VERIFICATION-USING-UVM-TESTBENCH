
class test extends uvm_test; 

        env envh;
	spi_config spi_conh;
	apb_config apb_conh;
	//apb_if avif;
	//spi_vif svif;
	env_config env_configh;
	bit has_spi_agent =1;
	bit has_apb_agent =1;
	bit has_scoreboard =1;


        `uvm_component_utils(test)

        function new(string name="test",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);
		env_configh = env_config :: type_id :: create("env_config",this);
		if(has_apb_agent)
			begin
			apb_conh = apb_config:: type_id :: create("apb_conh",this); 
		
			apb_conh.is_active = UVM_ACTIVE;
			if(!uvm_config_db#(virtual apb_if)::get(this,"","apb_if",apb_conh.vif))
				`uvm_fatal(get_type_name(),"get method failed interface not getting from test")
			env_configh.apb_conh = apb_conh;
			end

		if(has_spi_agent)
			begin
			spi_conh = spi_config:: type_id :: create("spi_conh",this); 
		
			spi_conh.is_active = UVM_ACTIVE;
			if(!uvm_config_db#(virtual spi_if)::get(this,"","spi_if",spi_conh.vif))
				`uvm_fatal(get_type_name(),"get method failed interface not getting from test")
			env_configh.spi_conh = spi_conh;
			end

							
			env_configh.has_apb_agent = has_apb_agent;
			env_configh.has_spi_agent = has_spi_agent;


			uvm_config_db#(env_config)::set(this,"*","env_config",env_configh);
		
                	envh = env::type_id::create("envh",this);

        endfunction

        function void end_of_elaboration_phase(uvm_phase phase);
                uvm_top.print_topology();
        endfunction

endclass

class cpol0_cphase0_lsb_test extends test;
        `uvm_component_utils(cpol0_cphase0_lsb_test)

        bit[7:0] ctrl = 8'b1111_0011;

        cpol0_cphase0_lsb cpol0_cphase0_lsb_h;
        spi_sequence spi_seqh;
	apb_rd_sequence r0;
        function new(string name="cpol0_cphase0_lsb_test",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                uvm_config_db #(bit[7:0])::set(this,"*","bit[7:0]",ctrl);
        endfunction

        task run_phase(uvm_phase phase);

		cpol0_cphase0_lsb_h = cpol0_cphase0_lsb::type_id::create("cpol0_cphase0_lsb_h");
                spi_seqh = spi_sequence::type_id::create("spi_seqh");
		r0 = apb_rd_sequence :: type_id :: create("apb_rd_sequence");

                phase.raise_objection(this);

                cpol0_cphase0_lsb_h.start(envh.apb_agenth.apb_agth.seqr);
                spi_seqh.start(envh.spi_agenth.spi_agth.seqr);
		#700;
		r0.start(envh.apb_agenth.apb_agth.seqr);
		#100;

                phase.drop_objection(this);
        endtask
endclass


class cpol0_cphase1_lsb_test extends test;
        `uvm_component_utils(cpol0_cphase1_lsb_test)

        bit[7:0] ctrl = 8'b1111_0111;

        cpol0_cphase1_lsb cpol0_cphase1_lsb_h;
        spi_sequence spi_seqh;
	apb_rd_sequence r0;
        function new(string name="cpol0_cphase1_lsb_test",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                uvm_config_db #(bit[7:0])::set(this,"*","bit[7:0]",ctrl);
        endfunction

        task run_phase(uvm_phase phase);

		cpol0_cphase1_lsb_h = cpol0_cphase1_lsb::type_id::create("cpol0_cphase1_lsb_h");
                spi_seqh = spi_sequence::type_id::create("spi_seqh");
		r0 = apb_rd_sequence :: type_id :: create("apb_rd_sequence");

                phase.raise_objection(this);

                cpol0_cphase1_lsb_h.start(envh.apb_agenth.apb_agth.seqr);
                spi_seqh.start(envh.spi_agenth.spi_agth.seqr);
		#1000;
		r0.start(envh.apb_agenth.apb_agth.seqr);
		#100;

                phase.drop_objection(this);
        endtask
endclass


class cpol1_cphase0_lsb_test extends test;
        `uvm_component_utils(cpol1_cphase0_lsb_test)

        bit[7:0] ctrl = 8'b1111_1011;

        cpol1_cphase0_lsb cpol1_cphase0_lsb_h;
        spi_sequence spi_seqh;
	apb_rd_sequence r0;
        function new(string name="cpol0_cphase1_lsb_test",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                uvm_config_db #(bit[7:0])::set(this,"*","bit[7:0]",ctrl);
        endfunction

        task run_phase(uvm_phase phase);

		cpol1_cphase0_lsb_h = cpol1_cphase0_lsb::type_id::create("cpol1_cphase0_lsb_h");
                spi_seqh = spi_sequence::type_id::create("spi_seqh");
		r0 = apb_rd_sequence :: type_id :: create("apb_rd_sequence");

                phase.raise_objection(this);

                cpol1_cphase0_lsb_h.start(envh.apb_agenth.apb_agth.seqr);
                spi_seqh.start(envh.spi_agenth.spi_agth.seqr);
		#1000;
		r0.start(envh.apb_agenth.apb_agth.seqr);
		#100;

                phase.drop_objection(this);
        endtask
endclass


class cpol1_cphase1_lsb_test extends test;
        `uvm_component_utils(cpol1_cphase1_lsb_test)

        bit[7:0] ctrl = 8'b1111_1111;

        cpol1_cphase1_lsb cpol1_cphase1_lsb_h;
        spi_sequence spi_seqh;
	apb_rd_sequence r0;
        function new(string name="cpol1_cphase1_lsb_test",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                uvm_config_db #(bit[7:0])::set(this,"*","bit[7:0]",ctrl);
        endfunction

        task run_phase(uvm_phase phase);

		cpol1_cphase1_lsb_h = cpol1_cphase1_lsb::type_id::create("cpol1_cphase1_lsb_h");
                spi_seqh = spi_sequence::type_id::create("spi_seqh");
		r0 = apb_rd_sequence :: type_id :: create("apb_rd_sequence");

                phase.raise_objection(this);

                cpol1_cphase1_lsb_h.start(envh.apb_agenth.apb_agth.seqr);
                spi_seqh.start(envh.spi_agenth.spi_agth.seqr);
		#1000;
		r0.start(envh.apb_agenth.apb_agth.seqr);
		#200;

                phase.drop_objection(this);
        endtask
endclass

//msb first

class cpol0_cphase0_msb_test extends test;
        `uvm_component_utils(cpol0_cphase0_msb_test)

        bit[7:0] ctrl = 8'b1111_0010;

        cpol0_cphase0_msb cpol0_cphase0_msb_h;
        spi_sequence spi_seqh;
	apb_rd_sequence r0;
        function new(string name="cpol1_cphase1_lsb_test",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                uvm_config_db #(bit[7:0])::set(this,"*","bit[7:0]",ctrl);
        endfunction

        task run_phase(uvm_phase phase);

		cpol0_cphase0_msb_h = cpol0_cphase0_msb::type_id::create("cpol0_cphase0_msb_h");
                spi_seqh = spi_sequence::type_id::create("spi_seqh");
		r0 = apb_rd_sequence :: type_id :: create("apb_rd_sequence");

                phase.raise_objection(this);

                cpol0_cphase0_msb_h.start(envh.apb_agenth.apb_agth.seqr);
                spi_seqh.start(envh.spi_agenth.spi_agth.seqr);
		#1000;
		r0.start(envh.apb_agenth.apb_agth.seqr);
		#200;

                phase.drop_objection(this);
        endtask
endclass


class cpol0_cphase1_msb_test extends test;
        `uvm_component_utils(cpol0_cphase1_msb_test)

        bit[7:0] ctrl = 8'b1111_0110;

        cpol0_cphase1_msb cpol0_cphase1_msb_h;
        spi_sequence spi_seqh;
	apb_rd_sequence r0;
        function new(string name="cpol0_cphase1_msb_test",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                uvm_config_db #(bit[7:0])::set(this,"*","bit[7:0]",ctrl);
        endfunction

        task run_phase(uvm_phase phase);

		cpol0_cphase1_msb_h = cpol0_cphase1_msb::type_id::create("cpol0_cphase1_msb_h");
                spi_seqh = spi_sequence::type_id::create("spi_seqh");
		r0 = apb_rd_sequence :: type_id :: create("apb_rd_sequence");

                phase.raise_objection(this);

                cpol0_cphase1_msb_h.start(envh.apb_agenth.apb_agth.seqr);
                spi_seqh.start(envh.spi_agenth.spi_agth.seqr);
		#1000;
		r0.start(envh.apb_agenth.apb_agth.seqr);
		#200;

                phase.drop_objection(this);
        endtask
endclass



class cpol1_cphase0_msb_test extends test;
        `uvm_component_utils(cpol1_cphase0_msb_test)

        bit[7:0] ctrl = 8'b1111_1010;

        cpol1_cphase0_msb cpol1_cphase0_msb_h;
        spi_sequence spi_seqh;
	apb_rd_sequence r0;
        function new(string name="cpol1_cphase0_msb_test",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                uvm_config_db #(bit[7:0])::set(this,"*","bit[7:0]",ctrl);
        endfunction

        task run_phase(uvm_phase phase);

		cpol1_cphase0_msb_h = cpol1_cphase0_msb::type_id::create("cpol1_cphase0_msb_h");
                spi_seqh = spi_sequence::type_id::create("spi_seqh");
		r0 = apb_rd_sequence :: type_id :: create("apb_rd_sequence");

                phase.raise_objection(this);

                cpol1_cphase0_msb_h.start(envh.apb_agenth.apb_agth.seqr);
                spi_seqh.start(envh.spi_agenth.spi_agth.seqr);
		#1000;
		r0.start(envh.apb_agenth.apb_agth.seqr);
		#200;

                phase.drop_objection(this);
        endtask
endclass




class cpol1_cphase1_msb_test extends test;
        `uvm_component_utils(cpol1_cphase1_msb_test)

        bit[7:0] ctrl = 8'b1111_1110;

        cpol1_cphase1_msb cpol1_cphase1_msb_h;
        spi_sequence spi_seqh;
	apb_rd_sequence r0;
        function new(string name="cpol1_cphase1_msb_test",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                uvm_config_db #(bit[7:0])::set(this,"*","bit[7:0]",ctrl);
        endfunction

        task run_phase(uvm_phase phase);

		cpol1_cphase1_msb_h = cpol1_cphase1_msb::type_id::create("cpol1_cphase1_msb_h");
                spi_seqh = spi_sequence::type_id::create("spi_seqh");
		r0 = apb_rd_sequence :: type_id :: create("apb_rd_sequence");

                phase.raise_objection(this);

                cpol1_cphase1_msb_h.start(envh.apb_agenth.apb_agth.seqr);
                spi_seqh.start(envh.spi_agenth.spi_agth.seqr);
		#1000;
		r0.start(envh.apb_agenth.apb_agth.seqr);
		#200;

                phase.drop_objection(this);
        endtask
endclass

/*
class  apb_rd_seq_test extends test;
        `uvm_component_utils(apb_rd_seq_test)

        //bit[7:0] ctrl = 8'b1111_1111;
        	
                spi_sequence spi_seqh;
		apb_rd_sequence r0;

        function new(string name="apb_rd_seq_test",uvm_component parent);
                super.new(name,parent);
        endfunction
       
        task run_phase(uvm_phase phase);



                
               
                spi_seqh = spi_seq::type_id::create("spi_seqh");
		r0 = apb_rd_sequence :: type_id :: create("apb_rd_sequence");

                phase.raise_objection(this);			
		env_configh.has_apb_agent = has_apb_agent;

                spi_seqh.start(envh.spi_agth.spi_seqrh);
		
		r0.start(envh.apb_agenth.apb_agth.seqr);
	


                phase.drop_objection(this);
        endtask
endclass
*/

