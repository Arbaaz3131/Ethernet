
//===============================================================================================================================================//
//----------------------------------------------------------TX MAC DRIVER------------------------------------------------------------------------//
//===============================================================================================================================================//


class tx_mac_driver extends uvm_driver#(ethernet_sequence_item);

	`uvm_component_utils(tx_mac_driver)

	virtual	ethernet_interface	h_intf;

	//===================================== component construction ===================================//

		function  new(string name="tx_mac_driver",uvm_component parent);
			super.new(name,parent);
		endfunction

	
	//======================================= BUILD PHASE =============================================//

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
		
			assert(uvm_config_db#(virtual	ethernet_interface)::get(this,"*","h_intf",h_intf))	else	$fatal("hintf not getting in tx mac driver");
		endfunction


	//=================================== RUN PHASE =====================================//

		task run_phase(uvm_phase phase);
		
			super.run_phase(phase);

			forever@(h_intf.cb_tx_mac_driver) begin
			
			//	seq_item_port.get_next_item(req);

						if(h_intf.MTxEn)		
							h_intf.cb_tx_mac_driver.MCrS	<=	1;	//req.MCrS;
						if(!h_intf.MTxEn)								
							h_intf.cb_tx_mac_driver.MCrS	<=	0;

			//	seq_item_port.item_done();

			end
		endtask
	
		
endclass



class mcrs_0 extends tx_mac_driver;

	`uvm_component_utils(mcrs_0)

	virtual	ethernet_interface	h_intf;

	//===================================== component construction ===================================//

		function  new(string name="mcrs_0",uvm_component parent);
			super.new(name,parent);
		endfunction

	
	//======================================= BUILD PHASE =============================================//

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
		
			assert(uvm_config_db#(virtual	ethernet_interface)::get(this,"*","h_intf",h_intf))	else	$fatal("hintf not getting in tx mac driver");
		endfunction


	//=================================== RUN PHASE =====================================//

		task run_phase(uvm_phase phase);
		
			super.run_phase(phase);

			forever@(h_intf.cb_tx_mac_driver) begin
			

				h_intf.cb_tx_mac_driver.MCrS	<=	0;


			end
		endtask
	
		
endclass

