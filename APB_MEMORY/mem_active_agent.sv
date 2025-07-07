
//===============================================================================================================================================//
//----------------------------------------------------------MEM ACTIVE AGENT---------------------------------------------------------------------//
//===============================================================================================================================================//


class mem_active_agent extends uvm_agent;

	`uvm_component_utils(mem_active_agent)

	
	mem_sequencer		h_mem_sequencer;			//sequencer			 instance
	mem_driver			h_mem_driver;				//driver			instance
	//mem_input_monitor_1	h_mem_input_monitor;		//input monitor		instance
	mem_input_monitor	h_mem_input_monitor;		//input monitor		instance


	//===================================== component construction ===================================//

		function  new(string name="mem_active_agent",uvm_component parent);
			super.new(name,parent);

		endfunction
	
	
	//======================================= BUILD PHASE =============================================//

		function void build_phase(uvm_phase phase);


			super.build_phase(phase);
				
 			set_inst_override_by_type("*", mem_input_monitor::get_type(), mem_input_monitor_1::get_type());


			h_mem_sequencer		=	mem_sequencer::type_id::create("h_mem_sequencer",this);				//sequencer 		memory creation
			h_mem_driver		=	mem_driver::type_id::create("h_mem_driver",this);					//driver			memory creation
			h_mem_input_monitor	=	mem_input_monitor::type_id::create("h_mem_input_monitor",this);		//input monitor 	memory creation
		endfunction


	//======================================= CONNECT PHASE ===========================================//
	
		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);

			h_mem_driver.seq_item_port.connect(h_mem_sequencer.seq_item_export);

		endfunction

endclass



