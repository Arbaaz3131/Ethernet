
//===============================================================================================================================================//
//------------------------------------------------------------MEM DRIVER-------------------------------------------------------------------------//
//===============================================================================================================================================//

/*
class mem_driver extends uvm_driver#(ethernet_sequence_item);

	`uvm_component_utils(mem_driver)

	virtual ethernet_interface	h_intf;

	ethernet_config_class		h_ethernet_config_class;

	int		addr=1024;


	//===================================== component construction ===================================//

		function  new(string name="mem_driver",uvm_component parent);
			super.new(name,parent);
		endfunction
	



	//======================================== CONNECT PHASE ========================================//

		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN MEM DRIVER");
				assert(uvm_config_db#(virtual	ethernet_interface)::get(this,"*","h_intf",h_intf))	else	$fatal("hintf not getting in mem driver");			
					
		endfunction

	
	//=================================== RUN PHASE =====================================//

		task run_phase(uvm_phase phase);
		
		
			super.run_phase(phase);

			forever @(h_intf.cb_memory_driver) begin	//------------
			

				seq_item_port.get_next_item(req);

						$display("==========In mem driver");
					
						if(!h_intf.cb_memory_driver.m_penable_o && h_intf.cb_memory_driver.m_psel_o && h_intf.cb_memory_driver.m_pwrite_o==0) begin	//{	
						h_intf.cb_memory_driver.m_pready_i	<=	0;						end

						//@(h_intf.cb_memory_driver);
				
					 if(h_intf.cb_memory_driver.m_penable_o && h_intf.cb_memory_driver.m_psel_o && h_intf.cb_memory_driver.m_pwrite_o==0)	begin	//{
						h_intf.cb_memory_driver.m_pready_i	<=	1;
						h_intf.cb_memory_driver.m_prdata_i	<=	req.m_prdata_i;

						end		//}

						seq_item_port.item_done();

			end
		endtask

endclass

*/

class mem_driver extends uvm_driver#(ethernet_sequence_item);

	`uvm_component_utils(mem_driver)

	virtual ethernet_interface	h_intf;

	ethernet_config_class		h_ethernet_config_class;

	int		addr=1024;

	int		temp_pointer;

	//===================================== component construction ===================================//

		function  new(string name="mem_driver",uvm_component parent);
			super.new(name,parent);
		endfunction
	



	//======================================== CONNECT PHASE ========================================//

		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN MEM DRIVER");
				assert(uvm_config_db#(virtual	ethernet_interface)::get(this,"*","h_intf",h_intf))	else	$fatal("hintf not getting in mem driver");			
					
		endfunction

	
	//=================================== RUN PHASE =====================================//

		task run_phase(uvm_phase phase);
		
		
			super.run_phase(phase);

			forever @(h_intf.cb_memory_driver) begin	//------------
			
			//temp_pointer	=	h_ethernet_config_class.TXD1[addr]

				seq_item_port.get_next_item(req);

					
						if(!h_intf.cb_memory_driver.m_penable_o && h_intf.cb_memory_driver.m_psel_o && h_intf.cb_memory_driver.m_pwrite_o==0) begin	//{	
						h_intf.cb_memory_driver.m_pready_i	<=	0;						end
						//setup phase
				
					  if(h_intf.cb_memory_driver.m_penable_o && h_intf.cb_memory_driver.m_psel_o && h_intf.cb_memory_driver.m_pwrite_o==0)	begin	//{
						h_intf.cb_memory_driver.m_pready_i	<=	1;
						h_intf.cb_memory_driver.m_prdata_i	<=	req.m_prdata_i;

					  end		//}
						//access phase

						seq_item_port.item_done();

			end
		endtask

endclass


class mem_driver_mtxerr extends mem_driver;

	`uvm_component_utils(mem_driver_mtxerr)

	virtual ethernet_interface	h_intf;

	ethernet_config_class		h_ethernet_config_class;

	int		addr=1024;

	int		temp_pointer;
	int 		q[$];
	//===================================== component construction ===================================//

		function  new(string name="mem_driver_mtxerr",uvm_component parent);
			super.new(name,parent);
		endfunction
	



	//======================================== CONNECT PHASE ========================================//

		function void connect_phase(uvm_phase phase);
			//super.connect_phase(phase);
				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN MEM DRIVER");
				assert(uvm_config_db#(virtual	ethernet_interface)::get(this,"*","h_intf",h_intf))	else	$fatal("hintf not getting in mem driver");			
					
		endfunction

	
	//=================================== RUN PHASE =====================================//

		task run_phase(uvm_phase phase);
		
		
			//super.run_phase(phase);

			forever @(h_intf.cb_memory_driver) begin	//------------
			
			//temp_pointer	=	h_ethernet_config_class.TXD1[addr]

				seq_item_port.get_next_item(req);

						$display("==========In mem driver");
					
						if(!h_intf.cb_memory_driver.m_penable_o && h_intf.cb_memory_driver.m_psel_o && h_intf.cb_memory_driver.m_pwrite_o==0) begin	//{	
						h_intf.cb_memory_driver.m_pready_i	<=	0;
						end

						//@(h_intf.cb_memory_driver);
					 if(h_intf.cb_memory_driver.m_penable_o && h_intf.cb_memory_driver.m_psel_o &&h_intf.cb_memory_driver.m_pwrite_o==0)begin//{
						h_intf.cb_memory_driver.m_pready_i	<=	1;
						h_intf.cb_memory_driver.m_prdata_i	<=	req.m_prdata_i;
						//repeat(200)begin
						#200;
						h_intf.cb_memory_driver.m_pready_i	<=	0;
						//end
						//h_intf.cb_memory_driver.m_pready_i	<=	1;
					end		//}
					//	$display($time,"||||||||||||||||||||||||||||||||||q: %p    q size: %0d",q,q.size());
						seq_item_port.item_done();

			end
		endtask

endclass



class sudden_reset extends mem_driver;

	`uvm_component_utils(sudden_reset)

	virtual ethernet_interface	h_intf;

	ethernet_config_class		h_ethernet_config_class;

	int		addr=1024;

	int		temp_pointer;
	int 		q[$];
	//===================================== component construction ===================================//

		function  new(string name="sudden_reset",uvm_component parent);
			super.new(name,parent);
		endfunction
	



	//======================================== CONNECT PHASE ========================================//

		function void connect_phase(uvm_phase phase);
			//super.connect_phase(phase);
				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN MEM DRIVER");
				assert(uvm_config_db#(virtual	ethernet_interface)::get(this,"*","h_intf",h_intf))	else	$fatal("hintf not getting in mem driver");			
					
		endfunction

	
	//=================================== RUN PHASE =====================================//

		task run_phase(uvm_phase phase);
		
		
			//super.run_phase(phase);

			forever @(h_intf.cb_memory_driver) begin	//------------
			
			//temp_pointer	=	h_ethernet_config_class.TXD1[addr]

				seq_item_port.get_next_item(req);

						$display("==========In mem driver");
					
						if(!h_intf.cb_memory_driver.m_penable_o && h_intf.cb_memory_driver.m_psel_o && h_intf.cb_memory_driver.m_pwrite_o==0) begin	//{	
						h_intf.cb_memory_driver.m_pready_i	<=	0;
						end

					 if(h_intf.cb_memory_driver.m_penable_o && h_intf.cb_memory_driver.m_psel_o &&h_intf.cb_memory_driver.m_pwrite_o==0)begin//{
						h_intf.cb_memory_driver.m_pready_i	<=	1;
						h_intf.cb_memory_driver.m_prdata_i	<=	req.m_prdata_i;
						#1000;
						h_intf.prstn_i<=0;
					end		//}
						seq_item_port.item_done();

			end
		endtask

endclass

