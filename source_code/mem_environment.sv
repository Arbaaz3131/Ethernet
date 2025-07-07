
//===============================================================================================================================================//
//-----------------------------------------------------------MEM ENVIRONMENT---------------------------------------------------------------------//
//===============================================================================================================================================//


class mem_env extends uvm_env;

	`uvm_component_utils(mem_env)

	mem_active_agent		h_mem_active_agent;				//memory	active agent	instance


	//===================================== component construction ===================================//

		function  new(string name="mem_env",uvm_component parent);
			super.new(name,parent);
		endfunction
	
	
	//======================================= BUILD PHASE =============================================//

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);

			h_mem_active_agent	=	mem_active_agent::type_id::create("h_mem_active_agent",this);		//mem_active_agent	memory creation
		endfunction

endclass


