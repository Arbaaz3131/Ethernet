
//===============================================================================================================================================//
//----------------------------------------------------------HOST   SEQUENCER---------------------------------------------------------------------//
//===============================================================================================================================================//


class host_sequencer extends uvm_sequencer#(ethernet_sequence_item);

	`uvm_component_utils(host_sequencer)


	//===================================== component construction ===================================//

		function new(string name="host_sequencer",uvm_component parent);
			super.new(name,parent);
		endfunction
	
	
endclass
