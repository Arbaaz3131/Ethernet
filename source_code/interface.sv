
//===============================================================================================================================================//
//-----------------------------------------------------------------INTERFACE---------------------------------------------------------------------//
//===============================================================================================================================================//




interface ethernet_interface(input bit pclk_i,MTxclk);
	
	//======================================== HOST SIGNALS =======================//
		logic prstn_i,pwrite_i,penable_i,psel_i,pready_o,int_o;
		logic [31:0]paddr_i,pwdata_i,prdata_o;


	//======================================== MEMORY SIGNALS ================================//
		logic m_pwrite_o,m_penable_o,m_psel_o,m_pready_i;
		logic [31:0]m_paddr_o,m_pwdata_o,m_prdata_i;


	//======================================== TX MAC SIGNALS ================================//
		logic MTxEn,MTxErr,MRxDV,MRxErr,MCrS;
		logic [3:0]MTxD,MRxD;


	//======================================= HOST CLOCKING BLOCKS ================================//	

		clocking cb_host_driver@(posedge pclk_i);
			input 		prdata_o,pready_o;
			output 		prstn_i,pwrite_i,penable_i,psel_i,pwdata_i,paddr_i;
		endclocking

		clocking cb_host_monitor@(posedge pclk_i);
			input 		prdata_o,pready_o;
			input 		prstn_i,pwrite_i,penable_i,psel_i,pwdata_i,paddr_i;
		endclocking

	//======================================== MEMORY CLOCKING BLOCK =================================//	

		clocking cb_memory_driver@(posedge pclk_i);
			input 		m_pwrite_o,m_penable_o,m_psel_o,m_paddr_o,m_pwdata_o;
			output 		m_pready_i,m_prdata_i;
		endclocking

		clocking cb_memory_monitor@(posedge pclk_i);
			input 		m_pwrite_o,m_penable_o,m_psel_o,m_paddr_o,m_pwdata_o;
			input 		m_pready_i,m_prdata_i;
		endclocking


	//============================================ MAC CLOCKING BLOCK ====================================//	

		clocking cb_tx_mac_driver@(posedge MTxclk);
			output 		MCrS;
			input  		MTxEn,MTxErr,MRxDV,MRxErr,MTxD,MRxD;
		endclocking
	
		clocking cb_tx_mac_monitor@(posedge MTxclk);
			input 		MCrS;
			input  		MTxEn,MTxErr,MRxDV,MRxErr,MTxD,MRxD;
		endclocking



endinterface
