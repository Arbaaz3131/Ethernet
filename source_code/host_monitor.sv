/////////////////////////////////////host monitor/////////////////////////////////////////////

class host_monitor extends uvm_monitor;

	`uvm_component_utils(host_monitor)
	ethernet_sequence_item 		h_seq_item;							//sequence item instance
	ethernet_config_class 		h_ethernet_config_class;			//config class instance
	virtual ethernet_interface 	h_intf;								//virtual intf instance

//======================================constructor==================================================//	
	function new(string name = "host_monitor", uvm_component parent);
		super.new(name,parent);
	endfunction


//========================================= BUILD PHASE ============================================//
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		h_seq_item=ethernet_sequence_item::type_id::create("h_seq_item");
	endfunction

//=========================================connect phase==============================================//
		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
			assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN MEM SEQUENCE");
			assert(uvm_config_db#(virtual	ethernet_interface)::get(this,"*","h_intf",h_intf))else $fatal("VIF NOT GETTING IN IP MONITOR");		
		endfunction

//=======================================  run phase ===============================//
		task run_phase(uvm_phase phase);
		super.run_phase(phase);
			forever@(h_intf.cb_host_monitor)	begin

				h_seq_item.paddr_i 	= h_intf.cb_host_monitor.paddr_i;
				h_seq_item.pwdata_i = h_intf.cb_host_monitor.pwdata_i;
				h_seq_item.pwrite_i = h_intf.cb_host_monitor.pwrite_i;
				h_seq_item.prstn_i	= h_intf.cb_host_monitor.prstn_i;
				h_seq_item.psel_i	= h_intf.cb_host_monitor.psel_i;
				h_seq_item.penable_i= h_intf.cb_host_monitor.penable_i;
				h_seq_item.pready_o	= h_intf.cb_host_monitor.pready_o;

				if(h_seq_item.pwrite_i	&&	h_seq_item.prstn_i	&& h_seq_item.psel_i && h_seq_item.penable_i && h_seq_item.pready_o  )begin
					h_ethernet_config_class.run(h_seq_item.paddr_i,h_seq_item.pwdata_i);
			end

			end
		endtask
	

endclass
