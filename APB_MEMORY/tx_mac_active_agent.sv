
//===============================================================================================================================================//
//----------------------------------------------------------TX_MAC ACTIVE AGENT------------------------------------------------------------------//
//===============================================================================================================================================//


class tx_mac_active_agent extends uvm_agent;

	`uvm_component_utils(tx_mac_active_agent)

	
	tx_mac_sequencer		h_tx_mac_sequencer;				//sequencer instance
	tx_mac_driver			h_tx_mac_driver;				//driver	instance

	//===================================== component construction ===================================//

		function  new(string name="tx_mac_active_agent",uvm_component parent);
			super.new(name,parent);
		endfunction
	
	
	//======================================= BUILD PHASE =============================================//

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);

			h_tx_mac_sequencer		=	tx_mac_sequencer::type_id::create("h_tx_mac_sequencer",this);		//sequencer tx_memory creation
			h_tx_mac_driver			=	tx_mac_driver::type_id::create("h_tx_mac_driver",this);				//driver	tx_memory creation

		endfunction


	//======================================= CONNECT PHASE ===========================================//
	
		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);

			h_tx_mac_driver.seq_item_port.connect(h_tx_mac_sequencer.seq_item_export);

		endfunction

endclass




