

//===============================================================================================================================================//
//----------------------------------------------------------TX MAC SEQUENCER---------------------------------------------------------------------//
//===============================================================================================================================================//


class tx_mac_sequencer extends uvm_sequencer#(ethernet_sequence_item);

	`uvm_component_utils(tx_mac_sequencer)


	//===================================== component construction ===================================//

		function  new(string name="tx_mac_sequencer",uvm_component parent);
			super.new(name,parent);
		endfunction
	
	
endclass

