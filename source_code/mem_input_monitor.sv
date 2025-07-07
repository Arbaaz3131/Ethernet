

//===============================================================================================================================================//
//--------------------------------------------------------------MEM INPUT MONITOR----------------------------------------------------------------//
//===============================================================================================================================================//




	class mem_input_monitor extends uvm_monitor;
		
		`uvm_component_utils(mem_input_monitor)
 		
		uvm_analysis_port#(nibble_type) h_mem_input_monitor_port;

		ethernet_sequence_item h_seq_item;

		ethernet_config_class h_ethernet_config_class;


	virtual ethernet_interface h_intf;

		bit		[31:0]slicer;				//prdata storing register

		bit		[3:0]mtxd;					//to write nibble into scoreoard fifo
 
		int addr = 1024;					//bd address pointer

		int 	len;						//counter for payload to nibble 



	function new(string name = " ", uvm_component parent);
		super.new(name,parent);
	endfunction


//========================================= BUILD PHASE ============================================//
	
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);

			h_mem_input_monitor_port=new("h_mem_input_monitor_port",this);
			h_seq_item=ethernet_sequence_item::type_id::create("h_seq_item");
			assert(uvm_config_db#(virtual	ethernet_interface)::get(this,"*","h_intf",h_intf))else $fatal("VIF NOT GETTING IN IP MONITOR");	
		
		endfunction

//=========================================connect phase==============================================//
		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN MEM SEQUENCE");
					
		endfunction

//=======================================  run phase ===============================//
		task run_phase(uvm_phase phase);
				super.run_phase(phase);

			forever@(h_intf.cb_memory_monitor)	begin
		
				h_seq_item.m_pready_i	=	h_intf.cb_memory_monitor.m_pready_i;
				h_seq_item.m_prdata_i	=	h_intf.cb_memory_monitor.m_prdata_i;

				if(h_ethernet_config_class.moder.TXEN) begin
				rd_check;																		//bd address pointer based on rd and lengths
				end

				if(h_seq_item.m_pready_i && h_ethernet_config_class.TXD0[addr].TEMP_RD && h_ethernet_config_class.moder.TXEN)begin			
					monitor_check;
				end
		

			end
		endtask

		
//=======================================monitor check================================//
		task	monitor_check;

	//----------------- len >4 & len < 46 & pad=1

		if(h_ethernet_config_class.TXD0[addr].LENGTH >= 4 && h_ethernet_config_class.TXD0[addr].LENGTH < 46 &&  h_ethernet_config_class.moder.PAD)begin//{
			
			if(len <= (h_ethernet_config_class.TXD0[addr].LENGTH)/4) begin	//{
				payload_data();																	//if length of payload is >=4  &  <46 and pad==1 payload generated upto 																								  length of payload and remaining are zero until kength is 46
				end//}	

				if(len > (h_ethernet_config_class.TXD0[addr].LENGTH)/4 && len<12) begin			//{
					slicer=32'h0000_0000;					
					payload_data();		
					$display($time,"********* len=%0d...lengthofpl=%0d",len,h_ethernet_config_class.TXD0[addr].LENGTH/4);
				end//}

				len++;


			if(len==12) begin
				len=0;	
					h_ethernet_config_class.TXD0[addr].TEMP_RD =	0;
			end
		
			end	//}

		
	//----------------------  len > 1500 && len < 2030	&& HUGEN
			else if((h_ethernet_config_class.TXD0[addr].LENGTH > 1500 && h_ethernet_config_class.TXD0[addr].LENGTH <= 2030 && h_ethernet_config_class.moder.HUGEN)||(h_ethernet_config_class.TXD0[addr].LENGTH >= 46 && h_ethernet_config_class.TXD0[addr].LENGTH <= 1500))	begin	//{

			$display($time,"@@@@@@@@@@@@@@@@@@@@@@ len:::%d",len);

				if(len <= (h_ethernet_config_class.TXD0[addr].LENGTH)/4) begin	//{
					payload_data();
				end//}

				len++;
				
				if(len > (((h_ethernet_config_class.TXD0[addr].LENGTH)/4)))begin//{
					len=0;	
					h_ethernet_config_class.TXD0[addr].TEMP_RD =	0;
				end//}
			end//}

		endtask


	

	
	//--------------------- rd check
		task rd_check;
		
			for(int i=0; i<h_ethernet_config_class.TX_BD_NUM.TXBD; i++)begin	//{ 1
			if(h_ethernet_config_class.TXD0.exists(addr+8))	begin			//{
			
			if(h_ethernet_config_class.TXD0[addr].TEMP_RD  &&  ((h_ethernet_config_class.TXD0[addr].LENGTH>=4 && h_ethernet_config_class.TXD0[addr].LENGTH<=45 && h_ethernet_config_class.moder.PAD)||(h_ethernet_config_class.TXD0[addr].LENGTH>=46 && h_ethernet_config_class.TXD0[addr].LENGTH<=1500)||(h_ethernet_config_class.TXD0[addr].LENGTH>=1501 && h_ethernet_config_class.TXD0[addr].LENGTH<=2030 && h_ethernet_config_class.moder.HUGEN)))begin//{
			
			addr=addr;						
											//it is possible for only good packet conditions
			end//}
			else begin		//{
		
			`uvm_info("NEXT BD",$sformatf("INPUT MONITOR"),UVM_NONE);							
			addr=addr+8;	
				
/*			if(h_ethernet_config_class.TXD0.exists(addr+8))	begin			//{
				`uvm_info("NEXT BD",$sformatf("INPUT MONITOR"),UVM_NONE);							
				addr=addr+8;	
			end//}
*/			
			
		end//} 1
		end	//}
		end	//}
		
	endtask





	//===========================TASK TO SLICE 32 BIT DATA FROM INTERFACE TO 4 BITS

		task	payload_data();
		

			slicer	=  h_intf.cb_memory_monitor.m_prdata_i;	//q.pop_front();						//data from queue assigned to 32 bit register to slice it furthur




		//-------------------- slicing 32 bit into nibbles abd storing it to 4 bit queue --------------------------//

		if(h_ethernet_config_class.TXD0[addr].LENGTH%4==0	|| len < (h_ethernet_config_class.TXD0[addr].LENGTH)/4)	begin//{
			for(int i=0;i<=7;i++) begin
				mtxd	=	slicer[(i*4) +: 4];	
				h_mem_input_monitor_port.write(mtxd);

			end
		end		//}

		
		if(h_ethernet_config_class.TXD0[addr].LENGTH%4==1  && len == (h_ethernet_config_class.TXD0[addr].LENGTH)/4)begin//{
			for(int i=0;i<=1;i++) begin
				mtxd	=	slicer[(i*4) +: 4];	
				h_mem_input_monitor_port.write(mtxd);

			end	
		end//}


		if(h_ethernet_config_class.TXD0[addr].LENGTH%4==2  && len == (h_ethernet_config_class.TXD0[addr].LENGTH)/4)begin//{
			for(int i=0;i<=3;i++) begin
				mtxd	=	slicer[(i*4) +: 4];	
				h_mem_input_monitor_port.write(mtxd);

			end	
		end//}

		if(h_ethernet_config_class.TXD0[addr].LENGTH%4==3  && len == (h_ethernet_config_class.TXD0[addr].LENGTH)/4)begin//{
			for(int i=0;i<=5;i++) begin
				mtxd	=	slicer[(i*4) +: 4];	
				h_mem_input_monitor_port.write(mtxd);

			end	
		end//}
	

			
	endtask


endclass



//------------------------------------------------------------------------------------------------------------------------------------------------------
//																	OVERRIDING CLASS
//-------------------------------------------------------------------------------------------------------------------------------------------------------


	class mem_input_monitor_11 extends mem_input_monitor;/*uvm_monitor;*/
		
		`uvm_component_utils(mem_input_monitor_11)
 		
	//	uvm_analysis_port#(nibble_type) h_mem_input_monitor_port;

		ethernet_sequence_item 			h_seq_item;

		ethernet_config_class			h_ethernet_config_class;

		virtual ethernet_interface 		h_intf;

		bit		[31:0]slicer;

//		int		q[$];

//		bit		[3:0]q_four[$];

		nibble_type		mtxd;

//		bit		[3:0]MTxD_temp;

		int addr = 1024;

		int len;


		bit		[3:0]pad_bit;
	//-------------------------------- component construction ---------------------------------//

		function new(string name = " ", uvm_component parent);
			super.new(name,parent);
		//	h_mem_input_monitor_port=new("h_mem_input_monitor_port",this);

		endfunction


//========================================= BUILD PHASE ============================================//
	
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			//h_mem_input_monitor_port=new("h_mem_input_monitor_port",this);
			
			h_seq_item=ethernet_sequence_item::type_id::create("h_seq_item");
			assert(uvm_config_db#(virtual	ethernet_interface)::get(this,"*","h_intf",h_intf))else $fatal("VIF NOT GETTING IN IP MONITOR");	
		
		endfunction

//=========================================connect phase==============================================//
		function void connect_phase(uvm_phase phase);
				assert(uvm_config_db#(ethernet_config_class)::get(null,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN MEM SEQUENCE");
					
		endfunction

//=======================================  run phase ===============================//
		task run_phase(uvm_phase phase);

			forever@(h_intf.cb_memory_monitor)	begin
		
				h_seq_item.m_pready_i	=	h_intf.cb_memory_monitor.m_pready_i;
				h_seq_item.m_prdata_i	=	h_intf.cb_memory_monitor.m_prdata_i;

				if(h_ethernet_config_class.moder.TXEN) begin
				rd_check;																		//bd address pointer based on rd and lengths
				end
					
				if(h_seq_item.m_pready_i && h_ethernet_config_class.TXD0[addr].TEMP_RD && h_ethernet_config_class.moder.TXEN)begin
					monitor_check;
				end

			end
		endtask

		
//=======================================monitor check================================//
		task	monitor_check;

	//----------------- len >=4 & len < 46 & pad=1


	
	if(h_ethernet_config_class.TXD0[addr].LENGTH >= 4 && h_ethernet_config_class.TXD0[addr].LENGTH < 46 &&  h_ethernet_config_class.moder.PAD)begin//{1
		
		
			if(len <= (h_ethernet_config_class.TXD0[addr].LENGTH)/4 ) begin	//{3
				payload_data();
					$display($time,"********* len=%0d...lengthofpl=%0d",len,h_ethernet_config_class.TXD0[addr].LENGTH/4);
			end//}3	

			len++;


			if(len > (h_ethernet_config_class.TXD0[addr].LENGTH)/4) begin//{4		

			for(int i=0;i<=((46-(h_ethernet_config_class.TXD0[addr].LENGTH))*4);i++) begin			//{
				mtxd=4'b0000;

				h_mem_input_monitor_port.write(mtxd);						
			end																						//}
					
			len=0;
			h_ethernet_config_class.TXD0[addr].TEMP_RD =	0;
			

		end//}4
		
		end//}1

	//----------------------  len > 1500 && len < 2030	&& HUGEN
			else if((h_ethernet_config_class.TXD0[addr].LENGTH > 1500 && h_ethernet_config_class.TXD0[addr].LENGTH <= 2030 && h_ethernet_config_class.moder.HUGEN)||(h_ethernet_config_class.TXD0[addr].LENGTH >= 46 && h_ethernet_config_class.TXD0[addr].LENGTH <= 1500))	begin	//{


				if(len <= (h_ethernet_config_class.TXD0[addr].LENGTH)/4) begin	//{
					payload_data();
				end//}

				len++;
				
				if(len > (((h_ethernet_config_class.TXD0[addr].LENGTH)/4)))begin//{
					len=0;	//	if(len==13) len=0;
					h_ethernet_config_class.TXD0[addr].TEMP_RD =	0;
				end//}
			end//}

		endtask


	

	
	//--------------------- rd check
		task rd_check;
		
			for(int i=0; i<h_ethernet_config_class.TX_BD_NUM.TXBD; i++)begin	//{ 1

			if(h_ethernet_config_class.TXD0.exists(addr+8)	&& !h_ethernet_config_class.TXD0[1024].RD)	begin			//{
				
				if(h_ethernet_config_class.TXD0[addr].TEMP_RD  &&  ((h_ethernet_config_class.TXD0[addr].LENGTH>=4 && h_ethernet_config_class.TXD0[addr].LENGTH<=45 && h_ethernet_config_class.moder.PAD)||(h_ethernet_config_class.TXD0[addr].LENGTH>=46 && h_ethernet_config_class.TXD0[addr].LENGTH<=1500)||(h_ethernet_config_class.TXD0[addr].LENGTH>=1501 && h_ethernet_config_class.TXD0[addr].LENGTH<=2030 && h_ethernet_config_class.moder.HUGEN)))begin//{
			
				addr=addr;					
											//it is possible for only good packet conditions
			end//}
			else begin		//{
		
				
				if(h_ethernet_config_class.TXD0.exists(addr+8))	begin			//{
					`uvm_info("NEXT BD",$sformatf("INPUT MONITOR"),UVM_NONE);							
					addr=addr+8;	
				end//
		
				else begin	//{
				
				`uvm_info("TEMP_RD CHECK",$sformatf("FINAL BD AND ALL TX_BD'S COMPLETED"),UVM_NONE);
				
				end	//}
				
			
		end//} 1
		end	//}
		end	//}
		
	endtask



	//===========================TASK TO SLICE 32 BIT DATA FROM INTERFACE TO 4 BITS

		task	payload_data();
		

			slicer	=  h_intf.cb_memory_monitor.m_prdata_i;	//q.pop_front();						//data from queue assigned to 32 bit register to slice it furthur


		//-------------------- slicing 32 bit into nibbles abd storing it to 4 bit queue --------------------------//

		if(h_ethernet_config_class.TXD0[addr].LENGTH%4==0	|| len < (h_ethernet_config_class.TXD0[addr].LENGTH)/4)	begin//{
			slicer	=	{slicer[7:4],slicer[3:0],slicer[15:12],slicer[11:8],slicer[23:20],slicer[19:16],slicer[31:28],slicer[27:24]};
			for(int i=0;i<=7;i++) begin
				mtxd	=	slicer[(i*4) +: 4];	
				h_mem_input_monitor_port.write(mtxd);
		//		$display("mtxd=%d",mtxd);
			end
		end		//}

		
		if(h_ethernet_config_class.TXD0[addr].LENGTH%4==1  && len == (h_ethernet_config_class.TXD0[addr].LENGTH)/4)begin//{
			slicer	=	{slicer[7:4],slicer[3:0],slicer[15:12],slicer[11:8],slicer[23:20],slicer[19:16],slicer[31:28],slicer[27:24]};
			for(int i=0;i<=1;i++) begin
				mtxd	=	(slicer[(i*4) +: 4]);	
				h_mem_input_monitor_port.write(mtxd);	
		//		$display("mtxd=%d",mtxd);		

			end	
		end//}


		if(h_ethernet_config_class.TXD0[addr].LENGTH%4==2  && len == (h_ethernet_config_class.TXD0[addr].LENGTH)/4)begin//{
			slicer	=	{slicer[7:4],slicer[3:0],slicer[15:12],slicer[11:8],slicer[23:20],slicer[19:16],slicer[31:28],slicer[27:24]};
			for(int i=0;i<=3;i++) begin
				mtxd	=	(slicer[(i*4) +: 4]);	
				h_mem_input_monitor_port.write(mtxd);
		//		$display("mtxd=%d",mtxd);		

			end	
		end//}

		if(h_ethernet_config_class.TXD0[addr].LENGTH%4==3  && len == (h_ethernet_config_class.TXD0[addr].LENGTH)/4)begin//{
			slicer	=	{slicer[7:4],slicer[3:0],slicer[15:12],slicer[11:8],slicer[23:20],slicer[19:16],slicer[31:28],slicer[27:24]};
			for(int i=0;i<=5;i++) begin
				mtxd	=	(slicer[(i*4) +: 4]);	
				h_mem_input_monitor_port.write(mtxd);
			//	$display("mtxd=%d",mtxd);		

			end	
		end//}
			
	endtask


endclass


//------------------------------------------------------------------------------------------------------------------------------------------------------
//																	OVERRIDING CLASS
//-------------------------------------------------------------------------------------------------------------------------------------------------------


	class mem_input_monitor_1 extends mem_input_monitor;/*uvm_monitor;*/
		
		`uvm_component_utils(mem_input_monitor_1)
 		
		ethernet_sequence_item 			h_seq_item;

		ethernet_config_class			h_ethernet_config_class;

		virtual ethernet_interface 		h_intf;

		bit		[31:0]slicer;

		nibble_type		mtxd;

		int addr = 1024;

		int len;

	//	bit 	flag;

	//	bit		[3:0]pad_bit;
//-------------------------------- component construction ---------------------------------//

	function new(string name = " ", uvm_component parent);
		super.new(name,parent);
	endfunction


//========================================= BUILD PHASE ============================================//
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		h_seq_item=ethernet_sequence_item::type_id::create("h_seq_item");
		assert(uvm_config_db#(virtual	ethernet_interface)::get(this,"*","h_intf",h_intf))else $fatal("VIF NOT GETTING IN IP MONITOR");	
	endfunction

//=========================================connect phase==============================================//
	function void connect_phase(uvm_phase phase);
			assert(uvm_config_db#(ethernet_config_class)::get(this,this.get_full_name,"h_ethernet_config_class",h_ethernet_config_class)) $display("Getting config class"); else $fatal("CONFIG CLASS NOT GETTING IN MEM SEQUENCE");
	endfunction

//=======================================  run phase ===============================//
	task run_phase(uvm_phase phase);
		forever@(h_intf.cb_memory_monitor)	begin
		
		h_seq_item.m_pready_i	=	h_intf.cb_memory_monitor.m_pready_i;
		h_seq_item.m_prdata_i	=	h_intf.cb_memory_monitor.m_prdata_i;

		if(h_ethernet_config_class.moder.TXEN) begin
			rd_check;																		//bd address pointer based on rd and lengths
		end
					
		if(h_seq_item.m_pready_i && h_ethernet_config_class.TXD0[addr].TEMP_RD && h_ethernet_config_class.moder.TXEN)begin
			monitor_check;
		end
		end
	endtask


		
//=======================================monitor check================================//
	task	monitor_check;

	//----------------- len >=4 & len < 46 & pad=1
	
		if(h_ethernet_config_class.TXD0[addr].LENGTH > 4 && h_ethernet_config_class.TXD0[addr].LENGTH < 46 &&  h_ethernet_config_class.moder.PAD)begin//{1
		
		if(h_ethernet_config_class.TXD0[addr].LENGTH%4!=0) begin	//{

		if(len <= h_ethernet_config_class.TXD0[addr].LENGTH/4) begin	//{3
			payload_data();
			len++;				
			$display($time,"********* len=%0d...lengthofpl=%0d",len,h_ethernet_config_class.TXD0[addr].LENGTH/4);
		end//}3	
			
		else begin	//{
	//------------------------------- padding condition
		if(len > h_ethernet_config_class.TXD0[addr].LENGTH/4 ) begin//{4				
			for(int i=0;i<((46-(h_ethernet_config_class.TXD0[addr].LENGTH))*2);i++) begin			//{
			mtxd=4'b0000;
			h_mem_input_monitor_port.write(mtxd);	
			//$display($time,"pad  mtxd=%d",mtxd);
			end																						//}
					
			len=0;
			h_ethernet_config_class.TXD0[addr].TEMP_RD =	0;
			end//}4
			end	//}
		end		//}


		else begin		//{
		if(len < h_ethernet_config_class.TXD0[addr].LENGTH/4) begin	//{3
			payload_data();
			len++;	
		//	$display($time,"********* len=%0d...lengthofpl=%0d",len,h_ethernet_config_class.TXD0[addr].LENGTH/4);
		end//}3	


		else begin if(len >= h_ethernet_config_class.TXD0[addr].LENGTH/4) begin//{4		

			for(int i=0;i<((46-(h_ethernet_config_class.TXD0[addr].LENGTH))*2);i++) begin			//{
			mtxd=4'b0000;
			h_mem_input_monitor_port.write(mtxd);	
			//$display($time,"pad  mtxd=%d",mtxd);
			end		
																					//}			
			len=0;
			h_ethernet_config_class.TXD0[addr].TEMP_RD =	0;
			end//}4
			end	//}1
			end
		end

	//----------------------  len > 1500 && len < 2030	&& HUGEN
		if((h_ethernet_config_class.TXD0[addr].LENGTH > 1500 && h_ethernet_config_class.TXD0[addr].LENGTH <= 2030 && h_ethernet_config_class.moder.HUGEN)||(h_ethernet_config_class.TXD0[addr].LENGTH >= 46 && h_ethernet_config_class.TXD0[addr].LENGTH <= 1500))	begin	//{

		if(h_ethernet_config_class.TXD0[addr].LENGTH%4!=0) begin	//{		

		if(len <= h_ethernet_config_class.TXD0[addr].LENGTH/4) begin	//{
		//	$display($time,"********* len=%0d...lengthofpl=%0d",len,h_ethernet_config_class.TXD0[addr].LENGTH/4);
			payload_data();
			len++;			
		end//}

				
		if(len > h_ethernet_config_class.TXD0[addr].LENGTH/4)begin//{
			len=0;	
			h_ethernet_config_class.TXD0[addr].TEMP_RD = 0;
		end		//}
		end		//}
	

		else begin		//{

			if(len <= h_ethernet_config_class.TXD0[addr].LENGTH/4) begin	//{
		//	$display($time,"********* len=%0d...lengthofpl=%0d",len,h_ethernet_config_class.TXD0[addr].LENGTH/4);
			payload_data();
			len++;
		
		end//}

				
		if(len > h_ethernet_config_class.TXD0[addr].LENGTH/4)begin//{
			len=0;	
			h_ethernet_config_class.TXD0[addr].TEMP_RD = 0;
		end		//}



		end				//}

		end//}

		endtask

	
	//--------------------- rd check
		task rd_check;
		
			for(int i=0; i<h_ethernet_config_class.TX_BD_NUM.TXBD; i++)begin	//{ 1

			if(h_ethernet_config_class.TXD0.exists(addr+8)	&& !h_ethernet_config_class.TXD0[1024].RD)	begin			//{goes to next bd only if next bd address is available
				
			if(h_ethernet_config_class.TXD0[addr].TEMP_RD  &&  ((h_ethernet_config_class.TXD0[addr].LENGTH>=4 && h_ethernet_config_class.TXD0[addr].LENGTH<=45 && h_ethernet_config_class.moder.PAD)||(h_ethernet_config_class.TXD0[addr].LENGTH>=46 && h_ethernet_config_class.TXD0[addr].LENGTH<=1500)||(h_ethernet_config_class.TXD0[addr].LENGTH>=1501 && h_ethernet_config_class.TXD0[addr].LENGTH<=2030 && h_ethernet_config_class.moder.HUGEN)))begin//{
			
				addr=addr;					
											//it is possible for only good packet conditions
			end//}
			else begin		//{
		
			 //addr=addr+8;	
				
			if(h_ethernet_config_class.TXD0.exists(addr+8))	begin			//{
				`uvm_info("NEXT BD",$sformatf("INPUT MONITOR"),UVM_NONE);							
			 	addr=addr+8;	
			end//
			
			/*else begin	//{
				
			`uvm_info("TEMP_RD CHECK",$sformatf("FINAL BD AND ALL TX_BD'S COMPLETED"),UVM_NONE);
				
			end	//}*/
				
		end//} 1
		end	//}
		end	//}
		
	endtask



	//===========================TASK TO SLICE 32 BIT DATA FROM INTERFACE TO 4 BITS

		task	payload_data();
		

			slicer	=  h_intf.cb_memory_monitor.m_prdata_i;						//data from queue assigned to 32 bit register to slice it 


		//-------------------- slicing 32 bit into nibbles abd storing it to 4 bit queue --------------------------//

		if(h_ethernet_config_class.TXD0[addr].LENGTH%4==0	|| len < (h_ethernet_config_class.TXD0[addr].LENGTH)/4 )	begin//{
			slicer	=	{slicer[7:4],slicer[3:0],slicer[15:12],slicer[11:8],slicer[23:20],slicer[19:16],slicer[31:28],slicer[27:24]};
			for(int i=0;i<=7;i++) begin
				mtxd	=	slicer[(i*4) +: 4];	
				h_mem_input_monitor_port.write(mtxd);
			//	$display($time," all  mtxd=%d",mtxd);
			end
		end		//}

		
		if(h_ethernet_config_class.TXD0[addr].LENGTH%4==1  && len == (h_ethernet_config_class.TXD0[addr].LENGTH)/4)begin//{
			slicer	=	{slicer[7:4],slicer[3:0],slicer[15:12],slicer[11:8],slicer[23:20],slicer[19:16],slicer[31:28],slicer[27:24]};
			for(int i=0;i<=1;i++) begin
				mtxd	=	(slicer[(i*4) +: 4]);	
				h_mem_input_monitor_port.write(mtxd);	
			//	$display($time," one mtxd=%d",mtxd);		

			end	
		end//}


		if(h_ethernet_config_class.TXD0[addr].LENGTH%4==2  && len == (h_ethernet_config_class.TXD0[addr].LENGTH)/4)begin//{
			slicer	=	{slicer[7:4],slicer[3:0],slicer[15:12],slicer[11:8],slicer[23:20],slicer[19:16],slicer[31:28],slicer[27:24]};
			for(int i=0;i<=3;i++) begin
				mtxd	=	(slicer[(i*4) +: 4]);	
				h_mem_input_monitor_port.write(mtxd);
			//	$display($time," two  mtxd=%d",mtxd);		

			end	
		end//}

		if(h_ethernet_config_class.TXD0[addr].LENGTH%4==3  && len == (h_ethernet_config_class.TXD0[addr].LENGTH)/4)begin//{
			slicer	=	{slicer[7:4],slicer[3:0],slicer[15:12],slicer[11:8],slicer[23:20],slicer[19:16],slicer[31:28],slicer[27:24]};
			for(int i=0;i<=5;i++) begin
				mtxd	=	(slicer[(i*4) +: 4]);	
				h_mem_input_monitor_port.write(mtxd);
				//$display($time,"three .. mtxd=%d",mtxd);		

			end	
		end//}
			
	endtask


endclass

