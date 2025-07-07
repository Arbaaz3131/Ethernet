
//===============================================================================================================================================//
//----------------------------------------------------------------TEST---------------------------------------------------------------------------//
//===============================================================================================================================================//


class ethernet_test extends uvm_test;

	`uvm_component_utils(ethernet_test)

	top_env							h_top_env;			//top environment	instance
	
	tx_mac_sequence					h_tx_mac_sequence;
	mem_sequence					h_mem_sequence;
	host_sequence					h_host_sequence;
	ethernet_config_class			h_ethernet_config_class;
	int_source_sequence				h_int_source_sequence;
	virtual_sequence				h_virtual_sequence;	

	virtual ethernet_interface		h_intf;
	int addr=1024;
    int count;
	//===================================== component construction ===================================//

		function  new(string name="ethernet_test",uvm_component parent);
			super.new(name,parent);
		endfunction
	

	//===================================== build_phase construction ===================================//
	
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			h_top_env				=	top_env::type_id::create("h_top_env",this);			//top environment memory creation			
			h_tx_mac_sequence		=	tx_mac_sequence::type_id::create("h_tx_mac_sequence");	
			h_mem_sequence			=	mem_sequence::type_id::create("h_mem_sequence");
			h_host_sequence			=	host_sequence::type_id::create("h_host_sequence");		
			h_int_source_sequence	=	int_source_sequence::type_id::create("h_int_source_sequence");
			h_virtual_sequence		=	virtual_sequence::type_id::create("h_virtual_sequence");

		endfunction



	//======================================== CONNECT PHASE ========================================//

		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
			assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN TEST");
			assert(	uvm_config_db#(virtual	ethernet_interface)::get(this,"*","h_intf",h_intf))else	$fatal("VINTF IN TEST");							
		endfunction


	//=============================== END OF ELOBORATION PHASE =======================================//

		function void	end_of_elaboration();
			uvm_top.print_topology();
		endfunction
	
	//======================================= RUN PHASE =================================//

	task  run_phase(uvm_phase phase);

/*		phase.raise_objection(this,"raise");
			h_virtual_sequence.start(h_top_env.h_virtual_sequencer);
			#1000;
		phase.drop_objection(this,"drop");
*/

		phase.raise_objection(this,"raise");

		begin				//{

		h_host_sequence.start(h_top_env.h_host_env.h_host_active_agent.h_host_sequencer);

		if(h_ethernet_config_class.moder.TXEN)	begin		//{
	
		fork
			begin//{
	    	h_mem_sequence.start(h_top_env.h_mem_env.h_mem_active_agent.h_mem_sequencer);				
			#8000;
			end

			forever@(h_intf.int_o || h_ethernet_config_class.pack)begin//{
			h_int_source_sequence.start(h_top_env.h_host_env.h_host_active_agent.h_host_sequencer);
          	h_ethernet_config_class.pack=0;
       	    count=count+1;
			end//}
		join_any
		end					//}
			
		end//}
		
		#300000;
		$display($time,"-------------------------- DROP OBJECTION-----------------------------------");
		phase.drop_objection(this,"drop");

	endtask		


endclass


