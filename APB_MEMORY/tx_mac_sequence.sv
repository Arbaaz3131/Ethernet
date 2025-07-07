class tx_mac_sequence	extends uvm_sequence#(ethernet_sequence_item);
	`uvm_object_utils(tx_mac_sequence)
	//===================================== object construction ===================================//
		function  new(string name="tx_mac_sequence");
			super.new(name);
		endfunction
	//=================================== RUN PHASE =======================================//
		task body;
				
			req=ethernet_sequence_item::type_id::create("req");		
			/*	start_item(req);
					req.randomize();
				finish_item(req);
			*/
		endtask
endclass





