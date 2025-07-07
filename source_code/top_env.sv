
//===============================================================================================================================================//
//-------------------------------------------------------------TOP ENVIRONMENT-------------------------------------------------------------------//
//===============================================================================================================================================//


class top_env extends uvm_env;

	`uvm_component_utils(top_env)

	host_env			h_host_env;			//host 	 	 environment instance
	mem_env				h_mem_env;			//mem	 	 environment instance
	tx_mac_env			h_tx_mac_env;		//tx_mac	 environment instance

	virtual_sequencer	h_virtual_sequencer;

	coverage			h_cov;

	ethernet_scoreboard		h_sb;

	
	//===================================== component construction ===================================//

		function  new(string name="top_env",uvm_component parent);
			super.new(name,parent);
		endfunction
	
	
	//======================================= BUILD PHASE =============================================//

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);

			h_host_env			=	host_env::type_id::create("h_host_env",this);		//host environment memory creation
			h_mem_env			=	mem_env::type_id::create("h_mem_env",this);			//mem environment memory creation
			h_tx_mac_env		=	tx_mac_env::type_id::create("h_tx_mac_env",this);	//tx_mac environment memory creation
			h_virtual_sequencer	=	virtual_sequencer::type_id::create("h_virtual_sequencer",this);
			h_sb				=	ethernet_scoreboard::type_id::create("h_sb",this);
			h_cov				=	coverage::type_id::create("h_cov",this);
            //set_type_override_by_type(mem_input_monitor::get_type(),mem_input_monitor_1::get_type());
		

		endfunction



	//===============================---- connect_phase	==========================================//

		function	void	connect_phase(uvm_phase phase);
			super.connect_phase(phase);

			h_virtual_sequencer.h_host_sequencer		=		h_host_env.h_host_active_agent.h_host_sequencer;
			h_virtual_sequencer.h_mem_sequencer			= 		h_mem_env.h_mem_active_agent.h_mem_sequencer;
			h_virtual_sequencer.h_tx_mac_sequencer		=		h_tx_mac_env.h_tx_mac_active_agent.h_tx_mac_sequencer;

			h_mem_env.h_mem_active_agent.h_mem_input_monitor.h_mem_input_monitor_port.connect(h_sb.h_fifo.analysis_export);		
			h_tx_mac_env.h_tx_mac_passive_agent.h_tx_mac_output_monitor.h_analysis_port_outmon.connect(h_sb.h_analysis_output_imp);

		

		endfunction

endclass





