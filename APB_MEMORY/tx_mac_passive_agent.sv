

//===============================================================================================================================================//
//----------------------------------------------------------TX MAC PASSIVE AGENT ----------------------------------------------------------------//
//===============================================================================================================================================//


class tx_mac_passive_agent extends uvm_agent;

	`uvm_component_utils(tx_mac_passive_agent)

	tx_mac_outmon		h_tx_mac_output_monitor;		//output monitor instance




	//===================================== component construction ===================================//

		function  new(string name="tx_mac_passive_agent",uvm_component parent);
			super.new(name,parent);
		endfunction
	
	
	//======================================= BUILD PHASE =============================================//

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			set_type_override_by_type(tx_mac_outmon::get_type(),tx_mac_outmon_bug::get_type());
			h_tx_mac_output_monitor	= tx_mac_outmon::type_id::create("h_tx_mac_output_monitor",this);
		endfunction

endclass


