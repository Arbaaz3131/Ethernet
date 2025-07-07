
//===============================================================================================================================================//
//----------------------------------------------------------HOST ENVIRONMENT---------------------------------------------------------------------//
//===============================================================================================================================================//


class host_env extends uvm_env;

	`uvm_component_utils(host_env)

	host_active_agent		h_host_active_agent;		//host active agent instance


	//===================================== component construction ===================================//

		function  new(string name="host_env",uvm_component parent);
			super.new(name,parent);
		endfunction
	
	
	//======================================= BUILD PHASE =============================================//

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);

			h_host_active_agent	=	host_active_agent::type_id::create("h_host_active_agent",this);		//host_active_agent memory creation
		endfunction

endclass

