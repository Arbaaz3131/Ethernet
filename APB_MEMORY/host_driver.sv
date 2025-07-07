
//===============================================================================================================================================//
//------------------------------------------------------------HOST DRIVER------------------------------------------------------------------------//
//===============================================================================================================================================//


class host_driver extends uvm_driver#(ethernet_sequence_item);

	`uvm_component_utils(host_driver)

	virtual ethernet_interface		h_intf;

	//===================================== component construction ===================================//

		function  new(string name="host_driver",uvm_component parent);
			super.new(name,parent);
		endfunction

	//===================================== build phase ================================//


		function void build_phase(uvm_phase phase);
			super.build_phase(phase);

			assert(uvm_config_db#(virtual	ethernet_interface)::get(this,"*","h_intf",h_intf))	else	$fatal("host driver hintf not getting");
			
		endfunction
		
	//=================================== RUN PHASE =====================================//

		task run_phase(uvm_phase phase);
		
		//	super.run_phase(phase);
			
			forever@(h_intf.cb_host_driver) begin						//{

				seq_item_port.get_next_item(req);

		/*			if(!req.prstn_i  ||	!req.psel_i)	begin

					h_intf.cb_host_driver.pwrite_i	<=	0;
					h_intf.cb_host_driver.paddr_i	<=	0;
					h_intf.cb_host_driver.pwdata_i	<=	0;
					h_intf.cb_host_driver.prstn_i	<=	0;
					h_intf.cb_host_driver.psel_i	<=	0;
					h_intf.cb_host_driver.penable_i	<=	0;
						
					end


					if(!req.prstn_i  ||	req.psel_i)	begin

					h_intf.cb_host_driver.pwrite_i	<=	0;
					h_intf.cb_host_driver.paddr_i	<=	0;
					h_intf.cb_host_driver.pwdata_i	<=	0;
					h_intf.cb_host_driver.prstn_i	<=	0;
					h_intf.cb_host_driver.psel_i	<=	1;
					h_intf.cb_host_driver.penable_i	<=	0;
						
					end

					if(req.prstn_i  ||	req.psel_i)	begin

					h_intf.cb_host_driver.pwrite_i	<=	0;
					h_intf.cb_host_driver.paddr_i	<=	0;
					h_intf.cb_host_driver.pwdata_i	<=	0;
					h_intf.cb_host_driver.prstn_i	<=	1;
					h_intf.cb_host_driver.psel_i	<=	0;
					h_intf.cb_host_driver.penable_i	<=	0;
						
					end

					
					if(req.prstn_i	&&	req.psel_i)	begin				//{

					h_intf.cb_host_driver.pwrite_i	<=	req.pwrite_i;
					h_intf.cb_host_driver.paddr_i	<=	req.paddr_i;
					h_intf.cb_host_driver.pwdata_i	<=	req.pwdata_i;
					h_intf.cb_host_driver.prstn_i	<=	req.prstn_i;
					h_intf.cb_host_driver.psel_i	<=	req.psel_i;
					h_intf.cb_host_driver.penable_i	<=	0;
				
					@(h_intf.cb_host_driver);	
		*/
					h_intf.cb_host_driver.pwrite_i	<=	req.pwrite_i;					
					h_intf.cb_host_driver.paddr_i	<=	req.paddr_i;
					h_intf.cb_host_driver.pwdata_i	<=	req.pwdata_i;
					h_intf.cb_host_driver.prstn_i	<=	req.prstn_i;
					h_intf.cb_host_driver.psel_i	<=	req.psel_i;
					h_intf.cb_host_driver.penable_i	<=	req.penable_i;
					
					if(h_intf.cb_host_driver.psel_i && h_intf.cb_host_driver.penable_i && h_intf.cb_host_driver.prstn_i)	wait (h_intf.cb_host_driver.pready_o);
		//	end															//}
				seq_item_port.item_done();
				//end

		//			h_intf.cb_host_driver.penable_i	<=0;

			end																//}
		endtask

endclass

