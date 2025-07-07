


//===============================================================================================================================================//
//---------------------------------------------------------HOST ACTIVE AGENT---------------------------------------------------------------------//
//===============================================================================================================================================//


class host_active_agent extends uvm_agent;

	`uvm_component_utils(host_active_agent)

	
	host_sequencer		h_host_sequencer;			//sequencer instance
	host_driver			h_host_driver;				//driver	instance
	host_monitor		h_host_monitor;
	//===================================== component construction ===================================//

		function  new(string name="host_active_agent",uvm_component parent);
			super.new(name,parent);
		endfunction
	
	
	//======================================= BUILD PHASE =============================================//

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);

			h_host_sequencer	=	host_sequencer::type_id::create("h_host_sequencer",this);		//sequencer memory creation
			h_host_driver		=	host_driver::type_id::create("h_host_driver",this);				//driver	memory creation
			h_host_monitor		=	host_monitor::type_id::create("h_host_monitor",this);
		endfunction


	//======================================= CONNECT PHASE ===========================================//
	
		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);

			h_host_driver.seq_item_port.connect(h_host_sequencer.seq_item_export);

		endfunction

endclass


