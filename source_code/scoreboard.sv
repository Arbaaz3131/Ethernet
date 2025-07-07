//=============================================================================//
//============================ethernet_scoreboard =============================//
//=============================================================================//



class ethernet_scoreboard extends uvm_scoreboard;

	`uvm_component_utils(ethernet_scoreboard)
	


	//--------------------------------- ADDITIONAL ANALYSIS PORT DECLARATION -----------------------------------//
//	`uvm_analysis_imp_decl(_outmon)


	uvm_event	sb_wait;

	nibble_type payload_inp,payload_out;

	
	uvm_analysis_imp #(nibble_type,ethernet_scoreboard) 	h_analysis_output_imp;


	uvm_tlm_analysis_fifo #(nibble_type) h_fifo;  
	

	//-------------------------------- component creation -------------------//

	function new(string name="ethernet_scoreboard",uvm_component parent);
		super.new(name,parent);
		h_fifo=new("h_fifo",this);

	endfunction



	//=========================build_phase=====================//
	
	function void build_phase(uvm_phase phase);
		
		super.build_phase(phase);
		
		h_analysis_output_imp=new("h_analysis_output_imp",this);
		
		//h_fifo=new("h_fifo",this);

		sb_wait=uvm_event_pool::get_global("event");
		
	endfunction




	function void write(nibble_type OUTDATA);
		payload_out=OUTDATA;
	endfunction


	
	task run_phase(uvm_phase phase);
		
		super.run_phase(phase);
		
		forever begin
		//	$display("****************** h_fifo=%d",h_fifo);
			sb_wait.wait_trigger;
	
			h_fifo.get(payload_inp);
			
			
			if( payload_inp == payload_out )begin//{ 1
			
      	`uvm_info("payload_pass",$sformatf("\n \t \t ----------   payload_inp =%0d   payload_out=%p    \n",payload_inp,payload_out),UVM_HIGH);

			end// } 1

			else begin//{ 2

      	`uvm_info("payload_fail",$sformatf("\n \t \t ----------   payload_inp =%0d   payload_out=%p    \n",payload_inp,payload_out),UVM_HIGH);

			end// } 2
			
			#10;
		
		end

	endtask
		


endclass 
