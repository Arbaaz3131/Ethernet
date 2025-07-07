

//===============================================================================================================================================//
//----------------------------------------------------------TX_MAC ENVIRONMENT-------------------------------------------------------------------//
//===============================================================================================================================================//


class tx_mac_env extends uvm_env;

	`uvm_component_utils(tx_mac_env)

	tx_mac_active_agent		h_tx_mac_active_agent;				//memory	active agent	instance
	tx_mac_passive_agent	h_tx_mac_passive_agent;				//memory	passive agent	instance

	//===================================== component construction ===================================//

		function  new(string name="tx_mac_env",uvm_component parent);
			super.new(name,parent);
		endfunction
	
	
	//======================================= BUILD PHASE =============================================//

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);

			h_tx_mac_active_agent	=	tx_mac_active_agent::type_id::create("h_tx_mac_active_agent",this);		//tx_mac_active_agent	memory creation
			h_tx_mac_passive_agent	=	tx_mac_passive_agent::type_id::create("h_tx_mac_passive_agent",this);	//tx_mac passive agent	memory creation

		endfunction

endclass



